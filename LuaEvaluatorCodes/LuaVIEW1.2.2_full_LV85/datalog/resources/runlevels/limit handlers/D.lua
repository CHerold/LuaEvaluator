--#identifier "D_handler"
--#class "<dir>"
--#description "Handles ??? limit events."
--#disallow_manual

while true do
	while msg.available() do
		message = msg.next()
        if message then
            -- message format: "<hi|lo>,<tagname>"
            side=string.sub(message,1,2)
            tag=string.sub(message,4)
            -- Do any custom handling here.
            msg.send("errors","Tag \""..tag.."\" exceeded its "..side.." limit")
        end
    end
    sleep()
end
