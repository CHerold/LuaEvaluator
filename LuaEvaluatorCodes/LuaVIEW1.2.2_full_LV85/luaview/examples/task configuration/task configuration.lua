-- This script demonstrates how the various preprocessor keywords
-- can be used to configure a task. See the HTML documentation for
-- details.
--#priority "normal priority"
--#prefsys "standard"
--#identifier "my identifier"
--#class "my class"
--#import "imports/specialprint.lua"
-- On the Mac, add a leading "/" or ":" to the path.
--#defer
--#version "1.00"
--#description "Task configuration via preprocessor keywords."
-- Do any error prone deferred initialization before switching to active mode.
task.active()
for i=1,20,1 do
  specialprint(i)
  wait(1000)
end
