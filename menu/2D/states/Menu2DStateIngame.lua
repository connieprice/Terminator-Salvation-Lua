require("menu/2D/states/Menu2DState")
require("menu/2D/states/Menu2DStateEndSyncToIngame")
require("menu/2D/states/Menu2DStateIngameEmpty")
require("menu/2D/states/Menu2DStateIngamePausedGameOver")
require("menu/2D/states/Menu2DStateIngamePausedNormal")
require("menu/2D/states/Menu2DStateIngameResuming")
require("shared/FiniteStateMachine")
Menu2DStateIngame = Menu2DStateIngame or class(Menu2DState)
Menu2DStateIngame.transitions = {
	{
		state_transition = "end_sync_to_ingame",
		state = Menu2DStateEndSyncToIngame
	},
	{state_transition = "ingame", state = Menu2DStateIngameEmpty},
	{state_transition = "game_over", state = Menu2DStateIngamePausedGameOver},
	{state_transition = "paused", state = Menu2DStateIngamePausedNormal},
	{
		state_transition = "resuming_from_pause",
		state = Menu2DStateIngameResuming
	}
}
function Menu2DStateIngame.init(A0_0)
	local L1_1, L2_2, L3_3
	L1_1 = Menu2DState
	L1_1 = L1_1.init
	L2_2 = A0_0
	L3_3 = Menu2DStateIngame
	L1_1(L2_2, L3_3)
	L1_1 = {}
	L2_2 = A0_0._state_data
	L2_2 = L2_2.menu
	L1_1.menu = L2_2
	L2_2 = A0_0.transitions
	L1_1.state_transitions = L2_2
	L2_2 = A0_0._state_data
	L2_2 = L2_2.menu
	L2_2 = L2_2.state_transition_data
	L2_2 = L2_2.requested_state
	L3_3 = Menu2DStateTransitionLookup
	L3_3 = L3_3.new
	L3_3 = L3_3(L3_3, A0_0.transitions)
	L3_3 = L3_3.state
	L3_3 = L3_3(L3_3, L2_2)
	A0_0._sub_state_machine = FiniteStateMachine:new(L1_1, "_state_data", L3_3)
	managers.volume:activate_set("ingame")
end
function Menu2DStateIngame.exit(A0_4)
	managers.volume:deactivate_set("ingame")
	A0_4._sub_state_machine:destroy()
end
function Menu2DStateIngame.update(A0_5, A1_6)
	A0_5._sub_state_machine:update(A1_6)
end
