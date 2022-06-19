require("managers/actionmanagers/AMNpcStart")
if not AMDavidWestonStart then
	AMDavidWestonStart = class(AMNpcStart)
end
AMDavidWestonStart.unit_type = "david_weston"
AMDavidWestonStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMDavidWestonStart.unit_type)
end


