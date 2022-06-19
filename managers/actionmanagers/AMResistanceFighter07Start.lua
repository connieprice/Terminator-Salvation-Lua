require("managers/actionmanagers/AMNpcStart")
if not AMResistanceFighter07Start then
	AMResistanceFighter07Start = class(AMNpcStart)
end
AMResistanceFighter07Start.unit_type = "resistance_fighter_07"
AMResistanceFighter07Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceFighter07Start.unit_type)
end


