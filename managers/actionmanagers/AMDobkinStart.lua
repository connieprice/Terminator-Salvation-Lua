require("managers/actionmanagers/AMNpcStart")
if not AMDobkinStart then
	AMDobkinStart = class(AMNpcStart)
end
AMDobkinStart.unit_type = "dobkin"
AMDobkinStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMDobkinStart.unit_type)
end


