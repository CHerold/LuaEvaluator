-- A Lua function library is a script containing a series of
-- function definitions and optionally some initialization code
-- that will typically be imported into a task script via the
-- "import" preprocessor keyword, thereby making these
-- functions available to the script.
--
--This example shows how Lua functions can be documented
-- by way of docstrings such that the "Function Manager"
-- can extract them. Select this script as source in the
-- "Function Manager" user interface to have the docstrings
-- be parsed and any format errors reported. Next select
-- export to generate HTML documentation.
--
-- Note that as opposed to Python, these docstrings are
-- not an official Lua language feature. The function
-- documentation features were created primarily for
-- LuaVIEW function VIs so as to force the argument
-- checking and documentation to remain in-sync. For
-- Lua functions, the docstrings have no functional
-- impact, but since the "Function Manager" existed
-- already, it was extended to handle Lua functions
-- as well. The format is identical to that enforced
-- by the "Edit Documentation" window of the
-- "Function Manager" apart from single line breaks in
-- the description being ignored.

function foo(fooable)
	--[[docstring
	This function serves to foo the fooable. Note that
	when no function name is specified after the docstring
	keyword, with a space inbetween, a prior nearby
	function definition is looked for.
	Parameters:
	str:fooable
	]]
	print("Fooing the fooable:")
	print(fooable)
end

function bar(barable)
	--[[docstring
	This function bars the  barable. The function description
	should summarize what the function does, but sometimes
	needs to be a bit longer for a full description.
	
	A second paragraph in the function description can be
	created by including an empty line. Any line breaks
	within a paragraph are converted to spaces unless
	they are at the end of the paragraph.
	Parameters:
	num:barable, the number to bar.
	Results:
	num:barred
	Errors:
	Negative barable not allowed.
	]]
	if (barable < 0) then
		error("Barable should be >= 0")
	end
	return sin(barable*barable)
end

zoom = function()
	--[[docstring zoom
	The docstring parser is not smart enough to determine
	the function name here so we specify it explicitely.
	The docstring parser strips leading and trailing whitespace
	in the function description, so you can write the docstring
	at the same indentation level as the function.
	Results:
	bool:zoomed, arguments and results can be explained with some additional text that should not contain a line break since the docstring parser expects one argument and one result per line.
	]]
	print("Zoooooooommmmm")
	return true
end
