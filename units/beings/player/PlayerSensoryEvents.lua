if not PlayerSensoryEvents then
	PlayerSensoryEvents = class()
end
PlayerSensoryEvents.init = function(l_1_0, l_1_1)
	l_1_0._running_event_visible_range = nil
	l_1_0._running_event_sound_level = 25
	l_1_0._running_event_sound_level_reference_distance = 100
	l_1_0._running_event_handle = nil
end

PlayerSensoryEvents.destroy = function(l_2_0)
	l_2_0:_force_end_event(l_2_0._running_event_handle)
end

PlayerSensoryEvents._force_end_event = function(l_3_0, l_3_1)
	if l_3_1 then
		managers.sensory_events:end_continuous_event(l_3_1)
	end
end

PlayerSensoryEvents.begin_running_callback = function(l_4_0, l_4_1, l_4_2, l_4_3)
end

PlayerSensoryEvents.end_running_callback = function(l_5_0, l_5_1, l_5_2, l_5_3)
end


