if not ActionEventListener then
	ActionEventListener = class()
end
ActionEventListener.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._unit_filter = l_1_2
	l_1_0._callback = l_1_1
	l_1_0._continuous_events = {}
end

ActionEventListener.destroy = function(l_2_0)
end

ActionEventListener.set_unit_filter = function(l_3_0, l_3_1)
	l_3_0._unit_filter = l_3_1
end

ActionEventListener.unit_filter = function(l_4_0)
	return l_4_0._unit_filter
end

ActionEventListener.callback = function(l_5_0)
	return l_5_0._callback
end

ActionEventListener.add_continuous_event = function(l_6_0, l_6_1)
	l_6_0._continuous_events[l_6_1] = true
end

ActionEventListener.remove_continuous_event = function(l_7_0, l_7_1)
	l_7_0._continuous_events[l_7_1] = nil
end

ActionEventListener.continuous_events = function(l_8_0)
	return l_8_0._continuous_events
end


