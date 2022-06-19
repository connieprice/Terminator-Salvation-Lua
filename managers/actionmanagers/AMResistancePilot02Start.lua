require("managers/actionmanagers/AMNpcStart")
if not AMResistancePilot02Start then
	AMResistancePilot02Start = class(AMNpcStart)
end
AMResistancePilot02Start.unit_type = "resistance_pilot_02"
AMResistancePilot02Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistancePilot02Start.unit_type)
end


