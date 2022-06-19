require("managers/actionmanagers/AMNpcStart")
AMRogersStart = AMRogersStart or class(AMNpcStart)
AMRogersStart.unit_type = "rogers"
function AMRogersStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMRogersStart.unit_type)
end
