--#class "example"
--#description "Demonstrates customized stop signal handling."
--
-- Handling the stop signal is rarely useful. If your task manages
-- resources that must be freed before the task is terminated,
-- adding cleanup functions using "lv.addcleanup()" is more
-- convenient and safer because cleanup functions are not
-- skipped when an error occurs.
--
-- The only situation that custom stop handling can cover that
-- cleanup functions cannot is when the task must verify
-- whether stopping is allowed, and resume the script when
-- it is not. When the condition that makes stopping impossible
-- is a result of the script execution instead of some external
-- asynchronous event, it is possible to use "sig.disallow_stop()"
-- instead, which is neater, and has as advantage that the task
-- manager "stop" button is greyed to make explicit that the
-- task is not in a stoppable condition.

sig.handle_stop()

print("---------------------")
while (true) do
	print("Waiting for stop signal.")
	sleep(2000)
	if (sig.stop_set()) then
		-- Verify if we are allowed to stop.
		if (dialog.two_button("Is it OK to stop?", "Yes", "No")) then
			break
		else
			sig.clear_stop()
		end
	end
end
