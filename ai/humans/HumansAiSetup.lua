require("ai/humans/npcs/NpcsAiSetup")
require("ai/humans/squadmember/SquadMemberAiSetup")
require("ai/humans/aiplayer/AiPlayerAiSetup")
HumansAiSetup = HumansAiSetup or class()
function HumansAiSetup.init(A0_0)
	NpcsAiSetup:init()
	SquadMemberAiSetup:init()
	AiPlayerAiSetup:init()
end
