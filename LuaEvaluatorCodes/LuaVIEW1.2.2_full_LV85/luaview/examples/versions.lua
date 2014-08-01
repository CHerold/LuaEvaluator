--#class "example"
--#description "Prints the Lua and CIN versions"
--The Lua version shows what version of Lua has been compiled
--and linked to the LuaVIEW code interface node (CIN). 
--The CIN version shows the version of the C interface
--between Lua and LabVIEW.

print(lv.luaversion())
print(lv.cinversion())
