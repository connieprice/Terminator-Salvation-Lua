require("managers/actionmanagers/AMNpcStart")
if not AMMarksStart then
	AMMarksStart = class(AMNpcStart)
end
AMMarksStart.unit_type = "marks"
AMMarksStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMMarksStart.unit_type)
end


