require("managers/actionmanagers/AMNpcStart")
AMResistanceMale09Start = AMResistanceMale09Start or class(AMNpcStart)
AMResistanceMale09Start.unit_type = "resistance_male_09"
function AMResistanceMale09Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceMale09Start.unit_type)
end
