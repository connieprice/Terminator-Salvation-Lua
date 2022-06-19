require("managers/actionmanagers/AMNpcStart")
AMDavidWestonStart = AMDavidWestonStart or class(AMNpcStart)
AMDavidWestonStart.unit_type = "david_weston"
function AMDavidWestonStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMDavidWestonStart.unit_type)
end
