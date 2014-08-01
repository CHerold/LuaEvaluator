--#class "test"
--#description "NaN handling."
-- VC++  6 gets NaN comparisons wrong. Now that the Windows
-- CIN is compiled with VC++ 7, NaN comparisons are as they should
-- be. But...
-- VC++ uses some weird string format when string formatting
-- NaN, Inf, and, -Inf numbers. What's worse, its scan functions
-- do not convert these back to floating point notation thereby
-- breaking the Lua string<>number symmetry for these special
-- numbers. In short, typical Microsoft inanity.

nan = sqrt(-1)
print(nan)
if (nan ~= nan) then
    print("Not a number")
else
    print("A number")
end
print(tonumber(tostring(nan)))
