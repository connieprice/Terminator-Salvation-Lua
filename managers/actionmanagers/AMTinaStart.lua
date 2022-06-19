require("managers/actionmanagers/AMNpcStart")
if not AMTinaStart then
	AMTinaStart = class(AMNpcStart)
end
AMTinaStart.unit_type = "tina"
AMTinaStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMTinaStart.unit_type)
end


