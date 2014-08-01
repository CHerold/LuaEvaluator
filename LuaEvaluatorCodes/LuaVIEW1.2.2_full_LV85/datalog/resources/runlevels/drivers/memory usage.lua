--#class "<dir>"
--#defer
--#description "Poll LabVIEW memory usage."
-- Poll the LabVIEW memory usage and write it to
-- the "mem_usage" tag.

sig.handle_stop()

-- Make sure the tag exists.
du = Tag.lookup("memory_usage","byte")
task.active()

-- Periodically update the usage.
repeat
    du:write(lv.memusage())
    sleep(2000)
until(sig.stop_set())

-- Indicate that the tag is no longer being updated.
du:write(_NaN)
