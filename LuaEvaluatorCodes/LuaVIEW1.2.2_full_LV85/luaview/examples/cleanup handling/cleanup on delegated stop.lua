--#class "example"
--#description "Demonstrates cleanup on a stop signal."
-- This script demonstrates that delegated handling of the stop
-- signal interrupts the script, but does not cause cleanup
-- functions to be skipped. The same holds for delegated
-- handling of the swap signal.

print("-----------------------")
lv.addcleanup(function() print("Cleaning up...") end)

print("Send this task a stop signal to verify that cleanup is run.")
while (true) do
    print("No stop yet")
    sleep(2000)
end
print("This line of code will will never be reached.")
