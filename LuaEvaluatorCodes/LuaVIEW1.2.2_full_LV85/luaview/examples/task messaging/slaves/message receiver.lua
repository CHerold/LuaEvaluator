--#class "slave"
--#description "Message receipt and handling"
--#disallow_manual
-- Shows how Lua tables and function values can be used to
-- implement an extensible message handler.
--The supported messages are the keys of the "handlers" table.
--The corresponding values are set to the handler functions.

function handle_foo()
    print('Handling the "foo" message')
end

function handle_bar()
    print('Handling the "bar" message')
end

handlers = {
foo=handle_foo,
bar=handle_bar,
}

while (true) do
	while(msg.available()) do
		message = msg.next()
        if (handlers[message]) then
            handlers[message]()
        else
            print('Received unsupported message "'..message..'".')
        end
    end
    sleep() -- puts this task to sleep until it woken up, e.g. because of a message.
end
