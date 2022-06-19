if not MissionObjective then
	MissionObjective = class()
end
MissionObjective.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._objective_id = l_1_1
	assert(l_1_2)
	l_1_0._assigned_to = l_1_2
end

MissionObjective.assigned_to = function(l_2_0)
	return l_2_0._assigned_to
end

MissionObjective.name = function(l_3_0)
	return l_3_0._objective_id
end

MissionObjective.set_text_id = function(l_4_0, l_4_1)
	l_4_0._text_id = l_4_1
end

MissionObjective.text_id = function(l_5_0)
	return l_5_0._text_id
end

MissionObjective.id = function(l_6_0)
	return l_6_0._objective_id
end

MissionObjective.set_time = function(l_7_0, l_7_1)
	l_7_0._time = l_7_1
end

MissionObjective.time = function(l_8_0)
	return l_8_0._time
end


