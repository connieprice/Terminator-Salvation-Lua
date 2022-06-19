require("managers/actionmanagers/AMNpcStart")
if not AMResistanceFemale08Start then
	AMResistanceFemale08Start = class(AMNpcStart)
end
AMResistanceFemale08Start.unit_type = "resistance_female_08"
AMResistanceFemale08Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceFemale08Start.unit_type)
end


