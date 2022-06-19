if not MissionObjectiveTimedOutTrigger then
	MissionObjectiveTimedOutTrigger = class(CoreTriggerBase)
end
MissionObjectiveTimedOutTrigger.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	CoreTriggerBase.init(l_1_0, l_1_1, l_1_2, l_1_3)
	local l_1_4 = l_1_2:parameter("objective_id")
	managers.assigned_mission_objective:add_timer_callback_object(l_1_4, l_1_0)
end

MissionObjectiveTimedOutTrigger.destroy = function(l_2_0)
	managers.assigned_mission_objective:remove_timer_callback_object(l_2_0)
end

MissionObjectiveTimedOutTrigger.timed_out = function(l_3_0)
	l_3_0._user:trigger_activated(l_3_0._id, 1)
end


