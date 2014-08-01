--#class "example"
--#description "Closing a module invalidates its export functions"
--#identifier "export"

-- On the Mac, we need :: instead of ../
if _SEP==":" then up="::" else up="../" end

-- Open the module. Set its export functions under a unique table
mvi=VI.open_module(up.."VI templates/Module Template.vit","",task.identifier())
lv.addcleanup(function() mvi:close() end)

-- Run a script (running under a seperate VM instance) that
-- calls an exported function repeatedly.
run_task("export caller",[[
while (true) do
	print(export.vi_name())
	sleep(500)
end
]])

-- Wait a bit, before closing the module.
wait(2000)
mvi:close()
-- When the module instance is closed, calling its export
-- function will fail.
print("Any further call will fail.")
sleep()
