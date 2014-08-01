-- Test the flat data push and pull LabVIEW API from Lua

function subset(t1,t2)
    -- see if t2 holds everything t1 does
    for k,v in pairs(t1) do
        if not t2[k] then return false end
        if type(t1[k])~=type(t2[k]) then return false end
        if type(t1[k])=="table" then
            if not equals(t1[k],t2[k]) then return false end
        else
            if t1[k]~=t2[k] then return false end
        end
    end
    return true
end
function equals(t1,t2)
    -- see if two items have the same value or, in case of tables, hold the same content.
    if type(t1)=="table" then
        if type(t2)~="table" then return false end
        return subset(t1,t2) and subset(t2,t1)
    end
    return t1==t2
end
function duplicate(t)
    -- duplicate a table
    local dup={}
    for k,v in pairs(t) do
        if type(t[k])=="table" then
            dup[k]=duplicate(t[k])
        else
            dup[k]=t[k]
        end
    end
    return dup
end

function bad() end -- something unpushable/unpullable

-- Quick test of push/pull path. Detailed tests follow later.
push_pull_path()
prior=lv.substitute_separators(true)
assert("foo".._SEP.."bar"==pull_push_path("foo/bar"),"Separator substitution failed")
assert("foo".._SEP.."bar"==pull_push_path([[foo\bar]]),"Separator substitution failed")
lv.substitute_separators(prior)

-- Some hardwired enum with items "foo", "bar", "baz"
assert("foo"==pull_enum("foo"),"Item mismatch")
assert("bar"==pull_enum("bar"),"Item mismatch")
assert("baz"==pull_enum("baz"),"Item mismatch")
assert(not lv.pcall(pull_enum,""),"Enum mismatch not detected")
assert(not lv.pcall(pull_enum,"mooooooo!"),"Enum mismatch not detected")

name="extended precision number"
t=string.char(0,0,0,4,0,8,64,11,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected unsupported type")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)

name="single precision complex number"
t=string.char(0,0,0,4,0,8,64,12,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected unsupported type")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)

name="double precision complex number"
t=string.char(0,0,0,4,0,8,64,13,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected unsupported type")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)

name="extended precision complex number"
t=string.char(0,0,0,4,0,8,64,14,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected unsupported type")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)

name="single precision physical quantity"
t=string.char(0,0,0,9,0,18,64,25,0,2,0,2,255,255,0,3,0,1,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected unsupported type")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)

name="double precision physical quantity"
t=string.char(0,0,0,9,0,18,64,26,0,2,0,2,255,255,0,3,0,1,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected unsupported type")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)

name="extended precision physical quantity"
t=string.char(0,0,0,9,0,18,64,27,0,2,0,2,255,255,0,3,0,1,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected unsupported type")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)

name="single precision complex physical quantity"
t=string.char(0,0,0,9,0,18,64,28,0,2,0,2,255,255,0,3,0,1,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected unsupported type")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)

name="double precision complex physical quantity"
t=string.char(0,0,0,9,0,18,64,29,0,2,0,2,255,255,0,3,0,1,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected unsupported type")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)

name="extended precision physical quantity"
t=string.char(0,0,0,9,0,18,64,30,0,2,0,2,255,255,0,3,0,1,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected unsupported type")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)

name="picture"
t=string.char(0,0,0,6,0,12,64,51,255,255,255,255,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected unsupported type")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)

name="waveform"
t=string.char(0,0,0,69,0,138,64,84,0,14,0,128,0,80,0,5,0,32,64,84,0,6,0,22,0,80,0,4,0,4,0,3,0,4,0,3,0,4,0,3,0,4,0,3,2,116,48,0,0,8,64,10,2,100,116,0,0,16,64,64,0,1,255,255,255,255,0,4,0,1,1,89,0,50,64,80,0,3,0,12,64,33,6,115,116,97,116,117,115,0,0,10,64,3,4,99,111,100,101,0,0,16,64,48,255,255,255,255,6,115,111,117,114,99,101,0,5,101,114,114,111,114,0,16,64,83,10,97,116,116,114,105,98,117,116,101,115,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected unsupported type")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)

name="nested variant"
t=string.char(0,0,0,4,0,8,64,83,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected unsupported type")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)

name="I8"
t=string.char(0,0,0,4,0,8,64,1,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=123
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
d=-2^7
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
d=-1
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
d=-2^6
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(not lv.pcall(pull,t,-2^7-1),"Type "..name..": undetected information loss")
assert(not lv.pcall(pull,t,2^7),"Type "..name..": undetected information loss")
assert(not lv.pcall(pull,t,1.23),"Type "..name..": undetected information loss")
assert(not lv.pcall(push,t,""),"Type "..name..": empy flat data string not detected")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
assert(d==push(t,default(t,pull(t,d))),"Type "..name..": failed implicit nil default substitution")

name="I16"
t=string.char(0,0,0,4,0,8,64,2,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=12345
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
d=-2^15
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
d=-1
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
d=-2^14
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(not lv.pcall(pull,t,-2^15-1),"Type "..name..": undetected information loss")
assert(not lv.pcall(pull,t,2^15),"Type "..name..": undetected information loss")
assert(not lv.pcall(pull,t,1.23),"Type "..name..": undetected information loss")
assert(not lv.pcall(push,t,""),"Type "..name..": empy flat data string not detected")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
assert(d==push(t,default(t,pull(t,d))),"Type "..name..": failed implicit nil default substitution")

name="I32"
t=string.char(0,0,0,4,0,8,64,3,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=123456789
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
d=-2^31
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
d=-1
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
d=-2^30
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(not lv.pcall(pull,t,-2^31-1),"Type "..name..": undetected information loss")
assert(not lv.pcall(pull,t,2^31),"Type "..name..": undetected information loss")
assert(not lv.pcall(pull,t,1.23),"Type "..name..": undetected information loss")
assert(not lv.pcall(push,t,""),"Type "..name..": empy flat data string not detected")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
assert(d==push(t,default(t,pull(t,d))),"Type "..name..": failed implicit nil default substitution")

name="U8"
t=string.char(0,0,0,4,0,8,64,5,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=123
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
assert(d==push(t,default(t,pull(t,d))),"Type "..name..": failed implicit nil default substitution")
assert(not lv.pcall(pull,t,-1),"Type "..name..": undetected information loss")
assert(not lv.pcall(pull,t,2^8),"Type "..name..": undetected information loss")
assert(not lv.pcall(pull,t,1.23),"Type "..name..": undetected information loss")
assert(not lv.pcall(push,t,""),"Type "..name..": empy flat data string not detected")

name="U16"
t=string.char(0,0,0,4,0,8,64,6,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=12345
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
assert(not lv.pcall(pull,t,-1),"Type "..name..": undetected information loss")
assert(not lv.pcall(pull,t,2^16),"Type "..name..": undetected information loss")
assert(not lv.pcall(pull,t,1.23),"Type "..name..": undetected information loss")
assert(not lv.pcall(push,t,"a"),"Type "..name..": too short flat data string not detected")

name="U32"
t=string.char(0,0,0,4,0,8,64,7,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=123456789
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
assert(not lv.pcall(pull,t,-1),"Type "..name..": undetected information loss")
assert(not lv.pcall(pull,t,2^32),"Type "..name..": undetected information loss")
assert(not lv.pcall(pull,t,1.23),"Type "..name..": undetected information loss")

name="float32"
t=string.char(0,0,0,4,0,8,64,9,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=0
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d=1234
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d=2^(-12)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d=push(t,string.char(1,2,3,4))
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d=_NaN
assert(lv.isnan(push(t,pull(t,d))),"Type "..name..": pull-push mismatch")

name="float64"
t=string.char(0,0,0,4,0,8,64,10,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=0
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d=1234
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d=2^(-12)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d=push(t,string.char(1,2,3,4,5,6,7,8))
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d=_NaN
assert(lv.isnan(push(t,pull(t,d))),"Type "..name..": pull-push mismatch")

name="U8 enum with items `the', `quick', and `brown'"
t=string.char(0,0,0,13,0,26,64,21,0,3,3,116,104,101,5,113,117,105,99,107,5,98,114,111,119,110,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
assert(not lv.pcall(push,t,string.char(3)),"Type "..name..": enum out of range not detected")
assert(not lv.pcall(pull,t,"bogus"),"Type "..name..": item mismatch not detected")
d="the"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="quick"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="brown"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="U8 enum with items `' and `foo'"
t=string.char(0,0,0,8,0,16,64,21,0,2,0,3,102,111,111,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
assert(not lv.pcall(pull,t,"bogus"),"Type "..name..": item mismatch not detected")
d=""
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="foo"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="U8 enum without items"
t=string.char(0,0,0,3,0,6,0,21,0,0)
assert(not lv.pcall(pull,t,"a"),"Type "..name..": zero enum items not detected")

name="U16 enum with items `the', `quick', and `brown'"
t=string.char(0,0,0,13,0,26,64,22,0,3,3,116,104,101,5,113,117,105,99,107,5,98,114,111,119,110,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
assert(not lv.pcall(push,t,string.char(0,3)),"Type "..name..": enum out of range not detected")
assert(not lv.pcall(pull,t,"bogus"),"Type "..name..": item mismatch not detected")
d="the"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="quick"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="brown"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="U16 enum with items `' and `foo'"
t=string.char(0,0,0,8,0,16,64,22,0,2,0,3,102,111,111,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
assert(not lv.pcall(pull,t,"bogus"),"Type "..name..": item mismatch not detected")
d=""
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="foo"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="U16 enum without items"
t=string.char(0,0,0,3,0,6,0,22,0,0)
assert(not lv.pcall(pull,t,"a"),"Type "..name..": zero enum items not detected")

name="U32 enum with items `the', `quick', and `brown'"
t=string.char(0,0,0,13,0,26,64,23,0,3,3,116,104,101,5,113,117,105,99,107,5,98,114,111,119,110,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
assert(not lv.pcall(push,t,string.char(0,0,0,3)),"Type "..name..": enum out of range not detected")
assert(not lv.pcall(pull,t,"bogus"),"Type "..name..": item mismatch not detected")
d="the"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="quick"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="brown"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="U32 enum with items `' and `foo'"
t=string.char(0,0,0,8,0,16,64,23,0,2,0,3,102,111,111,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
assert(not lv.pcall(pull,t,"bogus"),"Type "..name..": item mismatch not detected")
d=""
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="foo"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="U32 enum without items"
t=string.char(0,0,0,3,0,6,0,23,0,0)
assert(not lv.pcall(pull,t,"a"),"Type "..name..": zero enum items not detected")

name="Boolean"
t=string.char(0,0,0,4,0,8,64,33,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=true
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d=false
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="string"
t=string.char(0,0,0,6,0,12,64,48,255,255,255,255,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=""
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="A"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="abcd\0efghijkl"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="path"
t=string.char(0,0,0,6,0,12,64,50,255,255,255,255,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected unsupported type")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d="moo".._SEP.."moo"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="woof".._SEP.."moo".._SEP.."arf"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="Application refnum"
t=string.char(0,0,0,7,0,14,64,112,0,8,0,1,0,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=push_refnum(1234567)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="VI refnum"
t=string.char(0,0,0,8,0,16,64,112,0,8,0,2,0,4,0,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=push_refnum(1234567)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="callable VI refnum"
t=string.char(0,0,0,186,1,116,64,112,0,8,0,2,1,104,3,240,0,16,1,8,0,0,0,0,0,0,0,0,9,0,0,0,0,0,18,0,9,0,0,0,0,0,8,0,0,0,0,0,0,0,9,0,0,4,0,0,0,4,0,0,0,4,0,0,0,4,0,0,0,124,64,64,0,1,255,255,255,255,0,100,64,80,0,5,0,14,64,50,255,255,255,255,4,112,97,116,104,0,0,20,64,48,255,255,255,255,11,100,101,115,99,114,105,112,116,105,111,110,0,14,64,48,255,255,255,255,4,116,101,120,116,0,0,18,64,3,12,112,97,114,101,110,116,32,105,110,100,101,120,0,0,16,64,48,255,255,255,255,7,118,101,114,115,105,111,110,11,115,99,114,105,112,116,32,105,110,102,111,12,115,99,114,105,112,116,32,105,110,102,111,115,0,0,4,0,0,0,4,0,0,0,20,64,48,255,255,255,255,11,99,101,114,116,105,102)
..string.char(105,99,97,116,101,0,58,64,64,0,1,255,255,255,255,0,34,0,80,0,1,0,28,64,64,0,1,255,255,255,255,0,4,0,3,12,108,105,110,101,32,110,117,109,98,101,114,115,0,13,115,99,114,105,112,116,32,101,114,114,111,114,115,0,4,0,0,0,4,0,0,0,20,64,48,255,255,255,255,10,105,100,101,110,116,105,102,105,101,114,0,0,4,0,0,0,4,0,0,0,4,0,0,0,54,64,80,0,3,0,12,64,33,6,115,116,97,116,117,115,0,0,10,64,3,4,99,111,100,101,0,0,16,64,48,255,255,255,255,6,115,111,117,114,99,101,0,9,101,114,114,111,114,32,111,117,116,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=push_refnum(1234567)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="Control refnum"
t=string.char(0,0,0,8,0,16,64,112,0,8,0,6,0,4,0,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=push_refnum(1234567)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="Generic refnum"
t=string.char(0,0,0,8,0,16,64,112,0,8,0,3,0,4,0,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=push_refnum(1234567)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="Some datalog file refnum"
t=string.char(0,0,0,26,0,52,64,112,0,1,0,42,64,80,0,1,0,32,64,64,0,1,255,255,255,255,0,16,0,80,0,1,0,10,64,1,4,98,98,98,98,0,4,97,97,97,97,0,2,64,65,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=push_refnum(1234567)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="Byte stream file refnum"
t=string.char(0,0,0,5,0,10,64,112,0,2,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=push_refnum(1234567)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="Occurrence refnum"
t=string.char(0,0,0,5,0,10,64,112,0,4,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=push_refnum(1234567)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="TCP refnum"
t=string.char(0,0,0,5,0,10,64,112,0,5,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=push_refnum(1234567)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="Automation refnum"
t=string.char(0,0,0,6,0,12,64,112,0,7,1,15,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=push_refnum(1234567)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
t=string.char(0,0,0,40,0,80,64,112,0,7,69,16,0,0,0,2,0,2,69,0,0,0,0,0,192,0,0,0,0,0,0,70,0,0,0,4,0,2,8,213,0,0,0,0,192,0,0,0,0,0,0,70,0,0,0,1,0,2,8,19,0,0,0,0,192,0,0,0,0,0,0,70,0,0,0,1,0,0,0,2,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=push_refnum(1234567)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="Menu refnum"
t=string.char(0,0,0,5,0,10,64,112,0,9,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=push_refnum(1234567)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="Datasocket refnum"
t=string.char(0,0,0,5,0,10,64,112,0,13,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=push_refnum(1234567)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="UDP refnum"
t=string.char(0,0,0,5,0,10,64,112,0,16,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=push_refnum(1234567)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="IrDA refnum"
t=string.char(0,0,0,5,0,10,64,112,0,19,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=push_refnum(1234567)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="Imaq session"
t=string.char(0,0,0,8,0,16,64,112,0,11,4,73,77,65,81,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=push_refnum(1234567)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="Event callback refnum"
t=string.char(0,0,0,13,0,26,64,112,0,27,14,69,118,101,110,116,32,67,97,108,108,98,97,99,107,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=push_refnum(1234567)
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="VISA resource name"
t=string.char(0,0,0,8,0,16,64,112,0,14,5,73,110,115,116,114,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=""
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="A"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="abcd\0efghijkl"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="IVI logical name"
t=string.char(0,0,0,8,0,16,64,112,0,15,5,3,73,86,73,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=""
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="A"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="abcd\0efghijkl"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="Field point IO point"
t=string.char(0,0,0,18,0,36,64,112,0,21,10,70,105,101,108,100,80,111,105,110,116,0,13,70,105,101,108,100,80,111,105,110,116,32,73,79,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=""
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="A"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="abcd\0efghijkl"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="Motion resource"
t=string.char(0,0,0,10,0,20,64,112,0,21,6,77,111,116,105,111,110,0,0,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=""
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
-- These tests crash in LabVIEW >= 2009 in the test VI when attempting to unflatten the
-- resulting data to a variant
--d="A"
--assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
--assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
--d="abcd\0efghijkl"
--assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
--assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="DAQ MX task"
t=string.char(0,0,0,11,0,22,64,112,0,21,5,78,73,68,65,81,4,84,97,115,107,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=""
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="A"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="abcd\0efghijkl"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="Traditional DAQ channel"
t=string.char(0,0,0,7,0,14,64,55,255,255,255,255,0,2,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=""
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="A"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="abcd\0efghijkl"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="DAQ MX switch"
t=string.char(0,0,0,7,0,14,64,55,255,255,255,255,0,16,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=""
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="A"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="abcd\0efghijkl"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="DAQ MX device"
t=string.char(0,0,0,7,0,14,64,55,255,255,255,255,0,12,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=""
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="A"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="abcd\0efghijkl"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="DAQ MX physical channel"
t=string.char(0,0,0,7,0,14,64,55,255,255,255,255,0,14,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d=""
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="A"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")
d="abcd\0efghijkl"
assert(d==push(t,pull(t,d)),"Type "..name..": pull-push mismatch")
assert(d==push(t,default(t,pull(t,d),nil)),"Type "..name..": failed default substitution")

name="empty cluster"
t=string.char(0,0,0,5,0,10,64,80,0,0,3,64,65,66)
d={}
assert(not lv.pcall(pull,t,d),"Empty cluster not detected")

name="cluster with one unnamed element"
t=string.char(0,0,0,7,0,14,64,80,0,1,0,4,0,5,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d={[""]=0}
def=string.char(0)
assert(not lv.pcall(pull,t,d),"Type "..name..": empty cluster not detected")
assert(not lv.pcall(push,t,def),"Type "..name..": empty cluster not detected")

name="cluster with 2nd element unnamed"
t=string.char(0,0,0,12,0,24,64,80,0,2,0,10,64,5,4,65,65,65,65,0,0,4,0,5,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d={["AAAA"]=0,[""]=0}
def=string.char(0,0)
assert(not lv.pcall(pull,t,d),"Type "..name..": empty cluster not detected")
assert(not lv.pcall(push,t,def),"Type "..name..": empty cluster not detected")

name="cluster with synonymous elements"
t=string.char(0,0,0,15,0,30,64,80,0,2,0,10,64,5,4,65,65,65,65,0,0,10,64,5,4,65,65,65,65,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
def=string.char(0,0)
assert(not lv.pcall(push,t,def),"Type "..name..": identical cluster element names not detected")

name="cluster with 2 U8 elements named 'AAAA' and 'BBBB'"
t=string.char(0,0,0,15,0,30,64,80,0,2,0,10,64,5,4,65,65,65,65,0,0,10,64,5,4,66,66,66,66,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d={AAAA=111,BBBB=222}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
d2=duplicate(d)
d2.AAAA=nil
assert(not lv.pcall(pull,t,d2),"Type "..name..": missing element(s) not detected")
assert(equals(d,push(t,default(t,pull(t,d),d2))),"Type "..name..": failed default substitution")
d2=duplicate(d)
d2.BBBB=nil
assert(not lv.pcall(pull,t,d2),"Type "..name..": missing element(s) not detected")
assert(equals(d,push(t,default(t,pull(t,d),d2))),"Type "..name..": failed default substitution")
d2={}
assert(not lv.pcall(pull,t,d2),"Type "..name..": missing element(s) not detected")
assert(equals(d,push(t,default(t,pull(t,d),d2))),"Type "..name..": failed default substitution")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={AAAA=111,BBBB=222}
assert(equals({"AAAA","BBBB"},push(t,pull(t,d),true)["_cluster_order"]),"bad cluster order")
pull(t,push(t,pull(t,d),true))

name="cluster containing U16 'A' and nested cluster 'B' with U8's 'BA' and 'BB'"
t=string.char(0,0,0,20,0,40,64,80,0,2,0,6,64,6,1,65,0,24,64,80,0,2,0,8,64,5,2,66,65,0,0,8,64,5,2,66,66,0,1,66,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d={A=2^16-1,B={BA=0,BB=255}}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
d2=duplicate(d)
d2.B.BA=nil
assert(not lv.pcall(pull,t,d2),"Type "..name..": missing element(s) not detected")
assert(equals(d,push(t,default(t,pull(t,d),d2))),"Type "..name..": failed default substitution")
d2=duplicate(d)
d2.B.BB=nil
assert(not lv.pcall(pull,t,d2),"Type "..name..": missing element(s) not detected")
assert(equals(d,push(t,default(t,pull(t,d),d2))),"Type "..name..": failed default substitution")
d2.B={}
assert(not lv.pcall(pull,t,d2),"Type "..name..": missing element(s) not detected")
assert(equals(d,push(t,default(t,pull(t,d),d2))),"Type "..name..": failed default substitution")
d={A=2^16-1,B={BA=0,BB=255}}
assert(equals({"A","B"},push(t,pull(t,d),true)["_cluster_order"]),"bad cluster order")
assert(equals({"BA","BB"},push(t,pull(t,d),true)["B"]["_cluster_order"]),"bad cluster order")
pull(t,push(t,pull(t,d),true))

name="Nested clusters E in D in C in B in A with E holding U16 F"
t=string.char(0,0,0,28,0,56,64,80,0,1,0,46,64,80,0,1,0,38,64,80,0,1,0,30,64,80,0,1,0,22,64,80,0,1,0,14,64,80,0,1,0,6,64,6,1,70,1,69,1,68,1,67,1,66,1,65,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d={A={B={C={D={E={F=12345}}}}}}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
d2=duplicate(d)
d2.A.B.C.D.E.F=nil
assert(not lv.pcall(pull,t,d2),"Type "..name..": missing element(s) not detected")
assert(equals(d,push(t,default(t,pull(t,d),d2))),"Type "..name..": failed default substitution")
d={A={B={C={D={E={F=12345}}}}}}
assert(equals({"A"},push(t,pull(t,d),true)["_cluster_order"]),"bad cluster order")
assert(equals({"B"},push(t,pull(t,d),true)["A"]["_cluster_order"]),"bad cluster order")
assert(equals({"C"},push(t,pull(t,d),true)["A"]["B"]["_cluster_order"]),"bad cluster order")
assert(equals({"F"},push(t,pull(t,d),true)["A"]["B"]["C"]["D"]["E"]["_cluster_order"]),"bad cluster order")
pull(t,push(t,pull(t,d),true))

name="U8 1D Array"
t=string.char(0,0,0,9,0,18,64,64,0,1,255,255,255,255,0,4,0,5,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d={}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={1}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={1,2}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
flat=string.char(128,0,0,0)
assert(not lv.pcall(push,t,flat),"Dimensions >= 2^32 should fail")

name="U8 2D Array"
t=string.char(0,0,0,11,0,22,64,64,0,2,255,255,255,255,255,255,255,255,0,4,0,5,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d={} -- 0x0
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={{}} -- 1x0
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={{},{}} -- 2x0
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={{1,2},{3,4}} -- 2x2
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
flat=string.char(0,0,0,0,0,0,0,2) -- 0x2
assert(not lv.pcall(push,t,flat),"Non-zero dimensions after zero dimensions should fail")
d={{1},{}} -- mismatching "sub-array" sizes
assert(not lv.pcall(pull,t,d),"Mismatching sub table sizes not detected")
d={{1,2},{3,4},{5,6,7}} -- mismatching "sub-array" sizes
assert(not lv.pcall(pull,t,d),"Mismatching sub table sizes not detected")

name="U8 3D Array"
t=string.char(0,0,0,13,0,26,64,64,0,3,255,255,255,255,255,255,255,255,255,255,255,255,0,4,0,5,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d={} -- 0x0x0
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={{}} -- 1x0x0
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={{{}}} -- 1x1x0
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={{{}},{{}}} -- 2x1x0
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={{{1,2},{3,4}},{{5,6},{7,8}}} -- 2x2x2
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
flat=string.char(0,0,0,0,0,0,0,2,0,0,0,0) -- 0x2x0
assert(not lv.pcall(push,t,flat),"Non-zero dimensions after zero dimensions should fail")
flat=string.char(0,0,0,00,0,0,0,0,0,0,2) -- 0x0x2
assert(not lv.pcall(push,t,flat),"Non-zero dimensions after zero dimensions should fail")
d={{{1}},{{}}} -- mismatching "sub-array" sizes
assert(not lv.pcall(pull,t,d),"Mismatching sub table sizes not detected")
d={{{1,2},{3,4},{5,6,7}}} -- mismatching "sub-array" sizes
assert(not lv.pcall(pull,t,d),"Mismatching sub table sizes not detected")

name="1D Array of clusters holding U8 'a' and 'U16' 'b'"
t=string.char(0,0,0,16,0,32,64,64,0,1,255,255,255,255,0,18,0,80,0,2,0,6,64,5,1,97,0,6,64,6,1,98,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d={}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={{a=1,b=2}}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={{a=1,b=2},{a=3,b=4}}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
def=pull(t,d)
d[2]["b"]=nil
assert(not lv.pcall(default,t,def,d),"Type "..name..": default substitutions inside an array should fail")

name="cluster containing 1D array 'aaaa' holding unnamed U8 elements"
t=string.char(0,0,0,15,0,30,64,80,0,1,0,20,64,64,0,1,255,255,255,255,0,4,0,1,4,97,97,97,97,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d={}
assert(not lv.pcall(pull,d),"Type "..name..": missing cluster element should fail")
d={aaaa={1,2}}
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
assert(equals(d,push(t,default(t,pull(t,d),{}))),"Type "..name..": failed default substitution")
d={aaaa={}}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={aaaa={1}}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={aaaa={2,1}}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")

name="cluster containing 2D array 'aaaa' holding U8 elements named 'bbbb'"
t=string.char(0,0,0,20,0,40,64,80,0,1,0,30,64,64,0,2,255,255,255,255,255,255,255,255,0,10,64,1,4,98,98,98,98,0,4,97,97,97,97,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d={}
assert(not lv.pcall(pull,d),"Type "..name..": missing cluster element should fail")
d={aaaa={{1,2},{3,4}}}
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
assert(equals(d,push(t,default(t,pull(t,d),{}))),"Type "..name..": failed default substitution")
d={aaaa={}}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={aaaa={{}}}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={aaaa={{2,1}}}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={aaaa={{2,1},{4,3}}}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={aaaa={{2,1},{4}}}
assert(not lv.pcall(pull,d),"Type "..name..": mismatching table array sizes not detectedl")

name="cluster containing 1D array 'aaaa' holding clusters with one U8 element 'bbbb'"
t=string.char(0,0,0,21,0,42,64,80,0,1,0,32,64,64,0,1,255,255,255,255,0,16,0,80,0,1,0,10,64,1,4,98,98,98,98,0,4,97,97,97,97,0,3,64,65,66)
ok,err=lv.pcall(pull,t,bad)
assert(not ok,"Type "..name..": undetected type mismatch")
assert(string.find(err,"\"@AB\""),"Type "..name..": name missing in type error: "..err)
d={}
assert(not lv.pcall(pull,t,d),"Type "..name..": missing cluster element should fail")
d={aaaa={{bbbb=42}}}
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
assert(equals(d,push(t,default(t,pull(t,d),{}))),"Type "..name..": failed default substitution")
assert(not lv.pcall(default,t,pull(t,d),{aaaa={{}}}),"Type "..name..": default substitution inside an array should not be possible")
d={aaaa={}}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={aaaa={{bbbb=11},{bbbb=12}}}
assert(equals(d,push(t,pull(t,d))),"Type "..name..": pull-push mismatch")
assert(equals(d,push(t,default(t,pull(t,d),nil))),"Type "..name..": failed default substitution")
d={aaaa={1}}
assert(not lv.pcall(pull,t,d),"Type "..name..": wrong array element should fail")
d={aaaa={{bbbb=42}}}
assert(equals({"bbbb"},push(t,pull(t,d),true)["aaaa"][1]["_cluster_order"]),"bad cluster order")
pull(t,push(t,pull(t,d),true))
d={aaaa={{bbbb=123},{bbbb=42}}}
assert(equals({"bbbb"},push(t,pull(t,d),true)["aaaa"][1]["_cluster_order"]),"bad cluster order")
assert(equals({"bbbb"},push(t,pull(t,d),true)["aaaa"][2]["_cluster_order"]),"bad cluster order")
pull(t,push(t,pull(t,d),true))
