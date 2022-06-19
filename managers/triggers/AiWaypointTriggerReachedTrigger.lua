AiWaypointTriggerReachedTrigger = AiWaypointTriggerReachedTrigger or class(CoreTriggerBase)
function AiWaypointTriggerReachedTrigger.init(A0_0, A1_1, A2_2, A3_3)
	CoreTriggerBase.init(A0_0, A1_1, A2_2, A3_3)
	managers.ai.waypoint:add_reached_waypoint_trigger(A0_0)
end
function AiWaypointTriggerReachedTrigger.destroy(A0_4)
	managers.ai.waypoint:remove_reached_waypoint_trigger(A0_4)
end
function AiWaypointTriggerReachedTrigger.reached_waypoint(A0_5)
	A0_5._user:trigger_activated(A0_5._id, 1)
end
