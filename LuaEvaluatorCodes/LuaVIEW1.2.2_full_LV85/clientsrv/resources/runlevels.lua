--#identifier "runlevels"
--#class "system"
--#disallow_manual
--#description "Configures, starts, and stops runlevel scripts."
module=VI.open_module(resolve_VI_path("ClientSrv Runlevels Module.vi","dynamic"),"","",{
["runlevel scripts"]={
task.directory().."/runlevels/first.lua",
task.directory().."/runlevels/second.lua",
},
-- Runlevel scripts are task scripts that perform initialisation and cleanup.
-- They must be specified in order of dependency: later scripts may depend
-- on services and preparations of earlier scripts, but not vice versa.
-- This results in a set of runlevels each representing a degree of
-- initialisation of the server. The names of these runlevels are set
-- to the name of the respective script with any ".lua" extension
-- stripped off.
-- The first three runlevels are hardwired:
-- "stop": the server application will be stopped.
-- "reboot": the server application will be rebooted. This will re-run
-- the bootstrap and access scripts and allows the server to switch
-- to a different bootmode.
-- "stand by": server has started and is accepting network connections and
-- runlevel change messages, but no runlevel scripts are running as yet.
["boot modes"]={"test","deployed"},
-- The various modes that the server can boot into. The bootmode can
-- be selected when rebooting the server from the client. The bootmode
-- is persisted in a file "bootmode.txt" so that the server will boot
-- into the same mode after a power outage or crash. When the
-- server is booted into a mode not listed here, an error will be thrown.
-- To query the bootmode use the bootmode() function or refer to its
-- LabVIEW global (see glb_LuaVIEW Configuration Globals.vi).
})
lv.addcleanup(function() cleanup() module:close() end)
levels=getlevels()
identifiers={}

 -- When reaching a runlevel, it will be persisted in the file specified below.
 -- This file is deleted when the server is stopped. This allows the server
 -- to switch to the last active runlevel when the system is restarting from
 -- a power outage or crash.
levelfilename=task.directory().._SEP.."runlevel.txt"

function findlevel(level)
    -- Returns level index or nil if the level is not configured.
    for i,v in ipairs(levels) do
        if v==level then
            return i
        end
    end
    return nil
end

function setlevel(level)
    setcurrent(level)
    if level~="reboot" then
        msg.send("warnings",'Runlevel "'..level..'" reached.')
    end
    local levelfile=io.open(levelfilename,"w")
    if levelfile then
        levelfile:write(level)
        levelfile:close()
    end
end

function changelevel(level)
    -- Change the server's runlevel.
    local new=findlevel(level)
    local old=findlevel(getcurrent())
    if new==old then return end
    if new>old then
        -- Start runlevel scripts
        for i=old+1,new,1 do
            local ok,res=lv.pcall(run_task,getpath(levels[i]))
            if not ok then
                msg.send("errors",'Runlevel "'..level..'" failed to initialise. '..res)
                break
            end
            identifiers[i]=res
            setlevel(levels[i])
        end
    else
        -- Stop runlevel scripts
        for i=old,new+1,-1 do
            if identifiers[i] then
                while (task.ongoing(identifiers[i])) do
                    sig.stop(identifiers[i])
                    sleep(5)
                end
                identifiers[i]=nil
            end
            setlevel(levels[i-1])
        end
    end
end

lv.addcleanup(function()
    changelevel("reboot")
    xio.delete(levelfilename)
end)

-- Recover the runlevel when the server is restarting from a power outage or crash.
levelfile=io.open(levelfilename,"r")
if (levelfile) then
    level=levelfile:read("*a")
    levelfile:close()
    if findlevel(level) and findlevel(level) > findlevel("stand by") then
        changelevel(level)
    end
end

-- Handle runlevel change messages.
while true do
    while not msg.available() do
        sleep()
    end
    level=msg.next()
    if level=="stop" then
        msg.send("warnings","Stopping server...")
        setreboot(false)
        break
    elseif level=="reboot" then
        msg.send("warnings","Rebooting server...")
        setreboot(true)
        break
    elseif findlevel(level) then
        msg.send("warnings",'Changing to runlevel "'..level..'".')
        changelevel(level)
    else
        msg.send("errors",'Cannot change to runlevel "'..level..'", no such level is defined.')
    end
end
