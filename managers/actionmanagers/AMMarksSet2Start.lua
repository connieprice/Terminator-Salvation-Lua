require("managers/actionmanagers/AMNpcStart")
if not AMMarksSet2Start then
	AMMarksSet2Start = class(AMNpcStart)
end
AMMarksSet2Start.unit_type = "marks_set2"
AMMarksSet2Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, "marks_set2")
end


