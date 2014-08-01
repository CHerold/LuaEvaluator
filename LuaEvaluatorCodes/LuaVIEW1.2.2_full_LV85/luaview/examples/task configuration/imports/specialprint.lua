--#description "A special print function"
--Shows that import scripts are executed before the scripts
--they are imported from so as to allow them to define stuff.
print("Defining specialprint()")
function specialprint(s)
   print("Special: "..s)
end
wait(1000)
