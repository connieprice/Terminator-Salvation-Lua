AiWaypointManager = AiWaypointManager or class()
function AiWaypointManager.init(A0_0)
	A0_0._triggers = {}
end
function AiWaypointManager.add_reached_waypoint_trigger(A0_1, A1_2)
	A0_1._triggers[A1_2.chosen_waypoint_id] = A1_2
end
function AiWaypointManager.remove_reached_waypoint_trigger(A0_3, A1_4)
	A0_3._triggers[A1_4.chosen_waypoint_id] = nil
end
function AiWaypointManager.waypoint_passed(A0_5, A1_6)
	local L2_7
	L2_7 = A0_5._triggers
	L2_7 = L2_7[A1_6]
	if not L2_7 then
		return
	end
	L2_7:reached_waypoint()
end
