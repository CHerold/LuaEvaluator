--#import "../../resources/import/database management.lua"

ininumber=111
inistring="What's up doc?"

register.private_dir(task.directory().._SEP.."../../functions")
dbpath=xio.tmpdir().._SEP.."testdb"
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

if (lv.pcall(xio.listdir,dbpath)) then
    xio.deletetree(dbpath)
end
xio.newdir(dbpath)
lv.addcleanup(function() xio.delete(dbpath) end)

VI.open_module("../../dynamic/DataLog Databases Module.vi", "", "", {
["databases"]={
{mode="unlocked",path=dbpath},
},
["recovery directory"]=[[]],
["max points"]=1000000,
["max string mem"]=20000000,
})
dbmodcleanup=cleanup -- avoid naming collision with logging module.
lv.addcleanup(function() dbmodcleanup() end)

db=DB.lookup("testdb")
lv.addcleanup(function()
    deletetags(db,"*")
    for i,f in ipairs((xio.listdir(dbpath))) do
        xio.delete(f)
    end
end)
db:create("foo",{temporal="set&hold"},ininumber)
db:create("nana",{value="string"})
db:create("nana2",{value="string"})
db:create("zero",{value="string",temporal="set&hold"},"")
db:create("bar",{value="string",temporal="set&hold"},inistring)

VI.open_module("../../dynamic/DataLog Logging Module.vi","","datalog",{
["aggregation capacity"]=100000,
["aggregation fraction"]=0.5,
["min capacity"]=64,
})
lv.addcleanup(function() revoke_exports() cleanup() end)
assert(not lv.pcall(db.create,db,"bar",{}),"Should fail when live")
assert(not lv.pcall(db.delete,db,"foo"),"Should fail when live")

tasks_to_start={
    "logging tasks/aggregator.lua",
    "logging tasks/evaluator.lua",
    "logging tasks/recovery_updater.lua",
    "logging tasks/flusher.lua",
}
-- Start the datalogging service tasks.
for key,path in ipairs(tasks_to_start) do
    local id=run_task(path)
    lv.addcleanup(function() sig.stop(id) while(task.ongoing(id)) do wait(2) end end)
end

foo=Tag.lookup("foo")
assert(ininumber==foo:value(),"wrong number value")
foo:write(123)
assert(123==foo:value(),"wrong string value")
foo:write(654,321)
v,t=foo:last()
assert(654==v,"wrong number value")
assert(321==t,"wrong time")

nana=StringTag.lookup("nana")
assert("UNDEFINED"==nana:value(),"wrong string value")
assert(lv.isnan(Tag.value(nana)),"should be represented as a NaN file offset")

nana2=StringTag.lookup("nana2")
assert("UNDEFINED"==nana2:value(),"wrong string value")
assert(lv.isnan(Tag.value(nana2)),"should be represented as a NaN file offset")

zero=StringTag.lookup("zero")
assert(""==zero:value(),"wrong string value")
assert(0==Tag.value(zero),"should be represented as zero file offset")

bar=StringTag.lookup("bar")
assert(inistring==bar:value(),"wrong string value")
bar:write("UNDEFINED")
assert("UNDEFINED"==bar:value(),"wrong string value")
assert(lv.isnan(Tag.value(bar)),"should be represented as a NaN file offset")
bar:write("",321)
v,t=bar:last()
assert(""==v,"wrong string value")
assert(321==t,"wrong time")
assert(0==Tag.value(bar),"should be represented as a zero file offset")
