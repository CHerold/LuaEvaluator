periods=0
while true do
    sleep(200)
    if datalog.flush_next_if() then
        periods=0
    else
        periods=periods+1
        if periods>=50 then
            datalog.flush_next()
            periods=0
        end
    end
end
