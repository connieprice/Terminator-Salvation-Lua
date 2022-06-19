require("shared/TableAlgorithms")
if not CommonAiSensoryEventsHandler then
	CommonAiSensoryEventsHandler = class()
end
CommonAiSensoryEventsHandler.init_data = function(l_1_0, l_1_1)
	l_1_1._sensory_data = {}
	l_1_1._sensory_data.current_buffered_event = nil
	l_1_1._sensory_data.last_handled_event = nil
	l_1_1._sensory_data.current_event_last_known_position = nil
	l_1_1._sensory_data._current_event_end_time = nil
	l_1_1._sensory_data.current_event_in_line_of_sight = false
	l_1_1._sensory_data.memory = {}
end

CommonAiSensoryEventsHandler.logic_common_sensory_events_handler_main = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
	local l_2_8 = l_2_2:ai_data()
	local l_2_9 = l_2_8._sensory_data
	l_2_0:_handle_new_events(l_2_2, l_2_8, l_2_1)
	l_2_0:_update_current_event(l_2_9, l_2_1)
	l_2_0:_clean_memory(l_2_1, l_2_9.memory)
	return nil
end

CommonAiSensoryEventsHandler._handle_new_events = function(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_11, l_3_12, l_3_13, l_3_14, l_3_15, l_3_16, l_3_17, l_3_18, l_3_19, l_3_20, l_3_21, l_3_22, l_3_23, l_3_24, l_3_25, l_3_26, l_3_27, l_3_28, l_3_29, l_3_30 = nil
	local l_3_4 = {}
	local l_3_5 = {}
	local l_3_6 = l_3_1:position()
	local l_3_7 = l_3_2._sensory_data
	for i_0,i_1 in pairs(l_3_2.input.buffered_events) do
		if not i_1.read and i_1.event:valid() then
			table.insert(l_3_4, i_1)
			i_1.read = true
			l_3_5[i_1.event:instance_id()] = i_1.event:sound_level_at_position(l_3_6)
			l_3_0:_remember(l_3_7.memory, i_1, l_3_3)
		end
	end
	if #l_3_4 > 0 then
		table.sort(l_3_4, function(l_4_0, l_4_1)
		-- upvalues: l_3_1 , l_3_5
		local l_4_2 = l_3_1:position()
		local l_4_3 = l_3_5[l_4_0.event:instance_id()]
		local l_4_4 = l_3_5[l_4_1.event:instance_id()]
		return l_4_4 < l_4_3
  end)
		l_3_0:_process_buffered_event(l_3_1, l_3_4[1], l_3_7, l_3_3)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CommonAiSensoryEventsHandler._process_buffered_event = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4)
	local l_4_5 = 3
	if l_4_3.current_buffered_event then
		local l_4_9 = nil
		local l_4_11 = not l_4_3.current_buffered_event or not l_4_3.current_buffered_event.has_ended or not l_4_3._current_event_end_time or l_4_5 < l_4_4 - l_4_3._current_event_end_time
	end
	local l_4_12 = nil
	if (not l_4_12 and l_4_3.current_buffered_event.event:sound_level_at_position(l_4_1:position()) < l_4_2.event:sound_level_at_position(l_4_1:position()) and l_4_12) or true then
		l_4_3.current_buffered_event = l_4_2
		l_4_3.current_event_last_known_position = l_4_3.current_buffered_event.event:position()
		l_4_3._current_event_end_time = nil
	end
end

CommonAiSensoryEventsHandler._update_current_event = function(l_5_0, l_5_1, l_5_2)
	if l_5_1.current_buffered_event and l_5_1.current_buffered_event.has_ended then
		if not l_5_1._current_event_end_time then
			l_5_1._current_event_end_time = l_5_2
			l_5_1.current_event_in_line_of_sight = false
		end
	if tweak_data.ai.TIME_TO_FORGET_EVENT < l_5_2 - l_5_1._current_event_end_time then
		end
		l_5_1.current_buffered_event = nil
		l_5_1._current_event_end_time = nil
	end
	if l_5_1.current_buffered_event and not l_5_1.current_buffered_event.has_ended then
		l_5_1.current_event_last_known_position = l_5_1.current_buffered_event.event:position()
	end
end

CommonAiSensoryEventsHandler._remember = function(l_6_0, l_6_1, l_6_2, l_6_3)
	local l_6_4 = 4
	if l_6_4 <= #l_6_1 then
		table.sort(l_6_1, function(l_7_0, l_7_1)
		local l_7_2 = l_7_0.buffered_event
		local l_7_3 = l_7_1.buffered_event
		return l_7_2.event:start_time() < l_7_3.event:start_time()
  end)
		local l_6_5 = l_6_4 - #l_6_1 + 1
		for l_6_9 = 1, l_6_5 do
			table.remove(l_6_1, 1)
		end
	end
	local l_6_10 = {}
	l_6_10.buffered_event = l_6_2
	l_6_10.time_discovered = l_6_3
	table.insert(l_6_1, l_6_10)
end

CommonAiSensoryEventsHandler._clean_memory = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = 10
	do
		while 1 do
			local l_7_4 = 1
			while 1 do
				while l_7_4 <= #l_7_2 do
					local l_7_5 = l_7_2[l_7_4]
					local l_7_6 = l_7_5.buffered_event
					if l_7_3 < l_7_1 - l_7_6.event:start_time() then
						table.remove(l_7_2, l_7_4)
					end
					l_7_4 = l_7_4 + 1
				end
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end


