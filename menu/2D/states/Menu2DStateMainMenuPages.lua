require("menu/2D/states/Menu2DState")
require("shared/FiniteStateMachine")
require("menu/2D/states/Menu2DStateMainMenu")
require("menu/2D/states/Menu2DStateTitle")
require("menu/2D/states/Menu2DStateInactive")
require("menu/2D/states/Menu2DStateSaveIconNotification")
Menu2DStateMainMenuPages = Menu2DStateMainMenuPages or class(Menu2DState)
Menu2DStateMainMenuPages.transitions = {
	{state_transition = "main_menu", state = Menu2DStateMainMenu},
	{state_transition = "title", state = Menu2DStateTitle},
	{state_transition = "attract", state = Menu2DStateInactive},
	{
		state_transition = "save_icon_notification",
		state = Menu2DStateSaveIconNotification
	}
}
function Menu2DStateMainMenuPages.init(A0_0)
	local L1_1, L2_2, L3_3
	L1_1 = Menu2DState
	L1_1 = L1_1.init
	L2_2 = A0_0
	L3_3 = Menu2DStateMainMenuPages
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
	managers.music:player():play_nice("menu_radio")
end
function Menu2DStateMainMenuPages.exit(A0_4)
	managers.music:player():stop_nice()
	A0_4._sub_state_machine:destroy()
end
function Menu2DStateMainMenuPages.update(A0_5, A1_6)
	A0_5._sub_state_machine:update(A1_6)
end
