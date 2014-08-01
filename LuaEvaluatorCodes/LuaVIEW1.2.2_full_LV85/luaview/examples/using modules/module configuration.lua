--#class "example"
--#description "Various ways of passing a configuration table"
--#identifier "export"

-- On the Mac, we need :: instead of ../
if _SEP==":" then up="::" else up="../" end

-- Open the module without a configuration table.
-- Since the template specifies a default configuration, the default will be used.
mvi=VI.open_module(up.."VI templates/Module Template.vit","",task.identifier())
print(dump_config())
mvi:close()

-- Open the module with a fully specified configuration table.
mvi=VI.open_module(up.."VI templates/Module Template.vit","",task.identifier(),{
num=123,
blah="blah blah blah",
data={5,4,3,2,1},
})
print(dump_config())
mvi:close()

-- Open the module, omit the blah configuration element. Its default value will be used.
mvi=VI.open_module(up.."VI templates/Module Template.vit","",task.identifier(),{
num=42,
data={43,44},
})
print(dump_config())
mvi:close()
