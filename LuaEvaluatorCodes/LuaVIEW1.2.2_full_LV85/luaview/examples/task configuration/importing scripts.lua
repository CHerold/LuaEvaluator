--#class "example"
--#description "Demonstrates script importing"
--#import "imports/importa.lua"
--#import "imports/importb.lua"
--#import "imports/importc.lua"
-- On the Mac, add a leading "/" or ":" to the paths.
print ("Executing main script that has imported importa.lua, importb.lua, and importc.lua.")
print("Notice how the task leaves 'initializing' mode only after all import scripts have executed.")
print("Since importc.lua was already imported from importa.lua, it is not executed a second time.")
print()
wait(5000)
