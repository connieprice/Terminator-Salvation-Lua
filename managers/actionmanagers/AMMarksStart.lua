require("managers/actionmanagers/AMNpcStart")
AMMarksStart = AMMarksStart or class(AMNpcStart)
AMMarksStart.unit_type = "marks"
function AMMarksStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMMarksStart.unit_type)
end
