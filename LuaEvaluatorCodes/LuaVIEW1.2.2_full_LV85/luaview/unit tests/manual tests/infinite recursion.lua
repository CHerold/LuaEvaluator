--#class "test"
--#description "Recurses until a stack overflow occurs."

function recurse()
	recurse()
	return
end
recurse()
