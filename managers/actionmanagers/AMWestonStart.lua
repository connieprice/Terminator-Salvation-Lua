require("managers/actionmanagers/AMNpcStart")
if not AMWestonStart then
	AMWestonStart = class(AMNpcStart)
end
AMWestonStart.unit_type = "weston"
AMWestonStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMWestonStart.unit_type)
end


