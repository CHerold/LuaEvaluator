-- Import for mirror tasks. The task should open the mirror module,
-- provide it with the databse-specific configuration, and then call
-- the mirror() function.

function mirror(tagdelay)
    -- Main function that takes care of the mirroring operations.
    db=DB.lookup(localdb())
    lv.print("Connecting to remote server.")
    connect()
    lv.addcleanup(function() disconnect() end)
    local changecount=0
    local tagdex=1
    local cyclestart=time()
    local taglist,tagnum
    local values
    while true do
        local cnt,lst=get_list(changecount)
        if changecount==0 or cnt~=changecount then
            -- Remote might have been changed.
            changecount=cnt
            taglist=lst
            tagnum=table.getn(taglist)
            assert(tagnum>0,"Nothing to mirror: remote database \""..remotedb().."\" contains no tags.")
            -- Mirror tag configuration changes. Create tags that do not exist yet.
            for i,rcfg in ipairs(taglist) do
                if db:exists(rcfg.name) then
                    if (mirror_config(rcfg)) then
                        lv.print("Mirrored configuration of tag \""..rcfg.name.."\".")
                    end
                else
                    -- Create empty tag. The tags are sorted so parent tags will be created first.
                    lv.print(string.format("Creating empty %s tag \"%s\" in local database.",rcfg.value,rcfg.name))
                    create_empty(rcfg)
                    values=mirror_tag(rcfg.name)
                    if values>0 then
                        lv.print(string.format("First mirror of %.0f values for tag \"%s\".",values,rcfg.name))
                    end
                    sleep(tagdelay)
                end
            end
            -- Mirror subset changes.
            if (mirror_subsets()) then
                lv.print("Mirrored tag subset definitions.")
            end
            -- See if the number of tags matches, and error or warn when not so.
            if tagnum~=db:tags() then
                assert(tagnum<db:tags(),"Local database contains fewer tags than remote database.")
                lv.print("Warning. The local database \""..localdb().."\" contains tags not or no longer present in the remote database being mirrored. These are:")
                local tagkeys={}
                for i,rcfg in ipairs(taglist) do
                    tagkeys[rcfg.name]=true
                end
                for i,tag in ipairs(db:list()) do
                    if not tagkeys[tag] then
                        lv.print(tag)
                    end
                end
                tagkeys=nil
            end
        end
        -- Make sure the tag index is within bounds.
        if tagdex>tagnum then
            tagdex=1
            lv.print(string.format("Cycled through the %d remote tags in %.2f seconds.",tagnum,time()-cyclestart))
            cyclestart=time()
        end
        -- Mirror the indexed tag.
        values=mirror_tag(taglist[tagdex].name)
        if values>0 then
            lv.print(string.format("Mirrored %.0f values for tag \"%s\".",values,taglist[tagdex].name))
        end
        tagdex=tagdex+1
        sleep(tagdelay)
    end
end
