if not AiWaypointManager then
	AiWaypointManager = class()
end
AiWaypointManager.init = function(l_1_0)
	l_1_0._triggers = {}
end

AiWaypointManager.add_reached_waypoint_trigger = function(l_2_0, l_2_1)
	l_2_0._triggers[l_2_1.chosen_waypoint_id] = l_2_1
end

AiWaypointManager.remove_reached_waypoint_trigger = function(l_3_0, l_3_1)
	l_3_0._triggers[l_3_1.chosen_waypoint_id] = nil
end

AiWaypointManager.waypoint_passed = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0._triggers[l_4_1]
	if not l_4_2 then
		return 
	end
	l_4_2:reached_waypoint()
end


