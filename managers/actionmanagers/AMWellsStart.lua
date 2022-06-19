require("managers/actionmanagers/AMNpcStart")
AMWellsStart = AMWellsStart or class(AMNpcStart)
AMWellsStart.unit_type = "wells"
function AMWellsStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMWellsStart.unit_type)
end
