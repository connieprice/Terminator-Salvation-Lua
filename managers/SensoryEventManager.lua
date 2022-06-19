require("managers/SensoryEvent")
SensoryEventManager = SensoryEventManager or class()
function SensoryEventManager.init(A0_0)
	local L1_1
	L1_1 = {}
	A0_0._event_definitions = L1_1
	L1_1 = {}
	A0_0._listeners = L1_1
	L1_1 = {}
	A0_0._continuous_events = L1_1
	A0_0._next_id_value = 1
	A0_0._time = nil
	L1_1 = {}
	A0_0.event_types = L1_1
	L1_1 = {}
	A0_0.source_types = L1_1
end
function SensoryEventManager.register_listener(A0_2, A1_3, A2_4)
	local L3_5, L4_6, L5_7, L6_8, L7_9, L8_10
	L3_5 = {}
	L3_5.active_continuous_events = L4_6
	L3_5.source_type_filter = L4_6
	for L7_9, L8_10 in L4_6(L5_7) do
		assert(L8_10, "invalid filter!")
		L3_5.source_type_filter[L8_10] = true
	end
	L4_6[A1_3] = L3_5
end
function SensoryEventManager.unregister_listener(A0_11, A1_12)
	A0_11._listeners[A1_12] = nil
end
function SensoryEventManager.define_source_type(A0_13, A1_14)
	A0_13.source_types[string.upper(A1_14) .. "_ID"] = A0_13:_next_id()
end
function SensoryEventManager.is_defined(A0_15, A1_16)
	return A0_15.event_types[string.upper(A1_16) .. "_ID"] ~= nil
end
function SensoryEventManager.define_event(A0_17, A1_18, A2_19, A3_20, A4_21, A5_22)
	assert(A1_18)
	assert(A2_19)
	assert(not A0_17[string.upper(A1_18) .. "_ID"])
	A0_17.event_types[string.upper(A1_18) .. "_ID"] = A0_17:_next_id()
	A0_17._event_definitions[A0_17:_next_id()] = {}
	A0_17._event_definitions[A0_17:_next_id()].source_type_id = A2_19
	A0_17._event_definitions[A0_17:_next_id()].sound_level = A4_21
	A0_17._event_definitions[A0_17:_next_id()].sound_level_reference_distance = A5_22
	A0_17._event_definitions[A0_17:_next_id()].visual_range = A3_20
end
function SensoryEventManager.begin_continuous_event(A0_23, A1_24, A2_25)
	local L3_26, L4_27, L5_28, L6_29, L7_30
	L3_26 = A0_23._create_event
	L7_30 = A2_25.position
	L7_30 = L7_30(A2_25)
	L3_26 = L3_26(L4_27, L5_28, L6_29, L7_30, true)
	for L7_30, 