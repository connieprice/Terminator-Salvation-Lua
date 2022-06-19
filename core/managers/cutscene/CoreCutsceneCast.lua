CoreCutsceneCast = CoreCutsceneCast or class()
CoreCutsceneCast.FLOAT_ERROR_TIME_COMPENSATION = 1.0E-5
function CoreCutsceneCast.prime(A0_0, A1_1)
	local L2_2
	L2_2 = assert
	L2_2(A1_1 and A1_1:is_valid(), "Attempting to prime invalid cutscene.")
	L2_2 = true
	A0_0:_actor_units_in_cutscene(A1_1, L2_2)
	A0_0:_animation_blob_controller(A1_1, L2_2)
end
function CoreCutsceneCast.unload(A0_3)
	local L1_4, L2_5, L3_6, L4_7, L5_8
	for L4_7, L5_8 in L1_4(L2_5) do
		if L5_8 ~= false and alive(L5_8) then
			if L5_8:is_playing() then
				L5_8:stop()
			end
			L5_8:destroy()
		end
	end
	A0_3._animation_blob_controllers = nil
	for L4_7, L5_8 in L1_4(L2_5) do
		if alive(L5_8) then
			World:delete_unit(L5_8)
		end
	end
	A0_3._spawned_units = nil
	if L1_4 then
		L1_4(L2_5, L3_6)
	end
	A0_3.__root_unit = nil
end
function CoreCutsceneCast.is_ready(A0_9, A1_10)
	return (A1_10 and A0_9:_animation_blob_controller(A1_10)) == nil or (A1_10 and A0_9:_animation_blob_controller(A1_10)):ready()
end
function CoreCutsceneCast.set_timer(A0_11, A1_12)
	local L2_13, L3_14, L4_15, L5_16, L6_17
	for L5_16, L6_17 in L2_13(L3_14) do
		if alive(L6_17) then
			L6_17:set_timer(A1_12)
			L6_17:set_animation_timer(A1_12)
		end
	end
end
function CoreCutsceneCast.set_cutscene_visible(A0_18, A1_19, A2_20)
	local L3_21, L4_22, L5_23, L6_24, L7_25
	for L6_24, L7_25 in L3_21(L4_22) do
		if A1_19:has_unit(L6_24, true) then
			A0_18:_set_unit_and_children_visible(L7_25, A2_20 and A0_18:unit_visible(L6_24))
		end
	end
end
function CoreCutsceneCast.set_unit_visible(A0_26, A1_27, A2_28)
	local L3_29, L4_30
	L3_29 = not A2_28
	A2_28 = not L3_29
	L3_29 = A0_26._hidden_units
	L3_29 = L3_29 or {}
	A0_26._hidden_units = L3_29
	L3_29 = A0_26._hidden_units
	L3_29 = L3_29[A1_27]
	L3_29 = not L3_29
	if A2_28 ~= L3_29 then
		L4_30 = A0_26._hidden_units
		L4_30[A1_27] = not A2_28 or nil
		L4_30 = A0_26.unit
		L4_30 = L4_30(A0_26, A1_27)
		if L4_30 then
			A0_26:_set_unit_and_children_visible(L4_30, A2_28)
		end
	end
end
function CoreCutsceneCast.unit_visible(A0_31, A1_32)
	local L2_33
	L2_33 = A0_31._hidden_units
	if L2_33 then
		L2_33 = A0_31._hidden_units
		L2_33 = L2_33[A1_32]
	end
	L2_33 = L2_33 == nil
	return L2_33
end
function CoreCutsceneCast.unit(A0_34, A1_35)
	local L2_36
	L2_36 = A0_34._spawned_units
	if L2_36 then
		L2_36 = A0_34._spawned_units
		L2_36 = L2_36[A1_35]
	end
	return L2_36
end
function CoreCutsceneCast.actor_unit(A0_37, A1_38, A2_39)
	if A0_37:unit(A1_38) and A2_39:has_unit(A1_38) then
		return (A0_37:unit(A1_38))
	else
		return A0_37:_actor_units_in_cutscene(A2_39)[A1_38]
	end
end
function CoreCutsceneCast.unit_names(A0_40)
	return A0_40._spawned_units and table.map_keys(A0_40._spawned_units) or {}
end
function CoreCutsceneCast.evaluate_cutscene_at_time(A0_41, A1_42, A2_43)
	local L3_44, L4_45, L5_46, L6_47, L7_48, L8_49, L9_50, L10_51, L11_52, L12_53, L13_54
	L3_44 = A0_41._last_evaluated_cutscene
	L3_44 = L3_44 or A1_42
	A0_41._last_evaluated_cutscene = L3_44
	L3_44 = A0_41._last_evaluated_cutscene
	if A1_42 ~= L3_44 then
		L4_45 = A0_41
		L3_44 = A0_41._stop_animations_on_actor_units_in_cutscene
		L3_44(L4_45, L5_46)
	end
	L4_45 = A1_42
	L3_44 = A1_42.find_spawned_orientation_unit
	L3_44 = L3_44(L4_45)
	if L3_44 then
		L4_45 = A0_41._root_unit
		L4_45 = L4_45(L5_46)
		L4_45 = L4_45.parent
		L4_45 = L4_45(L5_46)
		if L4_45 ~= L3_44 then
			L4_45 = A0_41._reparent_to_locator_unit
			L8_49 = A0_41
			L13_54 = L7_48(L8_49)
			L4_45(L5_46, L6_47, L7_48, L8_49, L9_50, L10_51, L11_52, L12_53, L13_54, L7_48(L8_49))
		end
	end
	L4_45 = A0_41._animation_blob_controller
	L4_45 = L4_45(L5_46, L6_47)
	if L4_45 then
		if L5_46 then
			if not L5_46 then
				function L8_49(A0_55)
					local L1_56
					L1_56 = A0_55
					return L1_56, _UPVALUE0_:blend_set_for_unit(A0_55)
				end
				L8_49 = L4_45
				L9_50 = L5_46
				L10_51 = L6_47
				L7_48(L8_49, L9_50, L10_51)
				L8_49 = L4_45
				L7_48(L8_49)
			end
			L5_46(L6_47, L7_48)
		end
	else
		L8_49 = A1_42
		L13_54 = L6_47(L7_48, L8_49)
		for L8_49, L9_50 in L5_46(L6_47, L7_48, L8_49, L9_50, L10_51, L11_52, L12_53, L13_54, L6_47(L7_48, L8_49)) do
			L11_52 = A1_42
			L10_51 = A1_42.animation_for_unit
			L12_53 = L8_49
			L10_51 = L10_51(L11_52, L12_53)
			if L10_51 then
				L12_53 = L9_50
				L11_52 = L9_50.anim_state_machine
				L11_52 = L11_52(L12_53)
				L13_54 = L11_52
				L12_53 = L11_52.enabled
				L12_53 = L12_53(L13_54)
				if not L12_53 then
					L13_54 = L11_52
					L12_53 = L11_52.set_enabled
					L12_53(L13_54, true)
					L13_54 = A0_41
					L12_53 = A0_41._state_machine_is_playing_raw_animation
					L12_53 = L12_53(L13_54, L11_52, L10_51)
					if not L12_53 then
						L13_54 = L11_52
						L12_53 = L11_52.play_raw
						L12_53(L13_54, L10_51)
					end
				end
				L13_54 = A1_42
				L12_53 = A1_42.duration
				L12_53 = L12_53(L13_54)
				if L12_53 == 0 then
					L13_54 = 0
				else
					L13_54 = L13_54 or A2_43 / L12_53
				end
				L11_52:set_parameter(L10_51, "t", L13_54)
			end
		end
	end
	A0_41._last_evaluated_cutscene = A1_42
end
function CoreCutsceneCast.evaluate_object_at_time(A0_57, A1_58, A2_59, A3_60, A4_61)
	local L5_62, L6_63, L7_64
	L5_62 = assert
	L7_64 = A1_58
	L6_63 = A1_58.is_optimized
	L6_63 = L6_63(L7_64)
	L7_64 = "Currently only supported with optimized cutscenes."
	L5_62(L6_63, L7_64)
	L6_63 = A0_57
	L5_62 = A0_57._animation_blob_controller
	L7_64 = A1_58
	L5_62 = L5_62(L6_63, L7_64)
	L6_63 = alive
	L7_64 = L5_62
	L6_63 = L6_63(L7_64)
	if L6_63 then
		L7_64 = L5_62
		L6_63 = L5_62.ready
		L6_63 = L6_63(L7_64)
		if L6_63 then
			L7_64 = L5_62
			L6_63 = L5_62.is_playing
			L6_63 = L6_63(L7_64)
			if L6_63 then
				L6_63 = A2_59
				L7_64 = A3_60
				L6_63 = L6_63 .. L7_64
				L7_64 = A0_57.FLOAT_ERROR_TIME_COMPENSATION
				L7_64 = A4_61 + L7_64
				return L5_62:position(L6_63, L7_64), L5_62:rotation(L6_63, L7_64)
			end
		end
	else
		L6_63 = Vector3
		L7_64 = 0
		L6_63 = L6_63(L7_64, 0, 0)
		L7_64 = Rotation
		L7_64 = L7_64()
		return L6_63, L7_64, L7_64()
	end
end
function CoreCutsceneCast.spawn_unit(A0_65, A1_66, A2_67)
	local L3_68, L4_69
	L3_68 = UnitDatabase
	L4_69 = L3_68
	L3_68 = L3_68.get_unit_data
	L3_68 = L3_68(L4_69, A2_67)
	if L3_68 then
		L4_69 = cat_print
		L4_69("cutscene", string.format("[CoreCutsceneCast] Spawning \"%s\" named \"%s\".", A2_67, A1_66))
		L4_69 = World
		L4_69 = L4_69.effect_manager
		L4_69 = L4_69(L4_69)
		L4_69 = L4_69.set_spawns_enabled
		L4_69(L4_69, false)
		L4_69 = World
		L4_69 = L4_69.spawn_unit
		L4_69 = L4_69(L4_69, A2_67, Vector3(0, 0, 0), Rotation())
		World:effect_manager():set_spawns_enabled(true)
		L4_69:set_timer(managers.cutscene:timer())
		L4_69:set_animation_timer(managers.cutscene:timer())
		A0_65:_reparent_to_locator_unit(A0_65:_root_unit(), L4_69)
		A0_65:_set_unit_and_children_visible(L4_69, false)
		L4_69:set_animation_lod(1, 100000, 10000000, 10000000)
		if L4_69:cutscene() and L4_69:cutscene().setup then
			L4_69:cutscene():setup()
		end
		if L4_69:anim_state_machine() then
			L4_69:anim_state_machine():set_enabled(false)
		end
		managers.cutscene:actor_database():append_unit_info(L4_69)
		A0_65._spawned_units = A0_65._spawned_units or {}
		A0_65._spawned_units[A1_66] = L4_69
		return L4_69
	else
		L4_69 = error
		L4_69("Unit type \"" .. tostring(A2_67) .. "\" not found.")
	end
end
function CoreCutsceneCast.delete_unit(A0_70, A1_71)
	local L2_72
	L2_72 = A0_70.unit
	L2_72 = L2_72(A0_70, A1_71)
	if L2_72 and alive(L2_72) then
		World:delete_unit(L2_72)
	end
	if A0_70._spawned_units then
		A0_70._spawned_units[A1_71] = nil
	end
	if A0_70._hidden_units then
		A0_70._hidden_units[A1_71] = nil
	end
	return L2_72 ~= nil
end
function CoreCutsceneCast.rename_unit(A0_73, A1_74, A2_75)
	if A0_73:unit(A1_74) then
		A0_73._spawned_units[A1_74] = nil
		A0_73._spawned_units[A2_75] = A0_73:unit(A1_74)
		if A0_73._hidden_units and A0_73._hidden_units[A1_74] then
			A0_73._hidden_units[A1_74] = nil
			A0_73._hidden_units[A2_75] = true
		end
		return true
	end
	return false
end
function CoreCutsceneCast._stop_animations_on_actor_units_in_cutscene(A0_76, A1_77)
	if A0_76:_animation_blob_controller(A1_77) then
		A0_76:_animation_blob_controller(A1_77):stop()
	else
		for 