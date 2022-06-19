require("managers/actionmanagers/AMNpcStart")
AMConnieStart = AMConnieStart or class(AMNpcStart)
AMConnieStart.unit_type = "connie"
function AMConnieStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMConnieStart.unit_type)
end
