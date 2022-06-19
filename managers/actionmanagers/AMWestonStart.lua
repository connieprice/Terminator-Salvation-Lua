require("managers/actionmanagers/AMNpcStart")
AMWestonStart = AMWestonStart or class(AMNpcStart)
AMWestonStart.unit_type = "weston"
function AMWestonStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMWestonStart.unit_type)
end
