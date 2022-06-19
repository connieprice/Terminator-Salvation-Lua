require("managers/actionmanagers/AMNpcStart")
AMMiddleAgedManStart = AMMiddleAgedManStart or class(AMNpcStart)
AMMiddleAgedManStart.unit_type = "middle_aged_man"
function AMMiddleAgedManStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMMiddleAgedManStart.unit_type)
end
