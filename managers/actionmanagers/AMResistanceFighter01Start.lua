require("managers/actionmanagers/AMNpcStart")
if not AMResistanceFighter01Start then
	AMResistanceFighter01Start = class(AMNpcStart)
end
AMResistanceFighter01Start.unit_type = "resistance_fighter_01"
AMResistanceFighter01Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceFighter01Start.unit_type)
end


