--#class "example"
--#description "Demonstrates what can happen when exoort functions exports are not revoked"
--#identifier "export"

-- On the Mac, we need :: instead of ../
if _SEP==":" then up="::" else up="../" end

-- Open the module. Set its export functions under a unique table
mvi=VI.open_module(up.."VI templates/Module Template.vit","",task.identifier(),{
num=1,
blah="The module is initialized",
data={1,1,1},
})
lv.addcleanup(function() mvi:close() end)
lv.addcleanup(function() cleanup() end)
-- BAD! we need a revoke_exports() that executes prior to cleanup()

-- Run a script (running under a seperate VM instance) that
-- calls an exported function repeatedly.
run_task("export caller",[[
while (true) do
	print(export.dump_config())
	sleep(500)
end
]])

wait(1000)

-- Complete the script, and cause a cleanup.
-- The cleanup() function includes a delay such that the export
-- caller is sure to make a call while cleaning up, thus causing
-- the call to get executed after cleanup() returns.
print("\nNotice how the dump_config() export will get called after cleanup. This is BAD! ")

-- The "export caller" will fail when the "export timeout" expires
-- after the module is closed.
