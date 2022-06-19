AMMissionObjective = AMMissionObjective or class(CoreActionElement)
function AMMissionObjective.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMMissionObjective.activate_now(A0_3)
	if A0_3._mode == "start" then
		A0_3:activate_start()
	elseif A0_3._mode == "completed" then
		A0_3:activate_completed()
	else
		error("bad action type!")
		return
	end
	A0_3:deactivate_now()
end
function AMMissionObjective.activate_start(A0_4)
	local L1_5
	L1_5 = cat_print
	L1_5("debug", "Mission Objective", A0_4.objective_id, "has started!")
	L1_5 = managers
	L1_5 = L1_5.mission_objective
	L1_5 = L1_5.objective
	L1_5 = L1_5(L1_5, A0_4.objective_id)
	managers.assigned_mission_objective:start_objective(L1_5, A0_4.assigned_to, tonumber(A0_4.time))
end
function AMMissionObjective.activate_completed(A0_6)
	cat_print("debug", "Mission Objective", A0_6.objective_id, "is now completed!")
	managers.assigned_mission_objective:complete_objective(A0_6.objective_id)
end
