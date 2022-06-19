require("managers/actionmanagers/AMNpcStart")
AMResistanceFemale06Start = AMResistanceFemale06Start or class(AMNpcStart)
AMResistanceFemale06Start.unit_type = "resistance_female_06"
function AMResistanceFemale06Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceFemale06Start.unit_type)
end
