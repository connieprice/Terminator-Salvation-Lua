require("menu/2D/states/Menu2DState")
require("menu/2D/states/Menu2DStateStartupLegal")
require("menu/2D/states/Menu2DStateStartupMovie")
if not Menu2DStateStartup then
	Menu2DStateStartup = class(Menu2DState)
end
local l_0_0 = Menu2DStateStartup
local l_0_1 = {}
local l_0_2 = {}
l_0_2.state_transition = "startup"
l_0_2.state = Menu2DStateInactive
local l_0_3 = {}
l_0_3.state_transition = "legal"
l_0_3.state = Menu2DStateStartupLegal
local l_0_4 = {}
l_0_4.state_transition = "intro_movie"
l_0_4.state = Menu2DStateStartupMovie
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

l_0_0.transitions = l_0_1
l_0_0 = Menu2DStateStartup
l_0_1 = function(l_1_0)
	Menu2DState.init(l_1_0, Menu2DStateStartup)
	local l_1_1 = {}
	l_1_1.menu = l_1_0._state_data.menu
	l_1_1.state_transitions = l_1_0.transitions
	local l_1_2 = l_1_0._state_data.menu.state_transition_data.requested_state
	local l_1_3 = Menu2DStateTransitionLookup:new(l_1_0.transitions):state(l_1_2)
	l_1_0._sub_state_machine = FiniteStateMachine:new(l_1_1, "_state_data", l_1_3)
end

l_0_0.init = l_0_1
l_0_0 = Menu2DStateStartup
l_0_1 = function(l_2_0)
	l_2_0._sub_state_machine:destroy()
end

l_0_0.exit = l_0_1
l_0_0 = Menu2DStateStartup
l_0_1 = function(l_3_0, l_3_1)
	l_3_0._sub_state_machine:update(l_3_1)
end

l_0_0.update = l_0_1

