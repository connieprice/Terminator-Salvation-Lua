require("managers/actionmanagers/AMNpcStart")
if not AMResistancePilot01Start then
	AMResistancePilot01Start = class(AMNpcStart)
end
AMResistancePilot01Start.unit_type = "resistance_pilot_01"
AMResistancePilot01Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistancePilot01Start.unit_type)
end


