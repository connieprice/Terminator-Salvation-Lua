require("managers/actionmanagers/AMNpcStart")
if not AMPetersStart then
	AMPetersStart = class(AMNpcStart)
end
AMPetersStart.unit_type = "peters"
AMPetersStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMPetersStart.unit_type)
end


