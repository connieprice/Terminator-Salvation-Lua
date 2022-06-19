require("managers/actionmanagers/AMPlayerTankStart")
AMBlairTankStart = AMBlairTankStart or class(AMPlayerTankStart)
function AMBlairTankStart.init(A0_0, A1_1, A2_2)
	AMPlayerTankStart.init(A0_0, A1_1, A2_2, 2, "player2_tank")
end
function AMBlairTankStart._spawn(A0_3)
	A0_3._player_slot = 2
	AMPlayerTankStart._spawn(A0_3)
end
