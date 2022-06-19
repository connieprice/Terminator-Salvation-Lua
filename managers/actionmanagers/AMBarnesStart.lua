require("managers/actionmanagers/AMNpcStart")
if not AMBarnesStart then
	AMBarnesStart = class(AMNpcStart)
end
AMBarnesStart.unit_type = "barnes"
AMBarnesStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMBarnesStart.unit_type)
end


