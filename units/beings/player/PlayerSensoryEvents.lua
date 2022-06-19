PlayerSensoryEvents = PlayerSensoryEvents or class()
function PlayerSensoryEvents.init(A0_0, A1_1)
	A0_0._running_event_visible_range = nil
	A0_0._running_event_sound_level = 25
	A0_0._running_event_sound_level_reference_distance = 100
	A0_0._running_event_handle = nil
end
function PlayerSensoryEvents.destroy(A0_2)
	A0_2:_force_end_event(A0_2._running_event_handle)
end
function PlayerSensoryEvents._force_end_event(A0_3, A1_4)
	if A1_4 then
		managers.sensory_events:end_continuous_event(A1_4)
	end
end
function PlayerSensoryEvents.begin_running_callback(A0_5, A1_6, A2_7, A3_8)
end
function PlayerSensoryEvents.end_running_callback(A0_9, A1_10, A2_11, A3_12)
end
