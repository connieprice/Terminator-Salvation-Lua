require("managers/actionmanagers/AMNpcStart")
AMResistanceFemale09Start = AMResistanceFemale09Start or class(AMNpcStart)
AMResistanceFemale09Start.unit_type = "resistance_female_09"
function AMResistanceFemale09Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceFemale09Start.unit_type)
end
