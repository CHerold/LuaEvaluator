-- Since network connections are flaky and the remote server
-- whose database is being mirrored can go down independently,
-- we do not want to fail when the connection is dropped or
-- the remote database cannot be accessed. The solution is to
-- do a mirrortask that reports its errors back to this task,
-- and redo it with a moderate delay. That way, mirroring will
-- recommence once the remote server is back up without the
-- involved error catching and handling that would otherwise
-- be required for the mirror task.
function domirror(config)
    -- Format the mirror task script with the given configuration.
    testscript=[[
--#description "Mirror to local database ']]..config.localdb..[[' from remote database ']]..config.remotedb..[['."
--#identifier "]]..task.identifier()..[[_mirror"
--#class "mirroring"
--#hide
--#disallow_manual
--#import "mirrorlib.lua"
module=VI.open_module(resolve_VI_path("re_DataLog Mirror Module.vi","dynamic"),"","",{
localdb="]]..config.localdb..[[",
remotedb="]]..config.remotedb..[[",
machine="]]..config.machine..[[",
port=]]..config.port..[[,
password="]]..config.password..[[",
})
lv.addcleanup(function() module:close() end)
]]
    taskscript=testscript..[[
mirror(]]..config.tagdelay..[[)
]]
    -- Verify the configured tag delay.
    assert(floor(config.tagdelay)==config.tagdelay and config.tagdelay>0,"The tag delay must be a positive amd whole number of milliseconds.")
    -- Verify the configured reconnect delay. Make sure it is not too brief.
    assert(floor(config.reconnectdelay)==config.reconnectdelay and config.reconnectdelay>=30000,"The reconnect delay must be a whole number of milliseconds and may not be less than 30000.")
    -- Do the test script so as to ensure the config is mostly OK.
    do_task("",testscript)
    task.active()
    -- Keep on doing the mirror subtask
    while true do
        lv.print(format_time(time()).." Starting mirror subtask.")
        ok,err=lv.pcall(do_task,"",taskscript)
        if not ok then
            lv.print(format_time(time()).." Mirror subtask returned. "..err)
        end
        sleep(config.reconnectdelay)
    end
end
