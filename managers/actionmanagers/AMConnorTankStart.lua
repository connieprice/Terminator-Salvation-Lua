require("managers/actionmanagers/AMPlayerTankStart")
if not AMConnorTankStart then
	AMConnorTankStart = class(AMPlayerTankStart)
end
AMConnorTankStart.init = function(l_1_0, l_1_1, l_1_2)
	AMPlayerTankStart.init(l_1_0, l_1_1, l_1_2, 1, "player_tank")
end

AMConnorTankStart._spawn = function(l_2_0)
	l_2_0._player_slot = 1
	AMPlayerTankStart._spawn(l_2_0)
end


