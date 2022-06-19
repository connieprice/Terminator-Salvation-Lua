require("managers/actionmanagers/AMNpcStart")
AMResistanceSoldier10Start = AMResistanceSoldier10Start or class(AMNpcStart)
AMResistanceSoldier10Start.unit_type = "resistance_soldier_10"
function AMResistanceSoldier10Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceSoldier10Start.unit_type)
end
