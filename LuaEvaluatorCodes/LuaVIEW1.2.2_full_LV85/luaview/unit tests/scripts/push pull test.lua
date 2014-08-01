-- Test the LabVIEW-side single-element push/pull API from Lua and
-- also test the  per-LuaVIEW-state print buffer polling API VI.

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
assert(simubuf==dump(),"Print buffer mismatch")
lv.print()
simuprint()
assert(simubuf==dump(),"Print buffer mismatch")
lv.print(1)
simuprint(1)
assert(simubuf==dump(),"Print buffer mismatch")
lv.print(pi)
simuprint(pi)
assert(simubuf==dump(),"Print buffer mismatch")
pollbuf,pollindex=poll(0)
assert(simubuf==pollbuf,"Poll mismatch")
lv.print("wibble wobble")
simuprint("wibble wobble")
assert(simubuf==dump(),"Print buffer mismatch")
pollbuf,pollindex=poll(pollindex)
assert("wibble wobble\n"==pollbuf,"Poll mismatch")
lv.print("foo",nil,false,simuprint)
simuprint("foo",nil,false,simuprint)
randomprint(printbuflen-string.len(simubuf)-1)
assert(simubuf==dump(),"Print buffer mismatch")
assert(printbuflen==string.len(dump()),"Expecting a full buffer")
randomprint(floor(1.5*printbuflen))
assert(simubuf==dump(),"Print buffer mismatch")
assert(printbuflen==string.len(dump()),"Expecting a full buffer")
randomprint(floor(printbuflen/3))
assert(simubuf==dump(),"Print buffer mismatch")
assert(printbuflen==string.len(dump()),"Expecting a full buffer")
randomprint(floor(printbuflen/7))
assert(simubuf==dump(),"Print buffer mismatch")
assert(printbuflen==string.len(dump()),"Expecting a full buffer")
randomprint(floor(printbuflen/2))
assert(simubuf==dump(),"Print buffer mismatch")
assert(printbuflen==string.len(dump()),"Expecting a full buffer")

if (lv.pcall(pull_boolean, nil)) then error("Bad type check") end
if (lv.pcall(pull_boolean, 1)) then error("Bad type check") end
if (lv.pcall(pull_boolean, "")) then error("Bad type check") end
if (lv.pcall(pull_boolean, {})) then error("Bad type check") end
b = pass_boolean(true)
if (b ~= true) then error("Boolean mismatch") end
b = pass_boolean(false)
if (b ~= false) then error("Boolean mismatch") end

pull_number("123")
pull_number("1e7")
pull_number("0.34567")
if (lv.pcall(pull_number, nil)) then error("Bad type check") end
if (lv.pcall(pull_number, "")) then error("Bad type check") end
if (lv.pcall(pull_number, {})) then error("Bad type check") end
n1 = random()
n2 = pass_number(n1)
if (n1 ~= n2) then error("Number mismatch") end

pull_string("zoom")
pull_string(123)
pull_string(1e7)
pull_string(0.34567)
if (lv.pcall(pull_string, nil)) then error("Bad type check") end
if (lv.pcall(pull_string, {})) then error("Bad type check") end
s1 = tostring(random())
s2 = pass_string(s1)
if (s1 ~= s2) then error("String mismatch") end
s1 = "\0\0\0\0\0"
s2 = pass_string(s1)
if (s1 ~= s2) then error("String with null bytes mismatch") end

pull_path("zoom")
pull_path(123)
pull_path(1e7)
pull_path(0.34567)
if (lv.pcall(pull_path, nil)) then error("Bad type check") end
if (lv.pcall(pull_path, {})) then error("Bad type check") end
s1 = "foo/bar/baz"
s2 = pass_path(s1)
if (lv.topath(s1) ~= s2) then error("String-path-string conversion mismatch") end
s1 = "foo/bar/../baz"
s2 = pass_path(s1)
if (lv.topath(s1) ~= s2) then error("String-path-string conversion mismatch") end

if (lv.pcall(pull_object, nil)) then error("Bad type check") end
if (lv.pcall(pull_object, 1)) then error("Bad type check") end
if (lv.pcall(pull_object, "")) then error("Bad type check") end
if (lv.pcall(pull_object, {})) then error("Bad type check") end
u1 = floor(random()*2^32)
if (lv.pcall(push_object,u1,"not a table")) then error("Bad method table check") end
o1 = push_object(u1,"")
o2 = push_object(u1,"")
u2 = pull_object(o1)
if (u1 ~= u2) then error("Object mismatch") end
if (o1 == o2) then error("Objects should not be comparable by value on the Lua side") end

FOO = {}
FOO.value = function(self) return pull_object(self) end

u = floor(random()*2^32)
o = push_object(u,"FOO")
if (u ~= o:value()) then error("Messed up method call") end
if (lv.pcall(push_object, 1, "no_such_method_table")) then
    error("Bad method table should fail")
end

-- Setting attributes
o = push_object(u,"FOO")
v = "some attribute value"
set_object_attribute("attribute", o, v)
if (v ~= o.attribute) then error("Messed up attribute") end
o = push_object(123,"")
set_object_attribute("attribute", o, v)
if (v ~= o.attribute) then error("Messed up attribute") end
if (lv.pcall(unchecked_soa,"attribute")) then
    error("Missing object and value should fail")
end
if (lv.pcall(unchecked_soa,"attribute",o)) then
    error("Missing value should fail")
end
if (lv.pcall(unchecked_soa,"attribute",nil,v)) then
    error("Not an object should fail")
end

-- Getting attributes
o = push_object(u,"FOO")
v = 54321
set_object_attribute("attribute", o, v)
if (v ~= get_object_attribute("attribute",o)) then error("Cannot get attribute") end
if (lv.pcall(unchecked_goa,"attribute")) then
    error("Missing object should fail")
end
if (lv.pcall(unchecked_goa,"attribute",nil)) then
    error("Not an object should fail")
end

o = push_object(u,"")
pull_object(o)
if (kill_object(o)) then error("Object should not be dead yet") end
if (lv.pcall(pull_object,o)) then
    error("Pulling a dead object should fail")
end
if (not kill_object(o)) then error("Object should already be dead") end

if (lv.pcall(pull_refnum, nil)) then error("Bad type check") end
if (lv.pcall(pull_refnum, 1)) then error("Bad type check") end
if (lv.pcall(pull_refnum, "")) then error("Bad type check") end
if (lv.pcall(pull_refnum, {})) then error("Bad type check") end
u1 = floor(random()*2^32)
r1 = push_refnum(u1)
r2 = push_refnum(u1)
u2 = pull_refnum(r1)
if (u1 ~= u2) then error("Refnum mismatch") end
if (r1 ~= r2) then error("Refnums should be comparable by value") end

pull_I8("123")
pull_I8(-2^7)
pull_I8(2^7-1)
if (lv.pcall(pull_I8, nil)) then error("Bad type check") end
if (lv.pcall(pull_I8, {})) then error("Bad type check") end
if (lv.pcall(pull_I8, 2^7)) then error("Bad range check") end
if (lv.pcall(pull_I8, -2^7-1)) then error("Bad range check") end
if (lv.pcall(pull_I8,0.123)) then error("Bad integer check") end
n1 = floor(random()*2^8)-2^7
n2 = pass_I8(n1)
if (n1 ~= n2) then error("I8 mismatch") end

pull_U8("123")
pull_U8(0)
pull_U8(2^8-1)
if (lv.pcall(pull_U8, nil)) then error("Bad type check") end
if (lv.pcall(pull_U8, {})) then error("Bad type check") end
if (lv.pcall(pull_U8, 2^8)) then error("Bad range check") end
if (lv.pcall(pull_U8,-1)) then error("Bad range check") end
if (lv.pcall(pull_U8,0.123)) then error("Bad integer check") end
n1 = floor(random()*2^8)
n2 = pass_U8(n1)
if (n1 ~= n2) then error("U8 mismatch") end

pull_I16("123")
pull_I16(-2^15)
pull_I16(2^15-1)
if (lv.pcall(pull_I16, nil)) then error("Bad type check") end
if (lv.pcall(pull_I16, {})) then error("Bad type check") end
if (lv.pcall(pull_I16, 2^15)) then error("Bad range check") end
if (lv.pcall(pull_I16, -2^15-1)) then error("Bad range check") end
if (lv.pcall(pull_I16,0.123)) then error("Bad integer check") end
n1 = floor(random()*2^16)-2^15
n2 = pass_I16(n1)
if (n1 ~= n2) then error("I16 mismatch") end

pull_U16("123")
pull_U16(0)
pull_U16(2^16-1)
if (lv.pcall(pull_U16, nil)) then error("Bad type check") end
if (lv.pcall(pull_U16, {})) then error("Bad type check") end
if (lv.pcall(pull_U16, 2^16)) then error("Bad range check") end
if (lv.pcall(pull_U16,-1)) then error("Bad range check") end
if (lv.pcall(pull_U16,0.123)) then error("Bad integer check") end
n1 = floor(random()*2^16)
n2 = pass_U16(n1)
if (n1 ~= n2) then error("U16 mismatch") end

pull_I32("123")
pull_I32(-2^31)
pull_I32(2^31-1)
if (lv.pcall(pull_I32, nil)) then error("Bad type check") end
if (lv.pcall(pull_I32, {})) then error("Bad type check") end
if (lv.pcall(pull_I32, 2^31)) then error("Bad range check") end
if (lv.pcall(pull_I32, -2^31-1)) then error("Bad range check") end
if (lv.pcall(pull_I32,0.123)) then error("Bad integer check") end
n1 = floor(random()*2^32)-2^31
n2 = pass_I32(n1)
if (n1 ~= n2) then error("I32 mismatch") end

pull_U32("123")
pull_U32(0)
pull_U32(2^32-1)
if (lv.pcall(pull_U32, nil)) then error("Bad type check") end
if (lv.pcall(pull_U32, {})) then error("Bad type check") end
if (lv.pcall(pull_U32, 2^32)) then error("Bad range check") end
if (lv.pcall(pull_U32,-1)) then error("Bad range check") end
if (lv.pcall(pull_U32,0.123)) then error("Bad integer check") end
n1 = floor(random()*2^32)
n2 = pass_U32(n1)
if (n1 ~= n2) then error("U32 mismatch") end
