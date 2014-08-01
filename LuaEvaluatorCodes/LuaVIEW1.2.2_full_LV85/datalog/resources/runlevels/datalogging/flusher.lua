--#class "<dir>"
--#description "Flushes tag data from the aggregation buffer to the tag logs."
--#disallow_manual

-- Periodically attempt to flush the tag with the most ancient aggregated data
-- if it exceeds the aggregation fraction threshold. When 50 periods expire
-- without a flush being required, flush the dirtiest tag preemptively. This
-- combination of flushes will break up coherence in tags reaching the
-- threshold so that flushes get spread out in time even when lots of tags
-- are written to at the same rate.
periods=0
while true do
    sleep(200)
    if datalog.flush_next_if() then
        periods=0
    else
        periods=periods+1
        if periods>=50 then
            datalog.flush_next()
            periods=0
        end
    end
end
