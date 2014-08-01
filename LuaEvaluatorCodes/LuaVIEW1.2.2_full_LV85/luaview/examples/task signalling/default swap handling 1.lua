--#identifier "swappable"
--#class "example"
--#description "Demonstrates default built-in swap handling."
--#defer
--Run this script as a task, and then swap it with the alternate
--script, or vice versa. This can be done using the task manager.

--When a task is swapped-out, it might be desirable to retain some resources.
lv.addcleanup(function()
    if task.mode()=="swapping" then
        print("This task is being swapped, some resources might need retaining for the replacement script")
    else
        print("This task is being stopped, clean up everything")
    end
end)

--When a task is swapped-in, not all resources might require initialisation.
if task.mode()=="swapping" then
    print("This script was swapped for some prior script, some resources might already be initialized")
else
    print("This is the initial script with which the task was run, initialize all resources")
end

task.active()

while (true) do
    print("Active: 1")
	sleep(1500)
end
