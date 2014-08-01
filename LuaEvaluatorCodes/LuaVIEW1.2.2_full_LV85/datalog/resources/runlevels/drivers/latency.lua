--#class "<dir>"
--#defer
--#description "Detect long scheduling latencies."
-- Detects scheduling latencies and writes them to the "latency"
-- tag when they exceed a set threshold.

period=10
threshold=50

latency=Tag.lookup("latency","ms")
task.active()
while true do
    t1=lv.tickcount()
    wait(period)
    t2=lv.tickcount()
    l=lv.subU32(t2,t1)-period
    if l>threshold then
        latency:write(l)
    end
end
