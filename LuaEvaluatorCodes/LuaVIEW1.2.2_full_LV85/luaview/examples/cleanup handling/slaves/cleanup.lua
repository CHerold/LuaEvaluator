--#class "slave"
--#description "Pending cleanup for master task"
--#disallow_manual
--The message queue is used by the master task to notify
--the cleanup task of the resources that must be freed.
--These messages are popped so as to perform the freeing
--in reverse order.
--#disallow_manual

while(task.ongoing("master")) do
    wait(500)
end
print("Starting cleanup.")
while (msg.available()) do
    print("Freeing resource:", msg.pop())
end
print("Cleanup done")
