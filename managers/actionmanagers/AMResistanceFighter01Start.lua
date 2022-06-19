require("managers/actionmanagers/AMNpcStart")
AMResistanceFighter01Start = AMResistanceFighter01Start or class(AMNpcStart)
AMResistanceFighter01Start.unit_type = "resistance_fighter_01"
function AMResistanceFighter01Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceFighter01Start.unit_type)
end
