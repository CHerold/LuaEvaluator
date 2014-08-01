--#class "example"
--#description "Runs and prematurely aborts a VI"
vi = VI.open("Count Down.vi")
lv.addcleanup(function() vi:close() end)
print("Running VI...")
vi:run()
vi:open_fp()
wait(2000)
print("Aborting VI")
vi:abort()
vi:close_fp()
