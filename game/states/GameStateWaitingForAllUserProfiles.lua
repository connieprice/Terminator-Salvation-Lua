GameStateWaitingForAllUserProfiles = GameStateWaitingForAllUserProfiles or class(FiniteStateMachineState)
function GameStateWaitingForAllUserProfiles._playing_ready_user_count(A0_0)
	local L1_1
	L1_1 = managers
	L1_1 = L1_1.local_user
	L1_1 = L1_1.users
	L1_1 = L1_1(L1_1)
	for 