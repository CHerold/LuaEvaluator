-- A simple scheduler

function simple_scheduler_private(phases,validate)
    local phase,cycles,phreps,phrep,cycle,stages,cyreps,cyrep,stage,stagefunction
    for phase,cycles in ipairs(phases) do
        phreps = cycles.repeats
        for phrep=1,phreps,1 do
            for cycle,stages in ipairs(cycles) do
                cyreps = stages.repeats
                for cyrep=1,cyreps,1 do
                    for stage,stagefunction in ipairs(stages) do
			if ("function" ~= type(stagefunction)) then
			    error("No stage function for "..
				"phase="..phase..":rep"..phrep.."/"..
                                phreps.." cycle="..cycle..":rep"..
                                cyrep.."/"..cyreps.." stage="..stage)
			end
			-- When validating do not schedule anything.
			if (not validate) then
                            wait(1000)
                            print("")
                            print("phase="..phase..":rep"..phrep.."/"..
                                   phreps.." cycle="..cycle..":rep"..
                                   cyrep.."/"..cyreps.." stage="..stage)
                            stagefunction()
			end
                    end
                end
            end
        end
    end
end

function simple_scheduler(phases)
    -- First validate the passed phases table so as to discover errors early.
    simple_scheduler_private(phases,true)
    -- Next do the actual scheduling.
    simple_scheduler_private(phases,false)
end
