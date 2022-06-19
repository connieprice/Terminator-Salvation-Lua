require("ai/common/AiCoverManager")
require("ai/common/AiWaypointManager")
if not AiManager then
	AiManager = class()
end
AiManager.init = function(l_1_0)
	l_1_0.cover_manager = AiCoverManager:new()
	l_1_0.waypoint = AiWaypointManager:new()
end

AiManager.update = function(l_2_0, l_2_1, l_2_2)
	l_2_0.cover_manager:update(l_2_1, l_2_2)
	NavigationGraphUtilities.reset_counter()
end


