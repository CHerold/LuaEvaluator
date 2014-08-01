--#class "<dir>"
--#disallow_manual
--#defer
--#description "Second runlevel."

if bootmode()=="test" then
    tasks={
        "second/gamma.lua",
        "second/delta.lua",
    }
elseif bootmode()=="deployed" then
    tasks={
        "second/epsilon.lua",
        "second/zeta.lua",
    }
else
    error("Unsupported bootmode")
end

-- Start the tasks.
for key,path in ipairs(tasks) do
    local id=run_task(path)
    lv.addcleanup(function() sig.stop(id) while(task.ongoing(id)) do wait(2) end end)
end

task.active()
while true do sleep() end
