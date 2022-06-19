require("managers/actionmanagers/AMNpcStart")
AMResistanceFighter07Start = AMResistanceFighter07Start or class(AMNpcStart)
AMResistanceFighter07Start.unit_type = "resistance_fighter_07"
function AMResistanceFighter07Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceFighter07Start.unit_type)
end
