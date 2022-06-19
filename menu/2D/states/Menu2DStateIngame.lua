require("menu/2D/states/Menu2DState")
require("menu/2D/states/Menu2DStateEndSyncToIngame")
require("menu/2D/states/Menu2DStateIngameEmpty")
require("menu/2D/states/Menu2DStateIngamePausedGameOver")
require("menu/2D/states/Menu2DStateIngamePausedNormal")
require("menu/2D/states/Menu2DStateIngameResuming")
require("shared/FiniteStateMachine")
if not Menu2DStateIngame then
	Menu2DStateIngame = class(Menu2DState)
end
local l_0_0 = Menu2DStateIngame
local l_0_1 = {}
local l_0_2 = {}
l_0_2.state_transition = "end_sync_to_ingame"
l_0_2.state = Menu2DStateEndSyncToIngame
local l_0_3 = {}
l_0_3.state_transition = "ingame"
l_0_3.state = Menu2DStateIngameEmpty
local l_0_4 = {}
l_0_4.state_transition = "game_over"
l_0_4.state = Menu2DStateIngamePausedGameOver
local l_0_5 = {}
l_0_5.state_transition = "paused"
l_0_5.state = Menu2DStateIngamePausedNormal
local l_0_6 = {}
l_0_6.state_transition = "resuming_from_pause"
l_0_6.state = Menu2DStateIngameResuming
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

l_0_0.transitions = l_0_1
l_0_0 = Menu2DStateIngame
l_0_1 = function(l_1_0)
	Menu2DState.init(l_1_0, Menu2DStateIngame)
	local l_1_1 = {}
	l_1_1.menu = l_1_0._state_data.menu
	l_1_1.state_transitions = l_1_0.transitions
	local l_1_2 = l_1_0._state_data.menu.state_transition_data.requested_state
	local l_1_3 = Menu2DStateTransitionLookup:new(l_1_0.transitions):state(l_1_2)
	l_1_0._sub_state_machine = FiniteStateMachine:new(l_1_1, "_state_data", l_1_3)
	managers.volume:activate_set("ingame")
end

l_0_0.init = l_0_1
l_0_0 = Menu2DStateIngame
l_0_1 = function(l_2_0)
	managers.volume:deactivate_set("ingame")
	l_2_0._sub_state_machine:destroy()
end

l_0_0.exit = l_0_1
l_0_0 = Menu2DStateIngame
l_0_1 = function(l_3_0, l_3_1)
	l_3_0._sub_state_machine:update(l_3_1)
end

l_0_0.update = l_0_1

