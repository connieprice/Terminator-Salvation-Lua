require("managers/actionmanagers/AMNpcStart")
AMResistanceFemale07Start = AMResistanceFemale07Start or class(AMNpcStart)
AMResistanceFemale07Start.unit_type = "resistance_female_07"
function AMResistanceFemale07Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceFemale07Start.unit_type)
end
