CoreCutsceneKeyBase = CoreCutsceneKeyBase or class()
function CoreCutsceneKeyBase.init(A0_0, A1_1)
	A0_0:set_key_collection(A1_1)
end
function CoreCutsceneKeyBase.load(A0_2, A1_3, A2_4)
	local L3_5, L4_6, L5_7, L6_8, L7_9, L8_10
	A2_4 = A2_4 or A0_2
	if L3_5 then
		if L3_5 then
			L6_8 = A2_4.super
			L3_5(L4_6, L5_7, L6_8)
		end
	end
	if A2_4 == L3_5 then
		if L3_5 then
			L7_9 = A1_3
			L6_8 = A1_3.parameter
			L8_10 = "frame"
			L8_10 = L6_8(L7_9, L8_10)
			L8_10 = L5_7(L6_8, L7_9, L8_10, L6_8(L7_9, L8_10))
			L3_5(L4_6, L5_7, L6_8, L7_9, L8_10, L5_7(L6_8, L7_9, L8_10, L6_8(L7_9, L8_10)))
		end
	end
	for L6_8, L7_9 in L3_5(L4_6) do
		L8_10 = A1_3.parameter
		L8_10 = L8_10(A1_3, L6_8)
		if L8_10 then
			A0_2["__" .. L6_8] = L7_9(L8_10)
		end
	end
end
function CoreCutsceneKeyBase.populate_from_editor(A0_11, A1_12)
	local L2_13, L3_14
	L3_14 = A0_11
	L2_13 = A0_11.set_frame
	L2_13(L3_14, A1_12:playhead_position())
end
function CoreCutsceneKeyBase.set_key_collection(A0_15, A1_16)
	A0_15.__key_collection = A1_16
end
function CoreCutsceneKeyBase.set_cast(A0_17, A1_18)
	A0_17._cast = A1_18
end
function CoreCutsceneKeyBase.clone(A0_19)
	return clone(A0_19)
end
function CoreCutsceneKeyBase.prime(A0_20, A1_21)
end
function CoreCutsceneKeyBase.unload(A0_22, A1_23)
end
function CoreCutsceneKeyBase.type_name(A0_24)
	return A0_24.NAME or "Unknown"
end
function CoreCutsceneKeyBase._key_collection(A0_25)
	local L1_26
	L1_26 = A0_25.__key_collection
	return L1_26
end
function CoreCutsceneKeyBase.frame(A0_27)
	return A0_27._frame or 0
end
function CoreCutsceneKeyBase.set_frame(A0_28, A1_29)
	A0_28._frame = A1_29
end
function CoreCutsceneKeyBase.time(A0_30)
	return A0_30:frame() / 30
end
function CoreCutsceneKeyBase.preceeding_key(A0_31, A1_32)
	return A0_31:_key_collection() and A0_31:_key_collection():last_key_before(A0_31:time(), A0_31.ELEMENT_NAME, A1_32)
end
function CoreCutsceneKeyBase.can_evaluate_with_player(A0_33, A1_34)
	local L2_35
	L2_35 = A1_34 ~= nil
	return L2_35
end
function CoreCutsceneKeyBase.is_valid(A0_36, A1_37)
	local L2_38, L3_39, L4_40, L5_41, L6_42
	L6_42 = L3_39(L4_40)
	for L5_41, L6_42 in L2_38(L3_39, L4_40, L5_41, L6_42, L3_39(L4_40)) do
		if not A0_36:is_valid_attribute_value(L6_42, A0_36:attribute_value(L6_42)) then
			if A1_37 then
				Application:error("Attribute \"" .. L6_42 .. "\" is invalid.")
			end
			return false
		end
	end
	return L2_38
end
function CoreCutsceneKeyBase.is_valid_attribute_value(A0_43, A1_44, A2_45)
	local L3_46
	L3_46 = "is_valid_"
	L3_46 = L3_46 .. A1_44
	L3_46 = A0_43[L3_46]
	return L3_46 == nil or L3_46(A0_43, A2_45)
end
function CoreCutsceneKeyBase.is_valid_object_name(A0_47, A1_48, A2_49)
	if A1_48 then
	else
	end
	return table.contains(A0_47:_unit_object_names(A2_49 or A0_47:unit_name()), A1_48) or false
end
function CoreCutsceneKeyBase.is_valid_unit_name(A0_50, A1_51)
	return table.contains(A0_50:_unit_names(), A1_51)
end
function CoreCutsceneKeyBase._unit_names(A0_52)
	local L1_53, L2_54, L3_55, L4_56, L5_57
	L1_53 = A0_52._cast
	if L1_53 then
		L1_53 = A0_52._cast
		L1_53 = L1_53.unit_names
		L1_53 = L1_53(L2_54)
	else
		L1_53 = L1_53 or {}
	end
	if L3_55 then
	else
	end
	for L5_57, 