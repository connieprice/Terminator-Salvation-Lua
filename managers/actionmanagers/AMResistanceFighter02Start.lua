require("managers/actionmanagers/AMNpcStart")
AMResistanceFighter02Start = AMResistanceFighter02Start or class(AMNpcStart)
AMResistanceFighter02Start.unit_type = "resistance_fighter_02"
function AMResistanceFighter02Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceFighter02Start.unit_type)
end
