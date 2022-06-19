require("managers/actionmanagers/AMNpcStart")
AMRogersSet2Start = AMRogersSet2Start or class(AMNpcStart)
AMRogersSet2Start.unit_type = "rogers_set2"
function AMRogersSet2Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, "rogers_set2")
end
