--#class "example"
--#description "Open a module, call a function, and clean up"

-- On the Mac, we need :: instead of ../
if _SEP==":" then up="::" else up="../" end

-- Open the module
-- No table is specified, so the functions are set as globals.
mvi=VI.open_module(up.."VI templates/Module Template.vit","","")

-- Make sure the module VI instance gets closed.
lv.addcleanup(function() cleanup() mvi:close() end)

-- If the module has a cleanup function, make sure it gets called.
-- Since cleanups are called in reverse order, this must be added
-- after adding the close module cleanup function.
lv.addcleanup(function() cleanup() end)

-- So why not add a single cleanup function like so?
-- lv.addcleanup(function() cleanup() mvi:close() end)
-- It is because that might cause the close to be skipped
-- when your cleanup() happens to throw an error. Feel
-- free to put stuff that does not throw errors inside
-- a single cleanup function. Indeed, when a late cleanup
-- actions depends on a prior cleanup actions, it is better
-- to put them in a single cleanup function so that the
-- late cleanup actions does not get executed when the
-- prior actions fails.

-- See if we can call a module function.
mofu("This is a module function being called.","Cool")
