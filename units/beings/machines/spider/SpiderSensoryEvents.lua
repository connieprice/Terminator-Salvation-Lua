if not SpiderSensoryEvents then
	SpiderSensoryEvents = class()
end
SpiderSensoryEvents.init = function(l_1_0, l_1_1)
	l_1_0._moving_event_visible_range = tweak_data.sensory_events.machines.spider.MOVING_VISIBLE_RANGE
	l_1_0._moving_event_sound_level = tweak_data.sensory_events.machines.spider.MOVING_SOUND_LEVEL
	l_1_0._moving_event_sound_level_reference_distance = tweak_data.sensory_events.machines.spider.MOVING_SOUND_LEVEL_REFERENCE_DISTANCE
	if not managers.sensory_events:is_defined("SPIDER_MOVING") then
		managers.sensory_events:define_event("SPIDER_MOVING", managers.sensory_events.source_types.MACHINE_ID, l_1_0._moving_event_visible_range, l_1_0._moving_event_sound_level, l_1_0._moving_event_sound_level_reference_distance)
	end
	l_1_0._event_handles = {}
end

SpiderSensoryEvents.destroy = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7 = nil
	for i_0,i_1 in pairs(l_2_0._event_handles) do
		managers.sensory_events:destroy_continuous_event_handle(i_1)
	end
end

SpiderSensoryEvents.begin_moving_callback = function(l_3_0, l_3_1, l_3_2, l_3_3)
	l_3_0._event_handles.moving_event_handle = managers.sensory_events:begin_continuous_event(managers.sensory_events.event_types.SPIDER_MOVING_ID, l_3_1)
end

SpiderSensoryEvents.end_moving_callback = function(l_4_0, l_4_1, l_4_2, l_4_3)
	managers.sensory_events:end_continuous_event(l_4_0._event_handles.moving_event_handle)
	l_4_0._event_handles.moving_event_handle = nil
end


