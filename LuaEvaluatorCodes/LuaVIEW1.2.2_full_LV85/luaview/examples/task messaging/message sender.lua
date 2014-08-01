--#class "example"
--#description "Message sending."

-- On the Mac, add a leading "/" or ":" to the path.
id = run_task("slaves/message receiver.lua")
lv.addcleanup(function() sig.stop(id) end)
print("Started the message receiver task, about to send it messages.")

print('Sending the "foo" message.')
msg.send(id, "foo")
wait(2000)

print('Sending the "bar" message.')
msg.send(id, "bar")
wait(2000)

print('Sending the "garbled" message.')
msg.send(id, "garbled")
wait(3000)
