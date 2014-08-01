--#class "slave"
--#description "Simulates some asynchronous process to be managed programatically."
--#disallow_manual

i = 1
while (true) do
	print("Asynchronous task iteration "..i)
	i = i+1
	sleep(1000)
end
