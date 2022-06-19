require("managers/actionmanagers/AMNpcStart")
if not AMBlairStart then
	AMBlairStart = class(AMNpcStart)
end
AMBlairStart.unit_type = "blair"
AMBlairStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMBlairStart.unit_type)
end


