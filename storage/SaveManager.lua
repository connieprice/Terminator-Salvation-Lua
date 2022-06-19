SaveManager = SaveManager or class()
function SaveManager.init(A0_0, A1_1)
	A0_0._debug_check_profile = false
	if A1_1.primary_user_index then
		A0_0._primary_user = managers.local_user:user_from_user_index(A1_1.primary_user_index)
	end
end
function SaveManager.default_data(A0_2)
	local L1_3
end
function SaveManager.save(A0_4, A1_5)
	if A0_4._primary_user then
		A1_5.primary_user_index = A0_4._primary_user:user_index()
	end
end
function SaveManager.set_localized_chapter_names(A0_6, A1_7, A2_8)
	A0_6._chapter = A1_7
	A0_6._line = A2_8
end
function SaveManager.localized_chapter_names(A0_9)
	local L1_10, L2_11
	L1_10 = A0_9._chapter
	L2_11 = A0_9._line
	return L1_10, L2_11
end
function SaveManager.save_progress(A0_12, A1_13, A2_14)
	local L3_15, L4_16, L5_17, L6_18, L7_19, L8_20, L9_21, L10_22, L11_23, L12_24, L13_25, L14_26, L15_27
	L3_15 = assert
	L4_16 = A0_12._primary_user
	L3_15(L4_16)
	L3_15 = assert
	L4_16 = A1_13
	L3_15(L4_16)
	L3_15 = managers
	L3_15 = L3_15.local_user
	L4_16 = L3_15
	L3_15 = L3_15.users
	L3_15 = L3_15(L4_16)
	L5_17 = A0_12
	L4_16 = A0_12.profile
	L4_16 = L4_16(L5_17)
	L5_17 = assert
	L6_18 = L4_16
	L5_17(L6_18)
	L5_17 = L4_16.save_progress
	A2_14 = A2_14 or L4_16.current_level_id
	if not A2_14 then
		L6_18 = print
		L6_18(L7_19)
		return
	end
	L6_18 = false
	for L10_22, L11_23 in L7_19(L8_20) do
		L13_25 = L11_23
		L12_24 = L11_23.is_playing_the_game
		L12_24 = L12_24(L13_25)
		if L12_24 then
			L12_24 = cat_print
			L13_25 = "debug"
			L14_26 = "Saving progress for user index "
			L15_27 = L11_23.user_index
			L15_27 = L15_27(L11_23)
			L14_26 = L14_26 .. L15_27
			L12_24(L13_25, L14_26)
			L13_25 = L11_23
			L12_24 = L11_23.profile
			L12_24 = L12_24(L13_25)
			L13_25 = L12_24.levels
			L13_25 = L13_25[A2_14]
			if not L13_25 then
				L14_26 = cat_print
				L15_27 = "debug"
				L14_26(L15_27, "This level is not included in the users profile. skip progress")
				return
			end
			L15_27 = A0_12
			L14_26 = A0_12.set_mission_objective_id_to_profile
			L14_26(L15_27, L12_24, A2_14, A1_13)
			L12_24.current_level_id = A2_14
			L12_24.current_checkpoint_id = A1_13
			L12_24.debug_level_name = nil
			L14_26 = L12_24.save_progress
			if L14_26 then
				L12_24.progress_level_id = A2_14
				L12_24.progress_checkpoint_id = A1_13
			end
			L14_26 = math
			L14_26 = L14_26.max
			L15_27 = L13_25.maximum_checkpoint_id
			L14_26 = L14_26(L15_27, A1_13)
			L13_25.maximum_checkpoint_id = L14_26
			L12_24.has_progress = true
			L14_26 = L13_25.checkpoints
			L14_26 = L14_26[A1_13]
			L15_27 = L14_26.difficulty_levels
			L15_27[L12_24.difficulty_level] = true
			L15_27 = L11_23.assigned_unit
			L15_27 = L15_27(L11_23)
			if alive(L15_27) then
				assert(not TableAlgorithms.is_empty(L14_26.inventory))
				if L12_24.save_progress or L14_26.inventory.items[1].name == "" then
					print("saving inventory for unit " .. L15_27:name())
					A0_12:_save_inventory_to_profile(L12_24, L11_23, L14_26)
				end
				if not L6_18 then
					L15_27:hud_sound():progress_updated()
					L6_18 = true
				end
			end
			L11_23:save_profile()
		end
	end
end
function SaveManager._save_inventory_to_profile(A0_28, A1_29, A2_30, A3_31)
	local L4_32, L5_33, L6_34, L7_35, L8_36, L9_37, L10_38, L11_39, L12_40
	L5_33 = A2_30
	L4_32 = A2_30.assigned_unit
	L4_32 = L4_32(L5_33)
	L5_33 = assert
	L6_34 = L4_32
	L5_33(L6_34, L7_35)
	L6_34 = L4_32
	L5_33 = L4_32.base
	L5_33 = L5_33(L6_34)
	L6_34 = L5_33.inventory
	L6_34 = L6_34(L7_35)
	for L10_38 = 1, 4 do
		L12_40 = L6_34
		L11_39 = L6_34.item_by_index
		L11_39 = L11_39(L12_40, L10_38)
		if L11_39 then
			L12_40 = 0
			if L11_39:logic() then
				L12_40 = L11_39:logic():bullet_count()
			else
				L12_40 = L11_39:weapon_data()._ammo_pool + L11_39:weapon_data()._bullets_in_clip
			end
			if tweak_data.player.weapon[L11_39:name()] and tweak_data.player.weapon[L11_39:name()].respawn_min_ammo and L12_40 < tweak_data.player.weapon[L11_39:name()].respawn_min_ammo then
				L12_40 = tweak_data.player.weapon[L11_39:name()].respawn_min_ammo
			end
			A3_31.inventory.items[L10_38].name = L11_39:name()
			A3_31.inventory.items[L10_38].ammo = L12_40
		else
			L12_40 = A3_31.inventory
			L12_40 = L12_40.items
			L12_40 = L12_40[L10_38]
			L12_40.name = ""
			L12_40 = A3_31.inventory
			L12_40 = L12_40.items
			L12_40 = L12_40[L10_38]
			L12_40.ammo = 0
		end
	end
end
function SaveManager.set_new_game(A0_41)
	local L1_42
	L1_42 = A0_41.profile
	L1_42 = L1_42(A0_41)
	A0_41._set_cleared_checkpoint_data(L1_42)
	L1_42.has_progress = false
	A0_41._primary_user:save_profile()
end
function SaveManager.set_level_data_to_profiles(A0_43, A1_44, A2_45, A3_46, A4_47)
	local L5_48, L6_49
	L6_49 = A0_43
	L5_48 = A0_43.profile
	L5_48 = L5_48(L6_49)
	L6_49 = assert
	L6_49(L5_48)
	L6_49 = managers
	L6_49 = L6_49.local_user
	L6_49 = L6_49.users
	L6_49 = L6_49(L6_49)
	for 