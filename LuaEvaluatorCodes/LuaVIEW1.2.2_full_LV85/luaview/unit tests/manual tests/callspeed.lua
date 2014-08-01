--#class "test"
--#description "Tests the overhead of minimal LabVIEW side calls."

calls = 100000
lv.setyielding(0,0) -- disable auto-yielding
wait(1000) -- idle a bit to have the system settle.
ticks1 = lv.tickcount()
for i=1,calls,1 do
	-- This times a pure VM yield/resume at least if nothing
	-- else is busy, and as such will represent the basic calling
	-- overhead.
	wait(0)
end
ticks2 = lv.tickcount()
duration = 1e-3*lv.subU32(ticks2,ticks1)
print(calls/duration.." calls/s")
