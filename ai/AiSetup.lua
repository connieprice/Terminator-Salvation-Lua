require("ai/common/CommonAiSetup")
require("ai/humans/HumansAiSetup")
require("ai/machines/MachinesAiSetup")
require("units/data/AiGraphData/AiGraphDataSetup")
require("ai/AiGroups")
if not AiSetup then
	AiSetup = class()
end
AiSetup.init = function(l_1_0)
	CommonAiSetup:init()
	HumansAiSetup:init()
	MachinesAiSetup:init()
end


