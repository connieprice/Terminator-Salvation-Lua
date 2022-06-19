require("cover/CoverEdgeType")
require("shared/TableAlgorithms")
function access_control_wrapper(A0_0)
	class().init = function(A0_1, A1_2)
		A0_1._unit = A1_2
		A0_1._controlled_class_instance = _UPVALUE0_:new(A1_2)
		function A0_1.make_read_write(A0_3)
			setmetatable(A0_3, {
				__index = A0_3._controlled_class_instance,
				__newindex = A0_3._controlled_class_instance
			})
		end
		function A0_1.make_read_only(A0_4)
			setmetatable(A0_4, {
				__index = A0_4._controlled_class_instance,
				__newindex = function()
					assert(false, "Trying to modify readonly table")
				end
			})
			return A0_4._controlled_class_instance
		end
		A0_1:make_read_write()
	end
	return (class())
end
CharacterInput = CharacterInput or class()
CharacterInputAccessControlled = access_control_wrapper(CharacterInput)
function CharacterInput.init(A0_5, A1_6)
	A0_5:clear()
end
function CharacterInput.clear(A0_7)
	A0_7._movement = Vector3(0, 0, 0)
	A0_7._movement_length = 0
	A0_7._normalized_movement = Vector3(0, 0, 0)
	A0_7._precision_aiming = false
	A0_7._aiming = false
	A0_7._fire = 0
	A0_7._fire_pressed = false
	A0_7._fire_grenade = false
	A0_7._reload = false
	A0_7._enter_cover = false
	A0_7._target_cover_id = 0
	A0_7._target_cover_point_position = Vector3(0, 0, 0)
	A0_7._target_cover_point_edge = CoverEdgeType.NOT_EDGE
	A0_7._target_cover_squared_distance = 0
	A0_7._leave_cover = false
	A0_7._eye_target_position = nil
	A0_7._aim_target_position = nil
	A0_7._respawn = false
	A0_7._enter_rail_vehicle = false
	A0_7._revive = false
	A0_7._interact = false
	A0_7._weapon_slot = 0
	A0_7._toggle_flashlight = false
	A0_7._miss_dispersion = 0
	A0_7._quick_move_info_index = 0
	A0_7._quick_move_infos_id = 0
	A0_7._leave_mounted_weapon = nil
	A0_7._enter_inner_cover_position = false
	A0_7._enter_outer_cover_position = false
	A0_7._wants_to_look_at = false
end
function CharacterInput.set(A0_8, A1_9)
	TableAlgorithms.merge(A0_8, A1_9)
end
function CharacterInput.movement(A0_10)
	local L1_11
	L1_11 = A0_10._movement
	return L1_11
end
function CharacterInput.movement_length(A0_12)
	local L1_13
	L1_13 = A0_12._movement_length
	return L1_13
end
function CharacterInput.normalized_movement(A0_14)
	local L1_15
	L1_15 = A0_14._normalized_movement
	return L1_15
end
function CharacterInput.set_movement(A0_16, A1_17, A2_18)
	A0_16._movement = A1_17
	if A2_18 == true and A0_16._movement:length() > 0.5 then
		A0_16._movement_length = 0.5
	else
		A0_16._movement_length = A0_16._movement:length()
	end
	A0_16._normalized_movement = A0_16._movement:normalized()
end
function CharacterInput.eye_target_position(A0_19)
	local L1_20
	L1_20 = A0_19._eye_target_position
	return L1_20
end
function CharacterInput.set_eye_target_position(A0_21, A1_22)
	A0_21._eye_target_position = A1_22
end
function CharacterInput.wants_to_look_at(A0_23)
	local L1_24
	L1_24 = A0_23._wants_to_look_at
	return L1_24
end
function CharacterInput.set_wants_to_look_at(A0_25, A1_26)
	A0_25._wants_to_look_at = A1_26
end
function CharacterInput.aim_target_position(A0_27)
	local L1_28
	L1_28 = A0_27._aim_target_position
	return L1_28
end
function CharacterInput.set_aim_target_position(A0_29, A1_30)
	A0_29._aim_target_position = A1_30
end
function CharacterInput.precision_aiming(A0_31)
	local L1_32
	L1_32 = A0_31._precision_aiming
	return L1_32
end
function CharacterInput.set_precision_aiming(A0_33)
	local L1_34
	A0_33._precision_aiming = true
end
function CharacterInput.aiming(A0_35)
	local L1_36
	L1_36 = A0_35._aiming
	return L1_36
end
function CharacterInput.set_aiming(A0_37)
	local L1_38
	A0_37._aiming = true
end
function CharacterInput.fire(A0_39)
	local L1_40
	L1_40 = A0_39._fire
	return L1_40
end
function CharacterInput.fire_pressed(A0_41)
	local L1_42
	L1_42 = A0_41._fire_pressed
	return L1_42
end
function CharacterInput.set_fire(A0_43, A1_44, A2_45)
	A0_43._fire = A1_44
	A0_43._fire_pressed = A2_45
end
function CharacterInput.fire_grenade(A0_46)
	local L1_47
	L1_47 = A0_46._fire_grenade
	return L1_47
end
function CharacterInput.set_fire_grenade(A0_48)
	local L1_49
	A0_48._fire_grenade = true
end
function CharacterInput.set_reload(A0_50, A1_51)
	A0_50._reload = A1_51
end
function CharacterInput.reload(A0_52)
	local L1_53
	L1_53 = A0_52._reload
	return L1_53
end
function CharacterInput.enter_cover(A0_54)
	local L1_55
	L1_55 = A0_54._enter_cover
	return L1_55
end
function CharacterInput.set_enter_cover(A0_56, A1_57, A2_58)
	A0_56:set_target_cover_info(A1_57, A2_58)
	A0_56._enter_cover = true
end
function CharacterInput.set_target_cover_info(A0_59, A1_60, A2_61)
	assert(A1_60)
	A0_59._target_cover_id = managers.cover:cover_id(A1_60:cover())
	assert(A0_59._target_cover_id)
	A0_59._target_cover_point_position = A1_60:closest_cover_point():position()
	A0_59._target_cover_point_edge = A1_60:closest_cover_point():edge()
	A0_59._target_cover_point_normal = A1_60:closest_cover_point():normal()
	A0_59._target_cover_point_height = A1_60:closest_cover_point():height()
	A0_59._target_cover_point_cover_relative_position = A1_60:closest_cover_point():cover_relative_position()
	A0_59._target_cover_squared_distance = A1_60:squared_distance_to_cover_position()
	A0_59._target_cover_use_outer_position = A2_61
end
function CharacterInput.leave_cover(A0_62)
	local L1_63
	L1_63 = A0_62._leave_cover
	return L1_63
end
function CharacterInput.set_leave_cover(A0_64)
	local L1_65
	A0_64._target_cover_info = nil
	A0_64._leave_cover = true
end
function CharacterInput.target_cover_info(A0_66)
	local L1_67, L2_68
	L1_67 = A0_66._target_cover_id
	if L1_67 == 0 then
		L1_67 = nil
		return L1_67
	end
	L1_67 = managers
	L1_67 = L1_67.cover
	L2_68 = L1_67
	L1_67 = L1_67.cover
	L1_67 = L1_67(L2_68, A0_66._target_cover_id)
	L2_68 = assert
	L2_68(L1_67)
	L2_68 = CoverPoint
	L2_68 = L2_68.new
	L2_68 = L2_68(L2_68, A0_66._target_cover_point_position, A0_66._target_cover_point_edge, A0_66._target_cover_point_normal, A0_66._target_cover_point_height, A0_66._target_cover_point_cover_relative_position)
	return (CoverInfo:new(L1_67, L2_68, A0_66._target_cover_squared_distance))
end
function CharacterInput.target_cover_use_outer_position(A0_69)
	local L1_70
	L1_70 = A0_69._target_cover_use_outer_position
	return L1_70
end
function CharacterInput.enter_inner_cover_position(A0_71)
	local L1_72
	L1_72 = A0_71._enter_inner_cover_position
	return L1_72
end
function CharacterInput.set_enter_inner_cover_position(A0_73)
	local L1_74
	A0_73._enter_inner_cover_position = true
end
function CharacterInput.enter_outer_cover_position(A0_75)
	local L1_76
	L1_76 = A0_75._enter_outer_cover_position
	return L1_76
end
function CharacterInput.set_enter_outer_cover_position(A0_77)
	local L1_78
	A0_77._enter_outer_cover_position = true
end
function CharacterInput.respawn(A0_79)
	local L1_80
	L1_80 = A0_79._respawn
	return L1_80
end
function CharacterInput.set_respawn(A0_81)
	local L1_82
	A0_81._respawn = true
end
function CharacterInput.set_enter_rail_vehicle(A0_83)
	local L1_84
	A0_83._enter_rail_vehicle = true
end
function CharacterInput.enter_rail_vehicle(A0_85)
	local L1_86
	L1_86 = A0_85._enter_rail_vehicle
	return L1_86
end
function CharacterInput.set_revive(A0_87)
	local L1_88
	A0_87._revive = true
end
function CharacterInput.revive(A0_89)
	local L1_90
	L1_90 = A0_89._revive
	return L1_90
end
function CharacterInput.set_interact(A0_91)
	local L1_92
	A0_91._interact = true
end
function CharacterInput.interact(A0_93)
	local L1_94
	L1_94 = A0_93._interact
	return L1_94
end
function CharacterInput.set_weapon_slot(A0_95, A1_96)
	A0_95._weapon_slot = A1_96
end
function CharacterInput.weapon_slot(A0_97)
	local L1_98
	L1_98 = A0_97._weapon_slot
	return L1_98
end
function CharacterInput.set_toggle_flashlight(A0_99)
	local L1_100
	A0_99._toggle_flashlight = true
end
function CharacterInput.toggle_flashlight(A0_101)
	local L1_102
	L1_102 = A0_101._toggle_flashlight
	return L1_102
end
function CharacterInput.miss_dispersion(A0_103)
	local L1_104
	L1_104 = A0_103._miss_dispersion
	return L1_104
end
function CharacterInput.set_miss_dispersion(A0_105, A1_106)
	A0_105._miss_dispersion = A1_106
end
function CharacterInput.set_show_alternative_hud(A0_107, A1_108)
	A0_107._alternative_hud = A1_108
end
function CharacterInput.show_alternative_hud(A0_109)
	local L1_110
	L1_110 = A0_109._alternative_hud
	return L1_110
end
function CharacterInput.set_quick_move_info_index(A0_111, A1_112, A2_113)
	assert(A1_112)
	assert(A2_113)
	A0_111._quick_move_info_index = A1_112
	A0_111._quick_move_infos_id = A2_113
end
function CharacterInput.quick_move_info_index(A0_114)
	local L1_115
	L1_115 = A0_114._quick_move_info_index
	return L1_115
end
function CharacterInput.quick_move_infos_id(A0_116)
	local L1_117
	L1_117 = A0_116._quick_move_infos_id
	return L1_117
end
function CharacterInput.leave_mounted_weapon(A0_118)
	local L1_119
	L1_119 = A0_118._leave_mounted_weapon
	return L1_119
end
function CharacterInput.set_leave_mounted_weapon(A0_120)
	local L1_121
	A0_120._leave_mounted_weapon = true
end
