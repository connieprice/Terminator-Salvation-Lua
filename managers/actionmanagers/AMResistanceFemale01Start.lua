require("managers/actionmanagers/AMNpcStart")
if not AMResistanceFemale01Start then
	AMResistanceFemale01Start = class(AMNpcStart)
end
AMResistanceFemale01Start.unit_type = "resistance_female_01"
AMResistanceFemale01Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceFemale01Start.unit_type)
end


