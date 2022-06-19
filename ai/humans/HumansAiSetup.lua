require("ai/humans/npcs/NpcsAiSetup")
require("ai/humans/squadmember/SquadMemberAiSetup")
require("ai/humans/aiplayer/AiPlayerAiSetup")
if not HumansAiSetup then
	HumansAiSetup = class()
end
HumansAiSetup.init = function(l_1_0)
	NpcsAiSetup:init()
	SquadMemberAiSetup:init()
	AiPlayerAiSetup:init()
end


