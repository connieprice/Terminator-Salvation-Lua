require("shared/event/EventManager")
require("shared/action_event/ActionEventEmitter")
require("shared/action_event/ActionEventListener")
require("shared/action_event/ActionEventInfo")
require("shared/TableAlgorithms")
if not ActionEventManager then
	ActionEventManager = class(EventManager)
end
ActionEventManager.init = function(l_1_0)
	EventManager.init(l_1_0)
	l_1_0._callback_to_listener = {}
	l_1_0._action_name_to_listeners = {}
	l_1_0._action_name_to_listeners_without_unit_filter = {}
	l_1_0._action_name_to_listeners_with_and_without_unit_filter = {}
	l_1_0._deferred_dispatch_enabled = true
	l_1_0._deferred_dispatch_wanted = true
	l_1_0._deferred_event_channels = {}
	l_1_0._deferred_event_channels[1] = {}
	l_1_0._deferred_event_channels[2] = {}
	l_1_0._current_deferred_event_channel = 1
end

ActionEventManager.enable_deferred_dispatch = function(l_2_0, l_2_1)
	l_2_0._deferred_dispatch_wanted = l_2_1
end

ActionEventManager.define_actions = function(l_3_0, l_3_1)
	local l_3_5, l_3_6 = nil
	l_3_0._action_names = {}
	for i_0,i_1 in pairs(l_3_1) do
		l_3_0._action_names[i_1] = true
	end
end

ActionEventManager.create_emitter = function(l_4_0, l_4_1, l_4_2)
	if not l_4_2 and l_4_1 then
		l_4_2 = l_4_1:name()
	end
	return ActionEventEmitter.new(l_4_2, l_4_1)
end

ActionEventManager._destroy_emitter = function(l_5_0, l_5_1)
	local l_5_6, l_5_7, l_5_8, l_5_9, l_5_10 = nil
	local l_5_2 = false
	for i_0,i_1 in pairs(l_5_1._continuous_events) do
		if not i_1:pending_stop() then
			l_5_2 = true
			print(i_0)
		end
	end
	if l_5_2 then
		error("must call stop for the above events!")
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

ActionEventManager.register_listener = function(l_6_0, l_6_1, l_6_2, l_6_3)
	assert(l_6_0._action_names, "You must define all actions that can be fired first")
	local l_6_4 = ActionEventListener:new(l_6_1, l_6_3)
	l_6_0._callback_to_listener[l_6_1] = l_6_4
	local l_6_5 = nil
	if l_6_3 then
		local l_6_6 = l_6_0._action_name_to_listeners
		local l_6_7 = l_6_3:key()
		if not l_6_0._action_name_to_listeners[l_6_3:key()] then
			l_6_6[l_6_7] = {}
		end
		l_6_6, l_6_7 = l_6_0:_map_listener_to_target, l_6_0
		l_6_6(l_6_7, l_6_0._action_name_to_listeners[l_6_3:key()], l_6_4)
	else
		l_6_0:_map_listener_to_target(l_6_0._action_name_to_listeners_without_unit_filter, l_6_4)
	end
	l_6_0:_map_listener_to_target(l_6_0._action_name_to_listeners_with_and_without_unit_filter, l_6_4)
	return l_6_4
end

ActionEventManager._map_listener_to_target = function(l_7_0, l_7_1, l_7_2)
	local l_7_7, l_7_8, l_7_9, l_7_10, l_7_11, l_7_12, l_7_13 = nil
	local l_7_3 = l_7_2:callback()
	for i_0,i_1 in pairs(l_7_0._action_names) do
		if l_7_3[i_0] then
			if not l_7_1[i_0] then
				l_7_1[i_0] = {}
			end
			l_7_1[i_0][l_7_2] = true
		end
	end
end

ActionEventManager._remove_listener_from_maps = function(l_8_0, l_8_1)
	local l_8_5, l_8_6, l_8_7, l_8_8, l_8_9, l_8_10, l_8_14, l_8_15 = nil
	for i_0,i_1 in pairs(l_8_0._action_name_to_listeners_with_and_without_unit_filter) do
		i_1[l_8_1] = nil
	end
	for i_0,i_1 in pairs(l_8_0._action_name_to_listeners) do
		for i_0,i_1 in pairs(i_1) do
			do
				i_1[l_8_1] = nil
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ActionEventManager._stop_active_continuous_events = function(l_9_0, l_9_1)
	local l_9_6, l_9_7, l_9_8 = nil
	do
		local l_9_2 = l_9_1:continuous_events()
		for i_0,i_1 in pairs(l_9_2) do
			local l_9_11 = nil
			local l_9_12 = i_0:name() .. "_stop"
			local l_9_13 = nil
			l_9_0:_call_event_on_listener(l_9_1, l_9_12, l_9_9:emitter()._listener_data[l_9_1][l_9_11])
			l_9_9:remove_listener(l_9_1)
		end
	end
	 -- WARNING: undefined locals caused missing assignments!
end

ActionEventManager.unregister_listener = function(l_10_0, l_10_1)
	local l_10_2 = l_10_0._callback_to_listener[l_10_1]
	assert(l_10_2)
	l_10_0._callback_to_listener[l_10_1] = nil
	l_10_0:_stop_active_continuous_events(l_10_2)
	l_10_0:_remove_listener_from_maps(l_10_2)
	l_10_2:destroy()
end

ActionEventManager._fire_event = function(l_11_0, l_11_1, l_11_2, ...)
	if l_11_0._deferred_dispatch_enabled then
		local l_11_4 = nil
		local l_11_5 = l_11_0._deferred_event_channels[l_11_0._current_deferred_event_channel]
		table.insert({}, l_11_1)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		table.insert({}, l_11_2)
		local l_11_9, l_11_10 = , ipairs
		l_11_10 = l_11_10({...})
		for i_0,i_1 in l_11_10 do
			table.insert(l_11_9, i_1)
		end
		table.insert(l_11_5, {func = ActionEventManager._internal_fire_event, args = l_11_9})
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_11_4, l_11_5 = l_11_0:_internal_fire_event, l_11_0
		l_11_9 = l_11_1
		l_11_4(l_11_5, l_11_9, l_11_2, ...)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

ActionEventManager._internal_fire_event = function(l_12_0, l_12_1, l_12_2, ...)
	local l_12_8 = nil
	local l_12_7 = assert
	l_12_7(l_12_0._action_names[l_12_2], "Action '" .. l_12_2 .. "' is not defined!")
	l_12_7 = l_12_0._action_name_to_listeners_with_and_without_unit_filter
	l_12_7 = l_12_7[l_12_2]
	if not l_12_7 then
		return 
	end
	for i_0,i_1 in pairs(l_12_7) do
		l_12_0:_call_event_on_listener(i_0, l_12_2, ...)
	end
end

ActionEventManager._call_unit_event = function(l_13_0, l_13_1, l_13_2, l_13_3, ...)
	if l_13_0._deferred_dispatch_enabled then
		local l_13_5 = nil
		local l_13_6 = l_13_0._deferred_event_channels[l_13_0._current_deferred_event_channel]
		table.insert({}, l_13_1)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		table.insert({}, l_13_2)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		table.insert({}, l_13_3)
		local l_13_10, l_13_11 = , ipairs
		l_13_11 = l_13_11({...})
		for i_0,i_1 in l_13_11 do
			table.insert(l_13_10, i_1)
		end
		table.insert(l_13_6, {func = ActionEventManager._internal_call_unit_event, args = l_13_10})
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_13_5, l_13_6 = l_13_0:_internal_call_unit_event, l_13_0
		l_13_10 = l_13_1
		l_13_5(l_13_6, l_13_10, l_13_2, l_13_3, ...)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

ActionEventManager._internal_call_unit_event = function(l_14_0, l_14_1, l_14_2, l_14_3, ...)
	local l_14_11, l_14_12, l_14_13 = nil
	if not alive(l_14_1) then
		return 
	end
	if not l_14_0._action_name_to_listeners_without_unit_filter[l_14_3] then
		local l_14_5, l_14_6, l_14_7 = l_14_0:_filtered_listeners_for_unit(l_14_1, l_14_3), {}
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	TableAlgorithms.merge(l_14_5, l_14_6)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	for i_0,i_1 in pairs(l_14_5) do
		local l_14_8, l_14_9 = nil
		l_14_0:_call_event_on_listener(i_0, l_14_3, l_14_1, ...)
	end
end

ActionEventManager._start_event = function(l_15_0, l_15_1, l_15_2, l_15_3, ...)
	if l_15_0._deferred_dispatch_enabled then
		local l_15_5 = nil
		local l_15_6 = l_15_0._deferred_event_channels[l_15_0._current_deferred_event_channel]
		table.insert({}, l_15_1)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		table.insert({}, l_15_2)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		table.insert({}, l_15_3)
		local l_15_10, l_15_11 = , ipairs
		l_15_11 = l_15_11({...})
		for i_0,i_1 in l_15_11 do
			table.insert(l_15_10, i_1)
		end
		table.insert(l_15_6, {func = ActionEventManager._internal_start_event, args = l_15_10})
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_15_5, l_15_6 = l_15_0:_internal_start_event, l_15_0
		l_15_10 = l_15_1
		l_15_5(l_15_6, l_15_10, l_15_2, l_15_3, ...)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

ActionEventManager._internal_start_event = function(l_16_0, l_16_1, l_16_2, l_16_3, ...)
	assert(l_16_0._action_names[l_16_3], "Action '" .. l_16_3 .. "' is not defined!")
	local l_16_5 = (l_16_3:sub(0, -7))
	 -- DECOMPILER ERROR: Overwrote pending register.

	if alive(l_16_1) then
		if not l_16_0._action_name_to_listeners_without_unit_filter[l_16_3] then
			local l_16_6, l_16_7 = nil, {}
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		TableAlgorithms.merge(l_16_6, l_16_7)
	else
		local l_16_13 = {}
		local l_16_14 = ActionEventInfo:new
		l_16_14 = l_16_14(ActionEventInfo, l_16_2, l_16_5, l_16_1, arg, l_16_13)
		local l_16_8 = nil
		l_16_8 = l_16_2._continuous_events
		l_16_8[l_16_5] = l_16_14
		l_16_8 = l_16_2._listener_data
		local l_16_9 = nil
		l_16_9 = pairs
		l_16_9 = l_16_9(l_16_13)
		for i_0,i_1 in l_16_9 do
			l_16_12:add_continuous_event(l_16_14)
			if not l_16_8[l_16_12] then
				l_16_8[l_16_12] = {}
			end
			l_16_8[l_16_12][l_16_5] = {}
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_16_0:_call_event_on_listener(l_16_12, l_16_3, {}, l_16_1, ...)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 40 
end

ActionEventManager._stop_event = function(l_17_0, l_17_1, l_17_2, l_17_3, ...)
	if l_17_0._deferred_dispatch_enabled then
		local l_17_5 = nil
		local l_17_6 = l_17_0._deferred_event_channels[l_17_0._current_deferred_event_channel]
		table.insert({}, l_17_1)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		table.insert({}, l_17_2)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		table.insert({}, l_17_3)
		local l_17_10, l_17_11 = , ipairs
		l_17_11 = l_17_11({...})
		for i_0,i_1 in l_17_11 do
			table.insert(l_17_10, i_1)
		end
		table.insert(l_17_6, {func = ActionEventManager._internal_stop_event, args = l_17_10})
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_17_2._continuous_events[l_17_3:sub(0, -6)] then
			l_17_2._continuous_events[l_17_3:sub(0, -6)]:set_pending_stop()
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	else
		l_17_5, l_17_6 = l_17_0:_internal_stop_event, l_17_0
		l_17_10 = l_17_1
		l_17_5(l_17_6, l_17_10, l_17_2, l_17_3, ...)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

ActionEventManager._internal_stop_event = function(l_18_0, l_18_1, l_18_2, l_18_3, ...)
	local l_18_11, l_18_12, l_18_13, l_18_14, l_18_15, l_18_16 = nil
	assert(l_18_0._action_names[l_18_3], "Action '" .. l_18_3 .. "' is not defined!")
	local l_18_5 = nil
	assert(l_18_2._continuous_events[l_18_3:sub(0, -6)], "You must call " .. l_18_5 .. "_start first!")
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_18_6 = nil
	local l_18_7 = l_18_2._continuous_events[l_18_3:sub(0, -6)]:listeners()
	for i_0,i_1 in pairs(l_18_7) do
		local l_18_8 = l_18_2._listener_data
		i_0:remove_continuous_event(l_18_6)
		assert(l_18_8[i_0], l_18_3)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		assert(l_18_8[i_0][l_18_5], l_18_3)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_18_0:_call_event_on_listener(l_18_18, l_18_3, l_18_8[i_0][l_18_5], l_18_1, ...)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_18_8[i_0][l_18_5] = nil
	end
	l_18_2._continuous_events[l_18_5] = nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ActionEventManager._change_event = function(l_19_0, l_19_1, l_19_2, l_19_3, ...)
	if l_19_0._deferred_dispatch_enabled then
		local l_19_5 = nil
		local l_19_6 = l_19_0._deferred_event_channels[l_19_0._current_deferred_event_channel]
		table.insert({}, l_19_1)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		table.insert({}, l_19_2)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		table.insert({}, l_19_3)
		local l_19_10, l_19_11 = , ipairs
		l_19_11 = l_19_11({...})
		for i_0,i_1 in l_19_11 do
			table.insert(l_19_10, i_1)
		end
		table.insert(l_19_6, {func = ActionEventManager._internal_change_event, args = l_19_10})
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_19_5, l_19_6 = l_19_0:_internal_change_event, l_19_0
		l_19_10 = l_19_1
		l_19_5(l_19_6, l_19_10, l_19_2, l_19_3, ...)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

ActionEventManager._internal_change_event = function(l_20_0, l_20_1, l_20_2, l_20_3, ...)
	local l_20_11, l_20_12, l_20_13 = nil
	assert(l_20_0._action_names[l_20_3], "Action '" .. l_20_3 .. "' is not defined!")
	if not alive(l_20_1) then
		return 
	end
	local l_20_5 = nil
	assert(l_20_2._continuous_events[l_20_3:sub(0, -8)], "You must call " .. l_20_5 .. "_start first!")
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_20_6 = nil
	local l_20_7 = l_20_2._continuous_events[l_20_3:sub(0, -8)]:listeners()
	for i_0,i_1 in pairs(l_20_7) do
		local l_20_8 = l_20_2._listener_data
		assert(l_20_8[i_0])
		 -- DECOMPILER ERROR: Confused about usage of registers!

		assert(l_20_8[i_0][l_20_5])
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_20_0:_call_event_on_listener(l_20_15, l_20_3, l_20_8[i_0][l_20_5], l_20_1, ...)
	end
end

ActionEventManager._filtered_listeners_for_unit = function(l_21_0, l_21_1, l_21_2)
	assert(l_21_0._action_names[l_21_2], "Unit Action '" .. l_21_2 .. "' is not defined!")
	local l_21_3 = l_21_1:key()
	local l_21_4 = l_21_0._action_name_to_listeners[l_21_1:key()]
	if not l_21_4 then
		return {}
	end
	local l_21_5 = l_21_4[l_21_2]
	if not l_21_5 then
		return {}
	end
	return l_21_5
end

ActionEventManager.update = function(l_22_0, l_22_1, l_22_2)
	local l_22_8, l_22_9, l_22_10, l_22_11, l_22_12, l_22_13 = nil
	local l_22_3 = l_22_0._current_deferred_event_channel
	local l_22_4 = l_22_0._deferred_event_channels[l_22_3]
	l_22_0._current_deferred_event_channel = l_22_0._current_deferred_event_channel % 2 + 1
	for i_0,i_1 in ipairs(l_22_4) do
		i_1.func(l_22_0, unpack(i_1.args))
	end
	l_22_0._deferred_event_channels[l_22_3] = {}
	l_22_0._deferred_dispatch_enabled = l_22_0._deferred_dispatch_wanted
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ActionEventManager._call_event_on_listener = function(l_23_0, l_23_1, l_23_2, ...)
	local l_23_4 = nil
	assert(l_23_1:callback()[l_23_2])
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_23_1:callback()[l_23_2](l_23_4, ...)
end


