GameStatePreFrontend = GameStatePreFrontend or class(FiniteStateMachineState)
function GameStatePreFrontend.init(A0_0)
	local L1_1
	L1_1 = managers
	L1_1 = L1_1.game_transition
	L1_1 = L1_1.clear_wants_to_go_to_pre_frontend
	L1_1(L1_1)
	L1_1 = managers
	L1_1 = L1_1.game_transition
	L1_1 = L1_1.clear_wants_to_host
	L1_1(L1_1)
	L1_1 = A0_0.game
	L1_1._is_in_pre_frontend = true
	L1_1 = GameStateWaitingForPrimaryUser
	A0_0._machine = FiniteStateMachine:new(A0_0.game, "game", L1_1)
	A0_0.game:_request_show_menu_frontend()
	A0_0:_clear_player_slots()
end
function GameStatePreFrontend._clear_player_slots(A0_2)
	local L1_3
	L1_3 = managers
	L1_3 = L1_3.local_user
	L1_3 = L1_3.users
	L1_3 = L1_3(L1_3)
	for 