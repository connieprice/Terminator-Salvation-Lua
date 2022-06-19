require("ai/common/AiCoverManager")
require("ai/common/AiWaypointManager")
AiManager = AiManager or class()
function AiManager.init(A0_0)
	A0_0.cover_manager = AiCoverManager:new()
	A0_0.waypoint = AiWaypointManager:new()
end
function AiManager.update(A0_1, A1_2, A2_3)
	A0_1.cover_manager:update(A1_2, A2_3)
	NavigationGraphUtilities.reset_counter()
end
