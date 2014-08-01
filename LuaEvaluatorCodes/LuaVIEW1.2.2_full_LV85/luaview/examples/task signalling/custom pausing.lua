--#class "example"
--#description "Demonstrates custom handling of pausing."
-- Customized handling of pause and resume signals is needed when
-- a task wants to support pausing yet is managing some process that
-- must be suspended while the pause is ongoing. In short, it is rarely needed.

sig.handle_pausing()

print("-----------------------")
print("Try to pause/resume/stop this task...")

-- Start the process and arrange for its cleanup
id = run_task("slaves/asynchronous.lua")
lv.addcleanup(function() sig.stop(id) end)

while (true) do
	sleep()
	if (sig.pause_set()) then
		sig.disallow_pause()
		print("Handling the pause signal.")
		sig.pause(id) -- Suspend the process
		task.paused()
		sig.allow_resume()
	end
	if (sig.resume_set()) then
		sig.disallow_resume()
		print("Handling the resume signal.")
		sig.resume(id) -- Revive the process
		task.active()
		sig.allow_pause()
	end
end
