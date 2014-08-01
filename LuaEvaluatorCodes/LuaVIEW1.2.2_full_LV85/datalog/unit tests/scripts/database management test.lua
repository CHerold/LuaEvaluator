--#import "../../resources/import/database management.lua"
db1path=xio.tmpdir().._SEP.."testdb1"
db2path=xio.tmpdir().._SEP.."testdb2"
db3path=xio.tmpdir().._SEP.."testdb3"
function xio.deletetree(path)
    local files,dirs=xio.listdir(path)
    for i,d in ipairs(dirs) do
        xio.deletetree(d)
    end
    for i,f in ipairs(files) do
        xio.delete(f)
    end
    xio.delete(path)
end

if (lv.pcall(xio.listdir,db1path)) then
    xio.deletetree(db1path)
end
xio.newdir(db1path)
lv.addcleanup(function() xio.delete(db1path) end)
if (lv.pcall(xio.listdir,db2path)) then
    xio.deletetree(db2path)
end
xio.newdir(db2path)
lv.addcleanup(function() xio.delete(db2path) end)
if (lv.pcall(xio.listdir,db3path)) then
    xio.deletetree(db3path)
end
xio.newdir(db3path)
lv.addcleanup(function() xio.delete(db3path) end)

VI.open_module("../../dynamic/DataLog Databases Module.vi", "", "", {
["databases"]={
{mode="unlocked",path=db1path},
{mode="unlocked",path=db2path},
{mode="locked",path=db3path},
},
["recovery directory"]=[[]],
["max points"]=1000000,
["max string mem"]=20000000,
})
lv.addcleanup(function() cleanup() end)

db1=DB.lookup("testdb1")
lv.addcleanup(function() deletetags(db1,"*") end)
db2=DB.lookup("testdb2")
lv.addcleanup(function() deletetags(db2,"*") end)
db3=DB.lookup("testdb3")
lv.addcleanup(function() deletetags(db3,"*") end)

assert(not lv.pcall(DB.create,db1,"foo_warn_hi",{}),"Meta for non-existing tag should fail.")
db1:create("foo",{unit="Nie"})
assert(not lv.pcall(DB.create,db3,"foo",{unit="Nie"}),"Should be locked")
co=db1:config("foo")
assert("foo"==co.name,"Wrong creation configuration")
assert("Nie"==co.unit,"Wrong creation configuration")
assert("number"==co.value,"Wrong creation configuration")
assert("sample"==co.temporal,"Wrong creation configuration")
db1:create("foo_warn_hi",{})
c=db1:config("foo_warn_hi")
assert("Nie"==c.unit,"Wrong meta unit inheritance.")
l=db1:list()
assert(table.getn(l)==2,"Wrong number of tag list entries")
assert(l[1]=="foo","Wrong tag list content")
assert(l[2]=="foo_warn_hi","Wrong tag list content")
l=db1:list("???")
assert(table.getn(l)==1,"Wrong number of tag list entries")
assert(l[1]=="foo","Wrong tag list content")
clonetags(db1,db2,"*")
l=db2:list()
assert(table.getn(l)==2,"Wrong number of tag list entries")
assert(l[1]=="foo","Wrong tag list content")
assert(l[2]=="foo_warn_hi","Wrong tag list content")
db1:reconfigure("foo",{name="moo",capacity=666,index=666,["is meta?"]=true,unit="Barf",value="string",temporal="sample",description="foo bar baz"})
cr=db1:config("foo")
assert(co.name==cr.name,"Should not be reconfigurable")
assert(co.capacity==cr.capacity,"Should not be reconfigurable")
assert(co.index==cr.index,"Should not be reconfigurable")
assert(co["is meta?"]==cr["is meta?"],"Should not be reconfigurable")
assert(co.unit==cr.unit,"Should not be reconfigurable")
assert(co.value==cr.value,"Should not be reconfigurable")
assert(co.temporal==cr.temporal,"Should not be reconfigurable")
assert("foo bar baz"==cr.description,"Description reconfiguration failed")
db1:create("bar",{value="string"})
db1:create("baz",{value="string"},"pooooooof!")
assert(not lv.pcall(DB.create,db1,"bar_warn_lo",{}),"Meta for string tag should fail.")
