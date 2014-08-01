--#identifier "errors"
--#class "system"
--#disallow_manual
--#description "Logs error messages sent to it."
-- This task logs to its print buffer, and persists its
-- content. In addition, it attempts to log to a string
-- tag of the same name.

id=task.identifier()
logname=task.directory().._SEP..id..".log"

-- Load the log file if it exists
logfile=io.open(logname,"r")
if (logfile) then
    lv.print(logfile:read("*a"))
    logfile:close()
end
lv.print("--- System started on "..format_time(time()).."\n")

-- Wait for messages to log or a stop signal.
sig.handle_stop()
while true do
    m=msg.next()
    if (m) then
        lv.pcall(logstring,id,m)
        if string.byte(m,-1)==10 then
            lv.print("Error logged on "..format_time(time()).."  "..m)
        else
            lv.print("Error logged on "..format_time(time()).."  "..m.."\n")
        end
    else
        if sig.stop_set() then break end
        sleep()
    end
end

-- Save the log file
lv.print("--- System stopped on "..format_time(time()).."\n")
logfile=assert(io.open(logname,"w"))
logfile:write(lv.dump())
logfile:close()
