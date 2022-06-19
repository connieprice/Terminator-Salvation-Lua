require("managers/actionmanagers/AMNpcStart")
if not AMDeckardStart then
	AMDeckardStart = class(AMNpcStart)
end
AMDeckardStart.unit_type = "deckard"
AMDeckardStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMDeckardStart.unit_type)
end


