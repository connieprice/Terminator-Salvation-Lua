require("managers/actionmanagers/AMNpcStart")
if not AMMiddleAgedManStart then
	AMMiddleAgedManStart = class(AMNpcStart)
end
AMMiddleAgedManStart.unit_type = "middle_aged_man"
AMMiddleAgedManStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMMiddleAgedManStart.unit_type)
end


