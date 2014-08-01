--#class "<dir>"
--#defer
--#description "Poll disk usage."
-- Poll disk usage and write the usage percentage
-- to the "disk_usage" tag. This allows the system
-- to respond in a configurable manner when the disk
-- fills up by creating a hilim meta tag.

sig.handle_stop()

-- Make sure the tag exists.
du = Tag.lookup("disk_usage","%")
task.active()

-- Periodically poll the usage.
repeat
    size,used = datalog.volume_info()
    du:write(100*used/size)
    sleep(60000)
until(sig.stop_set())

-- Indicate that the tag is no longer being updated.
du:write(_NaN)
