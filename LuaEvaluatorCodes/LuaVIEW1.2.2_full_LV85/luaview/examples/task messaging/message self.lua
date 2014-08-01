--#identifier "Msg Self"
--#class "example"
--#description "Task manipulating its own message queue"
-- Message queues are used for asynchronous communication
-- between tasks. Still, it is sometimes convenient to
-- have a task to enqueue messages on its own message
-- queue, e.g. so as to schedule some action after
-- all queued messages have been handled.

print("First in first out (FIFO) queueing.")
print("msg.available():", msg.available())
print("Sending the foo message to myself")
msg.self("foo")
print("Sending the bar message to myself")
msg.self("bar")
print("msg.available():", msg.available())
print("Emptying message queue in first to last order")
print("msg.next():", msg.next())
print("msg.next():", msg.next())
print("msg.next():", msg.next())
print("msg.available():", msg.available())
sleep(2000)

print("Last in first out (LIFO) stacking.")
print("msg.available():", msg.available())
print("Sending the foo message to myself")
msg.self("foo")
print("Sending the bar message to myself")
msg.self("bar")
print("msg.available():", msg.available())
print("Empty message stack in last to first order")
print("msg.pop():", msg.pop())
print("msg.pop():", msg.pop())
print("msg.pop():", msg.pop())
print("msg.available():", msg.available())
sleep(2000)
