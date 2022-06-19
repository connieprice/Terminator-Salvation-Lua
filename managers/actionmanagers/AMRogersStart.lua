require("managers/actionmanagers/AMNpcStart")
if not AMRogersStart then
	AMRogersStart = class(AMNpcStart)
end
AMRogersStart.unit_type = "rogers"
AMRogersStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMRogersStart.unit_type)
end


