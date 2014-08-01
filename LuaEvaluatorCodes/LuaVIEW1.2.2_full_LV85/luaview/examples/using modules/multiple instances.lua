--#class "example"
--#description "Open two module instances and call them"

-- On the Mac, we need :: instead of ../
if _SEP==":" then up="::" else up="../" end

-- Open the first instance.
mvi=VI.open_module(up.."VI templates/Module Template.vit","instance1","")
lv.addcleanup(function() mvi:close() end)

-- Open the second instance.
mvi=VI.open_module(up.."VI templates/Module Template.vit","instance2","")
lv.addcleanup(function() mvi:close() end)

-- Call both instances.
print("Printing the VI names that LabVIEW assigned to the instances.")
print(instance1.vi_name())
print(instance2.vi_name())
