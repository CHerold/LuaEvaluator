--#class "<dir>"
--#disallow_manual
--#defer
--#import "auto tags.lua"
--#description "Initialise databases."

tasks={
    "databases/query monitor.lua",
}

module=VI.open_module(resolve_VI_path("DataLog Databases Module.vi","dynamic"),"","",{
["databases"]={
{mode="unlocked",path="testdb"},
{mode="mirrored",path="mirrordb"},
},
-- Specifies the various databases and their modes. Three modes can be set:
-- "locked", "unlocked", and "mirrored". When locked, no modifications can be
-- made to a database from scripts or the client: only read accesses are allowed.
-- When mirrored, the database is a duplicate of a remote database. The
-- mirroring is done through a separate mirroring task in conjunction with the
-- mirror module. A mirrored database cannot be modified from the client.
--
-- The path specifies the directory where the tag logs of the database reside.
-- When a relative path is specified, the path is made absolute by prepending
-- the resource base path. The tag logs are contained in subdirectories of the
-- specified paths.
--
-- The name of each database will be set equal to the last directory name in the
-- path. Even when two databases have different paths, they may not have the
-- same name. To rename a database, rename its directory.
-- 
--The first database in the list is the current database. The current database
-- is the database that can be logged once after datalogging goes live.
--
-- BEWARE: do not change the current database unless the server was properly
-- shut down or else the required recovery might not be applied or, worse, be
-- applied to the wrong database.
["recovery directory"]=[[]],
-- Specifies the directory where the aggregation mirror file and tag hash
-- recovery file are located. When an empty path is specified, these files
-- are placed in the "datalog base path". When a relative path is specified,
-- the resource base path is prepended. While logging, both the tag logs
-- and the mirror file are updated periodically. When there are multiple
-- harddisks available, improved throughput can be attained by specifying a
-- recovery directory on a different harddisk than the disk containing the
-- datalog.
--
-- BEWARE: do not change this setting unless the server was properly
-- shut down or else the required recovery will not be able to commence.
["max points"]=200000,
-- The maximum number of data points that can be read from a tag log into a
-- single memory array. If the number of points requested in a query exceeds
-- this, an error is returned. This serves to limit the amount of memory used
-- per tag. Each point uses 16 bytes. Consequently, this value should be set
-- such that the amount of readily available memory on the server is larger
-- than 16 times this value times the maximum number of simultaneously queried
-- tags with a lots of data. When the server is performing measurements it
-- might be desirable to choose this value serveral times smaller to 
-- avoid high system load or swapping to virtual memory.
["max string mem"]=3000000,
-- The maximum amount of memory that is allowed to be used for storing
-- strings read from a string tag during a query. As with max points, set
-- this such that the server memory usage remains reasonable in view of
-- its memory capacity and the tasks it is performing.
})
lv.addcleanup(function() revoke_exports() cleanup() module:close() end)

-- Make sure that the current database contains required tags and automatically
-- create them and any meta tags when they do not exist.
auto_tags()

-- Start the tasks.
for key,path in ipairs(tasks) do
    local id=run_task(path)
    lv.addcleanup(function() sig.stop(id) while(task.ongoing(id)) do wait(2) end end)
end

task.active()
while true do sleep() end
