require("managers/actionmanagers/AMNpcStart")
AMResistanceFemale08Start = AMResistanceFemale08Start or class(AMNpcStart)
AMResistanceFemale08Start.unit_type = "resistance_female_08"
function AMResistanceFemale08Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceFemale08Start.unit_type)
end
