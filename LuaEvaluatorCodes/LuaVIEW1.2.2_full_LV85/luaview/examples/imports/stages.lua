-- Define some stage functions

stage_rampto = function(I, t)
    print("Ramping current to "..I.." (A) in "..t.." (s).")
end

stage_blah = function(blahblah)
    print(blahblah)
end

stage_moo = function()
  print("moo!")
end

stage_countdown = function()
  for i=10,1,-1 do
    print(i)
  end
  print("lift off!")
end
