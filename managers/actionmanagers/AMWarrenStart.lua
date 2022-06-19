require("managers/actionmanagers/AMNpcStart")
AMWarrenStart = AMWarrenStart or class(AMNpcStart)
AMWarrenStart.unit_type = "warren"
function AMWarrenStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMWarrenStart.unit_type)
end
