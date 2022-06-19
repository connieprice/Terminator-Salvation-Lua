SensoryEvent = SensoryEvent or class()
SensoryEvent._next_event_instance_id = 1
function SensoryEvent.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	local L7_7, L8_8
	L7_7 = SensoryEvent
	L7_7 = L7_7._next_event_instance_id
	A0_0._instance_id = L7_7
	L7_7 = SensoryEvent
	L8_8 = SensoryEvent
	L8_8 = L8_8._next_event_instance_id
	L8_8 = L8_8 + 1
	L7_7._next_event_instance_id = L8_8
	A0_0._definition = A2_2
	A0_0._type_id = A1_1
	A0_0._duration = 0
	A0_0._start_time = A6_6
	A0_0._start_position = A4_4
	A0_0._position = A4_4
	A0_0._follow_unit = A5_5
	A0_0._unit = A3_3
end
function SensoryEvent.instance_id(A0_9)
	local L1_10
	L1_10 = A0_9._instance_id
	return L1_10
end
function SensoryEvent.type_id(A0_11)
	local L1_12
	L1_12 = A0_11._type_id
	return L1_12
end
function SensoryEvent.source_type_id(A0_13)
	return A0_13._definition.source_type_id
end
function SensoryEvent.position(A0_14)
	local L1_15
	L1_15 = A0_14._position
	return L1_15
end
function SensoryEvent.sound_level_at_position(A0_16, A1_17)
	local L2_18, L3_19, L4_20
	L2_18 = mvector3
	L2_18 = L2_18.distance
	L3_19 = A1_17
	L4_20 = A0_16._position
	L2_18 = L2_18(L3_19, L4_20)
	L3_19 = A0_16._definition
	L3_19 = L3_19.sound_level_reference_distance
	L3_19 = L2_18 / L3_19
	L4_20 = 1.0E-5
	L3_19 = math.max(L3_19, L4_20)
	return A0_16._definition.sound_level - 20 * math.log10(L3_19)
end
function SensoryEvent.duration(A0_21)
	local L1_22
	L1_22 = A0_21._duration
	return L1_22
end
function SensoryEvent.start_time(A0_23)
	local L1_24
	L1_24 = A0_23._start_time
	return L1_24
end
function SensoryEvent.valid(A0_25)
	return alive(A0_25._unit)
end
function SensoryEvent.update(A0_26, A1_27, A2_28)
	A0_26._duration = A0_26._duration + A2_28
	if A0_26._follow_unit and alive(A0_26._unit) then
		A0_26._position = A0_26._unit:position()
	end
end
