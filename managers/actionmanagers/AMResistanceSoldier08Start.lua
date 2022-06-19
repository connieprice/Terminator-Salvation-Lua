require("managers/actionmanagers/AMNpcStart")
AMResistanceSoldier08Start = AMResistanceSoldier08Start or class(AMNpcStart)
AMResistanceSoldier08Start.unit_type = "resistance_soldier_08"
function AMResistanceSoldier08Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceSoldier08Start.unit_type)
end
