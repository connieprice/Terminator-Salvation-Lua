require("managers/actionmanagers/AMNpcStart")
if not AMResistanceFemale06Start then
	AMResistanceFemale06Start = class(AMNpcStart)
end
AMResistanceFemale06Start.unit_type = "resistance_female_06"
AMResistanceFemale06Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceFemale06Start.unit_type)
end


