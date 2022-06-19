require("units/beings/player/states/PlayerMovementState")
if not PlayerMountedWeaponState then
	PlayerMountedWeaponState = class(PlayerMovementState)
end
PlayerMountedWeaponState.init = function(l_1_0, l_1_1, l_1_2)
	PlayerMovementState.init(l_1_0, l_1_1, l_1_2)
	l_1_0._right_hand_aim = l_1_0._machine:get_modifier("ik_right_hand_stationary_weapon")
	l_1_0._left_hand_aim = l_1_0._machine:get_modifier("ik_left_hand_stationary_weapon")
	l_1_0._unit:anim_state_machine():play("weapon_pose/idle")
end

PlayerMountedWeaponState._setup_ik = function(l_2_0)
	l_2_0._left_hand = l_2_0._unit:get_object("a_weapon_left_front")
	l_2_0._left_hand_pos = l_2_0._left_hand:local_position()
	l_2_0._left_hand_rot = l_2_0._left_hand:local_rotation()
	l_2_0._right_hand = l_2_0._unit:get_object("a_weapon_right_back")
	l_2_0._right_hand_pos = l_2_0._right_hand:local_position()
	l_2_0._right_hand_rot = l_2_0._right_hand:local_rotation()
	l_2_0._right_hand_aim:set_object(l_2_0._weapon:get_object("a_weapon_left_right"))
	l_2_0._left_hand_aim:set_object(l_2_0._weapon:get_object("a_weapon_left_front"))
end

PlayerMountedWeaponState._clear_ik = function(l_3_0)
	l_3_0._left_hand:set_local_position(l_3_0._left_hand_pos)
	l_3_0._left_hand:set_local_rotation(l_3_0._left_hand_rot)
	l_3_0._right_hand:set_local_position(l_3_0._right_hand_pos)
	l_3_0._right_hand:set_local_rotation(l_3_0._right_hand_rot)
end

PlayerMountedWeaponState._link_player_to_turret = function(l_4_0)
	l_4_0._unit:base():kill_mover()
end

PlayerMountedWeaponState.update = function(l_5_0, l_5_1, l_5_2)
	local l_5_3 = l_5_0._base:check_fully_damaged()
	if l_5_3 then
		return l_5_3
	end
	PlayerMovementState.update(l_5_0, l_5_1, l_5_2)
	l_5_0:_update_aim_parameters(l_5_2)
	l_5_0:_update_turret(l_5_1, l_5_2)
end

PlayerMountedWeaponState.destroy = function(l_6_0)
	PlayerMovementState.destroy(l_6_0)
end

PlayerMountedWeaponState.enter = function(l_7_0)
	PlayerMovementState.enter(l_7_0)
	l_7_0._unit:base():kill_mover()
	l_7_0._unit:set_driving("script")
	l_7_0._unit:play("foley_cover_enter")
end

PlayerMountedWeaponState.leave = function(l_8_0)
	PlayerMovementState.leave(l_8_0)
	l_8_0:_clear_ik()
	if alive(l_8_0._weapon) then
		l_8_0._weapon:weapon_data().fire_input = 0
		l_8_0._weapon = nil
	end
	l_8_0._unit:set_driving("animation")
	l_8_0._unit:base():unequip_forced_weapon()
	l_8_0._unit:play("foley_cover_exit")
end

PlayerMountedWeaponState.let_go_off_weapon = function(l_9_0)
	l_9_0._dont_update_turret_weapon = true
end

PlayerMountedWeaponState.set_weapon = function(l_10_0, l_10_1)
	l_10_0._weapon = l_10_1
	l_10_0:_setup_ik()
	l_10_0._unit:base():force_equip_weapon(l_10_1)
	l_10_0:_link_player_to_turret()
end

PlayerMountedWeaponState._update_turret = function(l_11_0, l_11_1, l_11_2)
	if not l_11_0._dont_update_turret_weapon then
		l_11_0._weapon:turret():set_aim_vec(l_11_0._unit:get_object("aim"):rotation():y())
	end
end

PlayerMountedWeaponState._get_aim_constraints = function(l_12_0, l_12_1)
	local l_12_2 = l_12_0._weapon:turret()
	return l_12_2.pitch_neg_angle, l_12_2.pitch_pos_angle, l_12_2.yaw_pos_angle, l_12_2.yaw_neg_angle
end


