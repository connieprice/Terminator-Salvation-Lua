require("managers/actionmanagers/AMNpcStart")
AMResistanceFemale05Start = AMResistanceFemale05Start or class(AMNpcStart)
AMResistanceFemale05Start.unit_type = "resistance_female_05"
function AMResistanceFemale05Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceFemale05Start.unit_type)
end
