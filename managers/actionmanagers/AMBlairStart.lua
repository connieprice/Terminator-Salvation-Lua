require("managers/actionmanagers/AMNpcStart")
AMBlairStart = AMBlairStart or class(AMNpcStart)
AMBlairStart.unit_type = "blair"
function AMBlairStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMBlairStart.unit_type)
end
