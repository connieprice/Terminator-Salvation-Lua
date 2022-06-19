require("managers/actionmanagers/AMNpcStart")
AMAllenStart = AMAllenStart or class(AMNpcStart)
AMAllenStart.unit_type = "allen"
function AMAllenStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMAllenStart.unit_type)
end
