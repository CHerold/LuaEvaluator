db=DB.lookup("Datalog")
tn="disk_usage"
values,times=db:indexrange(tn,0,db:valuesinlog(tn))
outfile=assert(io.open(task.directory().._SEP..tn..".txt","w"))
for i,v in ipairs(values) do
    outfile:write(format_time(times[i]),"\t",v,"\n")
end