require("managers/actionmanagers/AMNpcStart")
AMResistanceFighter06Start = AMResistanceFighter06Start or class(AMNpcStart)
AMResistanceFighter06Start.unit_type = "resistance_fighter_06"
function AMResistanceFighter06Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceFighter06Start.unit_type)
end
