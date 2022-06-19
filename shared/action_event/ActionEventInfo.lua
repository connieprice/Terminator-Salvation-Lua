ActionEventInfo = ActionEventInfo or class()
function ActionEventInfo.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5)
	A0_0._start_args = A4_4
	A0_0._name = A2_2
	A0_0._emitter = A1_1
	A0_0._unit = A3_3
	A0_0._listeners = A5_5
	A0_0._pending_stop = false
end
function ActionEventInfo.set_change(A0_6, A1_7)
	A0_6._change_args = A1_7
end
function ActionEventInfo.name(A0_8)
	local L1_9
	L1_9 = A0_8._name
	return L1_9
end
function ActionEventInfo.emitter(A0_10)
	local L1_11
	L1_11 = A0_10._emitter
	return L1_11
end
function ActionEventInfo.unit(A0_12)
	local L1_13
	L1_13 = A0_12._unit
	return L1_13
end
function ActionEventInfo.listeners(A0_14)
	local L1_15
	L1_15 = A0_14._listeners
	return L1_15
end
function ActionEventInfo.remove_listener(A0_16, A1_17)
	A0_16._listeners[A1_17] = nil
end
function ActionEventInfo.set_pending_stop(A0_18)
	assert(not A0_18._pending_stop)
	A0_18._pending_stop = true
end
function ActionEventInfo.pending_stop(A0_19)
	local L1_20
	L1_20 = A0_19._pending_stop
	return L1_20
end
