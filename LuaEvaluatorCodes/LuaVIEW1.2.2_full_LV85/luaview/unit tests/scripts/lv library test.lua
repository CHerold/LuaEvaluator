-- We should be forced to a C locale, so this should not fail irrespective of the selected language.
tonumber("1.23")
-- Test for supposed floor/ceil bug (XCode on OS X) with certain compile switches.
assert(0==floor(0.5),"Floor bug")
assert(1==ceil(0.5),"Ceil bug")

-- Tests for the "lv.*" library functions (implemented in C). These are intended mostly for easier
-- bit-wise / overflow sensitive manipulation of integers fitting into one of the various LabVIEW int types.

operations = {["add"]=2,["and"]=2,["invert"]=1,["or"]=2,["shift"]=2,["sub"]=2,["xor"]=2}
typespecs = {["U8"]=false,["I8"]=true,["U16"]=false,["I16"]=true,["U32"]=false,["I32"]=true}

if pcall(lv.addcleanup) then error("bad arg check for addcleanup") end
if pcall(lv.addcleanup, "moo") then error("bad arg check for addcleanup") end
if pcall(lv.addcleanup, wait) then error("bad arg check for addcleanup") end
lv.addcleanup(function() end) -- should not fail

-- Testing wait and tickcount
wait_time = 123
t1 = lv.tickcount()
wait(wait_time)
t2 = lv.tickcount()
if (lv.subU32(t2,t1) < wait_time) then error("wait time too short") end
if (lv.subU32(t2,t1) > wait_time + 500) then error("wait time too long by more than a reasonable degree of latency") end
if (pcall(wait,0)) then error("wait should throw an error when called via pcall") end

-- Testing exit
do_script("exit test",[[
exit()
error("this should not be reached")
]])
if (lv.pcall(do_script,"exit test",[[lv.addcleanup(function() exit() end)]])) then error("misplaced exit not detected") end

-- Test the per-LuaVIEW-state print buffer.
printbuflen=2^15
simubuf=""
function simuprint(...)
    -- Simulate the print buffer behaviour
    local n=table.getn(arg)
    local printstring
    for i=1,n,1 do
        if i==1 then simubuf=simubuf..tostring(arg[i])
        else simubuf=simubuf.." "..tostring(arg[i]) end
    end
    simubuf=simubuf.."\n"
    if (string.len(simubuf) > printbuflen) then
        simubuf=string.sub(simubuf,string.len(simubuf)-printbuflen+1,-1)
    end
end
function randomprint(len)
    local t={}
    for i=1,len,1 do
        t[i] = string.char(floor(random()*256))
    end
    local r=table.concat(t)
    lv.print(r)
    simuprint(r)
end
assert(simubuf==lv.dump(),"Print buffer mismatch")
lv.print()
simuprint()
assert(simubuf==lv.dump(),"Print buffer mismatch")
lv.print(1)
simuprint(1)
assert(simubuf==lv.dump(),"Print buffer mismatch")
lv.print(pi)
simuprint(pi)
assert(simubuf==lv.dump(),"Print buffer mismatch")
lv.print("foo",nil,false,simuprint)
simuprint("foo",nil,false,simuprint)
assert(simubuf==lv.dump(),"Print buffer mismatch")
randomprint(printbuflen-string.len(simubuf)-1)
assert(simubuf==lv.dump(),"Print buffer mismatch")
assert(printbuflen==string.len(lv.dump()),"Expecting a full buffer")
randomprint(floor(1.5*printbuflen))
assert(simubuf==lv.dump(),"Print buffer mismatch")
assert(printbuflen==string.len(lv.dump()),"Expecting a full buffer")
randomprint(floor(printbuflen/3))
assert(simubuf==lv.dump(),"Print buffer mismatch")
assert(printbuflen==string.len(lv.dump()),"Expecting a full buffer")
randomprint(floor(printbuflen/7))
assert(simubuf==lv.dump(),"Print buffer mismatch")
assert(printbuflen==string.len(lv.dump()),"Expecting a full buffer")
randomprint(floor(printbuflen/2))
assert(simubuf==lv.dump(),"Print buffer mismatch")
assert(printbuflen==string.len(lv.dump()),"Expecting a full buffer")

-- Testing auto-yielding
def_threshold,def_time=lv.getyielding()
lv.setyieldingdefaults(6,3)
do_script("yielding defaults test",[[
threshold,time=lv.getyielding()
if (threshold ~= 6) then error("Yielding threshold default not as expected") end
if (time ~= 3) then error("Yielding time default not as expected") end
]])
lv.setyieldingdefaults(def_threshold,def_time) -- revert defaults
lv.setyielding(5,2)
threshold,time=lv.getyielding()
if (threshold ~= 5) then error("Yielding threshold not set as expected") end
if (time ~= 2) then error("Yielding time not set as expected") end
lv.setyielding(2,0)

-- Test detection and reporting of a coroutine restrictions.
co=coroutine.create(function() wait(0) end)
ok,err=coroutine.resume(co)
assert(not ok,"coroutine should throw an error")
assert(string.find(err,"coroutine"),"not a coroutine error")
co=coroutine.create(function() exit() end)
ok,err=coroutine.resume(co)
assert(not ok,"coroutine should throw an error")
assert(string.find(err,"coroutine"),"not a coroutine error")
co=coroutine.create(function() print() end)
ok,err=coroutine.resume(co)
assert(not ok,"coroutine should throw an error")
assert(string.find(err,"coroutine"),"not a coroutine error")

-- Test memusage, but not on the Mac: there it is broken, at least under LabVIEW 7.0.
if _SEP ~= ":" then
    assert(lv.memusage()>100000,"Incredibly low mem usage")
end

-- Testing not a number and infity stuff
-- If this breaks, it is likely that the C compiler has emitted non-compliant floating point machine code.
if (0 ~= -0) then error("Zero should equal minus zero") end
if not lv.isnan(_NaN) then error("Bad _NaN or isnan()") end
if not lv.isnan(tan(1/0)) then error("Bad isnan()") end
if lv.isnan(1/0) then error("Bad isnan()") end
if lv.isnan(-1/0) then error("Bad isnan()") end
if lv.isnan(0) then error("Bad isnan()") end
if lv.isnan(0*-1) then error("Bad isnan()") end
if pcall(lv.isnan) then error("bad arg check") end
if pcall(lv.isnan, "moo") then error("bad arg check ") end
n=1/0
if not lv.isinf(_Inf) then error("Bad isinf()") end
if not lv.isinf(-_Inf) then error("Bad isinf()") end
if not lv.isinf(1/0) then error("Bad isinf()") end
if not lv.isinf(-1/0) then error("Bad isinf()") end
if lv.isinf(0) then error("Bad isinf()") end
if lv.isinf(123) then error("Bad isinf()") end
if lv.isinf(0*-1) then error("Bad isinf()") end
if pcall(lv.isinf) then error("bad arg check") end
if pcall(lv.isinf, "moo") then error("bad arg check") end

for operation,args in pairs(operations) do
    for typespec,signed in pairs(typespecs) do
        funcname = operation..typespec
        funcvar = _G["lv"][funcname]
        bits = tonumber(string.sub(typespec,2))
        if signed then
            maxval = 2^(bits-1)-1
            minval = -2^(bits-1)
        else
            maxval = 2^bits-1
            minval = 0
        end
        -- See if errors are properly detected. Note that pcall does not work with LuaVIEW functions.
        if args == 2 then
            if pcall(funcvar,6.6,0) then error(funcname.." bad arg1 fract check") end
            if pcall(funcvar,0,7.7) then error(funcname.." bad arg2 fract check") end
            if pcall(funcvar,_NaN,0) then error(funcname.." bad arg1 NaN check") end
            if pcall(funcvar,0,_NaN) then error(funcname.." bad arg2 NaN check") end
            if pcall(funcvar,1/0,0) then error(funcname.." bad arg1 Infinity check") end
            if pcall(funcvar,0,1/0) then error(funcname.." bad arg2 Infinity check") end
            if pcall(funcvar,maxval+1,0) then error(funcname.." bad arg1 max check") end
            if pcall(funcvar,minval-1,0) then error(funcname.." bad arg1 min check") end
	    if operation ~= "shift" then
                if pcall(funcvar,0,maxval+1) then error(funcname.." bad arg2 max check") end
		if pcall(funcvar,0,minval-1) then error(funcname.." bad arg2 min check") end
	    end
        end
        if args == 1 then
            if pcall(funcvar,3.3) then error(funcname.." bad arg1 fract check") end
            if pcall(funcvar,_NaN) then error(funcname.." bad arg1 NaN check") end
            if pcall(funcvar,1/0) then error(funcname.." bad arg1 Infinity check") end
            if pcall(funcvar,maxval+1) then error(funcname.." bad arg1 max check") end
            if pcall(funcvar,minval-1) then error(funcname.." bad arg1 min check") end
        end
	-- Perform some legal operations and see if the result is as expected.
	if operation == "add" then
	    if minval ~= funcvar(maxval,1) then error(funcname.." overflow expected") end
	    if signed and maxval ~= funcvar(minval,-1) then error(funcname.." underflow expected") end
	    if minval ~= funcvar(1,maxval) then error(funcname.." overflow expected") end
	    if signed and maxval ~= funcvar(-1,minval) then error(funcname.." underflow expected") end
	elseif operation == "and" then
	    if maxval ~= funcvar(maxval,maxval) then error(funcname.." maxval expected") end
	    if minval ~= funcvar(minval,minval) then error(funcname.." minval expected") end
	    if 0 ~= funcvar(maxval,0) then error(funcname.." all bits zero expected") end
	    if 0 ~= funcvar(0,maxval) then error(funcname.." all bits zero expected") end
	    if 0 ~= funcvar(minval,0) then error(funcname.." all bits zero expected") end
	    if 0 ~= funcvar(0,minval) then error(funcname.." all bits zero expected") end
	elseif operation == "invert" then
	    if minval ~= funcvar(maxval) then error(funcname.." bad inversion, minval expected") end
	    if maxval ~= funcvar(minval) then error(funcname.." bad inversion, maxval expected") end
	    if signed then
 	        if -1 ~= funcvar(0) then error(funcname.." bad inversion, -1 expected") end
 	        if 0 ~= funcvar(-1) then error(funcname.." bad inversion, 0 expected") end
	    end
	elseif operation == "or" then
	    if maxval ~= funcvar(maxval,maxval) then error(funcname.." maxval expected") end
	    if minval ~= funcvar(minval,minval) then error(funcname.." minval expected") end
	    if maxval ~= funcvar(maxval,0) then error(funcname.." all maxval expected") end
	    if maxval ~= funcvar(0,maxval) then error(funcname.." all maxval expected") end
	    if minval ~= funcvar(minval,0) then error(funcname.." all minval expected") end
	    if minval ~= funcvar(0,minval) then error(funcname.." all minval expected") end
	elseif operation == "sub" then
	    if maxval ~= funcvar(minval,1) then error(funcname.." underflow expected") end
	    if signed and minval ~= funcvar(maxval,-1) then error(funcname.." overflow expected") end
	elseif operation == "shift" then
	    if 2^(bits-2) ~= funcvar(1,bits-2) then error(funcname.." bad shift") end
	    if 1 ~= funcvar(2^(bits-2),-(bits-2)) then error(funcname.." bad shift, expected 1") end
	    if 0 ~= funcvar(maxval, bits) then error(funcname.." bad shift, expected 0") end
            if 0 ~= funcvar(maxval, -bits) then error(funcname.." bad shift, expected 0") end
	    if signed then
                 if -1 ~= funcvar(minval, -bits) then error(funcname.." bad shift, expected -1") end
                 if -1 ~= funcvar(minval, -(bits-1)) then error(funcname.." bad shift, expected -1") end
	    end
	elseif operation == "xor" then
	    if 0 ~= funcvar(maxval,maxval) then error(funcname.." zero expected") end
	    if 0 ~= funcvar(minval,minval) then error(funcname.." zero expected") end
	    if maxval ~= funcvar(maxval,0) then error(funcname.." all maxval expected") end
	    if maxval ~= funcvar(0,maxval) then error(funcname.." all maxval expected") end
	    if minval ~= funcvar(minval,0) then error(funcname.." all minval expected") end
	    if minval ~= funcvar(0,minval) then error(funcname.." all minval expected") end	end
    end
end

-- Testing path substitutions
prior=lv.substitute_separators(true)
assert("foo".._SEP.."bar" == lv.topath("foo/bar"),"lv.topath() failed")
if _SEP ~= ":" then
	if "foo".._SEP.."bar" ~= lv.topath("foo/baz/../bar") then error("lv.topath() failed") end
    if "foo".._SEP.."bar" ~= lv.topath([[foo\baz\..\bar]]) then error("lv.topath() failed") end
end
lv.substitute_separators(prior)
