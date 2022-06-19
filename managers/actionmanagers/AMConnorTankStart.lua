require("managers/actionmanagers/AMPlayerTankStart")
AMConnorTankStart = AMConnorTankStart or class(AMPlayerTankStart)
function AMConnorTankStart.init(A0_0, A1_1, A2_2)
	AMPlayerTankStart.init(A0_0, A1_1, A2_2, 1, "player_tank")
end
function AMConnorTankStart._spawn(A0_3)
	A0_3._player_slot = 1
	AMPlayerTankStart._spawn(A0_3)
end
