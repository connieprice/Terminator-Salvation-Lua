require("shared/TableAlgorithms")
CommonAiSensoryEventsHandler = CommonAiSensoryEventsHandler or class()
function CommonAiSensoryEventsHandler.init_data(A0_0, A1_1)
	local L2_2
	L2_2 = {}
	A1_1._sensory_data = L2_2
	L2_2 = A1_1._sensory_data
	L2_2.current_buffered_event = nil
	L2_2 = A1_1._sensory_data
	L2_2.last_handled_event = nil
	L2_2 = A1_1._sensory_data
	L2_2.current_event_last_known_position = nil
	L2_2 = A1_1._sensory_data
	L2_2._current_event_end_time = nil
	L2_2 = A1_1._sensory_data
	L2_2.current_event_in_line_of_sight = false
	L2_2 = A1_1._sensory_data
	L2_2.memory = {}
end
function CommonAiSensoryEventsHandler.logic_common_sensory_events_handler_main(A0_3, A1_4, A2_5, A3_6, A4_7, A5_8, A6_9, A7_10)
	local L8_11, L9_12
	L9_12 = A2_5
	L8_11 = A2_5.ai_data
	L8_11 = L8_11(L9_12)
	L9_12 = L8_11._sensory_data
	A0_3:_handle_new_events(A2_5, L8_11, A1_4)
	A0_3:_update_current_event(L9_12, A1_4)
	A0_3:_clean_memory(A1_4, L9_12.memory)
	return nil
end
function CommonAiSensoryEventsHandler._handle_new_events(A0_13, A1_14, A2_15, A3_16)
	local L4_17, L5_18, L6_19, L7_20, L8_21, L9_22, L10_23, L11_24, L12_25
	L4_17 = {}
	L5_18 = {}
	L7_20 = A1_14
	L6_19 = A1_14.position
	L6_19 = L6_19(L7_20)
	L7_20 = A2_15._sensory_data
	for L11_24, L12_25 in L8_21(L9_22) do
		if not L12_25.read and L12_25.event:valid() then
			table.insert(L4_17, L12_25)
			L12_25.read = true
			L5_18[L12_25.event:instance_id()] = L12_25.event:sound_level_at_position(L6_19)
			A0_13:_remember(L7_20.memory, L12_25, A3_16)
		end
	end
	if L8_21 > 0 then
		L8_21(L9_22, L10_23)
		L11_24 = A1_14
		L12_25 = L8_21
		L9_22(L10_23, L11_24, L12_25, L7_20, A3_16)
	end
end
function CommonAiSensoryEventsHandler._process_buffered_event(A0_26, A1_27, A2_28, A3_29, A4_30)
	local L5_31, L6_32, L7_33
	L5_31 = 3
	L6_32 = A3_29.current_buffered_event
	if L6_32 then
		L6_32 = A3_29.current_buffered_event
		L6_32 = L6_32.has_ended
		if L6_32 then
			L6_32 = A3_29._current_event_end_time
			if L6_32 then
				L6_32 = A3_29._current_event_end_time
				L6_32 = A4_30 - L6_32
				L6_32 = L5_31 < L6_32
			end
		end
	end
	L7_33 = A3_29.current_buffered_event
	L7_33 = not L7_33 or L6_32
	if L7_33 or true then
		A3_29.current_buffered_event = A2_28
		A3_29.current_event_last_known_position = A3_29.current_buffered_event.event:position()
		A3_29._current_event_end_time = nil
	end
end
function CommonAiSensoryEventsHandler._update_current_event(A0_34, A1_35, A2_36)
	if A1_35.current_buffered_event and A1_35.current_buffered_event.has_ended then
		if not A1_35._current_event_end_time then
			A1_35._current_event_end_time = A2_36
			A1_35.current_event_in_line_of_sight = false
		end
		if A2_36 - A1_35._current_event_end_time > tweak_data.ai.TIME_TO_FORGET_EVENT then
			A1_35.current_buffered_event = nil
			A1_35._current_event_end_time = nil
		end
	end
	if A1_35.current_buffered_event and not A1_35.current_buffered_event.has_ended then
		A1_35.current_event_last_known_position = A1_35.current_buffered_event.event:position()
	end
end
function CommonAiSensoryEventsHandler._remember(A0_37, A1_38, A2_39, A3_40)
	local L4_41, L5_42
	L4_41 = 4
	L5_42 = #A1_38
	if L4_41 <= L5_42 then
		L5_42 = table
		L5_42 = L5_42.sort
		L5_42(A1_38, function(A0_43, A1_44)
			return A0_43.buffered_event.event:start_time() < A1_44.buffered_event.event:start_time()
		end)
		L5_42 = #A1_38
		L5_42 = L4_41 - L5_42
		L5_42 = L5_42 + 1
		for _FORV_9_ = 1, L5_42 do
			table.remove(A1_38, 1)
		end
	end
	L5_42 = {}
	L5_42.buffered_event = A2_39
	L5_42.time_discovered = A3_40
	table.insert(A1_38, L5_42)
end
function CommonAiSensoryEventsHandler._clean_memory(A0_45, A1_46, A2_47)
	local L3_48, L4_49, L5_50
	L3_48 = 10
	L4_49 = 1
	while true do
		L5_50 = #A2_47
		if L4_49 <= L5_50 then
			L5_50 = A2_47[L4_49]
			if L3_48 < A1_46 - L5_50.buffered_event.event:start_time() then
				table.remove(A2_47, L4_49)
			else
				L4_49 = L4_49 + 1
			end
		end
	end
end
