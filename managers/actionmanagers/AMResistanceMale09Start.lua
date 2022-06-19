require("managers/actionmanagers/AMNpcStart")
if not AMResistanceMale09Start then
	AMResistanceMale09Start = class(AMNpcStart)
end
AMResistanceMale09Start.unit_type = "resistance_male_09"
AMResistanceMale09Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceMale09Start.unit_type)
end


