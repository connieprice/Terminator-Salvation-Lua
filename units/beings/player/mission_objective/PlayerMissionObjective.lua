require("mission_objective/AssignedMissionObjective")
PlayerMissionObjective = PlayerMissionObjective or class()
function PlayerMissionObjective.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._assigned_objectives = {}
end
function PlayerMissionObjective._has_objective(A0_2, A1_3)
	local L2_4
	L2_4 = A0_2._assigned_objectives
	L2_4 = L2_4[A1_3]
	L2_4 = L2_4 ~= nil
	return L2_4
end
function PlayerMissionObjective._check_for_new_objectives(A0_5)
	local L1_6, L2_7, L3_8, L4_9, L5_10, L6_11
	L1_6 = managers
	L1_6 = L1_6.assigned_mission_objective
	L1_6 = L1_6.objectives_assigned_to
	L1_6 = L1_6(L2_7, L3_8)
	for L5_10, L6_11 in L2_7(L3_8) do
		if not A0_5:_has_objective(L6_11) then
			A0_5:_add_assigned_objective(L6_11)
		end
	end
end
function PlayerMissionObjective._add_assigned_objective(A0_12, A1_13)
	assert(A0_12._assigned_objectives[A1_13] == nil)
	A0_12._assigned_objectives[A1_13] = A1_13
end
function PlayerMissionObjective.assigned_objectives(A0_14)
	local L1_15
	L1_15 = A0_14._assigned_objectives
	return L1_15
end
function PlayerMissionObjective.update(A0_16, A1_17, A2_18, A3_19)
	A0_16:_check_for_new_objectives()
end
