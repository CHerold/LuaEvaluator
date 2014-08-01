--#class "<dir>"
--#disallow_manual
--#defer
--#description "Mirroring of remote databases."

-- Prepare scripts with an appropriate configuration for each database
-- that must be mirrored and add them to the list below.
tasks={
    "mirroring/mirrordb.lua",
}

-- Start the mirroring tasks. Note that each main task tries to start a sub task
-- with a "_mirror" identifier extention that must also be signalled to stop when
-- the runlevel terminates.
names={}
mirrorids={}
connecteds={}
for i,path in ipairs(tasks) do
    local id=run_task(path)
    lv.addcleanup(function()
        sig.stop(id)
        while task.ongoing(id) do
            sig.stop(id.."_mirror") -- repeating this stop signal sidesteps a small redo race risk
            wait(2)
        end
    end)
    path,name=xio.strip(path)
    names[i]=name
    mirrorids[i]=id.."_mirror"
    connecteds[i]=false
end
task.active()

-- Periodically lv.print() an overview of the mirroring connections.
changed=true
while true do
    sleep(10000)
    for i,id in ipairs(mirrorids) do
        connected=task.ongoing(id)
        if connecteds[i]~=connected then
            changed=true
            connecteds[i]=connected
        end
    end
    if changed then
        lv.print()
        lv.print(format_time(time()).." Mirroring connections:")
        for i,name in ipairs(names) do
            if connecteds[i] then
                lv.print(name,"connected")
            else
                lv.print(name,"disconnected")
            end
        end
    end
    changed=false
end
