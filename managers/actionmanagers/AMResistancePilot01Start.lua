require("managers/actionmanagers/AMNpcStart")
AMResistancePilot01Start = AMResistancePilot01Start or class(AMNpcStart)
AMResistancePilot01Start.unit_type = "resistance_pilot_01"
function AMResistancePilot01Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistancePilot01Start.unit_type)
end
