--#class "example"
--#description "Synchronously executes a VI"
obj = VI.open("Count Down.vi")
lv.addcleanup(function() obj:close() end)
obj:open_fp()
t1 = time()
obj:execute()
t2 = time()
print("The VI took "..t2-t1.." seconds to complete execution.")
obj:close_fp()
