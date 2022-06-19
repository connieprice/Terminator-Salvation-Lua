require("mission_objective/AssignedMissionObjective")
require("mission_objective/MissionObjectiveTimerManager")
AssignedMissionObjectiveManager = AssignedMissionObjectiveManager or class()
function AssignedMissionObjectiveManager.init(A0_0)
	A0_0._active_objectives = {}
	A0_0._name_to_callback_object = {}
	A0_0._callback_object_to_name = {}
	A0_0._timer_manager = MissionObjectiveTimerManager:new()
	if Application:editor() == true then
		A0_0._in_debug_mode = true
	end
end
function AssignedMissionObjectiveManager.destroy(A0_1)
	local L1_2
end
function AssignedMissionObjectiveManager.set_assigned_objectives(A0_3, A1_4)
	A0_3._active_objectives = A1_4
end
function AssignedMissionObjectiveManager.has_assigned_objectives(A0_5)
	return not TableAlgorithms.is_empty(A0_5._active_objectives)
end
function AssignedMissionObjectiveManager.assigned_objectives(A0_6)
	local L1_7
	L1_7 = A0_6._active_objectives
	return L1_7
end
function AssignedMissionObjectiveManager.start_objective(A0_8, A1_9, A2_10, A3_11)
	local L4_12, L5_13, L6_14, L7_15, L8_16
	L5_13 = A1_9
	L4_12 = A1_9.id
	L4_12 = L4_12(L5_13)
	L5_13 = assert
	L6_14 = L4_12
	L5_13(L6_14)
	L5_13 = assert
	L6_14 = TableAlgorithms
	L6_14 = L6_14.is_empty
	L7_15 = A0_8._active_objectives
	L6_14 = L6_14(L7_15)
	L7_15 = "Trying to activate a new Mission Objective ("
	L8_16 = L4_12
	L7_15 = L7_15 .. L8_16 .. ") when another is still active!"
	L5_13(L6_14, L7_15)
	L5_13 = assert
	L6_14 = A0_8._active_objectives
	L6_14 = L6_14[L4_12]
	L6_14 = L6_14 == nil
	L7_15 = "Mission objective '"
	L8_16 = L4_12
	L7_15 = L7_15 .. L8_16 .. "' is already an active objective!"
	L5_13(L6_14, L7_15)
	L5_13 = AssignedMissionObjective
	L6_14 = L5_13
	L5_13 = L5_13.new
	L7_15 = A1_9
	L5_13 = L5_13(L6_14, L7_15)
	L7_15 = A1_9
	L6_14 = A1_9.time
	L6_14 = L6_14(L7_15)
	if L6_14 then
		L6_14 = A0_8._name_to_callback_object
		L6_14 = L6_14[L4_12]
		L8_16 = A1_9
		L7_15 = A1_9.time
		L7_15 = L7_15(L8_16)
		if A3_11 and A3_11 > 0 then
			L7_15 = A3_11
		end
		L8_16 = A0_8._timer_manager
		L8_16 = L8_16.add_objective_timer
		L8_16 = L8_16(L8_16, L4_12, L6_14, L7_15)
		L5_13:set_timer(L8_16)
	end
	L6_14 = assert
	L7_15 = A0_8._active_objectives
	L7_15 = L7_15[L4_12]
	L7_15 = L7_15 == nil
	L6_14(L7_15)
	L6_14 = A0_8._active_objectives
	L6_14[L4_12] = L5_13
	return L5_13
end
function AssignedMissionObjectiveManager.update(A0_17, A1_18)
	A0_17._timer_manager:update(A1_18)
end
function AssignedMissionObjectiveManager.complete_objective(A0_19, A1_20)
	local L2_21
	L2_21 = assert
	L2_21(A1_20)
	L2_21 = A0_19._active_objectives
	L2_21 = L2_21[A1_20]
	if L2_21 == nil and A0_19._in_debug_mode then
		return
	end
	assert(L2_21, "Mission objective '" .. A1_20 .. "' is not an active objective!")
	L2_21:mark_as_completed()
	if L2_21:timer() then
		A0_19._timer_manager:remove_objective_timer(L2_21:timer())
	end
	A0_19._active_objectives[A1_20] = nil
end
function AssignedMissionObjectiveManager.objectives_assigned_to(A0_22, A1_23)
	for 