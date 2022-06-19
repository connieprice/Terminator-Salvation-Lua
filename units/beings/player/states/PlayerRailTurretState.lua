require("units/beings/player/states/PlayerMountedWeaponState.lua")
require("shared/InterpolatorLinear")
require("shared/Angle")
if not PlayerRailTurretState then
	PlayerRailTurretState = class(PlayerMountedWeaponState)
end
local l_0_0 = PlayerRailTurretState
local l_0_1 = {}
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.INCOMING_FIRE, l_0_1 = l_0_1, {"vehicle_turn_left", "vehicle_turn_right"}
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.ACC_ANIM_THRESHOLD = 1350
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.ACC_ANIM_BLOCKED_DURATION = 4
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.IDLE_EXIT_TIME = 1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_1_0, l_1_1)
	PlayerMountedWeaponState.init(l_1_0, l_1_1, "PlayerOnRailTurret")
	l_1_0._right_hand_aim = l_1_0._machine:get_modifier("ik_right_hand_turret")
	l_1_0._left_hand_aim = l_1_0._machine:get_modifier("ik_left_hand_turret")
	l_1_0._aim_modifier = l_1_0._machine:get_modifier("ik_aim")
	l_1_0._vehicle = l_1_0._unit:rail():get_vehicle()
	l_1_0._seat = l_1_0._vehicle:base():get_seat(l_1_0._unit)
	l_1_0._current_anim = nil
	l_1_0._last_acc_time = 0
	l_1_0._last_dec_time = 0
	l_1_0._last_hit_reaction = 0
	l_1_0._last_damage = l_1_0._vehicle:damage_data().damage
end

l_0_0.init = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_2_0)
	PlayerMountedWeaponState.destroy(l_2_0)
end

l_0_0.destroy = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_3_0)
	PlayerMountedWeaponState.enter(l_3_0)
	l_3_0._vehicle = l_3_0._unit:rail():get_vehicle()
	l_3_0:set_weapon(l_3_0._vehicle:base():get_turret_unit())
	l_3_0._unit:base():set_unequiped_weapon_visiblity(false, true)
	l_3_0._current_anim = l_3_0._vehicle:base():get_seat(l_3_0._unit):get_animation()
	l_3_0._unit:play_redirect(l_3_0._current_anim)
	l_3_0._unit:look():set_eye_target_distance(100000)
	l_3_0:_next_turn(Application:time())
	l_3_0._last_acc_time = 0
	l_3_0._last_dec_time = 0
	managers.action_event:register_listener(l_3_0, l_3_0._unit, l_3_0._unit)
	l_3_0._vehicle:damage_data().no_lethal_damage = not managers.player:is_unit_human_player(l_3_0._unit)
end

l_0_0.enter = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_4_0)
	managers.action_event:unregister_listener(l_4_0)
	l_4_0._unit:base():set_unequiped_weapon_visiblity(true)
	PlayerMountedWeaponState.leave(l_4_0)
	l_4_0._unit:look():reset_eye_target_distance()
	l_4_0._vehicle = nil
end

l_0_0.leave = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_5_0)
	PlayerMountedWeaponState.let_go_off_weapon(l_5_0)
end

l_0_0.let_go_off_weapon = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_6_0)
	return l_6_0._vehicle:rotation():roll() + l_6_0._vehicle:base():get_seat(l_6_0._unit):get_rotation():roll()
end

l_0_0._get_seat_yaw = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_7_0, l_7_1)
	local l_7_2 = l_7_0._unit:player_data().named_camera_targets.enemy
	local l_7_3 = nil
	local l_7_4 = l_7_0._unit:rotation()
	if alive(l_7_2) then
		local l_7_5 = Rotation:look_at(l_7_0._unit:position(), l_7_2:position(), Vector3(0, 0, 1))
		l_7_3 = l_7_5:roll()
	else
		l_7_3 = l_7_0:_get_seat_yaw()
	end
	local l_7_6 = Rotation:look_at(l_7_0._unit:input():eye_target_position() - l_7_0._unit:position(), Vector3(0, 0, 1))
	local l_7_7 = Rotation(0, 0, l_7_3)
	local l_7_8, l_7_9 = l_7_0._unit:look():yaw_limits()
	local l_7_10, l_7_11, l_7_12, l_7_13 = l_7_0:_get_aim_constraints()
	local l_7_14 = l_7_12 + l_7_13
	if l_7_8 and l_7_9 and l_7_8 + l_7_9 > 0 then
		l_7_14 = l_7_8 + l_7_9
	end
	local l_7_15 = l_7_14 - (l_7_12 + l_7_13)
	local l_7_16 = iff
	l_7_16 = l_7_16(l_7_15 > 0, l_7_15, 0)
	l_7_15 = l_7_16
	l_7_16 = Rotation
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_3 = l_7_3 - l_7_16:roll() * l_7_15 / (l_7_14)
	l_7_7 = Rotation(0, 0, l_7_3)
	l_7_3 = l_7_4:slerp(l_7_7, tweak_data.rail.TURRET_ROTATION_SPEED)
	l_7_0._unit:set_rotation(l_7_3)
end

l_0_0._update_rotation = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_8_0, l_8_1)
	local l_8_2 = l_8_0._unit:base():weapon():weapon_data()
	local l_8_3, l_8_4 = l_8_0:get_heavy_acceleration(l_8_1)
	if l_8_3 and l_8_0._last_acc_time < l_8_1 then
		l_8_0._current_anim = "vehicle_acc"
		l_8_0._last_acc_time = l_8_1 + PlayerRailTurretState.ACC_ANIM_BLOCKED_DURATION
	elseif l_8_4 and l_8_0._last_dec_time < l_8_1 then
		l_8_0._current_anim = "vehicle_break"
		l_8_0._last_dec_time = l_8_1 + PlayerRailTurretState.ACC_ANIM_BLOCKED_DURATION
	elseif l_8_2._firing then
		l_8_0._current_anim = l_8_0._seat:get_animation() .. "_fire"
	else
		l_8_0._current_anim = l_8_0:_get_turn(l_8_1)
	if not l_8_0._current_anim then
		end
		l_8_0._current_anim = l_8_0._seat:get_animation()
	end
end

l_0_0._update_animation = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_9_0, l_9_1)
	local l_9_2 = l_9_0._vehicle:base():get_acceleration_vec()
	if l_9_2 and l_9_2 ~= 0 then
		do return end
	end
	local l_9_3 = Draw:pen()
	local l_9_4 = l_9_0._unit:position() + Vector3(0, 0, 200)
	l_9_3:set("white")
	if l_9_1 < l_9_0._last_acc_time then
		l_9_3:sphere(l_9_4, 250)
	end
	if l_9_1 < l_9_0._last_dec_time then
		l_9_3:sphere(l_9_4, 175)
	end
	local l_9_5 = l_9_0._unit:orientation_object():rotation():y()
	local l_9_6 = l_9_2:dot(l_9_5)
	local l_9_7 = l_9_6 * l_9_5
	local l_9_8 = l_9_7:length()
	if l_9_0.ACC_ANIM_THRESHOLD < l_9_8 then
		local l_9_9 = l_9_0._vehicle:orientation_object():rotation():y()
		local l_9_10 = l_9_9:angle(l_9_5)
		if l_9_10 < 35 or l_9_10 > 155 then
			if l_9_6 > 0 then
				return true, false
			end
		end
	else
		return false, true
	end
	return false, false
end

l_0_0.get_heavy_acceleration = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_10_0, l_10_1, l_10_2)
	local l_10_3 = l_10_0._base:check_fully_damaged()
	if l_10_3 then
		return l_10_3
	end
	local l_10_4 = l_10_0._unit
	local l_10_5 = l_10_4:player_data()
	if not alive(l_10_0._vehicle) or l_10_0._vehicle:vehicle_data().destroyed then
		l_10_0._right_hand_aim:set_object(l_10_0._unit:get_object("a_weapon_right_back"))
		local l_10_10 = l_10_0._left_hand_aim:set_object
		l_10_10(l_10_0._left_hand_aim, l_10_0._unit:get_object("a_weapon_left_back"))
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_10_10(l_10_10)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_10_10 then
			l_10_10(l_10_10)
		 -- DECOMPILER ERROR: Overwrote pending register.

		else
			l_10_10(l_10_4, false)
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_10_5.rail_vehicle_camera = l_10_10
		l_10_5.rail_vehicle_permanent_camera = true
		l_10_5.rail_vehicle_camera_blend_time = 2
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_10_9 = l_10_4
		l_10_10(l_10_9, "base", false)
		l_10_5.on_destroyed_rail_vehicle = true
		return 
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_10_10 then
		l_10_5.leave_rail_vehicle = nil
		l_10_0._vehicle:base():unlink_player(l_10_0._unit)
		local l_10_6, l_10_7 = PlayerOnGround:new, PlayerOnGround
		local l_10_8 = l_10_0._unit
		return l_10_6(l_10_7, l_10_8)
	end
	l_10_0:_update_animation(l_10_1)
	l_10_0:_update_rotation(l_10_2)
	if l_10_5.rail_exit_idle and not l_10_0._idle_timer then
		l_10_0._idle_timer = 0
		l_10_0._dont_update_turret_weapon = true
	elseif l_10_0._idle_timer then
		if l_10_0.IDLE_EXIT_TIME < l_10_0._idle_timer then
			l_10_0._current_anim = "exit_idle"
			l_10_5.rail_exit_idle = false
			l_10_0._dont_update_turret_weapon = false
			l_10_0._idle_timer = nil
		end
	elseif l_10_0._idle_timer > 0.1 then
		l_10_0._dont_update_turret_weapon = false
	end
	l_10_0._idle_timer = l_10_0._idle_timer + l_10_2
	l_10_0._unit:play_redirect(l_10_0._current_anim)
	l_10_0:_check_for_damage()
	PlayerMountedWeaponState.update(l_10_0, l_10_1, l_10_2)
	if l_10_0._idle_timer or l_10_5.rail_idle then
		l_10_0:_idle_aiming()
	end
end

l_0_0.update = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_11_0)
	local l_11_1 = (l_11_0._idle_timer or 0) / l_11_0.IDLE_EXIT_TIME
	local l_11_2 = l_11_0._machine:get_global("g_pitch")
	local l_11_3 = l_11_0._machine:get_global("g_yaw")
	l_11_0._machine:set_global("g_yaw", l_11_3 * l_11_1)
	l_11_0._machine:set_global("g_pitch", l_11_2 * l_11_1)
end

l_0_0._idle_aiming = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_12_0, l_12_1, l_12_2)
	if l_12_0._player_data.rail_turret_bracing then
		local l_12_3 = l_12_0._unit:input()
		local l_12_4 = l_12_3:eye_target_position()
		local l_12_5 = Rotation:look_at(l_12_0._unit:position(), l_12_4, math.UP)
		l_12_0._aim_modifier:set_target_rotation(l_12_5)
	end
	l_12_0._weapon:turret():set_traverse_angle(l_12_0._unit:rotation():roll())
	PlayerMountedWeaponState._update_turret(l_12_0, l_12_1, l_12_2)
end

l_0_0._update_turret = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_13_0, l_13_1)
	local l_13_2, l_13_3, l_13_4, l_13_5 = l_13_0:_get_aim_constraints()
	l_13_0._base:_update_aim_parameters(l_13_1, l_13_2, l_13_3, l_13_4, l_13_5, true, l_13_0._unit:control():is_ai_controlled())
end

l_0_0._update_aim_parameters = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_14_0, l_14_1)
	l_14_0._next_turn_anim_time = l_14_1 + math.rand(tweak_data.rail.MAX_TURN_ANIM_TIME - tweak_data.rail.MIN_TURN_ANIM_TIME) + tweak_data.rail.MIN_TURN_ANIM_TIME
end

l_0_0._next_turn = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_15_0, l_15_1)
	if l_15_0._next_turn_anim_time < l_15_1 then
		l_15_0:_next_turn(l_15_1)
		return l_15_0.TURN_ANIMS[math.random(1, #l_15_0.TURN_ANIMS)]
	end
	return nil
end

l_0_0._get_turn = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_16_0, l_16_1, l_16_2, l_16_3, l_16_4, l_16_5)
	l_16_0:_trigger_hit_reaction()
end

l_0_0.unit_afro_hit = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_17_0)
	local l_17_1 = l_17_0._vehicle:damage_data().damage
	if l_17_0._last_damage < l_17_1 - 1 then
		l_17_0:_trigger_hit_reaction()
		l_17_0._last_damgage = l_17_1
	end
end

l_0_0._check_for_damage = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_18_0)
	local l_18_1 = Application:time()
	if l_18_0._last_hit_reaction < l_18_1 then
		l_18_0._last_hit_reaction = l_18_1 + math.random(10)
		local l_18_2 = l_18_0.INCOMING_FIRE[math.random(1, #l_18_0.INCOMING_FIRE)]
		l_18_0._unit:play_redirect(l_18_2)
	end
end

l_0_0._trigger_hit_reaction = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_19_0, l_19_1, l_19_2)
	local l_19_3 = l_19_0._unit:rotation():y()
	local l_19_4 = l_19_0._unit:position() + Vector3(0, 0, 100)
	local l_19_5 = l_19_3 * 1000
	local l_19_6 = Rotation(0, 0, -l_19_1)
	local l_19_7 = Rotation(0, 0, l_19_2)
	local l_19_8 = l_19_5:rotate_with(l_19_6)
	local l_19_9 = l_19_5:rotate_with(l_19_7)
	local l_19_10 = l_19_4 + l_19_8
	local l_19_11 = l_19_4 + l_19_9
	local l_19_12 = Draw:pen()
	l_19_12:line(l_19_4, l_19_10)
	l_19_12:line(l_19_4, l_19_11)
end

l_0_0._draw_constraints = l_0_1

