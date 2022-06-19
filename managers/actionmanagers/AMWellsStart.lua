require("managers/actionmanagers/AMNpcStart")
if not AMWellsStart then
	AMWellsStart = class(AMNpcStart)
end
AMWellsStart.unit_type = "wells"
AMWellsStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMWellsStart.unit_type)
end


