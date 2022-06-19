require("managers/actionmanagers/AMNpcStart")
if not AMResistanceFighter06Start then
	AMResistanceFighter06Start = class(AMNpcStart)
end
AMResistanceFighter06Start.unit_type = "resistance_fighter_06"
AMResistanceFighter06Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceFighter06Start.unit_type)
end


