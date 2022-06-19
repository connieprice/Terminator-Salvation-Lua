require("managers/actionmanagers/AMNpcStart")
AMResistancePilot02Start = AMResistancePilot02Start or class(AMNpcStart)
AMResistancePilot02Start.unit_type = "resistance_pilot_02"
function AMResistancePilot02Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistancePilot02Start.unit_type)
end
