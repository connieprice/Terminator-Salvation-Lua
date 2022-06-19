if not AiWaypointTriggerReachedTrigger then
	AiWaypointTriggerReachedTrigger = class(CoreTriggerBase)
end
AiWaypointTriggerReachedTrigger.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	CoreTriggerBase.init(l_1_0, l_1_1, l_1_2, l_1_3)
	managers.ai.waypoint:add_reached_waypoint_trigger(l_1_0)
end

AiWaypointTriggerReachedTrigger.destroy = function(l_2_0)
	managers.ai.waypoint:remove_reached_waypoint_trigger(l_2_0)
end

AiWaypointTriggerReachedTrigger.reached_waypoint = function(l_3_0)
	l_3_0._user:trigger_activated(l_3_0._id, 1)
end


