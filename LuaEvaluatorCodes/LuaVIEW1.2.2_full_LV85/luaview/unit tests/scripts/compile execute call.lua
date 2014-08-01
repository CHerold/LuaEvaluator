-- Test the compile/execute/pcall API from Lua.

-- Base state auto-closing, don't do simultaneous scripting so as to not erroneously fail this test.
entropy=lv.tickcount()
s=open_states()
open_base_state("blargh_a"..entropy)
assert(open_states()==s+1,"states mismatch")
open_base_state("blargh_b"..entropy)
assert(open_states()==s+2,"states mismatch")
open_base_state("blargh_a"..entropy)
assert(open_states()==s+2,"states mismatch")
close()
assert(open_states()==s+1,"states mismatch")
open_base_state("blargh_b"..entropy)
close()
assert(open_states()==s,"states mismatch")

-- Private: compile error.
open_private_state()
assert(not lv.pcall(compile,"",[[do while if end or not]]),"compile error not detected")
close()

-- Base: compile error.
open_base_state()
assert(not lv.pcall(compile,"",[[do while if end or not]]),"compile error not detected")
close()

-- Private: execute simple script without errors.
open_private_state()
compile("",[[wait(200)]])
t1=lv.tickcount()
execute()
t2=lv.tickcount()
assert(lv.subU32(t2,t1)>=199,"wait time too short")
close()

-- Base: execute simple script without errors.
open_base_state()
compile("",[[for i=1,10,1 do j=i*i end]])
execute()
close()

-- Private: execute simple script with errors.
open_private_state()
compile("nih nih",[[error("foo bar")]])
ok,err=lv.pcall(execute)
assert(not ok,"should not be OK")
assert(string.find(err,"nih nih"),"name not reported in error")
assert(string.find(err,"foo bar"),"error message not in error")
close()

-- Base: execute simple script with errors.
open_base_state()
compile("nih nih",[[error("foo bar")]])
ok,err=lv.pcall(execute)
assert(not ok,"should not be OK")
assert(string.find(err,"nih nih"),"name not reported in error")
assert(string.find(err,"foo bar"),"error message not in error")
close()

-- Private: test error appending for cleanup functions
open_private_state()
compile("",[[
lv.addcleanup(function() error("woof_c") end)
lv.addcleanup(function() error("woof_b") end)
error("woof_a")
]])
ok,err=lv.pcall(execute)
assert(not ok,"should not be OK")
assert(string.find(err,"woof_a"),"name not reported in error")
assert(string.find(err,"woof_b"),"error message not in error")
assert(string.find(err,"woof_c"),"error message not in error")
close()

-- Private: multiple compilations
open_private_state()
compile("",[[function three() return 3 end]])
compile("",[[function four() return 4 end]])
compile("",[[if 25~=three()^2+four()^2 then error ("prior compilations messed up") end]])
execute()
close()

-- Base: multiple compilations
open_base_state()
compile("",[[function three() return 3 end]])
compile("",[[function four() return 4 end]])
compile("",[[if 25~=three()^2+four()^2 then error ("prior compilations messed up") end]])
execute()
close()

-- Private: call should fail.
open_private_state()
compile("",[[function foo() return 123 end]])
execute()
assert(not lv.pcall(call,"foo"),"should not be able to call a non-base state")
close()

--Base: a simple call to Lua
open_base_state()
compile("",[[function foo() return 123 end]])
execute()
assert(123==call("foo"),"bad call")
assert(not lv.pcall(call,""),"missing function name not detected")
assert(not lv.pcall(call,"bar"),"non-existent function not detected")
assert(not lv.pcall(call,"."),"non-existent function not detected")
assert(not lv.pcall(call,".foo"),"non-existent function not detected")
assert(not lv.pcall(call,"foo."),"non-existent function not detected")
close()

--Base: calling functions inside tables
open_base_state()
compile("",[[
bar={
foo=function() return 123 end
}
baz={bar={
foo=function() return 123 end
}}
]])
execute()
assert(123==call("bar.foo"),"bad call")
assert(123==call("baz.bar.foo"),"bad call")
assert(not lv.pcall(call,"bar"),"not a function not detected")
assert(not lv.pcall(call,"baz.bar"),"not a function not detected")
assert(not lv.pcall(call,"baz.bar.foo."),"non-existent function not detected")
assert(not lv.pcall(call,"bar..foo"),"non-existent function not detected")
close()

--Base: passing no arguments
open_base_state()
compile("",[[
function foo(a1)
    assert(a1==nil,"too many arguments")
end
bar={
foo=foo
}
baz={bar={
foo=foo
}}
]])
execute()
call("foo")
call("bar.foo")
call("baz.bar.foo")
close()

--Base: passing one arg
open_base_state()
compile("",[[
function foo(a1,a2)
    assert(a1==1,"wrong argument")
    assert(a2==nil,"too many arguments")
end
bar={
foo=foo
}
baz={bar={
foo=foo
}}
]])
execute()
call("foo",1)
call("bar.foo",1)
call("baz.bar.foo",1)
close()

--Base: passing two args
open_base_state()
compile("",[[
function foo(a1,a2,a3)
    assert(a1==1,"wrong argument")
    assert(a2==2,"wrong argument")
    assert(a3==nil,"too many arguments")
end
bar={
foo=foo
}
baz={bar={
foo=foo
}}
]])
execute()
call("foo",1,2)
call("bar.foo",1,2)
call("baz.bar.foo",1,2)
close()

--Base: check C functions that should or should not be there.
open_base_state()
compile("",[[
coroutine.create(function() end)
function fail() lv.addcleanup(function() end) end
]])
execute()
assert(not lv.pcall(call,"wait",0),"should fail")
assert(not lv.pcall(call,"exit"),"should fail")
assert(not lv.pcall(call,"fail"),"should fail")
assert(not lv.pcall(call,"lv.setyielding",0,0),"should fail")
assert(not lv.pcall(call,"lv.getyielding"),"should fail")
assert(not lv.pcall(call,"pcall"),"should fail")
close()

-- Base: test required results checking
open_base_state()
compile("",[[
    function none() end
    function one() return 1 end
    function two() return 1,2 end
]])
execute()
call_required("none",0)
call_required("one",1)
call_required("two",2)
assert(not lv.pcall(call_required,"none",1),"should fail")
assert(not lv.pcall(call_required,"one",0),"should fail")
assert(not lv.pcall(call_required,"one",2),"should fail")
assert(not lv.pcall(call_required,"two",0),"should fail")
assert(not lv.pcall(call_required,"two",1),"should fail")
assert(not lv.pcall(call_required,"two",3),"should fail")
close()
