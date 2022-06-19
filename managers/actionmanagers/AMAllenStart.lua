require("managers/actionmanagers/AMNpcStart")
if not AMAllenStart then
	AMAllenStart = class(AMNpcStart)
end
AMAllenStart.unit_type = "allen"
AMAllenStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMAllenStart.unit_type)
end


