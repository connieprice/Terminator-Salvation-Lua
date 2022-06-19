require("menu/2D/states/Menu2DState")
require("menu/2D/states/Menu2DStateStartupLegal")
require("menu/2D/states/Menu2DStateStartupMovie")
Menu2DStateStartup = Menu2DStateStartup or class(Menu2DState)
Menu2DStateStartup.transitions = {
	{state_transition = "startup", state = Menu2DStateInactive},
	{state_transition = "legal", state = Menu2DStateStartupLegal},
	{
		state_transition = "intro_movie",
		state = Menu2DStateStartupMovie
	}
}
function Menu2DStateStartup.init(A0_0)
	local L1_1, L2_2, L3_3
	L1_1 = Menu2DState
	L1_1 = L1_1.init
	L2_2 = A0_0
	L3_3 = Menu2DStateStartup
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
end
function Menu2DStateStartup.exit(A0_4)
	A0_4._sub_state_machine:destroy()
end
function Menu2DStateStartup.update(A0_5, A1_6)
	A0_5._sub_state_machine:update(A1_6)
end
