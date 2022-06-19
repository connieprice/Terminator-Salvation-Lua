require("managers/actionmanagers/AMNpcStart")
if not AMResistanceMale10Start then
	AMResistanceMale10Start = class(AMNpcStart)
end
AMResistanceMale10Start.unit_type = "resistance_male_10"
AMResistanceMale10Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceMale10Start.unit_type)
end


