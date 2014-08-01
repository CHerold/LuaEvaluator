--#class "<dir>"
--#disallow_manual
--#description "Monitors a directory for query scripts to execute."

-- The directory to monitor for query scripts.
querydir=task.directory().._SEP.."queries"
-- The directory where to create the result directories.
resultroot=task.directory().._SEP.."results"
-- The number of milliseconds to wait before repolling the directory.
period=1000

while true do
    files=xio.listdir(querydir)
    for i,file in ipairs(files) do
        path,name=xio.strip(file)
        resultdir=resultroot.._SEP..name..format_time(time(),"_%y%m%d_%H%M%S%2u")
        xio.newdir(resultdir)
        xio.move(file,resultdir)
        ok,err=lv.pcall(do_task,resultdir.._SEP..name)
        if not ok then
            errfile=assert(io.open(resultdir.._SEP.."error.txt","w"))
            errfile:write(err)
            errfile:close()
        end
    end
    sleep(period)
end
