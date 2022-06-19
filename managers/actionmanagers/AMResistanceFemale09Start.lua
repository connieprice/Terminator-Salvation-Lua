require("managers/actionmanagers/AMNpcStart")
if not AMResistanceFemale09Start then
	AMResistanceFemale09Start = class(AMNpcStart)
end
AMResistanceFemale09Start.unit_type = "resistance_female_09"
AMResistanceFemale09Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceFemale09Start.unit_type)
end


