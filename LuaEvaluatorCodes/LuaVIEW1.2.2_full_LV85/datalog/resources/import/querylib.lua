function t2s(t)
    --[[docstring
    Convert a LabVIEW timestamp into a BTC-format time string.
    Parameters:
    num:t, time in seconds since the LabVIEW epoch..
    Results:
    str:s, converted time string.
    ]]
    local s=format_time(t,"%y%m%d.%H%M%S%2u")
    return string.sub(s,1,13)..string.sub(s,15,16)
end

function s2t(s)
    --[[docstring
    Convert a BTC-format time string into a LabVIEW timestamp.
    Parameters:
    str:s, string to convert.
    Results:
    num:t, time in seconds since the LabVIEW epoch.
    Errors:
    String too short.
    Missing separation dot between days and hours.
    Value out of range.
    ]]
    local date={}
    local len=string.len(s)
    assert(len>=6,"Too few characters in time time specification \""..s.."\"")
    local ticks=0
    date.year=2000+string.sub(s,1,2)
    date.month=string.sub(s,3,4)
    date.day=string.sub(s,5,6)
    if len>6 then
        assert(string.sub(s,7,7)==".","Time specification \""..s.."\" lacks a dot as 7th character.")
        assert(len<=15,"Too many characters in time specification \""..s.."\"")
        if len<15 then
            s=s..string.sub("00000000",1,15-len)
        end
        date.hour=string.sub(s,8,9)
        date.min=string.sub(s,10,11)
        date.sec=string.sub(s,12,13)
        ticks=string.sub(s,14,15)
    else
        s=s..".00000000"
    end
    local t=time(date)+ticks/100
    -- Test for and work around LabVIEW for Linux daytime bug in "Date/Time To Seconds".
    if t2s(t)~=s then
        t=t-3600
        assert(t2s(t)==s,"Cannot fix numerical/string time discrepancy.")
    end
    return t
end

function interpolations(db,tags,times)
    --[[docstring
    Returns a table of tables containing the values of a series of tags interpolated at
    the specified times.
    Parameters:
    obj:db, database object.
    tab:tags, array of tags to interpolate.
    tab:times, array of times to interpolate at.
    Results:
    tab:values_per_tag, table of tables containing the interpolated tag values.
    ]]
    local tvals={}
    for i,tag in ipairs(tags) do
        tvals[i]=db:interpolate(tag,times)
    end
    return tvals
end

function units(db,tags)
        --[[docstring
        Return the unit strings of the given tags.
        Parameters:
        tab:tags
        Results:
        tab:units
        ]]
      local u={}
      for i,tag in ipairs(tags) do
          u[i]=(db:config(tag)).unit
      end
      return u
end

function csv(db,tags,times)
    --[[docstring
    Output a comma separated file named "results.csv" for the
    given tags interpolated at the given times. The header will
    include both tag names and units. The first column includes
    the times converted in hours since the first specified time.
    Parameters:
    obj:db, database object.
    tab:tags, array of tag names.
    tab:times, times to interpolate at.
    Errors:
    Non-existing tag.
    Wrong temporal type for interpolation.
    ]]
    local tvals=interpolations(db,tags,times)
    local file=io.open("c:\\work\\results.csv","w")
    local eol="\n"
    -- local file=io.open(task.directory().._SEP.."results.csv")
    file:write()
    local s
    s="time"
    for i,tag in ipairs(tags) do
        s=s..","..tag
    end
    file:write(s,eol)
    s="hours"
    for i,unit in ipairs(units(db,tags)) do
        s=s..","..unit
    end
    file:write(s,eol)
    for row,t in ipairs(times) do
        s=(times[row]-times[1])/3600
        for col,tag in ipairs(tags) do
            if lv.isnan(tvals[col][row]) then
                s=s..","
            else
                s=s..","..tvals[col][row]
            end
        end
        file:write(s,eol)
    end
    file:close()
end

function tcsv(db,tags,times)
    --[[docstring
    Output a comma separated file named "results.csv" for the
    given tags interpolated at the given times. The header will
    include both tag names and units. The first two columns include
    the times converted a BTC time string and hours since the first
    specified time.
    Parameters:
    obj:db, database object.
    tab:tags, array of tag names.
    tab:times, times to interpolate at.
    Errors:
    Non-existing tag.
    Wrong temporal type for interpolation.
    ]]
    local tvals=interpolations(db,tags,times)
    local file=io.open("c:\\work\\results.csv","w")
    local eol="\n"
    -- local file=io.open(task.directory().._SEP.."results.csv")
    file:write()
    local s
    s="date,time"
    for i,tag in ipairs(tags) do
        s=s..","..tag
    end
    file:write(s,eol)
    s=",hours"
    for i,unit in ipairs(units(db,tags)) do
        s=s..","..unit
    end
    file:write(s,eol)
    for row,t in ipairs(times) do
        s="\""..t2s(times[row]).."\","..(times[row]-times[1])/3600
        for col,tag in ipairs(tags) do
            if lv.isnan(tvals[col][row]) then
                s=s..","
            else
                s=s..","..tvals[col][row]
            end
        end
        file:write(s,eol)
    end
    file:close()
end

function timeseries(be,en,step)
   --[[docstring
    Return a series of times starting from the begin time and
    incremented by the specified step up to the end time. The
    last returned value does not exceed the specified end time.
    Parameters:
    num:be, begin time in seconds since the LabVIEW epoch.
    num:en, end time in seconds since the LabVIEW epoch.
    num:step, time step size in seconds.
    Results:
    tab:times
    ]]
    local t=be
    local times={}
    while t<=en do
        table.insert(times,t)
        t=t+step
    end
    return times
end