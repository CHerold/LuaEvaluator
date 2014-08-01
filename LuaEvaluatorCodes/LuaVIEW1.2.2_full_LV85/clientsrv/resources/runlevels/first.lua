--#class "<dir>"
--#disallow_manual
--#defer
--#description "First runlevel."

tasks={
    "first/alpha.lua",
    "first/beta.lua",
}

-- Start the tasks.
for key,path in ipairs(tasks) do
    local id=run_task(path)
    lv.addcleanup(function() sig.stop(id) while(task.ongoing(id)) do wait(2) end end)
end

task.active()
while true do sleep() end
