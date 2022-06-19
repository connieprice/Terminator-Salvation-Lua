require("ai/directors/AiOrderDirector")
require("ai/directors/AiPositioningDirector")
require("director/faith/ActionLevelDirector")
DirectorManagerSetup = DirectorManagerSetup or {}
function DirectorManagerSetup.setup()
	local L0_0, L1_1, L2_2
	L0_0 = managers
	L0_0 = L0_0.director
	L1_1 = L0_0
	L0_0 = L0_0.register_acting_director
	L2_2 = "order"
	L0_0(L1_1, L2_2, AiOrderDirector:new())
	L0_0 = managers
	L0_0 = L0_0.director
	L1_1 = L0_0
	L0_0 = L0_0.register_acting_director
	L2_2 = "positioning"
	L0_0(L1_1, L2_2, AiPositioningDirector:new())
	L0_0 = managers
	L0_0 = L0_0.director
	L1_1 = L0_0
	L0_0 = L0_0.register_acting_director
	L2_2 = "music"
	L0_0(L1_1, L2_2, ActionLevelDirector:new())
end
