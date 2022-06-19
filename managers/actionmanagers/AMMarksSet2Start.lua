require("managers/actionmanagers/AMNpcStart")
AMMarksSet2Start = AMMarksSet2Start or class(AMNpcStart)
AMMarksSet2Start.unit_type = "marks_set2"
function AMMarksSet2Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, "marks_set2")
end
