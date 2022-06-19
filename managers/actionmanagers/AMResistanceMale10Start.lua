require("managers/actionmanagers/AMNpcStart")
AMResistanceMale10Start = AMResistanceMale10Start or class(AMNpcStart)
AMResistanceMale10Start.unit_type = "resistance_male_10"
function AMResistanceMale10Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceMale10Start.unit_type)
end
