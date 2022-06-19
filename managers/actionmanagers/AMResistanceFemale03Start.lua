require("managers/actionmanagers/AMNpcStart")
AMResistanceFemale03Start = AMResistanceFemale03Start or class(AMNpcStart)
AMResistanceFemale03Start.unit_type = "resistance_female_03"
function AMResistanceFemale03Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceFemale03Start.unit_type)
end
