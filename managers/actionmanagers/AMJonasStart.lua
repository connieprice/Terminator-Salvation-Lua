require("managers/actionmanagers/AMNpcStart")
if not AMJonasStart then
	AMJonasStart = class(AMNpcStart)
end
AMJonasStart.unit_type = "jones"
AMJonasStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMJonasStart.unit_type)
end


