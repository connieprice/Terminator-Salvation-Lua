require("managers/SensoryEvent")
if not SensoryEventManager then
	SensoryEventManager = class()
end
SensoryEventManager.init = function(l_1_0)
	l_1_0._event_definitions = {}
	l_1_0._listeners = {}
	l_1_0._continuous_events = {}
	l_1_0._next_id_value = 1
	l_1_0._time = nil
	l_1_0.event_types = {}
	l_1_0.source_types = {}
end

SensoryEventManager.register_listener = function(l_2_0, l_2_1, l_2_2)
	local l_2_7, l_2_8, l_2_9, l_2_10, l_2_11, l_2_12 = nil
	local l_2_3 = {}
	l_2_3.active_continuous_events = {}
	l_2_3.source_type_filter = {}
	for i_0,i_1 in pairs(l_2_2) do
		assert(i_1, "invalid filter!")
		l_2_3.source_type_filter[i_1] = true
	end
	l_2_0._listeners[l_2_1] = l_2_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SensoryEventManager.unregister_listener = function(l_3_0, l_3_1)
	l_3_0._listeners[l_3_1] = nil
end

SensoryEventManager.define_source_type = function(l_4_0, l_4_1)
	local l_4_2 = string.upper(l_4_1) .. "_ID"
	l_4_0.source_types[l_4_2] = l_4_0:_next_id()
end

SensoryEventManager.is_defined = function(l_5_0, l_5_1)
	local l_5_2 = string.upper(l_5_1) .. "_ID"
	return l_5_0.event_types[l_5_2] ~= nil
end

SensoryEventManager.define_event = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4, l_6_5)
	assert(l_6_1)
	assert(l_6_2)
	local l_6_6 = string.upper(l_6_1) .. "_ID"
	local l_6_7 = l_6_0:_next_id()
	assert(not l_6_0[l_6_6])
	l_6_0.event_types[l_6_6] = l_6_7
	l_6_0._event_definitions[l_6_7] = {}
	local l_6_8 = l_6_0._event_definitions[l_6_7]
	l_6_8.source_type_id = l_6_2
	l_6_8.sound_level = l_6_4
	l_6_8.sound_level_reference_distance = l_6_5
	l_6_8.visual_range = l_6_3
end

SensoryEventManager.begin_continuous_event = function(l_7_0, l_7_1, l_7_2)
	local l_7_7 = l_7_0:_create_event
	local l_7_8 = l_7_0
	l_7_7 = l_7_7(l_7_8, l_7_1, l_7_2, l_7_2:position(), true)
	local l_7_3 = nil
	l_7_8 = pairs
	l_7_3 = l_7_0._listeners
	l_7_8 = l_7_8(l_7_3)
	for i_0,i_1 in l_7_8 do
		if l_7_0:_filter_check(l_7_6.source_type_filter, l_7_7:source_type_id()) and l_7_0:_within_range(l_7_5, l_7_7) then
			l_7_6.active_continuous_events[l_7_7:instance_id()] = true
			l_7_5:begin_continuous_sensory_event_callback(l_7_7)
		end
	end
	l_7_0._continuous_events[l_7_7:instance_id()] = l_7_7
	return {instance_id = l_7_7:instance_id()}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SensoryEventManager.end_continuous_event = function(l_8_0, l_8_1)
	local l_8_6, l_8_7, l_8_8, l_8_9, l_8_10, l_8_11, l_8_12, l_8_13, l_8_14 = nil
	local l_8_2 = l_8_0._continuous_events[l_8_1.instance_id]
	assert(l_8_2)
	l_8_0._continuous_events[l_8_1.instance_id] = nil
	for i_0,i_1 in pairs(l_8_0._listeners) do
		if i_1.active_continuous_events[l_8_2:instance_id()] then
			i_1.active_continuous_events[l_8_2:instance_id()] = nil
			i_0:end_continuous_sensory_event_callback(l_8_2)
		end
	end
end

SensoryEventManager.destroy_continuous_event_handle = function(l_9_0, l_9_1)
	if l_9_1 and l_9_0._continuous_events[l_9_1.instance_id] then
		l_9_0:end_continuous_event(l_9_1)
	end
end

SensoryEventManager.trigger_impulse_event = function(l_10_0, l_10_1, l_10_2, l_10_3)
	if l_10_3 then
		local l_10_4, l_10_5, l_10_6 = l_10_3
	else
		local l_10_11 = nil
		local l_10_12 = l_10_0:_create_event
		l_10_12 = l_10_12(l_10_0, l_10_1, l_10_2, l_10_2:position(), false)
		local l_10_7 = nil
		l_10_7 = pairs
		l_10_7 = l_10_7(l_10_0._listeners)
		for i_0,i_1 in l_10_7 do
			if l_10_0:_filter_check(i_1.source_type_filter, l_10_12:source_type_id()) and l_10_0:_within_range(l_10_10, l_10_12) then
				l_10_10:trigger_impulse_sensory_event_callback(l_10_12)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 8 
end

SensoryEventManager._create_event = function(l_11_0, l_11_1, l_11_2, l_11_3, l_11_4)
	assert(l_11_1, "Invalid event id!")
	return SensoryEvent:new(l_11_1, l_11_0._event_definitions[l_11_1], l_11_2, l_11_3, l_11_4, l_11_0._time)
end

SensoryEventManager.update = function(l_12_0, l_12_1, l_12_2)
	l_12_0._time = l_12_1
	l_12_0:_update_events(l_12_1, l_12_2)
	l_12_0:_update_listeners(l_12_1, l_12_2)
end

SensoryEventManager._update_events = function(l_13_0, l_13_1, l_13_2)
	local l_13_6, l_13_7, l_13_8, l_13_9 = nil
	for i_0,i_1 in pairs(l_13_0._continuous_events) do
		i_1:update(l_13_1, l_13_2)
	end
end

SensoryEventManager._update_listeners = function(l_14_0, l_14_1, l_14_2)
	local l_14_6, l_14_7, l_14_8, l_14_9, l_14_13, l_14_14, l_14_15, l_14_16, l_14_17, l_14_18, l_14_20, l_14_21, l_14_22, l_14_23, l_14_25, l_14_26, l_14_27, l_14_28 = nil
	for i_0,i_1 in pairs(l_14_0._listeners) do
		for i_0,i_1 in pairs(l_14_0._continuous_events) do
			if (l_14_11.active_continuous_events[i_1:instance_id()] ~= nil or l_14_0:_within_range(l_14_10, i_1)) and not not l_14_0:_filter_check(l_14_11.source_type_filter, i_1:source_type_id()) then
				l_14_11.active_continuous_events[i_1:instance_id()] = true
				l_14_10:begin_continuous_sensory_event_callback(i_1)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			elseif not l_14_0:_within_range(l_14_10, i_1) and not l_14_0:_filter_check(l_14_11.source_type_filter, i_1:source_type_id()) then
				l_14_11.active_continuous_events[i_1:instance_id()] = nil
				l_14_10:end_continuous_sensory_event_callback(i_1)
			end
		end
	end
end

SensoryEventManager._within_range = function(l_15_0, l_15_1, l_15_2)
	local l_15_3 = l_15_2:sound_level_at_position(l_15_1:position())
	return l_15_1:sound_level_hearing_threshold() <= l_15_3
end

SensoryEventManager._filter_check = function(l_16_0, l_16_1, l_16_2)
	if not l_16_1 then
		return true
	end
	return l_16_1[l_16_2]
end

SensoryEventManager._next_id = function(l_17_0)
	local l_17_1 = l_17_0._next_id_value
	l_17_0._next_id_value = l_17_0._next_id_value + 1
	return l_17_1
end


