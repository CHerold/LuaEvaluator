--#class "<dir>"
--#defer
--#description "Tag expression evaluation and updating."
--#disallow_manual

call_plugin(resolve_VI_path("Datalog Evaluator.vi","dynamic"),{
["tag expression definitions"]=[[
-- Define any custom functions or variables that you wish to use in tag
-- expressions in this scriptlet. Only math functions (without "math."
-- prefix) can be used as part of the definitions.
]]})
