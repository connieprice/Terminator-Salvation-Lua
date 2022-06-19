require("managers/actionmanagers/AMNpcStart")
if not AMResistanceFemale04Start then
	AMResistanceFemale04Start = class(AMNpcStart)
end
AMResistanceFemale04Start.unit_type = "resistance_female_04"
AMResistanceFemale04Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceFemale04Start.unit_type)
end


