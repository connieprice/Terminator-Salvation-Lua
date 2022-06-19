require("managers/actionmanagers/AMNpcStart")
AMDeckardStart = AMDeckardStart or class(AMNpcStart)
AMDeckardStart.unit_type = "deckard"
function AMDeckardStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMDeckardStart.unit_type)
end
