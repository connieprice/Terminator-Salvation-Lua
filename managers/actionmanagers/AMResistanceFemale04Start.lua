require("managers/actionmanagers/AMNpcStart")
AMResistanceFemale04Start = AMResistanceFemale04Start or class(AMNpcStart)
AMResistanceFemale04Start.unit_type = "resistance_female_04"
function AMResistanceFemale04Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceFemale04Start.unit_type)
end
