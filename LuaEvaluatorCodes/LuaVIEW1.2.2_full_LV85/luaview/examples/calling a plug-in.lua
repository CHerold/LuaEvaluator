--#class "example"
--#description "Demonstrates how to call a plug-in"
-- Plug-ins hold dynamically loaded bits of LabVIEW functionality
-- implemented inside a VI or VI template. In contrast to functions,
-- which return back to the Lua script as soon as possible, plug-ins
-- are allowed to run for an indefinate time provided that
-- they handle the task signals, particularly the stop signal.
-- 
-- This script shows how to call a plug-in. Note that it is possible
-- to start multiple instances of this task script because the
-- specified plug-in is a template VI and thus can be instantiated
-- multiple times.
--
-- To stop the task/plug-in, send it a stop signal.

-- On the Mac, add a leading separator to make the path relative.
if _SEP==":" then lead=":" else lead="" end

print("-----------------------")
print("Try to pause/resume/stop the task to see the plug-in respond.")
print("Run the script multiple times to get multiple instances.")
print("Calling the plug-in.")
call_plugin(lead.."VI templates/Plug-in Template.vit", {dialstep=2})
-- If the plug-in returns because of a stop signal, the
-- code below will never be reached because the Lua virtual
-- machine is interrupted when a task script does not handle
-- the stop signal itself.
print("The plug-in has returned.")
