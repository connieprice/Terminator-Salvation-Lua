require("managers/actionmanagers/AMNpcStart")
if not AMResistanceSoldier10Start then
	AMResistanceSoldier10Start = class(AMNpcStart)
end
AMResistanceSoldier10Start.unit_type = "resistance_soldier_10"
AMResistanceSoldier10Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceSoldier10Start.unit_type)
end


