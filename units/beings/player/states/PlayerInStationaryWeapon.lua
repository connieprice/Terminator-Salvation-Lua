require("units/beings/player/states/PlayerMountedWeaponState.lua")
require("shared/InterpolatorLinear")
require("shared/Angle")
PlayerInStationaryWeapon = PlayerInStationaryWeapon or class(PlayerMountedWeaponState)
PlayerInStationaryWeapon._AIM_ANIM = "stationary_weapon"
PlayerInStationaryWeapon._AIM_FIRE_ANIM = "stationary_weapon_fire"
function PlayerInStationaryWeapon.init(A0_0, A1_1)
	PlayerMountedWeaponState.init(A0_0, A1_1, "PlayerInStationaryWeapon")
	A0_0._last_position = A1_1:position()
	A0_0._current_anim = nil
	A0_0._last_rotation_diff = 360
	A0_0._current_anim = PlayerInStationaryWeapon._AIM_ANIM
	A0_0._weapon_unit = A0_0._player_data._mounted_weapon
	assert(A0_0._weapon_unit)
	A0_0._weapon_data = A0_0._weapon_unit:weapon_data()
	A0_0._offset = Vector3(0, 0, -100)
	A0_0._input = A1_1:input()
end
function PlayerInStationaryWeapon.destroy(A0_2)
	PlayerMountedWeaponState.destroy(A0_2)
end
function PlayerInStationaryWeapon.enter(A0_3)
	local L1_4, L2_5, L3_6, L4_7, L5_8
	L1_4 = PlayerMovementState
	L1_4 = L1_4.enter
	L2_5 = A0_3
	L1_4(L2_5)
	L1_4 = A0_3._player_data
	L1_4._in_stationary_weapon = true
	L1_4 = PlayerMountedWeaponState
	L1_4 = L1_4.enter
	L2_5 = A0_3
	L1_4(L2_5)
	L2_5 = A0_3
	L1_4 = A0_3.set_weapon
	L3_6 = A0_3._weapon_unit
	L1_4(L2_5, L3_6)
	L1_4 = A0_3._weapon_unit
	L2_5 = L1_4
	L1_4 = L1_4.base
	L1_4 = L1_4(L2_5)
	L2_5 = L1_4
	L1_4 = L1_4.setup
	L3_6 = A0_3._unit
	L1_4(L2_5, L3_6)
	L1_4 = A0_3._weapon_unit
	L2_5 = L1_4
	L1_4 = L1_4.base
	L1_4 = L1_4(L2_5)
	L2_5 = L1_4
	L1_4 = L1_4.set_equiped
	L3_6 = true
	L1_4(L2_5, L3_6)
	L1_4 = A0_3._unit
	L2_5 = L1_4
	L1_4 = L1_4.play_redirect
	L3_6 = A0_3._current_anim
	L1_4(L2_5, L3_6)
	L1_4 = A0_3._unit
	L2_5 = L1_4
	L1_4 = L1_4.set_rotation
	L3_6 = A0_3._weapon
	L4_7 = L3_6
	L3_6 = L3_6.rotation
	L5_8 = L3_6(L4_7)
	L1_4(L2_5, L3_6, L4_7, L5_8, L3_6(L4_7))
	L1_4 = assert
	L2_5 = A0_3._weapon_unit
	L3_6 = L2_5
	L2_5 = L2_5.interact
	L5_8 = L2_5(L3_6)
	L1_4(L2_5, L3_6, L4_7, L5_8, L2_5(L3_6))
	L1_4 = A0_3._weapon_unit
	L2_5 = L1_4
	L1_4 = L1_4.interact
	L1_4 = L1_4(L2_5)
	L1_4 = L1_4._x_offset
	L1_4 = L1_4 or 0
	L2_5 = A0_3._weapon_unit
	L3_6 = L2_5
	L2_5 = L2_5.interact
	L2_5 = L2_5(L3_6)
	L2_5 = L2_5._y_offset
	L2_5 = L2_5 or 0
	L3_6 = A0_3._weapon_unit
	L4_7 = L3_6
	L3_6 = L3_6.interact
	L3_6 = L3_6(L4_7)
	L3_6 = L3_6._z_offset
	L3_6 = L3_6 or 0
	L4_7 = A0_3._weapon_unit
	L5_8 = L4_7
	L4_7 = L4_7.position
	L4_7 = L4_7(L5_8)
	L5_8 = A0_3._weapon_unit
	L5_8 = L5_8.rotation
	L5_8 = L5_8(L5_8)
	L5_8 = L5_8.x
	L5_8 = L5_8(L5_8)
	L5_8 = L5_8.normalized
	L5_8 = L5_8(L5_8)
	L5_8 = L5_8 * L1_4
	L4_7 = L4_7 + L5_8
	L5_8 = A0_3._weapon_unit
	L5_8 = L5_8.rotation
	L5_8 = L5_8(L5_8)
	L5_8 = L5_8.y
	L5_8 = L5_8(L5_8)
	L5_8 = L5_8.normalized
	L5_8 = L5_8(L5_8)
	L5_8 = L5_8 * L2_5
	L4_7 = L4_7 + L5_8
	L5_8 = A0_3._weapon_unit
	L5_8 = L5_8.rotation
	L5_8 = L5_8(L5_8)
	L5_8 = L5_8.z
	L5_8 = L5_8(L5_8)
	L5_8 = L5_8 * L3_6
	L4_7 = L4_7 + L5_8
	L5_8 = A0_3._unit
	L5_8 = L5_8.set_position
	L5_8(L5_8, L4_7)
	L5_8 = A0_3._unit
	L5_8 = L5_8.set_moving
	L5_8(L5_8)
	L5_8 = A0_3._weapon_unit
	L5_8 = L5_8.turret
	L5_8 = L5_8(L5_8)
	assert(L5_8)
	A0_3._unit:look():set_yaw_constraints(A0_3._weapon_unit:rotation():roll(), L5_8.yaw_neg_angle, L5_8.yaw_pos_angle)
	A0_3._unit:look():set_pitch_constraints(-L5_8.pitch_neg_angle, L5_8.pitch_pos_angle)
end
function PlayerInStationaryWeapon.leave(A0_9)
	PlayerMovementState.leave(A0_9)
	A0_9._player_data._in_stationary_weapon = false
	A0_9._player_data._mounted_weapon = nil
	A0_9._weapon_unit:base():setup(nil)
	A0_9._weapon_unit:base():set_equiped(false)
	PlayerMountedWeaponState.leave(A0_9)
	A0_9._unit:look():reset_constraints()
	A0_9._player_data.is_precision_aiming = false
end
function PlayerInStationaryWeapon._link_player_to_turret(A0_10)
	local L1_11
end
function PlayerInStationaryWeapon.wants_to_leave(A0_12)
	return A0_12._input:leave_mounted_weapon()
end
function PlayerInStationaryWeapon._update_fire_animation(A0_13)
	local L1_14
	L1_14 = A0_13._weapon_data
	L1_14 = L1_14._firing
	if L1_14 then
		L1_14 = PlayerInStationaryWeapon
		L1_14 = L1_14._AIM_FIRE_ANIM
	elseif not L1_14 then
		L1_14 = PlayerInStationaryWeapon
		L1_14 = L1_14._AIM_ANIM
	end
	A0_13._current_anim = L1_14
end
function PlayerInStationaryWeapon.transition(A0_15)
	if A0_15._base:check_fully_damaged() then
		return (A0_15._base:check_fully_damaged())
	end
	if A0_15:wants_to_leave() then
		A0_15._unit:set_position(A0_15._last_position)
		A0_15._unit:play_redirect("idle_std")
		A0_15._unit:play_redirect("exit_stationary_weapon")
		return PlayerOnGround:new(A0_15._unit)
	end
end
function PlayerInStationaryWeapon.update(A0_16, A1_17, A2_18)
	if A0_16:transition() then
		return (A0_16:transition())
	end
	PlayerMountedWeaponState.update(A0_16, A1_17, A2_18)
end
function PlayerInStationaryWeapon.variable_frequency_post_update(A0_19, A1_20)
	PlayerMovementState.variable_frequency_post_update(A0_19, A1_20)
	A0_19:_update_fire_animation()
	A0_19._unit:play_redirect(A0_19._current_anim)
	A0_19._player_data.is_precision_aiming = A0_19._unit:input():precision_aiming()
end
function PlayerInStationaryWeapon._update_turret(A0_21, A1_22, A2_23)
	PlayerMountedWeaponState._update_turret(A0_21, A1_22, A2_23)
end
