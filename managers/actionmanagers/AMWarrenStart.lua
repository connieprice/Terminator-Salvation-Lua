require("managers/actionmanagers/AMNpcStart")
if not AMWarrenStart then
	AMWarrenStart = class(AMNpcStart)
end
AMWarrenStart.unit_type = "warren"
AMWarrenStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMWarrenStart.unit_type)
end


