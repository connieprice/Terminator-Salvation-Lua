require("units/beings/player/states/PlayerMovementState")
PlayerMountedWeaponState = PlayerMountedWeaponState or class(PlayerMovementState)
function PlayerMountedWeaponState.init(A0_0, A1_1, A2_2)
	PlayerMovementState.init(A0_0, A1_1, A2_2)
	A0_0._right_hand_aim = A0_0._machine:get_modifier("ik_right_hand_stationary_weapon")
	A0_0._left_hand_aim = A0_0._machine:get_modifier("ik_left_hand_stationary_weapon")
	A0_0._unit:anim_state_machine():play("weapon_pose/idle")
end
function PlayerMountedWeaponState._setup_ik(A0_3)
	A0_3._left_hand = A0_3._unit:get_object("a_weapon_left_front")
	A0_3._left_hand_pos = A0_3._left_hand:local_position()
	A0_3._left_hand_rot = A0_3._left_hand:local_rotation()
	A0_3._right_hand = A0_3._unit:get_object("a_weapon_right_back")
	A0_3._right_hand_pos = A0_3._right_hand:local_position()
	A0_3._right_hand_rot = A0_3._right_hand:local_rotation()
	A0_3._right_hand_aim:set_object(A0_3._weapon:get_object("a_weapon_left_right"))
	A0_3._left_hand_aim:set_object(A0_3._weapon:get_object("a_weapon_left_front"))
end
function PlayerMountedWeaponState._clear_ik(A0_4)
	A0_4._left_hand:set_local_position(A0_4._left_hand_pos)
	A0_4._left_hand:set_local_rotation(A0_4._left_hand_rot)
	A0_4._right_hand:set_local_position(A0_4._right_hand_pos)
	A0_4._right_hand:set_local_rotation(A0_4._right_hand_rot)
end
function PlayerMountedWeaponState._link_player_to_turret(A0_5)
	A0_5._unit:base():kill_mover()
end
function PlayerMountedWeaponState.update(A0_6, A1_7, A2_8)
	if A0_6._base:check_fully_damaged() then
		return (A0_6._base:check_fully_damaged())
	end
	PlayerMovementState.update(A0_6, A1_7, A2_8)
	A0_6:_update_aim_parameters(A2_8)
	A0_6:_update_turret(A1_7, A2_8)
end
function PlayerMountedWeaponState.destroy(A0_9)
	PlayerMovementState.destroy(A0_9)
end
function PlayerMountedWeaponState.enter(A0_10)
	PlayerMovementState.enter(A0_10)
	A0_10._unit:base():kill_mover()
	A0_10._unit:set_driving("script")
	A0_10._unit:play("foley_cover_enter")
end
function PlayerMountedWeaponState.leave(A0_11)
	PlayerMovementState.leave(A0_11)
	A0_11:_clear_ik()
	if alive(A0_11._weapon) then
		A0_11._weapon:weapon_data().fire_input = 0
		A0_11._weapon = nil
	end
	A0_11._unit:set_driving("animation")
	A0_11._unit:base():unequip_forced_weapon()
	A0_11._unit:play("foley_cover_exit")
end
function PlayerMountedWeaponState.let_go_off_weapon(A0_12)
	local L1_13
	A0_12._dont_update_turret_weapon = true
end
function PlayerMountedWeaponState.set_weapon(A0_14, A1_15)
	A0_14._weapon = A1_15
	A0_14:_setup_ik()
	A0_14._unit:base():force_equip_weapon(A1_15)
	A0_14:_link_player_to_turret()
end
function PlayerMountedWeaponState._update_turret(A0_16, A1_17, A2_18)
	if not A0_16._dont_update_turret_weapon then
		A0_16._weapon:turret():set_aim_vec(A0_16._unit:get_object("aim"):rotation():y())
	end
end
function PlayerMountedWeaponState._get_aim_constraints(A0_19, A1_20)
	return A0_19._weapon:turret().pitch_neg_angle, A0_19._weapon:turret().pitch_pos_angle, A0_19._weapon:turret().yaw_pos_angle, A0_19._weapon:turret().yaw_neg_angle
end
