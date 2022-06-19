require("managers/actionmanagers/AMNpcStart")
AMResistanceFemale02Start = AMResistanceFemale02Start or class(AMNpcStart)
AMResistanceFemale02Start.unit_type = "resistance_female_02"
function AMResistanceFemale02Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceFemale02Start.unit_type)
end
