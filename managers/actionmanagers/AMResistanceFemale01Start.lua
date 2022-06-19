require("managers/actionmanagers/AMNpcStart")
AMResistanceFemale01Start = AMResistanceFemale01Start or class(AMNpcStart)
AMResistanceFemale01Start.unit_type = "resistance_female_01"
function AMResistanceFemale01Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceFemale01Start.unit_type)
end
