-- Configurations of required tags that should be automatically created
-- for the current database when they do not yet exist. 

function auto_tags()
    local db=DB.lookup()
    if db:mode()~="unlocked" then return end
    local function ifcreate(tag,config,initial)
        -- Create a tag if it does not exist yet with optional initial value.
        if db:exists(tag) then return end
        if initial then
            db:create(tag,config,initial)
        else
            db:create(tag,config)
        end
    end
    ifcreate("errors",{
        ["temporal"]="event",
        ["value"]="string",
        ["mincapacity"]=2048,
        ["description"]="Error messages logged via the \"errors\" task.",
        ["logging algorithm"]="everything",
    })
    ifcreate("warnings",{
        ["temporal"]="event",
        ["value"]="string",
        ["mincapacity"]=2048,
        ["description"]="Warning messages logged via the \"warnings\" task.",
        ["logging algorithm"]="everything",
    })
    ifcreate("disk_usage",{
        ["unit"]="%",
        ["temporal"]="sample",
        ["value"]="number",
        ["precision"]=5,
        ["description"]="Usage of disk containing logging database.",
        ["logging algorithm"]="everything",
        ["undefine"]=true,
     })
     ifcreate("disk_usage_warn_hi",{
        ["precision"]=5,
        ["logging algorithm"]="everything",
    },95)
    ifcreate("latency",{
        ["unit"]="ms",
        ["temporal"]="event",
        ["value"]="number",
        ["mincapacity"]=1024,
        ["precision"]=0,
        ["description"]="Long scheduling latency events.",
        ["logging algorithm"]="nothing",
    })
    ifcreate("memory_usage",{
        ["unit"]="byte",
        ["temporal"]="sample",
        ["value"]="number",
        ["format"]="engineering",
        ["precision"]=3,
        ["description"]="Memory usage of the LabVIEW runtime.",
        ["logging algorithm"]="everything",
        ["undefine"]=true,
    })
end
