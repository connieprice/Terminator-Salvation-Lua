require("managers/actionmanagers/AMPlayerTankStart")
if not AMBlairTankStart then
	AMBlairTankStart = class(AMPlayerTankStart)
end
AMBlairTankStart.init = function(l_1_0, l_1_1, l_1_2)
	AMPlayerTankStart.init(l_1_0, l_1_1, l_1_2, 2, "player2_tank")
end

AMBlairTankStart._spawn = function(l_2_0)
	l_2_0._player_slot = 2
	AMPlayerTankStart._spawn(l_2_0)
end


