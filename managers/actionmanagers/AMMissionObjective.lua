if not AMMissionObjective then
	AMMissionObjective = class(CoreActionElement)
end
AMMissionObjective.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMMissionObjective.activate_now = function(l_2_0)
	if l_2_0._mode == "start" then
		l_2_0:activate_start()
	elseif l_2_0._mode == "completed" then
		l_2_0:activate_completed()
	else
		error("bad action type!")
		return 
	end
	l_2_0:deactivate_now()
end

AMMissionObjective.activate_start = function(l_3_0)
	cat_print("debug", "Mission Objective", l_3_0.objective_id, "has started!")
	local l_3_1 = managers.mission_objective:objective(l_3_0.objective_id)
	managers.assigned_mission_objective:start_objective(l_3_1, l_3_0.assigned_to, tonumber(l_3_0.time))
end

AMMissionObjective.activate_completed = function(l_4_0)
	cat_print("debug", "Mission Objective", l_4_0.objective_id, "is now completed!")
	managers.assigned_mission_objective:complete_objective(l_4_0.objective_id)
end


