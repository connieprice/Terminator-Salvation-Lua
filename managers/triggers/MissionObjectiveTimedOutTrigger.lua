MissionObjectiveTimedOutTrigger = MissionObjectiveTimedOutTrigger or class(CoreTriggerBase)
function MissionObjectiveTimedOutTrigger.init(A0_0, A1_1, A2_2, A3_3)
	local L4_4
	L4_4 = CoreTriggerBase
	L4_4 = L4_4.init
	L4_4(A0_0, A1_1, A2_2, A3_3)
	L4_4 = A2_2.parameter
	L4_4 = L4_4(A2_2, "objective_id")
	managers.assigned_mission_objective:add_timer_callback_object(L4_4, A0_0)
end
function MissionObjectiveTimedOutTrigger.destroy(A0_5)
	managers.assigned_mission_objective:remove_timer_callback_object(A0_5)
end
function MissionObjectiveTimedOutTrigger.timed_out(A0_6)
	A0_6._user:trigger_activated(A0_6._id, 1)
end
