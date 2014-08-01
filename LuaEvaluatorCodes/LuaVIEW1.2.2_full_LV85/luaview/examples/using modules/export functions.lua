--#class "example"
--#description "Using an export function"
--#identifier "export"

-- On the Mac, we need :: instead of ../
if _SEP==":" then up="::" else up="../" end

-- Open the module. Set its export functions under a unique table.
mvi=VI.open_module(up.."VI templates/Module Template.vit","",task.identifier())
lv.addcleanup(function() mvi:close() end)

-- Do a script (running under a seperate VM instance) that
-- calls the exported function.
do_script("export caller",[[
print("About to call the exported module function from a newly started script")
print(export.vi_name())
]])
