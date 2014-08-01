--#class "example"
--#description "Test sequencing example"
--#import "imports/schedulers.lua"
--#import "imports/stages.lua"
-- On the Mac, add a leading "/" or "%" to the paths.
--
-- Shows how Lua can be used to run a test sequence.
-- The main script uses tables to define the sequence.
-- One import script defines a scheduler to iterate over
-- the sequence stages. Another import script defines
-- functions that can be used to make up the stages.
-- This setup allows the scheduler and stage functions
-- to be reused for different test sequences and puts
-- all the test specific-definitions in this main script.

-- Define cycles using stage functions.
cycle_foo = {
function() stage_blah("foo") end,
function() stage_rampto(1, 30) end,
repeats=2
}
cycle_bar = {
stage_moo,
stage_countdown,
repeats=1
}
cycle_baz = {
function() stage_blah("baz") end,
function() stage_rampto(3, 10) end,
stage_moo,
repeats=2
}

-- Define phases using cycles.
phase_one = {
cycle_baz,
cycle_foo,
cycle_baz,
repeats=1
}
phase_two = {
cycle_foo,
cycle_bar,
repeats=3
}

-- Schedule the phases
simple_scheduler({phase_one, phase_two})
