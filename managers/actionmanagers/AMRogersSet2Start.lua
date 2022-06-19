require("managers/actionmanagers/AMNpcStart")
if not AMRogersSet2Start then
	AMRogersSet2Start = class(AMNpcStart)
end
AMRogersSet2Start.unit_type = "rogers_set2"
AMRogersSet2Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, "rogers_set2")
end


