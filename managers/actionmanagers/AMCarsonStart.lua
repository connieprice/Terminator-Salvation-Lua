require("managers/actionmanagers/AMNpcStart")
if not AMCarsonStart then
	AMCarsonStart = class(AMNpcStart)
end
AMCarsonStart.unit_type = "carson"
AMCarsonStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMCarsonStart.unit_type)
end


