SpiderSensoryEvents = SpiderSensoryEvents or class()
function SpiderSensoryEvents.init(A0_0, A1_1)
	A0_0._moving_event_visible_range = tweak_data.sensory_events.machines.spider.MOVING_VISIBLE_RANGE
	A0_0._moving_event_sound_level = tweak_data.sensory_events.machines.spider.MOVING_SOUND_LEVEL
	A0_0._moving_event_sound_level_reference_distance = tweak_data.sensory_events.machines.spider.MOVING_SOUND_LEVEL_REFERENCE_DISTANCE
	if not managers.sensory_events:is_defined("SPIDER_MOVING") then
		managers.sensory_events:define_event("SPIDER_MOVING", managers.sensory_events.source_types.MACHINE_ID, A0_0._moving_event_visible_range, A0_0._moving_event_sound_level, A0_0._moving_event_sound_level_reference_distance)
	end
	A0_0._event_handles = {}
end
function SpiderSensoryEvents.destroy(A0_2)
	local L1_3, L2_4, L3_5, L4_6, L5_7
	for L4_6, L5_7 in L1_3(L2_4) do
		managers.sensory_events:destroy_continuous_event_handle(L5_7)
	end
end
function SpiderSensoryEvents.begin_moving_callback(A0_8, A1_9, A2_10, A3_11)
	A0_8._event_handles.moving_event_handle = managers.sensory_events:begin_continuous_event(managers.sensory_events.event_types.SPIDER_MOVING_ID, A1_9)
end
function SpiderSensoryEvents.end_moving_callback(A0_12, A1_13, A2_14, A3_15)
	managers.sensory_events:end_continuous_event(A0_12._event_handles.moving_event_handle)
	A0_12._event_handles.moving_event_handle = nil
end
