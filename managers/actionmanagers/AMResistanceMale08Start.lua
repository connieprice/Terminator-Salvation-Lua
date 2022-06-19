require("managers/actionmanagers/AMNpcStart")
AMResistanceMale08Start = AMResistanceMale08Start or class(AMNpcStart)
AMResistanceMale08Start.unit_type = "resistance_male_08"
function AMResistanceMale08Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceMale08Start.unit_type)
end
