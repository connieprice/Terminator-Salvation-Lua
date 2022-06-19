require("mission_objective/AssignedMissionObjective")
require("mission_objective/MissionObjectiveTimerManager")
if not AssignedMissionObjectiveManager then
	AssignedMissionObjectiveManager = class()
end
AssignedMissionObjectiveManager.init = function(l_1_0)
	l_1_0._active_objectives = {}
	l_1_0._name_to_callback_object = {}
	l_1_0._callback_object_to_name = {}
	l_1_0._timer_manager = MissionObjectiveTimerManager:new()
	if Application:editor() == true then
		l_1_0._in_debug_mode = true
	end
end

AssignedMissionObjectiveManager.destroy = function(l_2_0)
end

AssignedMissionObjectiveManager.set_assigned_objectives = function(l_3_0, l_3_1)
	l_3_0._active_objectives = l_3_1
end

AssignedMissionObjectiveManager.has_assigned_objectives = function(l_4_0)
	return not TableAlgorithms.is_empty(l_4_0._active_objectives)
end

AssignedMissionObjectiveManager.assigned_objectives = function(l_5_0)
	return l_5_0._active_objectives
end

AssignedMissionObjectiveManager.start_objective = function(l_6_0, l_6_1, l_6_2, l_6_3)
	local l_6_4 = l_6_1:id()
	assert(l_6_4)
	assert(TableAlgorithms.is_empty(l_6_0._active_objectives), "Trying to activate a new Mission Objective (" .. l_6_4 .. ") when another is still active!")
	local l_6_5 = assert
	l_6_5(l_6_0._active_objectives[l_6_4] == nil, "Mission objective '" .. l_6_4 .. "' is already an active objective!")
	l_6_5 = AssignedMissionObjective
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_6_1:time() then
		local l_6_8 = l_6_0._name_to_callback_object[l_6_4]
		local l_6_9 = l_6_1:time()
		if l_6_3 and l_6_3 > 0 then
			l_6_9 = l_6_3
		end
		local l_6_10 = l_6_0._timer_manager:add_objective_timer(l_6_4, l_6_8, l_6_9)
		l_6_5:set_timer(l_6_10)
	end
	local l_6_11 = assert
	l_6_11(l_6_0._active_objectives[l_6_4] == nil)
	l_6_11 = l_6_0._active_objectives
	l_6_11[l_6_4] = l_6_5
	return l_6_5
end

AssignedMissionObjectiveManager.update = function(l_7_0, l_7_1)
	l_7_0._timer_manager:update(l_7_1)
end

AssignedMissionObjectiveManager.complete_objective = function(l_8_0, l_8_1)
	assert(l_8_1)
	local l_8_2 = l_8_0._active_objectives[l_8_1]
	if l_8_2 == nil and l_8_0._in_debug_mode then
		return 
	end
	assert(l_8_2, "Mission objective '" .. l_8_1 .. "' is not an active objective!")
	l_8_2:mark_as_completed()
	if l_8_2:timer() then
		l_8_0._timer_manager:remove_objective_timer(l_8_2:timer())
	end
	l_8_0._active_objectives[l_8_1] = nil
end

AssignedMissionObjectiveManager.objectives_assigned_to = function(l_9_0, l_9_1)
	local l_9_6, l_9_7, l_9_8, l_9_9, l_9_10, l_9_11 = nil
	local l_9_2 = {}
	for i_0,i_1 in pairs(l_9_0._active_objectives) do
		if l_9_0:_assigned_to_unit(i_1:objective():assigned_to(), l_9_1) then
			l_9_2[i_1:objective():name()] = i_1
		end
	end
	return l_9_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AssignedMissionObjectiveManager._assigned_to_unit = function(l_10_0, l_10_1, l_10_2)
	if not l_10_1 == "all" then
		if l_10_1 == "character_slot_1" then
			local l_10_5 = l_10_0:_slot_matches(1, l_10_2)
		end
	else
		if not false then
			if l_10_1 == "character_slot_2" then
				local l_10_6 = l_10_0:_slot_matches(2, l_10_2)
			end
		else
			return false
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 17 
end

AssignedMissionObjectiveManager._slot_matches = function(l_11_0, l_11_1, l_11_2)
	local l_11_3 = managers.player_slot:slot(l_11_1)
	do
		return not l_11_3 or l_11_3:spawned_unit() == l_11_2
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AssignedMissionObjectiveManager.remove_timer_callback_object = function(l_12_0, l_12_1)
	local l_12_2 = l_12_0._callback_object_to_name[l_12_1]
	l_12_0._name_to_callback_object[l_12_2] = nil
	l_12_0._callback_object_to_name[l_12_1] = nil
end

AssignedMissionObjectiveManager.add_timer_callback_object = function(l_13_0, l_13_1, l_13_2)
	l_13_0._name_to_callback_object[l_13_1] = l_13_2
	l_13_0._callback_object_to_name[l_13_2] = l_13_1
end


