if not AssignedMissionObjective then
	AssignedMissionObjective = class()
end
AssignedMissionObjective.init = function(l_1_0, l_1_1)
	assert(l_1_1)
	l_1_0._objective = l_1_1
	l_1_0._is_completed = false
end

AssignedMissionObjective.mark_as_completed = function(l_2_0)
	l_2_0._is_completed = true
end

AssignedMissionObjective.is_completed = function(l_3_0)
	return l_3_0._is_completed
end

AssignedMissionObjective.objective = function(l_4_0)
	return l_4_0._objective
end

AssignedMissionObjective.set_timer = function(l_5_0, l_5_1)
	l_5_0._timer = l_5_1
end

AssignedMissionObjective.timer = function(l_6_0)
	return l_6_0._timer
end


