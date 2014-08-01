--#identifier "master"
--#class "example"
--#description "Resource allocating task with cleanup task"
-- Though adding cleanup functions using "lv.addcleanup" is more convenient,
-- it is also possible to start a slave task to manage resources.
-- This is slightly safer since memory allocation errors and task killing
-- cause LabVIEW to abort the task context, thereby ignoring cleanups.
-- Also, it is in principle possible to mess up global variables through
-- programming errors such so that cleanup functions cannot perform
-- their actions properly. Since under normal conditions the system
-- does not run out of memory, operators behave with common sense,
-- and scripts will have been tested, the use of cleanup functions is
-- just fine. However, if you're paranoid, doing cleanup work in a
-- seperate task is a bit more secure. Another reason for using this
-- cumbersome mechanism is when it provides additional value beyond
-- what lv.addcleanup offers, e.g. management of joint resources of
-- multiple scripts.

sig.handle_stop()
id = run_task("slaves/cleanup.lua")
print("Master task "..task.identifier().." as well as its slave cleanup task have been started.")
print('Allocating resource "foo"')
msg.send(id, "foo")
print('Allocating resource "bar"')
msg.send(id, "bar")
print('Allocating resource "baz"')
msg.send(id, "baz")
repeat
    sleep()
until (sig.stop_set())
print("Task "..task.identifier().." stopped.")
