require("managers/actionmanagers/AMNpcStart")
AMResistanceSoldier06Start = AMResistanceSoldier06Start or class(AMNpcStart)
AMResistanceSoldier06Start.unit_type = "resistance_soldier_06"
function AMResistanceSoldier06Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceSoldier06Start.unit_type)
end
