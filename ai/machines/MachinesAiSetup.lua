require("ai/machines/spider/SpiderAiSetup")
require("ai/machines/flyer/FlyerAiSetup")
require("ai/machines/walker/WalkerAiSetup")
require("ai/machines/rail_flyer/RailFlyerAiSetup")
require("ai/machines/hunter_killer/HunterKillerAiSetup")
require("ai/machines/biker/BikerAiSetup")
require("ai/machines/skynet_defence_turret/SkynetDefenceTurretAiSetup")
if not MachinesAiSetup then
	MachinesAiSetup = class()
end
MachinesAiSetup.init = function(l_1_0, l_1_1)
	SpiderAiSetup.init(l_1_0)
	FlyerAiSetup:init()
	WalkerAiSetup.init()
	RailFlyerAiSetup:init()
	HunterKillerAiSetup:init()
	BikerAiSetup:init()
	SkynetDefenceTurretAiSetup:init()
end


