lv.substitute_separators(true)
lv.setyieldingdefaults(2,0)

-- Register a selection of public LuaVIEW functions.
register.public_dir(toolkit_path("luaview","functions"))
register.public_dir(toolkit_path("clientsrv","functions"))
register.public_dir(bootstrap_path().._SEP.."functions")

-- The default bootmode, used when not persisted.
mode="test"

-- When the bootmode is persisted, read it from its persistence file.
modefile=io.open(bootstrap_path().._SEP.."bootmode.txt","r")
if (modefile) then
    mode=modefile:read("*a")
    modefile:close()
end

-- Configure LuaVIEW. These settings map to the LabVIEW globals
-- contained in luaview/glb_LuaVIEW Configuration Globals.vi and
-- library/glb_Library Configuration Globals.vi.
-- See their descriptions for details. When a setting is commented out
-- or omitted, its current/default value will be used.
configure({
["bootmode"]=mode,
["resource base path"]=bootstrap_path(),
["time format"]="%Y/%m/%d %H:%M:%S%2u",
["auto-init registry"]=true,
["unload functions ASAP"]=true,
["script search directories"]={""},
["custom info"]=[[
Example server.
Demonstrates the client-server framework.

]],
["export timeout"]=1000,
["incite timeout"]=2000,
["task error logger"]="errors",
})

-- Now we can start a script that can assume a proper configuration
-- and registered functions.
do_script("access.lua")
