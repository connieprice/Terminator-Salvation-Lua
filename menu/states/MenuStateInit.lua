MenuStateInit = MenuStateInit or class(FiniteStateMachineState)
function MenuStateInit.transition(A0_0)
	local L1_1
	L1_1 = managers
	L1_1 = L1_1.game
	L1_1 = L1_1.menu_frontend_type
	L1_1 = L1_1(L1_1)
	return A0_0._menu:_frontend_end_sync_state(L1_1)
end
