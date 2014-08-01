Lua use with New SetList
------------------------

There were two nearly duplicate methods being used to call Lua and evaluate expressions.
  - Caching_Expression_Evaluator_Table.vi has an extra method "evaltable" which accepts timing information for use with our "Ramp" lines.
  - Caching_Expression_Evaluator_v4.vi is nearly identical to the LuaVIEW provided Caching_Expression_Evaluator.vi except function "eval2" was also defined.

We need the "evaltable" function, so I've switched to only using Caching_Expression_Evaluator_Table.vi everywhere. This has the advantage of only starting ONE Lua state making it easier to use variables and user functions WITHOUT having to constantly reset them to ensure they are known.

1 August 2014 - Creston Herold