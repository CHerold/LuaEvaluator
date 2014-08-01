--#class "example"
--#description "Demonstrates adding of cleanup functions."
--Like LabVIEW, Lua does automatic memory managment
--and tracking of other resources it knows about. But
--there can be resources that require explicit definition
--of their cleanup, e.g. an external instrument whose state
--must be reset on completion of a test.
--
--Since such cleanup must occur irrespective of whether
--the script completes normally, is interrupted because
--of an error, or is sent a stop or swap signal, LuaVIEW
--provides a facility for adding cleanup functions that
--are always called after the normal execution of the
--script comes to an end.

print("-----------------------")
print("Adding cleanup function #1.")
lv.addcleanup(function() print("Cleanup function #1 called.") end)

print("Adding cleanup function #2.")
lv.addcleanup(function() print("Cleanup function #2 called.") end)

print([[
On script completion or interruption, cleanup functions
are called in reverse order. Cleanup functions are
typically used to reset or deallocate resources. The
reverse order allows a later resource with associated
cleanup to depend on a prior resource with associated
cleanup...
]])
