require("managers/actionmanagers/AMNpcStart")
if not AMCommanderStart then
	AMCommanderStart = class(AMNpcStart)
end
AMCommanderStart.unit_type = "murphy"
AMCommanderStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMCommanderStart.unit_type)
end


