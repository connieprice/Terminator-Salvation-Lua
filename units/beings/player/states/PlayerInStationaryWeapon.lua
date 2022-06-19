require("units/beings/player/states/PlayerMountedWeaponState.lua")
require("shared/InterpolatorLinear")
require("shared/Angle")
if not PlayerInStationaryWeapon then
	PlayerInStationaryWeapon = class(PlayerMountedWeaponState)
end
PlayerInStationaryWeapon._AIM_ANIM = "stationary_weapon"
PlayerInStationaryWeapon._AIM_FIRE_ANIM = "stationary_weapon_fire"
PlayerInStationaryWeapon.init = function(l_1_0, l_1_1)
	PlayerMountedWeaponState.init(l_1_0, l_1_1, "PlayerInStationaryWeapon")
	l_1_0._last_position = l_1_1:position()
	l_1_0._current_anim = nil
	l_1_0._last_rotation_diff = 360
	l_1_0._current_anim = PlayerInStationaryWeapon._AIM_ANIM
	l_1_0._weapon_unit = l_1_0._player_data._mounted_weapon
	assert(l_1_0._weapon_unit)
	l_1_0._weapon_data = l_1_0._weapon_unit:weapon_data()
	l_1_0._offset = Vector3(0, 0, -100)
	l_1_0._input = l_1_1:input()
end

PlayerInStationaryWeapon.destroy = function(l_2_0)
	PlayerMountedWeaponState.destroy(l_2_0)
end

PlayerInStationaryWeapon.enter = function(l_3_0)
	PlayerMovementState.enter(l_3_0)
	l_3_0._player_data._in_stationary_weapon = true
	PlayerMountedWeaponState.enter(l_3_0)
	l_3_0:set_weapon(l_3_0._weapon_unit)
	l_3_0._weapon_unit:base():setup(l_3_0._unit)
	l_3_0._weapon_unit:base():set_equiped(true)
	l_3_0._unit:play_redirect(l_3_0._current_anim)
	l_3_0._unit:set_rotation(l_3_0._weapon:rotation())
	assert(l_3_0._weapon_unit:interact())
	do
		local l_3_1 = l_3_0._weapon_unit:interact()._x_offset or 0
	do
		end
		local l_3_2 = nil
	do
		end
		local l_3_3 = nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_3_4 = nil
	l_3_0._unit:set_position(l_3_0._weapon_unit:position() + l_3_0._weapon_unit:rotation():x():normalized() * l_3_3 + l_3_0._weapon_unit:rotation():y():normalized() * (l_3_0._weapon_unit:interact()._y_offset or 0) + l_3_0._weapon_unit:rotation():z() * (l_3_0._weapon_unit:interact()._z_offset or 0))
	l_3_0._unit:set_moving()
	local l_3_5 = nil
	assert(l_3_0._weapon_unit:turret())
	l_3_0._unit:look():set_yaw_constraints(l_3_0._weapon_unit:rotation():roll(), l_3_0._weapon_unit:turret().yaw_neg_angle, l_3_0._weapon_unit:turret().yaw_pos_angle)
	l_3_0._unit:look():set_pitch_constraints(-l_3_0._weapon_unit:turret().pitch_neg_angle, l_3_0._weapon_unit:turret().pitch_pos_angle)
end

PlayerInStationaryWeapon.leave = function(l_4_0)
	PlayerMovementState.leave(l_4_0)
	l_4_0._player_data._in_stationary_weapon = false
	l_4_0._player_data._mounted_weapon = nil
	l_4_0._weapon_unit:base():setup(nil)
	l_4_0._weapon_unit:base():set_equiped(false)
	PlayerMountedWeaponState.leave(l_4_0)
	l_4_0._unit:look():reset_constraints()
	l_4_0._player_data.is_precision_aiming = false
end

PlayerInStationaryWeapon._link_player_to_turret = function(l_5_0)
end

PlayerInStationaryWeapon.wants_to_leave = function(l_6_0)
	local l_6_1, l_6_2 = l_6_0._input:leave_mounted_weapon, l_6_0._input
	return l_6_1(l_6_2)
end

PlayerInStationaryWeapon._update_fire_animation = function(l_7_0)
	if not l_7_0._weapon_data._firing or not PlayerInStationaryWeapon._AIM_FIRE_ANIM then
		l_7_0._current_anim = PlayerInStationaryWeapon._AIM_ANIM
	end
end

PlayerInStationaryWeapon.transition = function(l_8_0)
	local l_8_1 = l_8_0._base:check_fully_damaged()
	if l_8_1 then
		return l_8_1
	end
	if l_8_0:wants_to_leave() then
		l_8_0._unit:set_position(l_8_0._last_position)
		l_8_0._unit:play_redirect("idle_std")
		l_8_0._unit:play_redirect("exit_stationary_weapon")
		local l_8_2, l_8_3 = PlayerOnGround:new, PlayerOnGround
		local l_8_4 = l_8_0._unit
		return l_8_2(l_8_3, l_8_4)
	end
end

PlayerInStationaryWeapon.update = function(l_9_0, l_9_1, l_9_2)
	local l_9_3 = l_9_0:transition()
	if l_9_3 then
		return l_9_3
	end
	PlayerMountedWeaponState.update(l_9_0, l_9_1, l_9_2)
end

PlayerInStationaryWeapon.variable_frequency_post_update = function(l_10_0, l_10_1)
	PlayerMovementState.variable_frequency_post_update(l_10_0, l_10_1)
	l_10_0:_update_fire_animation()
	l_10_0._unit:play_redirect(l_10_0._current_anim)
	l_10_0._player_data.is_precision_aiming = l_10_0._unit:input():precision_aiming()
end

PlayerInStationaryWeapon._update_turret = function(l_11_0, l_11_1, l_11_2)
	PlayerMountedWeaponState._update_turret(l_11_0, l_11_1, l_11_2)
end


