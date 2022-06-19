CommonAiLod = CommonAiLod or class()
function CommonAiLod.logic_common_lod_init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7)
	local L8_8
	L8_8 = 0
	return L8_8
end
function CommonAiLod.logic_common_lod_inactive_enter(A0_9, A1_10, A2_11, A3_12)
	cat_print("ai", "Deactivating AI")
	A0_9:_activate_threads(A2_11, false)
	A2_11:ai_data().output.hibernate = true
end
function CommonAiLod.logic_common_lod_inactive(A0_13, A1_14, A2_15, A3_16, A4_17, A5_18, A6_19, A7_20)
	if A0_13:_unit_within_range(A2_15) then
		return 0
	end
	return nil
end
function CommonAiLod.logic_common_lod_active_enter(A0_21, A1_22, A2_23, A3_24)
	cat_print("ai", "Activating AI")
	A0_21:_activate_threads(A2_23, true)
	A2_23:ai_data().output.hibernate = false
end
function CommonAiLod.logic_common_lod_active(A0_25, A1_26, A2_27, A3_28, A4_29, A5_30, A6_31, A7_32)
	if not A0_25:_unit_within_range(A2_27) then
		return 0
	end
	return nil
end
function CommonAiLod._unit_within_range(A0_33, A1_34)
	local L2_35
	L2_35 = managers
	L2_35 = L2_35.player
	L2_35 = L2_35.distance_to_closest_player
	L2_35 = L2_35(L2_35, A1_34:position())
	if not L2_35 then
		return false
	end
	if L2_35 < A1_34:ai_data().lod_distance then
		return true
	end
	return false
end
function CommonAiLod._activate_threads(A0_36, A1_37, A2_38)
	local L3_39, L4_40, L5_41, L6_42, L7_43, L8_44
	L3_39 = A1_37.ai_data
	L3_39 = L3_39(L4_40)
	for L7_43, L8_44 in L4_40(L5_41) do
		if A2_38 then
			L3_39.brain:activate_thread(L8_44)
		else
			L3_39.brain:deactivate_thread(L8_44)
		end
	end
end
