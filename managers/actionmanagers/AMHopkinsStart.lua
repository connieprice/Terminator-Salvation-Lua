require("managers/actionmanagers/AMNpcStart")
if not AMHopkinsStart then
	AMHopkinsStart = class(AMNpcStart)
end
AMHopkinsStart.unit_type = "hopkins"
AMHopkinsStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMHopkinsStart.unit_type)
end


