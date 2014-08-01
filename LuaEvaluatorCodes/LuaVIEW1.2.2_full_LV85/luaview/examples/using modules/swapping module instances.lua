--#class "example"
--#description "Shows that module instances can be replaced"
--#identifier "export"

-- Beware, when the module has state that must be cleaned up, more work is
-- required. See the other examples.

-- On the Mac, we need :: instead of ../
if _SEP==":" then up="::" else up="../" end

-- Open the first module instance. Set its export functions under a unique table
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

-- Wait a bit, before closing the module instance.
wait(2000)
mvi:close()
print("First instance closed, opening second instance.")
-- Open the second module instance. Set its export functions under a unique table
mvi=VI.open_module(up.."VI templates/Module Template.vit","",task.identifier())
lv.addcleanup(function() mvi:close() end)

-- Wait a bit before dropping off the end of the world.
wait(2000)
print("Second instance will be cleaned up, export calls will time out.")
