if not ActionEventInfo then
	ActionEventInfo = class()
end
ActionEventInfo.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5)
	l_1_0._start_args = l_1_4
	l_1_0._name = l_1_2
	l_1_0._emitter = l_1_1
	l_1_0._unit = l_1_3
	l_1_0._listeners = l_1_5
	l_1_0._pending_stop = false
end

ActionEventInfo.set_change = function(l_2_0, l_2_1)
	l_2_0._change_args = l_2_1
end

ActionEventInfo.name = function(l_3_0)
	return l_3_0._name
end

ActionEventInfo.emitter = function(l_4_0)
	return l_4_0._emitter
end

ActionEventInfo.unit = function(l_5_0)
	return l_5_0._unit
end

ActionEventInfo.listeners = function(l_6_0)
	return l_6_0._listeners
end

ActionEventInfo.remove_listener = function(l_7_0, l_7_1)
	l_7_0._listeners[l_7_1] = nil
end

ActionEventInfo.set_pending_stop = function(l_8_0)
	assert(not l_8_0._pending_stop)
	l_8_0._pending_stop = true
end

ActionEventInfo.pending_stop = function(l_9_0)
	return l_9_0._pending_stop
end


