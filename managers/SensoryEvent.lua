if not SensoryEvent then
	SensoryEvent = class()
end
SensoryEvent._next_event_instance_id = 1
SensoryEvent.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	l_1_0._instance_id = SensoryEvent._next_event_instance_id
	SensoryEvent._next_event_instance_id = SensoryEvent._next_event_instance_id + 1
	l_1_0._definition = l_1_2
	l_1_0._type_id = l_1_1
	l_1_0._duration = 0
	l_1_0._start_time = l_1_6
	l_1_0._start_position = l_1_4
	l_1_0._position = l_1_4
	l_1_0._follow_unit = l_1_5
	l_1_0._unit = l_1_3
end

SensoryEvent.instance_id = function(l_2_0)
	return l_2_0._instance_id
end

SensoryEvent.type_id = function(l_3_0)
	return l_3_0._type_id
end

SensoryEvent.source_type_id = function(l_4_0)
	return l_4_0._definition.source_type_id
end

SensoryEvent.position = function(l_5_0)
	return l_5_0._position
end

SensoryEvent.sound_level_at_position = function(l_6_0, l_6_1)
	local l_6_2 = mvector3.distance(l_6_1, l_6_0._position)
	local l_6_3 = l_6_2 / l_6_0._definition.sound_level_reference_distance
	local l_6_4 = 1e-005
	l_6_3 = math.max(l_6_3, l_6_4)
	return l_6_0._definition.sound_level - 20 * math.log10(l_6_3)
end

SensoryEvent.duration = function(l_7_0)
	return l_7_0._duration
end

SensoryEvent.start_time = function(l_8_0)
	return l_8_0._start_time
end

SensoryEvent.valid = function(l_9_0)
	local l_9_1 = alive
	local l_9_2 = l_9_0._unit
	return l_9_1(l_9_2)
end

SensoryEvent.update = function(l_10_0, l_10_1, l_10_2)
	l_10_0._duration = l_10_0._duration + l_10_2
	if l_10_0._follow_unit and alive(l_10_0._unit) then
		l_10_0._position = l_10_0._unit:position()
	end
end


