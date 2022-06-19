TargetingInfo = TargetingInfo or class()
function TargetingInfo.init(A0_0, A1_1)
	A0_0._unit = A1_1
	assert(A0_0.default)
	A0_0._default_objects = A0_0:_get_objects(A0_0.default)
end
function TargetingInfo.is_visible(A0_2, A1_3, A2_4)
	return A0_2:_target_object(A1_3, A2_4, A0_2._default_objects) ~= nil
end
function TargetingInfo.target_position(A0_5, A1_6, A2_7, A3_8)
	if not A0_5:_target_object(A1_6, A2_7, A0_5._default_objects, A3_8) then
		return nil
	end
	return A0_5:_target_object(A1_6, A2_7, A0_5._default_objects, A3_8):position()
end
function TargetingInfo.primary_target_position(A0_9)
	local L1_10
	L1_10 = A0_9._default_objects
	L1_10 = L1_10[1]
	return L1_10:position()
end
function TargetingInfo.target_objects(A0_11)
	local L1_12
	L1_12 = A0_11._default_objects
	return L1_12
end
function TargetingInfo._get_objects(A0_13, A1_14)
	local L2_15, L3_16, L4_17, L5_18, L6_19, L7_20, L8_21
	L2_15 = {}
	for L6_19, L7_20 in L3_16(L4_17) do
		L8_21 = A0_13._unit
		L8_21 = L8_21.get_object
		L8_21 = L8_21(L8_21, L7_20)
		assert(L8_21, "Unit '" .. A0_13._unit:name() .. "' has no object named '" .. L7_20 .. "'")
		table.insert(L2_15, L8_21)
	end
	return L2_15
end
function TargetingInfo._target_object(A0_22, A1_23, A2_24, A3_25, A4_26)
	local L5_27, L6_28, L7_29, L8_30, L9_31
	for L8_30, L9_31 in L5_27(L6_28) do
		if not A0_22:_raycast(A1_23, L9_31, A2_24, A4_26) then
			return L9_31
		end
	end
	return L5_27
end
function TargetingInfo._raycast(A0_32, A1_33, A2_34, A3_35, A4_36)
	if A4_36 then
		return A0_32._unit:raycast("ray", A1_33, A2_34:position(), "slot_mask", A3_35, "ignore_unit", A4_36)
	end
	return A0_32._unit:raycast("ray", A1_33, A2_34:position(), "slot_mask", A3_35)
end
