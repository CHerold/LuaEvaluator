--#class "<dir>"
--#disallow_manual
--#defer
--#description "Starts/stops datalogging. Updates the recovery file periodically."

tasks={
    "datalogging/aggregator.lua",
    "datalogging/evaluator.lua",
    "datalogging/flusher.lua",
}

-- Open the logging module.
module=VI.open_module(resolve_VI_path("DataLog Logging Module.vi","dynamic"),"","datalog",{
["aggregation capacity"]=100000,
-- Determines number of points that the aggregation buffer can hold
-- after rounding up to the next power of two. This determines how
-- frequently data will be flushed to tag logs. The larger the capacity,
-- the less frequent the flushes, and the lower the disk I/O load.
--
-- A reasonable size resulting in roughly a once-a-second log update
-- can be calculated by multiplying the number of tags being logged
-- by their aggregate number of points being logged per second.
["aggregation fraction"]=0.7,
-- Sets a flush threshold. When the oldest unflushed point lags more than
-- this fraction of the buffer size behind the most recent entry, the
-- {flush next if} method of the aggregation buffer will flush all data
-- of that point's tag. Essentially, this makes that the fraction of the
-- buffer specified here is used for aggregation, and the remainder is
-- used to guard against overflows.
["min capacity"]=64,
-- Globally sets a lower limit for the capacity of the in-memory buffer of all tags.
-- It overrides the per-tag min capacity setting when that setting is lower.
-- The actual capacity of a tag buffer is rounded up to the next power of two
-- when no power of two is specified in the highest min capacity setting.
-- It is not possible to configure a setting lower than 32.
--
-- When you can spare the memory, set this to a value that is more than
-- sufficient for the majority of tags. That way only the high-bandwidth tags
-- will need to be configured with a higher per-tag capacity setting.
})
lv.addcleanup(function() revoke_exports() cleanup() module:close() end)

-- Start the tasks.
for key,path in ipairs(tasks) do
    local id=run_task(path)
    lv.addcleanup(function() sig.stop(id) while(task.ongoing(id)) do wait(2) end end)
end

task.active()

-- Periodically update the recovery file.
-- The sleep period determines how many milliseconds worth of data you
-- will at most loose in case of a power outtage or crash: all data up
-- to the last update will be recovered when the system restarts.
-- Do not set the period too short: that will cause lots of disk I/O.
while true do
    sleep(2000)
    update_recovery()
end
