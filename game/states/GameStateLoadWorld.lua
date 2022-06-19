require("menu/ingame/IntroCredits")
GameStateLoadWorld = GameStateLoadWorld or class(FiniteStateMachineState)
function GameStateLoadWorld._number_of_players(A0_0, A1_1)
	local L2_2
	L2_2 = managers
	L2_2 = L2_2.local_user
	L2_2 = L2_2.users
	L2_2 = L2_2(L2_2)
	for 