ActionEventListener = ActionEventListener or class()
function ActionEventListener.init(A0_0, A1_1, A2_2)
	A0_0._unit_filter = A2_2
	A0_0._callback = A1_1
	A0_0._continuous_events = {}
end
function ActionEventListener.destroy(A0_3)
	local L1_4
end
function ActionEventListener.set_unit_filter(A0_5, A1_6)
	A0_5._unit_filter = A1_6
end
function ActionEventListener.unit_filter(A0_7)
	local L1_8
	L1_8 = A0_7._unit_filter
	return L1_8
end
function ActionEventListener.callback(A0_9)
	local L1_10
	L1_10 = A0_9._callback
	return L1_10
end
function ActionEventListener.add_continuous_event(A0_11, A1_12)
	A0_11._continuous_events[A1_12] = true
end
function ActionEventListener.remove_continuous_event(A0_13, A1_14)
	A0_13._continuous_events[A1_14] = nil
end
function ActionEventListener.continuous_events(A0_15)
	local L1_16
	L1_16 = A0_15._continuous_events
	return L1_16
end
