require("managers/actionmanagers/AMNpcStart")
if not AMResistanceMale08Start then
	AMResistanceMale08Start = class(AMNpcStart)
end
AMResistanceMale08Start.unit_type = "resistance_male_08"
AMResistanceMale08Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceMale08Start.unit_type)
end


