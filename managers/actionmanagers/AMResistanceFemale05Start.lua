require("managers/actionmanagers/AMNpcStart")
if not AMResistanceFemale05Start then
	AMResistanceFemale05Start = class(AMNpcStart)
end
AMResistanceFemale05Start.unit_type = "resistance_female_05"
AMResistanceFemale05Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceFemale05Start.unit_type)
end


