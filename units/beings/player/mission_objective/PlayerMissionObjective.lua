require("mission_objective/AssignedMissionObjective")
if not PlayerMissionObjective then
	PlayerMissionObjective = class()
end
PlayerMissionObjective.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._assigned_objectives = {}
end

PlayerMissionObjective._has_objective = function(l_2_0, l_2_1)
	return l_2_0._assigned_objectives[l_2_1] ~= nil
end

PlayerMissionObjective._check_for_new_objectives = function(l_3_0)
	local l_3_5, l_3_6, l_3_7, l_3_8, l_3_9, l_3_10 = nil
	local l_3_1 = managers.assigned_mission_objective:objectives_assigned_to(l_3_0._unit)
	for i_0,i_1 in pairs(l_3_1) do
		if not l_3_0:_has_objective(i_1) then
			l_3_0:_add_assigned_objective(i_1)
		end
	end
end

PlayerMissionObjective._add_assigned_objective = function(l_4_0, l_4_1)
	local l_4_2 = assert
	l_4_2(l_4_0._assigned_objectives[l_4_1] == nil)
	l_4_2 = l_4_0._assigned_objectives
	l_4_2[l_4_1] = l_4_1
end

PlayerMissionObjective.assigned_objectives = function(l_5_0)
	return l_5_0._assigned_objectives
end

PlayerMissionObjective.update = function(l_6_0, l_6_1, l_6_2, l_6_3)
	l_6_0:_check_for_new_objectives()
end


