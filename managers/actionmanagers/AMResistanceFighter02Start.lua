require("managers/actionmanagers/AMNpcStart")
if not AMResistanceFighter02Start then
	AMResistanceFighter02Start = class(AMNpcStart)
end
AMResistanceFighter02Start.unit_type = "resistance_fighter_02"
AMResistanceFighter02Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceFighter02Start.unit_type)
end


