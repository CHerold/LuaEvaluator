--#class "example"
--#description "Shows various means of error handling"
--
-- Run this script and look at its output. Ignore the
-- confusing code below, it is not ment as an example,
-- it is ment to output a series of examples.

script_strings = {[[
print("A")
error("Some Lua error")
print("B")
-- By default, errors interrupt scripts and are passed up to
-- whatever context the script was running under. This
-- will do for most use cases.
-- Notice that the script and line number are reported.]],[[
msg.send("nonexistingtask")
-- When a LabVIEW-implemented function is called with
-- the arguments that do not match the calling synopsis, the
-- error is detected before the LabVIEW-side is reached.
-- Note that the calling synopsis is displayed for convenience.
-- This does not require implementation work on the part of
-- the LabVIEW function. The only requirement is that the
-- function is documented with a calling synopsis.]],[[
msg.send("nonexistingtask","some message")
-- When the error occurs on the LabVIEW-side, the error
-- message will show both the Lua-side and LabVIEW-side
-- context of the error.]],[[
print("A")
success,errormsg = pcall(error, "Some Lua error")
if (not success) then
	print ("Caught error: ", errormsg)
end
print("B")
-- Errors caused by Lua functions or C function libraries can
-- be caught using the pcall() function.]],[[
success,errormsg = pcall(print)
print(errormsg)
-- Calling LabVIEW-side functions requires a mechanism
-- that is incompatible with pcall(). Therefore, pcall() cannot
-- run code that makes LabVIEW calls.
]],[[
success,errormsg = lv.pcall(msg.send, "nonexistingtask","some message")
print(errormsg)
-- Errors on calling the LabVIEW side can be caught with
-- lv.pcall() which works like pcall with the distinction that it
-- can protect only direct calls to LabVIEW-side functions.]],[[
-- It is possible to add one or more cleanup functions that
-- will be executed in reverse order when the script is done
-- or throws an error. Here, the script runs without error.
-- Note that Lua allows previously defined functions to be
-- referenced, or new anonymous functions to be defined on
-- the fly.
function cleanup_foo()
    print("Cleaning up foo")
end
lv.addcleanup(cleanup_foo)
lv.addcleanup(function () print("Cleaning up bar") end)
print("A")]],[[
-- Cleanup functions will also be executed when the script
-- is interrupted because of an error. The cleanups are
-- executed in reverse order because resources allocated
-- at a later stage can depend on previously allocated
-- resources. Just be sure to add cleanups in order of
-- resource allocation if there is mutual dependence.
lv.addcleanup(function () print("Cleaning up foo") end)
lv.addcleanup(function () print("Cleaning up bar") end)
print("About to run into an error...")
error("Some error in the middle of a script")
print("Never reached.")]],[[
-- When an error occurs during a cleanup function, any
-- further cleanup functions will still be executed.
-- Note that the error is prepended to any prior error.
-- The error code of the initial error is retained.
lv.addcleanup(function () print("Cleaning up foo") end)
lv.addcleanup(function () error("Error while cleaning up") end)
print("About to run into an error...")
error("Some error in the middle of a script")
print("Never reached.")]]}

for key,script in ipairs(script_strings) do
	print()
	print()
	print("###### the following script")
	print(script)
	print("###### has as printing output")
	success,errormsg = lv.pcall(do_script,"example "..key,script)
	if (success) then
		print("###### and completed without error")
	else
		print("###### and returned the following error message:")
		print(errormsg)
		print("######")
	end
	wait(1000)
end
