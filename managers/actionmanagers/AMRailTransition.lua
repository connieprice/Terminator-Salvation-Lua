AMRailTransition = AMRailTransition or class(CoreActionElement)
function AMRailTransition.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMRailTransition.activate_now(A0_3)
	local L1_4, L2_5, L3_6, L4_7, L5_8, L6_9, L7_10, L8_11, L9_12, L10_13, L11_14
	if L1_4 then
		A0_3._vehicle_unit = L1_4
		if not L1_4 then
			L1_4(L2_5)
			return
		end
		L1_4(L2_5, L3_6)
		if L1_4 then
			if L1_4 ~= "" then
				L1_4(L2_5, L3_6)
				if L1_4 then
					L11_14 = L4_7(L5_8)
					L1_4(L2_5, L3_6, L4_7, L5_8, L6_9, L7_10, L8_11, L9_12, L10_13, L11_14, L4_7(L5_8))
				elseif not L1_4 then
					L1_4(L2_5, L3_6, L4_7)
				end
				L1_4(L2_5, L3_6, L4_7)
			end
		end
		if L1_4 then
			if L1_4 > 0 then
				A0_3.animation_speed = L1_4
				L1_4(L2_5, L3_6, L4_7)
			end
		end
		if L1_4 then
			for L4_7, L5_8 in L1_4(L2_5) do
				for L9_12, L10_13 in L6_9(L7_10) do
					L11_14 = A0_3[L9_12]
					L11_14(A0_3, L10_13)
				end
			end
		end
		if L1_4 then
			if L2_5 then
				L1_4.default_forced_target_units = L2_5
			end
			if L2_5 then
				L1_4.default_forced_target_locations = L2_5
			end
			L2_5(L3_6)
		else
		end
		if not L1_4 then
			for L6_9, L7_10 in L3_6(L4_7) do
				L9_12 = L7_10
				L8_11.rail_player_escort_unit = L2_5
				L9_12 = L8_11
				L10_13 = "PLAYER UNIT"
				L11_14 = L7_10.name
				L11_14 = L11_14(L7_10)
				L8_11(L9_12, L10_13, L11_14, "IS NOW ESCORTING UNIT", L2_5:name())
			end
		end
	end
	L1_4(L2_5)
end
function AMRailTransition.ai_forced_target_selection(A0_15, A1_16)
	A0_15._vehicle_unit:ai_data().default_forced_target_selection = A1_16
end
function AMRailTransition.ai_forced_primary_attack(A0_17, A1_18)
	if A1_18 and A1_18 ~= "" then
		A0_17._vehicle_unit:ai_data().default_forced_primary_attacks, A0_17._vehicle_unit:ai_data().default_primary_attack_properties = A0_17:_split_forced_attacks(A1_18)
	end
end
function AMRailTransition.ai_forced_secondary_attack(A0_19, A1_20)
	if A1_20 and A1_20 ~= "" then
		A0_19._vehicle_unit:ai_data().default_forced_secondary_attacks, A0_19._vehicle_unit:ai_data().default_secondary_attack_properties = A0_19:_split_forced_attacks(A1_20)
	end
end
function AMRailTransition._split_forced_attacks(A0_21, A1_22)
	local L2_23, L3_24, L4_25, L5_26, L6_27, L7_28, L8_29, L9_30
	L2_23 = {}
	L3_24 = {}
	L4_25 = string
	L4_25 = L4_25.find
	L4_25 = L4_25(L5_26, L6_27)
	if L4_25 then
		L4_25 = string
		L4_25 = L4_25.sub
		L8_29 = A1_22
		L9_30 = "[]%s]"
		L4_25 = L4_25(L5_26, L6_27, L7_28)
		L4_25 = L5_26
		for L8_29, L9_30 in L5_26(L6_27) do
			L2_23[String.split(L9_30, "[=%s]")[1]] = String.split(L9_30, "[=%s]")[2]
		end
		L8_29 = A1_22
		L9_30 = "[]%s]"
		L8_29 = string
		L8_29 = L8_29.len
		L9_30 = A1_22
		L9_30 = L8_29(L9_30)
		L3_24 = L5_26
	else
		L3_24 = A1_22
	end
	L4_25 = String
	L4_25 = L4_25.split
	L4_25 = L4_25(L5_26, L6_27)
	L3_24 = L4_25 or L4_25
	L4_25 = L2_23
	return L4_25, L5_26
end
function AMRailTransition.ai_override_previous_forced_attacks(A0_31, A1_32)
	A0_31._vehicle_unit:ai_data().default_override_previous_forced_attacks = string.find(A1_32, "true")
end
function AMRailTransition.base_primary_attack_damage(A0_33, A1_34)
	A0_33._vehicle_unit:base().primary_attack_damage = tweak_data.rail.hunter_killer.damage[string.upper(A1_34)]
end
function AMRailTransition.base_secondary_attack_damage(A0_35, A1_36)
	A0_35._vehicle_unit:base().secondary_attack_damage = tweak_data.rail.hunter_killer.damage[string.upper(A1_36)]
end
function AMRailTransition.ai_forced_flares(A0_37, A1_38)
	if A1_38 and A1_38 ~= "" then
		A0_37._vehicle_unit:ai_data().default_forced_flares = String.split(A1_38, "[,%s]") or {}
	end
end
function AMRailTransition._get_units_by_names(A0_39, A1_40)
	local L2_41, L3_42, L4_43, L5_44, L6_45, L7_46, L8_47
	L2_41 = {}
	for L6_45, L7_46 in L3_42(L4_43) do
		L8_47 = managers
		L8_47 = L8_47.unit_scripting
		L8_47 = L8_47.get_unit_by_name
		L8_47 = L8_47(L8_47, L7_46.script_name)
		table.insert(L2_41, L8_47)
	end
	return L2_41
end
function AMRailTransition._rail_vehicle_uses_ai(A0_48)
	return A0_48._vehicle_unit:ai_nerve_system() and A0_48._vehicle_unit:ai_data()
end
function AMRailTransition.hit_zones_activation(A0_49, A1_50)
	local L2_51, L3_52, L4_53, L5_54, L6_55
	L2_51 = {}
	for L6_55, 