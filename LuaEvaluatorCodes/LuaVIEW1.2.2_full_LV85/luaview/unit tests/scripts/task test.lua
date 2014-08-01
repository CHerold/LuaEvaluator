function waitontask(id)
    -- Wait for a task to complete or bug out
    local timeout=10000
    local t0=lv.tickcount()
    while (task.ongoing(id)) do
       assert(lv.subU32(lv.tickcount(),t0)<timeout,"task \""..id.."\" did not complete before the "..timeout.." (ms) timeout")
       sleep(2)
    end
    sig.confirm(id)
end

function waitformode(id,mode)
    -- Wait for a task to switch modes
    local timeout=10000
    local t0=lv.tickcount()
    while (task.mode(id)~=mode) do
       assert(lv.subU32(lv.tickcount(),t0)<timeout,"task \""..id.."\" did not switch to the \""..mode.."\" mode before the "..timeout.." (ms) timeout")
       sleep(2)
    end
end

-- Test the preprocessor
ok,err=lv.pcall(do_task,"mooooo",[[--#badkeyword]])
assert(not ok,"bad keyword should fail")
assert(string.find(err,"mooooo\""),"script name should appear in error:\n"..err)
do_task("",[[
woof=1
--#badkeyword
]]) -- keywords not in the header should be ignored
do_task("",[[--#identifier "wobble wobble woop wap"]])
do_task("",[[--#class "wobble wobble woop wap"]])
do_task("",[[--#description "wobble wobble woop wap"]])
do_task("",[[--#version "wobble wobble woop wap"]])
do_task("",[[--#prefsys "standard"]])
do_task("",[[--#priority "normal priority"]])
do_task("",[[--#disallow_manual]])
do_task("",[[--#defer]])
do_task("",[[--#import "]]..task.directory().._SEP..[[import.lua"
assert(imported,"import failed")
]])
assert(not lv.pcall(do_task,"",[[--#identifier ""]]),"empty value not detected")
assert(not lv.pcall(do_task,"",[[--#identifier "]]..task.identifier()..[["]]),"existing identifier not detected")
assert(not lv.pcall(do_task,"",[[--#identifier "123"]]),"decimal digit identifier not blocked")
assert(not lv.pcall(do_task,"",[[--#identifier]]),"missing value not detected")
assert(not lv.pcall(do_task,"",[[--#class]]),"missing value not detected")
assert(not lv.pcall(do_task,"",[[--#description]]),"missing value not detected")
assert(not lv.pcall(do_task,"",[[--#version]]),"missing value not detected")
assert(not lv.pcall(do_task,"",[[--#import]]),"missing value not detected")
assert(not lv.pcall(do_task,"",[[--#import ""]]),"empty value not detected")
assert(not lv.pcall(do_task,"",[[--#prefsys]]),"missing value not detected")
assert(not lv.pcall(do_task,"",[[--#priority]]),"missing value not detected")
assert(not lv.pcall(do_task,"",[[--#disallow_manual "ploof"]]),"superfluous value not detected")
assert(not lv.pcall(do_task,"",[[--#defer "ploof"]]),"superfluous value not detected")
assert(not lv.pcall(do_task,"",[[
--#defer
--#defer
]]),"redundant keywords not detected")

-- Basic do_task
do_task("",[[return]])
assert(not lv.pcall(do_task,"",[[error("poof!")]]),"should fail")
ok,err=lv.pcall(do_task,"@ABC",[[error("@DEF")]])
assert(string.find(err,"@ABC"),"script name not reported in error")
assert(string.find(err,"@DEF"),"not the expected error")

-- Basic run_task
id=run_task("",[[return]])
waitontask(id)
assert(not lv.pcall(run_task,"",[[
--#defer
error("poof!")
]]),"should fail")
ok,err=lv.pcall(run_task,"@ABC",[[
--#defer
error("@DEF")
]])
assert(string.find(err,"@ABC"),"script name not reported in error")
assert(string.find(err,"@DEF"),"not the expected error")
id=run_task("",[[
run_task("","--") -- non-reentrancy makes sure that prior run_task has returned
error("poof!") -- consequently, this error should not be passed to launching context
]])
waitontask(id)

-- Basic signalling
id=run_task("",[[sleep()]])
waitformode(id,"running")
sig.stop(id)
waitontask(id)
--
id=run_task("",[[while true do wait(1) end]])
waitformode(id,"running")
sig.stop(id)
waitontask(id)
--
id=run_task("",[[sleep()]])
waitformode(id,"running")
sig.pause(id)
waitformode(id,"paused")
sig.resume(id)
waitontask(id)
--
id=run_task("",[[while true do sleep() end]])
waitformode(id,"running")
sig.pause(id)
waitformode(id,"paused")
sig.resume(id)
waitformode(id,"running")
sig.stop(id)
waitontask(id)

-- Messaging
assert(not msg.available(),"should be no message yet")
msg.self("woof")
assert(msg.available(),"should be a message")
assert("woof"==msg.next(),"wrong message")
assert(not msg.next(),"queue should be empty")
msg.self("foo")
msg.self("bar")
assert("foo"==msg.next(),"wrong message")
assert("bar"==msg.next(),"wrong message")
assert(not msg.next(),"queue should be empty")
msg.self("foo")
msg.self("bar")
assert("bar"==msg.pop(),"wrong message")
assert("foo"==msg.pop(),"wrong message")
assert(not msg.next(),"queue should be empty")
sleep(1) -- unlatch wakeup occurrence
--
id=run_task("",[[sleep() msg.send("]]..task.identifier()..[[",msg.next().."_reply")]])
msg.send(id,"foo")
sleep(1000)
assert("foo_reply"==msg.next(),"wrong reply")
assert(not msg.available(),"queue should be empty")
waitontask(id)

-- Do a lot of simultaneous run_tasks to verify race protection
ids={}
numid=20
for i=1,numid,1 do
table.insert(ids,run_task("sub1",[[
sleep()
ok,err=lv.pcall(run_task,"sub2",[[
--#defer
wait(floor(random()*2)) -- permutates order of failures
error("@]]..task.identifier()..[[")
]])
if string.find(err,"@"..task.identifier()) then msg.send("]]..task.identifier()..[[","OK") end
]]))
end
for k,id in ipairs(ids) do task.wakeup(id) end
for k,id in ipairs(ids) do waitontask(id) end
for i=1,numid,1 do assert("OK"==msg.next(),"error got mixed up") end
assert(not msg.available(),"too many replies")
sleep(1) -- unlatch wakeup occurrence

-- Swapping and identifiers
id=run_task("",[[
--#identifier "wobble wobble woop wap"
while true do sleep() end
]])
assert(not lv.pcall(swap_task,"bad identifier","",[[sleep()]]),"bad ID not detected")
assert(not lv.pcall(swap_task,"bad identifier","",[[
--#identifier "bad identifier"
]]),"bad ID not detected")
assert(not lv.pcall(swap_task,"wobble wobble woop wap","",[[
--#identifier "bad identifier"
]]),"mismatching ID not detected")
swap_task("wobble wobble woop wap","",[[do end]])
waitontask(id)

-- Disallowed swapping
id=run_task("",[[
sig.disallow_swap()
while true do sleep() end
]])
assert(not lv.pcall(swap_task,id,"",[[do end]]),"signal disallowance ignored")
sig.stop(id)
waitontask(id)

-- Task mode on swapping cleanup/initialisation
do_task("",[[
lv.addcleanup(function() assert(task.mode()=="swapping","bad mode") end)
swap_task(task.identifier(),"",[[
--#defer
assert(task.mode()=="swapping","bad mode")
task.active()
assert(task.mode()=="executing","bad mode")
]])
]])
