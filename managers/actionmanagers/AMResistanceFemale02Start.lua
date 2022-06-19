require("managers/actionmanagers/AMNpcStart")
if not AMResistanceFemale02Start then
	AMResistanceFemale02Start = class(AMNpcStart)
end
AMResistanceFemale02Start.unit_type = "resistance_female_02"
AMResistanceFemale02Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceFemale02Start.unit_type)
end


