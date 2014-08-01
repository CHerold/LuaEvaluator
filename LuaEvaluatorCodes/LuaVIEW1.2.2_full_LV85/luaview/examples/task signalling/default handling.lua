--#class "example"
--#description "Demonstrates default built-in signal handling."
-- Signals cause sleep() to return, but the built-in handling will
-- take over immediately. Note that when the task is not asleep,
-- the pausing and stopping occurs at some arbitrary point of
-- execution on the Lua side. C functions and LuaVIEW function
-- VIs other than sleep() and call_plugin() execute to completion
-- irrespective of any signals.

while (true) do
	sleep()
	-- The built-in handling of the stop signal terminates the script here.
	-- The built-in handling of the pause signal blocks the script here.
	-- The built-in handling of the resume signal unblocks the script.
	print "I was woken up."
end
