--#import "../../imports/database management.lua"

amount=5000000
maxpoints=500000
eps=1e-5

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

VI.open_module("../../DataLog Databases Module.vi", "", "", {
["databases"]={
{locked=false,path=dbpath},
},
["recovery directory"]=[[]],
["max points"]=maxpoints,
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
db:create("verify",{temporal="sample",value="number",["mincapacity"]=200000,["logging algorithm"]="everything"})

VI.open_module("../../DataLog Logging Module.vi","","datalog",{
["aggregation capacity"]=amount/4,
["aggregation fraction"]=0.5,
["min capacity"]=64,
})
lv.addcleanup(function() revoke_exports() cleanup() end)

tasks_to_start={
    "../scripts/logging tasks/aggregator.lua",
    "../scripts/logging tasks/evaluator.lua",
    "../scripts/logging tasks/recovery_updater.lua",
    "../scripts/logging tasks/flusher.lua",
}
-- Start the datalogging service tasks.
for key,path in ipairs(tasks_to_start) do
    local id=run_task(path)
    lv.addcleanup(function() sig.stop(id) while(task.ongoing(id)) do wait(2) end end)
end

-- Write points to the log.
verify=Tag.lookup("verify")
inisize=db:logsize("verify")
initime=ceil(time())
t1=time()
for i=1,amount,1 do
    verify:write(i,initime+i)
end
t2=time()
print(amount/(t2-t1).." points/s")
-- Verify operation of indexrange retrieval
values,times=db:indexrange("verify",inisize,maxpoints)
for i,v in ipairs(values) do
    assert(v==i,"wrong value read at point "..i)
    assert(times[i]==i+initime,"wrong time read at point "..i)
end
ok,err=lv.pcall(db.indexrange,db,"verify",0,amount)
assert(not ok,"should fail because of too many points")
-- Verify operaiton of timerange retrieval
range=20000
values,times=db:timerange("verify",initime+amount-range+1,initime+amount)
for i,v in ipairs(values) do
    assert(v==i+amount-range,"wrong value read at point "..i)
    assert(times[i]==initime+i+amount-range,"wrong time read at point "..i)
end
ok,err=lv.pcall(db.timerange,db,"verify",-_Inf,_Inf)
assert(not ok,"should fail because of too many points")
-- See if interpolation works fine across the whole log.
n=97
step=amount/n
times={}
for i=1,n,1 do
    times[i]=initime+i*step
end
values=db:interpolate("verify",times)
for i,v in ipairs(values) do
    assert(v-i*step<eps,"interpolation returned wrong or inaccurate result")
end
for i=1,amount,1 do
    times[i]=initime+i
end
ok,err=lv.pcall(db.interpolate,db,"verify",times)
assert(not ok,"should fail because of too many points")
-- Do some unordered interpolation (inefficient) to stress the subdivision.
n=50
times={}
for i=1,n,1 do
    times[i]=initime+1+random()*(amount-1)
end
values=db:interpolate("verify",times)
for i,v in ipairs(values) do
    assert(v-(times[i]-initime)*step<eps,"interpolation returned wrong or inaccurate result")
end
-- Some corner cases
times={}
values=db:interpolate("verify",times)
assert(table.getn(values)==0,"no values should be returned")
values=db:interpolate("verify",{initime+42})
assert(table.getn(values)==1,"one value should be returned")
assert(values[1]==42,"wrong interpolation")
