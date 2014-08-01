--#class "example"
--#description "Lets calls be traced"
--#import "imports/trace-calls.lua"
-- On the Mac, add a leading "/" or ":" to the path.

function bar()
	print("bar")
end

function foo()
	print("foo")
	bar()
end

foo()
