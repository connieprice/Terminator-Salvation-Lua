CoreUnitDamage = CoreUnitDamage or class()
UnitDamage = UnitDamage or class(CoreUnitDamage)
function CoreUnitDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	local L7_7, L8_8, L9_9, L10_10, L11_11, L12_12, L13_13, L14_14, L15_15, L16_16, L17_17, L18_18, L19_19, L20_20, L21_21
	A0_0._unit = A1_1
	A0_0._unit_element = L7_7
	A0_0._damage = 0
	A0_0._variables = L7_7
	if L7_7 then
		for L10_10, L11_11 in L7_7(L8_8) do
			L12_12 = A0_0._variables
			L12_12[L10_10] = L11_11
		end
	end
	L10_10 = L10_10 ~= nil
	L7_7(L8_8, L9_9, L10_10)
	L21_21 = L8_8(L9_9)
	for L10_10, L11_11 in L7_7(L8_8, L9_9, L10_10, L11_11, L12_12, L13_13, L14_14, L15_15, L16_16, L17_17, L18_18, L19_19, L20_20, L21_21, L8_8(L9_9)) do
		L12_12 = {}
		L12_12.name = L10_10
		L14_14 = L11_11
		L13_13 = L11_11.get_enabled
		L13_13 = L13_13(L14_14)
		L12_12.enabled = L13_13
		L14_14 = L11_11
		L13_13 = L11_11.get_ref_object
		L13_13 = L13_13(L14_14)
		if L13_13 then
			L13_13 = A0_0._unit
			L14_14 = L13_13
			L13_13 = L13_13.get_object
			L16_16 = L11_11
			L15_15 = L11_11.get_ref_object
			L21_21 = L15_15(L16_16)
			L13_13 = L13_13(L14_14, L15_15, L16_16, L17_17, L18_18, L19_19, L20_20, L21_21, L15_15(L16_16))
		end
		L12_12.ref_object = L13_13
		L14_14 = L11_11
		L13_13 = L11_11.get_interval
		L13_13 = L13_13(L14_14)
		L12_12.interval = L13_13
		L14_14 = L11_11
		L13_13 = L11_11.is_quick
		L13_13 = L13_13(L14_14)
		L12_12.quick = L13_13
		L14_14 = L11_11
		L13_13 = L11_11.get_start_within
		L13_13 = L13_13(L14_14)
		L12_12.is_within = L13_13
		L14_14 = L11_11
		L13_13 = L11_11.get_slotmask
		L13_13 = L13_13(L14_14)
		L12_12.slotmask = L13_13
		L13_13 = TimerManager
		L14_14 = L13_13
		L13_13 = L13_13.game
		L13_13 = L13_13(L14_14)
		L14_14 = L13_13
		L13_13 = L13_13.time
		L13_13 = L13_13(L14_14)
		L14_14 = math
		L14_14 = L14_14.rand
		L15_15 = math
		L15_15 = L15_15.min
		L16_16 = L12_12.interval
		L21_21 = L15_15(L16_16, L17_17)
		L14_14 = L14_14(L15_15, L16_16, L17_17, L18_18, L19_19, L20_20, L21_21, L15_15(L16_16, L17_17))
		L13_13 = L13_13 + L14_14
		L12_12.last_check_time = L13_13
		L14_14 = A0_0
		L13_13 = A0_0.populate_proximity_range_data
		L15_15 = L12_12
		L16_16 = "within_data"
		L21_21 = L17_17(L18_18)
		L13_13(L14_14, L15_15, L16_16, L17_17, L18_18, L19_19, L20_20, L21_21, L17_17(L18_18))
		L14_14 = A0_0
		L13_13 = A0_0.populate_proximity_range_data
		L15_15 = L12_12
		L16_16 = "outside_data"
		L21_21 = L17_17(L18_18)
		L13_13(L14_14, L15_15, L16_16, L17_17, L18_18, L19_19, L20_20, L21_21, L17_17(L18_18))
		L13_13 = A0_0._proximity_map
		L13_13 = L13_13 or {}
		A0_0._proximity_map = L13_13
		L13_13 = A0_0._proximity_map
		L13_13[L10_10] = L12_12
		L13_13 = A0_0._proximity_count
		L13_13 = L13_13 or 0
		L13_13 = L13_13 + 1
		A0_0._proximity_count = L13_13
		L13_13 = L12_12.enabled
		if L13_13 then
			L13_13 = A0_0._proximity_enabled_count
			if not L13_13 then
				A0_0._proximity_enabled_count = 0
				L14_14 = A0_0
				L13_13 = A0_0.set_update_callback
				L15_15 = "update_proximity_list"
				L16_16 = true
				L13_13(L14_14, L15_15, L16_16)
			end
			L13_13 = A0_0._proximity_enabled_count
			L13_13 = L13_13 + 1
			A0_0._proximity_enabled_count = L13_13
		end
	end
	L21_21 = L8_8(L9_9)
	for L10_10 in L7_7(L8_8, L9_9, L10_10, L11_11, L12_12, L13_13, L14_14, L15_15, L16_16, L17_17, L18_18, L19_19, L20_20, L21_21, L8_8(L9_9)) do
		A0_0._trigger_func_list = L11_11
		L12_12 = {}
		L11_11[L10_10] = L12_12
	end
	A0_0._mover_collision_ignore_duration = A6_6
	if L7_7 then
		A3_3 = A3_3 or L7_7
		A2_2 = A2_2 or CoreBodyDamage
		for L12_12, L13_13 in L9_9(L10_10) do
			L14_14 = A0_0._unit
			L15_15 = L14_14
			L14_14 = L14_14.body
			L16_16 = L13_13._name
			L14_14 = L14_14(L15_15, L16_16)
			if L14_14 then
				L16_16 = L14_14
				L15_15 = L14_14.set_extension
				L15_15(L16_16, L17_17)
				L15_15 = L13_13._name
				L15_15 = A3_3[L15_15]
				L15_15 = L15_15 or A2_2
				L16_16 = L15_15
				L15_15 = L15_15.new
				L20_20 = L13_13
				L15_15 = L15_15(L16_16, L17_17, L18_18, L19_19, L20_20)
				L16_16 = L14_14.extension
				L16_16 = L16_16(L17_17)
				L16_16.damage = L15_15
				L16_16 = nil
				L21_21 = L18_18(L19_19)
				for L20_20, L21_21 in L17_17(L18_18, L19_19, L20_20, L21_21, L18_18(L19_19)) do
					if L7_7[L21_21] then
						L16_16 = L16_16 or L14_14:key()
						A0_0._added_inflict_updator_damage_type_map = A0_0._added_inflict_updator_damage_type_map or {}
						A0_0._added_inflict_updator_damage_type_map[L21_21] = {}
						A0_0._added_inflict_updator_damage_type_map[L21_21][L16_16] = L15_15
						managers.sequence:add_inflict_updator_body(L21_21, L8_8, L16_16, L15_15)
					end
				end
			else
				L15_15 = Application
				L16_16 = L15_15
				L15_15 = L15_15.throw_exception
				L20_20 = L13_13._name
				L21_21 = "\" that was loaded into the SequenceManager."
				L15_15(L16_16, L17_17)
			end
		end
	else
		L7_7(L8_8, L9_9)
	end
	if not A4_4 then
		L12_12 = "body_collision_callback"
		L21_21 = L9_9(L10_10, L11_11, L12_12)
		L7_7(L8_8, L9_9, L10_10, L11_11, L12_12, L13_13, L14_14, L15_15, L16_16, L17_17, L18_18, L19_19, L20_20, L21_21, L9_9(L10_10, L11_11, L12_12))
	end
	if L7_7 and not A5_5 then
		L12_12 = "mover_collision_callback"
		L21_21 = L9_9(L10_10, L11_11, L12_12)
		L7_7(L8_8, L9_9, L10_10, L11_11, L12_12, L13_13, L14_14, L15_15, L16_16, L17_17, L18_18, L19_19, L20_20, L21_21, L9_9(L10_10, L11_11, L12_12))
	end
	A0_0._water_check_element_map = L7_7
	if L7_7 then
		for L10_10, L11_11 in L7_7(L8_8) do
			L13_13 = A0_0
			L12_12 = A0_0.set_water_check
			L14_14 = L10_10
			L16_16 = L11_11
			L15_15 = L11_11.get_enabled
			L15_15 = L15_15(L16_16)
			L16_16 = L11_11.get_interval
			L16_16 = L16_16(L17_17)
			L20_20 = L11_11
			L21_21 = L11_11
			L20_20 = L11_11.get_physic_effect
			L21_21 = L20_20(L21_21)
			L12_12(L13_13, L14_14, L15_15, L16_16, L17_17, L18_18, L19_19, L20_20, L21_21, L20_20(L21_21))
		end
	end
	A0_0._startup_sequence_map = L7_7
	if L7_7 then
		L12_12 = "run_startup_sequences"
		L21_21 = L9_9(L10_10, L11_11, L12_12)
		A0_0._startup_sequence_callback_id = L7_7
	end
	if L7_7 then
		A0_0._editor_startup_sequence_map = L7_7
		if L7_7 then
			L12_12 = "run_editor_startup_sequences"
			L21_21 = L9_9(L10_10, L11_11, L12_12)
			A0_0._editor_startup_sequence_callback_id = L7_7
		end
	end
end
function CoreUnitDamage.destroy(A0_22)
	local L1_23, L2_24, L3_25, L4_26, L5_27, L6_28, L7_29, L8_30, L9_31, L10_32
	if L1_23 then
		for L5_27, L6_28 in L2_24(L3_25) do
			for L10_32 in L7_29(L8_30) do
				managers.sequence:remove_inflict_updator_body(L5_27, L1_23, L10_32)
			end
		end
	end
	if L1_23 then
		for L4_26 in L1_23(L2_24) do
			L6_28 = A0_22
			L5_27 = A0_22.set_water_check_active
			L5_27(L6_28, L7_29, L8_30)
		end
	end
	if L1_23 then
		for L4_26, L5_27 in L1_23(L2_24) do
			L6_28 = alive
			L6_28 = L6_28(L7_29)
			if L6_28 then
				L6_28 = L5_27.set_slot
				L6_28(L7_29, L8_30)
			end
		end
	end
end
function CoreUnitDamage.update(A0_33, A1_34, A2_35, A3_36)
	local L4_37, L5_38, L6_39, L7_40, L8_41
	if L4_37 then
		for L7_40, L8_41 in L4_37(L5_38) do
			A0_33[L7_40](A0_33, A1_34, A2_35, A3_36, L8_41)
		end
	else
		L7_40 = tostring
		L8_41 = A1_34.name
		L8_41 = L8_41(A1_34)
		L7_40 = L7_40(L8_41, L8_41(A1_34))
		L8_41 = "\" or an artist have specified more than one damage-extension in the unit xml. This would have resulted in a crash, so fix it!"
		L4_37(L5_38, L6_39)
		L7_40 = false
		L4_37(L5_38, L6_39, L7_40)
	end
end
function CoreUnitDamage.set_update_callback(A0_42, A1_43, A2_44)
	if A2_44 then
		A0_42._update_func_map = A0_42._update_func_map or {}
		if not A0_42._update_func_map[A1_43] then
			if not A0_42._update_func_count then
				A0_42._update_func_count = 0
				A0_42._unit:set_extension_update_enabled("damage", true)
			end
			A0_42._update_func_count = A0_42._update_func_count + 1
		end
		A0_42._update_func_map[A1_43] = A2_44
	elseif A0_42._update_func_map and A0_42._update_func_map[A1_43] then
		A0_42._update_func_count = A0_42._update_func_count - 1
		A0_42._update_func_map[A1_43] = nil
		if A0_42._update_func_count == 0 then
			A0_42._unit:set_extension_update_enabled("damage", false)
			A0_42._update_func_map = nil
			A0_42._update_func_count = nil
		end
	end
end
function CoreUnitDamage.populate_proximity_range_data(A0_45, A1_46, A2_47, A3_48)
	local L4_49
	if A3_48 then
		L4_49 = {}
		A1_46[A2_47] = L4_49
		L4_49 = A1_46[A2_47]
		L4_49.element = A3_48
		L4_49 = A1_46[A2_47]
		L4_49.activation_count = 0
		L4_49 = A1_46[A2_47]
		L4_49.max_activation_count = A3_48:get_max_activation_count()
		L4_49 = A1_46[A2_47]
		L4_49.delay = A3_48:get_delay()
		L4_49 = A1_46[A2_47]
		L4_49.range = A3_48:get_range()
		L4_49 = A1_46[A2_47]
		L4_49.count = A3_48:get_count()
		L4_49 = A1_46[A2_47]
		L4_49.is_within = A2_47 == "within_data"
	end
end
function CoreUnitDamage.set_proximity_enabled(A0_50, A1_51, A2_52)
	local L3_53
	L3_53 = A0_50._proximity_map
	if L3_53 then
		L3_53 = A0_50._proximity_map
		L3_53 = L3_53[A1_51]
	end
	if L3_53 and not L3_53.enabled ~= not A2_52 then
		L3_53.enabled = A2_52
		if A2_52 then
			if not A0_50._proximity_enabled_count then
				A0_50:set_update_callback("update_proximity_list", true)
				A0_50._proximity_enabled_count = 0
			end
			A0_50._proximity_enabled_count = A0_50._proximity_enabled_count + 1
		else
			A0_50._proximity_enabled_count = A0_50._proximity_enabled_count - 1
			if A0_50._proximity_enabled_count <= 0 then
				A0_50._proximity_enabled_count = nil
				A0_50:set_update_callback("update_proximity_list", nil)
			end
		end
	end
end
function CoreUnitDamage.update_proximity_list(A0_54, A1_55, A2_56, A3_57)
	local L4_58, L5_59, L6_60, L7_61, L8_62, L9_63
	if L4_58 then
		for L7_61, L8_62 in L4_58(L5_59) do
			L9_63 = L8_62.enabled
			if L9_63 then
				L9_63 = L8_62.last_check_time
				L9_63 = L9_63 + L8_62.interval
				if A2_56 >= L9_63 then
					L9_63 = nil
					if L8_62.is_within then
						L9_63 = L8_62.outside_data
						if not L9_63 then
							L9_63 = L8_62.within_data
						else
						end
					else
						L9_63 = L8_62.within_data
						if not L9_63 then
							L9_63 = L8_62.outside_data
						else
						end
					end
					if A0_54:check_proximity_activation_count(L8_62) and A2_56 >= L8_62.last_check_time + L9_63.delay and A0_54:update_proximity(A1_55, A2_56, A3_57, L8_62, L9_63) ~= false then
						L8_62.last_check_time = A2_56
						L8_62.is_within = not L8_62.is_within
						if not false and A0_54:is_proximity_range_active(L9_63) then
							L9_63.activation_count = L9_63.activation_count + 1
							A0_54._proximity_env = A0_54._proximity_env or SequenceEnvironment:new("proximity", A0_54._unit, A0_54._unit, nil, Vector3(0, 0, 0), Vector3(0, 0, 0), Vector3(0, 0, 0), 0, Vector3(0, 0, 0), nil, A0_54._unit_element)
							L9_63.element:activate_elements(A0_54._proximity_env)
							A0_54:check_proximity_activation_count(L8_62)
						end
					end
				end
			end
		end
	end
end
function CoreUnitDamage.is_proximity_range_active(A0_64, A1_65)
	local L2_66
	L2_66 = A1_65 and (L2_66 < 0 or L2_66 < A1_65.max_activation_count)
	return L2_66
end
function CoreUnitDamage.check_proximity_activation_count(A0_67, A1_68)
	if not A0_67:is_proximity_range_active(A1_68.within_data) and not A0_67:is_proximity_range_active(A1_68.outside_data) then
		A0_67:set_proximity_enabled(A1_68.name, false)
		return false
	else
		return true
	end
end
function CoreUnitDamage.update_proximity(A0_69, A1_70, A2_71, A3_72, A4_73, A5_74)
	local L6_75, L7_76
	L7_76 = A4_73.ref_object
	if L7_76 then
		L7_76 = A4_73.ref_object
		L7_76 = L7_76.position
		L7_76 = L7_76(L7_76)
		L6_75 = L7_76
	else
		L7_76 = A0_69._unit
		L7_76 = L7_76.position
		L7_76 = L7_76(L7_76)
		L6_75 = L7_76
	end
	L7_76 = nil
	if A5_74.quick then
		L7_76 = A0_69._unit:find_units_quick("sphere", L6_75, A5_74.range, A4_73.slotmask)
	else
		L7_76 = A0_69._unit:find_units("sphere", L6_75, A5_74.range, A4_73.slotmask)
	end
	if A4_73.is_within and A5_74.is_within ~= A4_73.is_within or not A4_73.is_within and A5_74.is_within == A4_73.is_within then
		return #L7_76 <= A5_74.count
	else
		return #L7_76 >= A5_74.count
	end
end
function CoreUnitDamage.get_proximity_map(A0_77)
	return A0_77._proximity_map or {}
end
function CoreUnitDamage.set_proximity_slotmask(A0_78, A1_79, A2_80)
	local L3_81
	L3_81 = A0_78._proximity_map
	L3_81 = L3_81[A1_79]
	L3_81.slotmask = A2_80
end
function CoreUnitDamage.set_proximity_ref_obj_name(A0_82, A1_83, A2_84)
	local L3_85
	L3_85 = A0_82._proximity_map
	L3_85 = L3_85[A1_83]
	L3_85.ref_object = A2_84 and A0_82._unit:get_object(A2_84)
end
function CoreUnitDamage.set_proximity_interval(A0_86, A1_87, A2_88)
	local L3_89
	L3_89 = A0_86._proximity_map
	L3_89 = L3_89[A1_87]
	L3_89.interval = A2_88
end
function CoreUnitDamage.set_proximity_is_within(A0_90, A1_91, A2_92)
	local L3_93
	L3_93 = A0_90._proximity_map
	L3_93 = L3_93[A1_91]
	L3_93.is_within = A2_92
end
function CoreUnitDamage.set_proximity_within_activations(A0_94, A1_95, A2_96)
	local L3_97, L4_98
	L3_97 = A0_94._proximity_map
	L3_97 = L3_97[A1_95]
	L4_98 = L3_97.within_data
	if L4_98 then
		L4_98.activations = A2_96
		return A0_94:check_proximity_activation_count(L3_97)
	end
end
function CoreUnitDamage.set_proximity_within_max_activations(A0_99, A1_100, A2_101)
	local L3_102, L4_103
	L3_102 = A0_99._proximity_map
	L3_102 = L3_102[A1_100]
	L4_103 = L3_102.within_data
	if L4_103 then
		L4_103.max_activations = A2_101
		return A0_99:check_proximity_activation_count(L3_102)
	end
end
function CoreUnitDamage.set_proximity_within_delay(A0_104, A1_105, A2_106)
	local L3_107
	L3_107 = A0_104._proximity_map
	L3_107 = L3_107[A1_105]
	L3_107 = L3_107.within_data
	if L3_107 then
		L3_107.delay = A2_106
	end
end
function CoreUnitDamage.set_proximity_within_range(A0_108, A1_109, A2_110)
	local L3_111
	L3_111 = A0_108._proximity_map
	L3_111 = L3_111[A1_109]
	L3_111 = L3_111.within_data
	if L3_111 then
		L3_111.range = A2_110
	end
end
function CoreUnitDamage.set_proximity_inside_count(A0_112, A1_113, A2_114)
	local L3_115
	L3_115 = A0_112._proximity_map
	L3_115 = L3_115[A1_113]
	L3_115 = L3_115.within_data
	if L3_115 then
		L3_115.count = A2_114
	end
end
function CoreUnitDamage.set_proximity_outside_activations(A0_116, A1_117, A2_118)
	local L3_119, L4_120
	L3_119 = A0_116._proximity_map
	L3_119 = L3_119[A1_117]
	L4_120 = L3_119.outside_data
	if L4_120 then
		L4_120.activations = A2_118
		return A0_116:check_proximity_activation_count(L3_119)
	end
end
function CoreUnitDamage.set_proximity_outside_max_activations(A0_121, A1_122, A2_123)
	local L3_124, L4_125
	L3_124 = A0_121._proximity_map
	L3_124 = L3_124[A1_122]
	L4_125 = L3_124.outside_data
	if L4_125 then
		L4_125.max_activations = A2_123
		return A0_121:check_proximity_activation_count(L3_124)
	end
end
function CoreUnitDamage.set_proximity_outside_delay(A0_126, A1_127, A2_128)
	local L3_129
	L3_129 = A0_126._proximity_map
	L3_129 = L3_129[A1_127]
	L3_129 = L3_129.outside_data
	if L3_129 then
		L3_129.delay = A2_128
	end
end
function CoreUnitDamage.set_proximity_outside_range(A0_130, A1_131, A2_132)
	local L3_133
	L3_133 = A0_130._proximity_map
	L3_133 = L3_133[A1_131]
	L3_133 = L3_133.outside_data
	if L3_133 then
		L3_133.range = A2_132
	end
end
function CoreUnitDamage.set_proximity_outside_range(A0_134, A1_135, A2_136)
	local L3_137
	L3_137 = A0_134._proximity_map
	L3_137 = L3_137[A1_135]
	L3_137 = L3_137.outside_data
	if L3_137 then
		L3_137.range = count
	end
end
function CoreUnitDamage.get_water_check_map(A0_138)
	local L1_139
	L1_139 = A0_138._water_check_map
	return L1_139
end
function CoreUnitDamage.set_water_check(A0_140, A1_141, A2_142, A3_143, A4_144, A5_145, A6_146, A7_147)
	local L8_148, L9_149, L10_150
	L8_148 = A0_140._water_check_map
	L8_148 = L8_148 or {}
	A0_140._water_check_map = L8_148
	L8_148 = A0_140._water_check_map
	L8_148 = L8_148[A1_141]
	L9_149 = A4_144 and L9_149(L10_150, A4_144)
	L10_150 = A5_145 and L10_150(L10_150, A5_145)
	if not L8_148 then
		L8_148 = CoreDamageWaterCheck:new(A0_140._unit, A0_140, A1_141, A3_143, L9_149, L10_150, A6_146, A7_147)
		A0_140._water_check_map[A1_141] = L8_148
	else
		L8_148:set_interval(A3_143)
		L8_148:set_body_depth(A6_146)
		if L9_149 then
			L8_148:set_ref_object(L9_149)
		elseif L10_150 then
			L8_148:set_ref_body(L10_150)
		end
	end
	A0_140:set_water_check_active(A1_141, A2_142)
	if not L8_148:is_valid() then
		Application:error("Invalid water check \"" .. tostring(A1_141) .. "\" in unit \"" .. tostring(A0_140._unit:name()) .. "\". Neither ref_body nor ref_object is speicified in it.")
		A0_140:remove_water_check(A1_141)
	end
end
function CoreUnitDamage.remove_water_check(A0_151, A1_152)
	local L2_153
	L2_153 = A0_151._water_check_map
	if L2_153 then
		L2_153 = A0_151._water_check_map
		L2_153 = L2_153[A1_152]
		if L2_153 then
			A0_151:set_water_check_active(A1_152, false)
			A0_151._water_check_map[A1_152] = nil
		end
	end
end
function CoreUnitDamage.exists_water_check(A0_154, A1_155)
	local L2_156
	L2_156 = A0_154._water_check_map
	if L2_156 then
		L2_156 = A0_154._water_check_map
		L2_156 = L2_156[A1_155]
		L2_156 = L2_156 ~= nil
	end
	return L2_156
end
function CoreUnitDamage.is_water_check_active(A0_157, A1_158)
	local L2_159
	L2_159 = A0_157._active_water_check_map
	if L2_159 then
		L2_159 = A0_157._active_water_check_map
		L2_159 = L2_159[A1_158]
		L2_159 = L2_159 ~= nil
	end
	return L2_159
end
function CoreUnitDamage.set_water_check_active(A0_160, A1_161, A2_162)
	local L3_163
	L3_163 = A0_160._water_check_map
	if L3_163 then
		L3_163 = A0_160._water_check_map
		L3_163 = L3_163[A1_161]
	end
	if L3_163 then
		if A2_162 then
			if not A0_160._active_water_check_map or not A0_160._active_water_check_map[A1_161] then
				A0_160._active_water_check_map = A0_160._active_water_check_map or {}
				A0_160._active_water_check_map[A1_161] = L3_163
				A0_160._active_water_check_count = (A0_160._active_water_check_count or 0) + 1
				if A0_160._active_water_check_count == 1 then
					A0_160._water_check_func_id = managers.sequence:add_callback(callback(A0_160, A0_160, "update_water_checks"))
				end
			end
		else
			L3_163:set_activation_callbacks_enabled(false)
			if A0_160._active_water_check_map and A0_160._active_water_check_map[A1_161] then
				A0_160._active_water_check_map[A1_161] = nil
				A0_160._active_water_check_count = A0_160._active_water_check_count - 1
				if A0_160._active_water_check_count == 0 then
					managers.sequence:remove_callback(A0_160._water_check_func_id)
					A0_160._water_check_func_id = nil
					A0_160._active_water_check_map = nil
					A0_160._active_water_check_count = nil
				end
			end
		end
	end
end
function CoreUnitDamage.update_water_checks(A0_164, A1_165, A2_166)
	for 