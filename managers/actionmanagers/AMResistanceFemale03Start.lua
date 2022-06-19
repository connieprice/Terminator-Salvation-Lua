require("managers/actionmanagers/AMNpcStart")
if not AMResistanceFemale03Start then
	AMResistanceFemale03Start = class(AMNpcStart)
end
AMResistanceFemale03Start.unit_type = "resistance_female_03"
AMResistanceFemale03Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceFemale03Start.unit_type)
end


