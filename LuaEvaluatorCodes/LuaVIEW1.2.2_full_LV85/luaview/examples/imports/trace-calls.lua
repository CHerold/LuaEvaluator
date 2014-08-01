-- trace calls
-- Import this from the task script whose calls you want to trace.

local level=0

lv.addcleanup(function() print(lv.dump()) end)

function hook(event)
 local t=debug.getinfo(3)
 lv.print(level," >>> ",string.rep(" ",level))
 if t~=nil and t.currentline>=0 then lv.print(t.short_src,":",t.currentline," ") end
 t=debug.getinfo(2)
 if event=="call" then
  level=level+1
 else
  level=level-1 if level<0 then level=0 end
 end
 if t.what=="main" then
  if event=="call" then
   lv.print("begin ",t.short_src)
  else
   lv.print("end ",t.short_src)
  end
 elseif t.what=="Lua" then
-- table.foreach(t,lv.print)
  lv.print(event," ",t.name or "(Lua)"," <",t.linedefined,":",t.short_src,">")
 else
 lv.print(event," ",t.name or "(C)"," [",t.what,"] ")
 end
end

debug.sethook(hook,"cr")
level=0
