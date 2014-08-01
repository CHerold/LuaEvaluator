-- Some functions for managing databases.
-- To use these, the databases module must be running with
-- some configured databases.

function clonetag(sourcedb,targetdb,tag,as)
    --[[docstring
    Clone a (meta)tag from one database to another. This creates
    a tag in the target database with the same name and
    configuration as the source tag.
    
    When the tag is a set&hold tag, the initial value
    of the target tag is set to the last value logged to
    the source tag. Otherwise, the initial value is NaN
    in case of a number tag, and "UNDEFINED" in case
    of a string tag.
    Parameters:
    any:sourcedb, name or object of source database.
    any:targetdb, name or object of target database. May be the same as the source only when an alternate tag name is provided.
    str:tag, name of tag to clone.
    [str:as], alternate name for the cloned tag.
    Errors:
    No such database.
    Target database must be unlocked.
    Tag does not exist in source database.
    Tag already exists in target database.
    Cannot clone a meta tag when parent tag does not exist.
    ]]
    if type(sourcedb)~="userdata" then sourcedb=DB.lookup(sourcedb) end
    if type(targetdb)~="userdata" then targetdb=DB.lookup(targetdb) end
    if nil==as then as=tag end
    local config=sourcedb:config(tag)
    if config.temporal=="set&hold" then
        targetdb:create(as,config,(sourcedb:last(tag)))
    else
        targetdb:create(as,config)
    end
end

function clonetags(sourcedb,targetdb,pattern)
    --[[docstring
    Clone all tags matching the specified pattern from one database
    to another. Useful for creating an empty database that contains
    a subset of tags or all tags in a database that is being retired.
    See the documentation of clonetag() for further details.
    Parameters:
    any:sourcedb, name or object of source database.
    any:targetdb, name or object of target database.
    str:pattern, tag filter pattern with '?' or '*' wildcards.
    Errors:
    No such database.
    Target database must be unlocked.
    Tag already exists in target database.
    ]]
    if type(sourcedb)~="userdata" then sourcedb=DB.lookup(sourcedb) end
    if type(targetdb)~="userdata" then targetdb=DB.lookup(targetdb) end
    assert(nil~=pattern,"No tag filtering pattern specified")
    -- This works because meta tags follow their base tags in the list.
    for i,tag in ipairs(sourcedb:list(pattern)) do
        clonetag(sourcedb,targetdb,tag)
    end
end

function deletetags(db,pattern)
    --[[docstring
    Delete all tags matching the specified pattern from a database. This
    function is highly dangerous when applied to a database containing
    important data.
    Parameters:
    any:db, name or object of database.
    str:pattern, tag filter pattern with '?' or '*' wildcards.
    Errors:
    No such database.
    Database must be unlocked.
    Cannot delete a base tag when a meta tag remains in existence.
    ]]
    if type(db)~="userdata" then db=DB.lookup(db) end
    assert(nil~=pattern,"No tag filtering pattern specified")
    local list=db:list(pattern)
    -- By working in reverse order, meta tags get deleted first.
    for i=table.getn(list),1,-1 do
        db:delete(list[i])
    end
end
