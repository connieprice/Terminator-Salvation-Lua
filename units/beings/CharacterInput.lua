require("cover/CoverEdgeType")
require("shared/TableAlgorithms")
access_control_wrapper = function(l_1_0)
	local l_1_1 = class()
	l_1_1.init = function(l_2_0, l_2_1)
		-- upvalues: l_1_0
		l_2_0._unit = l_2_1
		l_2_0._controlled_class_instance = l_1_0:new(l_2_1)
		l_2_0.make_read_write = function(l_3_0)
			local l_3_1 = setmetatable
			local l_3_2 = l_3_0
			local l_3_3 = {}
			l_3_3.__index = l_3_0._controlled_class_instance
			l_3_3.__newindex = l_3_0._controlled_class_instance
			l_3_1(l_3_2, l_3_3)
    end
		l_2_0.make_read_only = function(l_4_0)
			local l_4_1 = setmetatable
			local l_4_2 = l_4_0
			local l_4_3 = {}
			l_4_3.__index = l_4_0._controlled_class_instance
			l_4_3.__newindex = function()
				assert(false, "Trying to modify readonly table")
      end
			l_4_1(l_4_2, l_4_3)
			l_4_1 = l_4_0._controlled_class_instance
			return l_4_1
    end
		l_2_0:make_read_write()
  end
	return l_1_1
end

if not CharacterInput then
	CharacterInput = class()
end
CharacterInputAccessControlled = access_control_wrapper(CharacterInput)
CharacterInput.init = function(l_2_0, l_2_1)
	l_2_0:clear()
end

CharacterInput.clear = function(l_3_0)
	l_3_0._movement = Vector3(0, 0, 0)
	l_3_0._movement_length = 0
	l_3_0._normalized_movement = Vector3(0, 0, 0)
	l_3_0._precision_aiming = false
	l_3_0._aiming = false
	l_3_0._fire = 0
	l_3_0._fire_pressed = false
	l_3_0._fire_grenade = false
	l_3_0._reload = false
	l_3_0._enter_cover = false
	l_3_0._target_cover_id = 0
	l_3_0._target_cover_point_position = Vector3(0, 0, 0)
	l_3_0._target_cover_point_edge = CoverEdgeType.NOT_EDGE
	l_3_0._target_cover_squared_distance = 0
	l_3_0._leave_cover = false
	l_3_0._eye_target_position = nil
	l_3_0._aim_target_position = nil
	l_3_0._respawn = false
	l_3_0._enter_rail_vehicle = false
	l_3_0._revive = false
	l_3_0._interact = false
	l_3_0._weapon_slot = 0
	l_3_0._toggle_flashlight = false
	l_3_0._miss_dispersion = 0
	l_3_0._quick_move_info_index = 0
	l_3_0._quick_move_infos_id = 0
	l_3_0._leave_mounted_weapon = nil
	l_3_0._enter_inner_cover_position = false
	l_3_0._enter_outer_cover_position = false
	l_3_0._wants_to_look_at = false
end

CharacterInput.set = function(l_4_0, l_4_1)
	TableAlgorithms.merge(l_4_0, l_4_1)
end

CharacterInput.movement = function(l_5_0)
	return l_5_0._movement
end

CharacterInput.movement_length = function(l_6_0)
	return l_6_0._movement_length
end

CharacterInput.normalized_movement = function(l_7_0)
	return l_7_0._normalized_movement
end

CharacterInput.set_movement = function(l_8_0, l_8_1, l_8_2)
	l_8_0._movement = l_8_1
	local l_8_3 = l_8_0._movement:length()
	if l_8_2 == true and l_8_3 > 0.5 then
		l_8_0._movement_length = 0.5
	else
		l_8_0._movement_length = l_8_3
	end
	l_8_0._normalized_movement = l_8_0._movement:normalized()
end

CharacterInput.eye_target_position = function(l_9_0)
	return l_9_0._eye_target_position
end

CharacterInput.set_eye_target_position = function(l_10_0, l_10_1)
	l_10_0._eye_target_position = l_10_1
end

CharacterInput.wants_to_look_at = function(l_11_0)
	return l_11_0._wants_to_look_at
end

CharacterInput.set_wants_to_look_at = function(l_12_0, l_12_1)
	l_12_0._wants_to_look_at = l_12_1
end

CharacterInput.aim_target_position = function(l_13_0)
	return l_13_0._aim_target_position
end

CharacterInput.set_aim_target_position = function(l_14_0, l_14_1)
	l_14_0._aim_target_position = l_14_1
end

CharacterInput.precision_aiming = function(l_15_0)
	return l_15_0._precision_aiming
end

CharacterInput.set_precision_aiming = function(l_16_0)
	l_16_0._precision_aiming = true
end

CharacterInput.aiming = function(l_17_0)
	return l_17_0._aiming
end

CharacterInput.set_aiming = function(l_18_0)
	l_18_0._aiming = true
end

CharacterInput.fire = function(l_19_0)
	return l_19_0._fire
end

CharacterInput.fire_pressed = function(l_20_0)
	return l_20_0._fire_pressed
end

CharacterInput.set_fire = function(l_21_0, l_21_1, l_21_2)
	l_21_0._fire = l_21_1
	l_21_0._fire_pressed = l_21_2
end

CharacterInput.fire_grenade = function(l_22_0)
	return l_22_0._fire_grenade
end

CharacterInput.set_fire_grenade = function(l_23_0)
	l_23_0._fire_grenade = true
end

CharacterInput.set_reload = function(l_24_0, l_24_1)
	l_24_0._reload = l_24_1
end

CharacterInput.reload = function(l_25_0)
	return l_25_0._reload
end

CharacterInput.enter_cover = function(l_26_0)
	return l_26_0._enter_cover
end

CharacterInput.set_enter_cover = function(l_27_0, l_27_1, l_27_2)
	l_27_0:set_target_cover_info(l_27_1, l_27_2)
	l_27_0._enter_cover = true
end

CharacterInput.set_target_cover_info = function(l_28_0, l_28_1, l_28_2)
	assert(l_28_1)
	l_28_0._target_cover_id = managers.cover:cover_id(l_28_1:cover())
	assert(l_28_0._target_cover_id)
	l_28_0._target_cover_point_position = l_28_1:closest_cover_point():position()
	l_28_0._target_cover_point_edge = l_28_1:closest_cover_point():edge()
	l_28_0._target_cover_point_normal = l_28_1:closest_cover_point():normal()
	l_28_0._target_cover_point_height = l_28_1:closest_cover_point():height()
	l_28_0._target_cover_point_cover_relative_position = l_28_1:closest_cover_point():cover_relative_position()
	l_28_0._target_cover_squared_distance = l_28_1:squared_distance_to_cover_position()
	l_28_0._target_cover_use_outer_position = l_28_2
end

CharacterInput.leave_cover = function(l_29_0)
	return l_29_0._leave_cover
end

CharacterInput.set_leave_cover = function(l_30_0)
	l_30_0._target_cover_info = nil
	l_30_0._leave_cover = true
end

CharacterInput.target_cover_info = function(l_31_0)
	if l_31_0._target_cover_id == 0 then
		return nil
	end
	local l_31_1 = managers.cover:cover(l_31_0._target_cover_id)
	assert(l_31_1)
	local l_31_2 = CoverPoint:new(l_31_0._target_cover_point_position, l_31_0._target_cover_point_edge, l_31_0._target_cover_point_normal, l_31_0._target_cover_point_height, l_31_0._target_cover_point_cover_relative_position)
	return CoverInfo:new(l_31_1, l_31_2, l_31_0._target_cover_squared_distance)
end

CharacterInput.target_cover_use_outer_position = function(l_32_0)
	return l_32_0._target_cover_use_outer_position
end

CharacterInput.enter_inner_cover_position = function(l_33_0)
	return l_33_0._enter_inner_cover_position
end

CharacterInput.set_enter_inner_cover_position = function(l_34_0)
	l_34_0._enter_inner_cover_position = true
end

CharacterInput.enter_outer_cover_position = function(l_35_0)
	return l_35_0._enter_outer_cover_position
end

CharacterInput.set_enter_outer_cover_position = function(l_36_0)
	l_36_0._enter_outer_cover_position = true
end

CharacterInput.respawn = function(l_37_0)
	return l_37_0._respawn
end

CharacterInput.set_respawn = function(l_38_0)
	l_38_0._respawn = true
end

CharacterInput.set_enter_rail_vehicle = function(l_39_0)
	l_39_0._enter_rail_vehicle = true
end

CharacterInput.enter_rail_vehicle = function(l_40_0)
	return l_40_0._enter_rail_vehicle
end

CharacterInput.set_revive = function(l_41_0)
	l_41_0._revive = true
end

CharacterInput.revive = function(l_42_0)
	return l_42_0._revive
end

CharacterInput.set_interact = function(l_43_0)
	l_43_0._interact = true
end

CharacterInput.interact = function(l_44_0)
	return l_44_0._interact
end

CharacterInput.set_weapon_slot = function(l_45_0, l_45_1)
	l_45_0._weapon_slot = l_45_1
end

CharacterInput.weapon_slot = function(l_46_0)
	return l_46_0._weapon_slot
end

CharacterInput.set_toggle_flashlight = function(l_47_0)
	l_47_0._toggle_flashlight = true
end

CharacterInput.toggle_flashlight = function(l_48_0)
	return l_48_0._toggle_flashlight
end

CharacterInput.miss_dispersion = function(l_49_0)
	return l_49_0._miss_dispersion
end

CharacterInput.set_miss_dispersion = function(l_50_0, l_50_1)
	l_50_0._miss_dispersion = l_50_1
end

CharacterInput.set_show_alternative_hud = function(l_51_0, l_51_1)
	l_51_0._alternative_hud = l_51_1
end

CharacterInput.show_alternative_hud = function(l_52_0)
	return l_52_0._alternative_hud
end

CharacterInput.set_quick_move_info_index = function(l_53_0, l_53_1, l_53_2)
	assert(l_53_1)
	assert(l_53_2)
	l_53_0._quick_move_info_index = l_53_1
	l_53_0._quick_move_infos_id = l_53_2
end

CharacterInput.quick_move_info_index = function(l_54_0)
	return l_54_0._quick_move_info_index
end

CharacterInput.quick_move_infos_id = function(l_55_0)
	return l_55_0._quick_move_infos_id
end

CharacterInput.leave_mounted_weapon = function(l_56_0)
	return l_56_0._leave_mounted_weapon
end

CharacterInput.set_leave_mounted_weapon = function(l_57_0)
	l_57_0._leave_mounted_weapon = true
end


