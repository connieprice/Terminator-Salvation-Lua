require("managers/actionmanagers/AMNpcStart")
if not AMResistanceSoldier06Start then
	AMResistanceSoldier06Start = class(AMNpcStart)
end
AMResistanceSoldier06Start.unit_type = "resistance_soldier_06"
AMResistanceSoldier06Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceSoldier06Start.unit_type)
end


