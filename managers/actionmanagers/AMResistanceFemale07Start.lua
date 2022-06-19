require("managers/actionmanagers/AMNpcStart")
if not AMResistanceFemale07Start then
	AMResistanceFemale07Start = class(AMNpcStart)
end
AMResistanceFemale07Start.unit_type = "resistance_female_07"
AMResistanceFemale07Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceFemale07Start.unit_type)
end


