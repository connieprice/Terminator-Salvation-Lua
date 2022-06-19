require("managers/actionmanagers/AMNpcStart")
if not AMResistanceSoldier08Start then
	AMResistanceSoldier08Start = class(AMNpcStart)
end
AMResistanceSoldier08Start.unit_type = "resistance_soldier_08"
AMResistanceSoldier08Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceSoldier08Start.unit_type)
end


