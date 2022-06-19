require("managers/actionmanagers/AMNpcStart")
if not AMConnieStart then
	AMConnieStart = class(AMNpcStart)
end
AMConnieStart.unit_type = "connie"
AMConnieStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMConnieStart.unit_type)
end


