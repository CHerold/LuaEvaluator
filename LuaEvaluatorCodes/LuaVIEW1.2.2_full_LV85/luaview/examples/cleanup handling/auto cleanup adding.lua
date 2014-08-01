--#class "example"
--#description "Demonstrates how to automagically add cleanup functions"
--Lua has the useful but slightly confusing capability of defining
--anonymous functions on the fly. This can be be used to define
--a dedicated cleanup function when allocating some resources
--such that that function cleans up the specific resources of
--that particular allocation.

resource_count = 0

-- A resource allocation function with also arranges for cleanup
function allocate(amount)
	print("Allocating "..amount.." resources.")
	resource_count = resource_count + amount
	-- Now we've done the allocation, add the corresponding cleanup
	lv.addcleanup(function()
		print("Freeing "..amount.." resources.")
		resource_count = resource_count - amount
		print(resource_count.." resources left.")
	end)
end

print("-----------------------")
allocate(42)
allocate(1)
allocate(123)
