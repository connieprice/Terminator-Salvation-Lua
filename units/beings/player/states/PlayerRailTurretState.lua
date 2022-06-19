require("units/beings/player/states/PlayerMountedWeaponState.lua")
require("shared/InterpolatorLinear")
require("shared/Angle")
PlayerRailTurretState = PlayerRailTurretState or class(PlayerMountedWeaponState)
PlayerRailTurretState.TURN_ANIMS = {
	"vehicle_turn_left",
	"vehicle_turn_right"
}
PlayerRailTurretState.INCOMING_FIRE = {
	"vehicle_incoming_fire_01",
	"vehicle_incoming_fire_02"
}
PlayerRailTurretState.ACC_ANIM_THRESHOLD = 1350
PlayerRailTurretState.ACC_ANIM_BLOCKED_DURATION = 4
PlayerRailTurretState.IDLE_EXIT_TIME = 1
function PlayerRailTurretState.init(A0_0, A1_1)
	PlayerMountedWeaponState.init(A0_0, A1_1, "PlayerOnRailTurret")
	A0_0._right_hand_aim = A0_0._machine:get_modifier("ik_right_hand_turret")
	A0_0._left_hand_aim = A0_0._machine:get_modifier("ik_left_hand_turret")
	A0_0._aim_modifier = A0_0._machine:get_modifier("ik_aim")
	A0_0._vehicle = A0_0._unit:rail():get_vehicle()
	A0_0._seat = A0_0._vehicle:base():get_seat(A0_0._unit)
	A0_0._current_anim = nil
	A0_0._last_acc_time = 0
	A0_0._last_dec_time = 0
	A0_0._last_hit_reaction = 0
	A0_0._last_damage = A0_0._vehicle:damage_data().damage
end
function PlayerRailTurretState.destroy(A0_2)
	PlayerMountedWeaponState.destroy(A0_2)
end
function PlayerRailTurretState.enter(A0_3)
	PlayerMountedWeaponState.enter(A0_3)
	A0_3._vehicle = A0_3._unit:rail():get_vehicle()
	A0_3:set_weapon(A0_3._vehicle:base():get_turret_unit())
	A0_3._unit:base():set_unequiped_weapon_visiblity(false, true)
	A0_3._current_anim = A0_3._vehicle:base():get_seat(A0_3._unit):get_animation()
	A0_3._unit:play_redirect(A0_3._current_anim)
	A0_3._unit:look():set_eye_target_distance(100000)
	A0_3:_next_turn(Application:time())
	A0_3._last_acc_time = 0
	A0_3._last_dec_time = 0
	managers.action_event:register_listener(A0_3, A0_3._unit, A0_3._unit)
	A0_3._vehicle:damage_data().no_lethal_damage = not managers.player:is_unit_human_player(A0_3._unit)
end
function PlayerRailTurretState.leave(A0_4)
	managers.action_event:unregister_listener(A0_4)
	A0_4._unit:base():set_unequiped_weapon_visiblity(true)
	PlayerMountedWeaponState.leave(A0_4)
	A0_4._unit:look():reset_eye_target_distance()
	A0_4._vehicle = nil
end
function PlayerRailTurretState.let_go_off_weapon(A0_5)
	PlayerMountedWeaponState.let_go_off_weapon(A0_5)
end
function PlayerRailTurretState._get_seat_yaw(A0_6)
	return A0_6._vehicle:rotation():roll() + A0_6._vehicle:base():get_seat(A0_6._unit):get_rotation():roll()
end
function PlayerRailTurretState._update_rotation(A0_7, A1_8)
	local L2_9, L3_10, L4_11, L5_12, L6_13, L7_14, L8_15, L9_16, L10_17, L11_18, L12_19, L13_20, L14_21
	L2_9 = A0_7._unit
	L3_10 = L2_9
	L2_9 = L2_9.player_data
	L2_9 = L2_9(L3_10)
	L2_9 = L2_9.named_camera_targets
	L2_9 = L2_9.enemy
	L3_10 = nil
	L4_11 = A0_7._unit
	L5_12 = L4_11
	L4_11 = L4_11.rotation
	L4_11 = L4_11(L5_12)
	L5_12 = alive
	L6_13 = L2_9
	L5_12 = L5_12(L6_13)
	if L5_12 then
		L5_12 = Rotation
		L6_13 = L5_12
		L5_12 = L5_12.look_at
		L7_14 = A0_7._unit
		L8_15 = L7_14
		L7_14 = L7_14.position
		L7_14 = L7_14(L8_15)
		L9_16 = L2_9
		L8_15 = L2_9.position
		L8_15 = L8_15(L9_16)
		L9_16 = Vector3
		L10_17 = 0
		L11_18 = 0
		L12_19 = 1
		L14_21 = L9_16(L10_17, L11_18, L12_19)
		L5_12 = L5_12(L6_13, L7_14, L8_15, L9_16, L10_17, L11_18, L12_19, L13_20, L14_21, L9_16(L10_17, L11_18, L12_19))
		L7_14 = L5_12
		L6_13 = L5_12.roll
		L6_13 = L6_13(L7_14)
		L3_10 = L6_13
	else
		L6_13 = A0_7
		L5_12 = A0_7._get_seat_yaw
		L5_12 = L5_12(L6_13)
		L3_10 = L5_12
	end
	L5_12 = Rotation
	L6_13 = L5_12
	L5_12 = L5_12.look_at
	L7_14 = A0_7._unit
	L8_15 = L7_14
	L7_14 = L7_14.input
	L7_14 = L7_14(L8_15)
	L8_15 = L7_14
	L7_14 = L7_14.eye_target_position
	L7_14 = L7_14(L8_15)
	L8_15 = A0_7._unit
	L9_16 = L8_15
	L8_15 = L8_15.position
	L8_15 = L8_15(L9_16)
	L7_14 = L7_14 - L8_15
	L8_15 = Vector3
	L9_16 = 0
	L10_17 = 0
	L11_18 = 1
	L14_21 = L8_15(L9_16, L10_17, L11_18)
	L5_12 = L5_12(L6_13, L7_14, L8_15, L9_16, L10_17, L11_18, L12_19, L13_20, L14_21, L8_15(L9_16, L10_17, L11_18))
	L6_13 = Rotation
	L7_14 = 0
	L8_15 = 0
	L9_16 = L3_10
	L6_13 = L6_13(L7_14, L8_15, L9_16)
	L7_14 = A0_7._unit
	L8_15 = L7_14
	L7_14 = L7_14.look
	L7_14 = L7_14(L8_15)
	L8_15 = L7_14
	L7_14 = L7_14.yaw_limits
	L8_15 = L7_14(L8_15)
	L10_17 = A0_7
	L9_16 = A0_7._get_aim_constraints
	L12_19 = L9_16(L10_17)
	L13_20 = L11_18 + L12_19
	if L7_14 and L8_15 then
		L14_21 = L7_14 + L8_15
		if L14_21 > 0 then
			L13_20 = L7_14 + L8_15
		end
	end
	L14_21 = L11_18 + L12_19
	L14_21 = L13_20 - L14_21
	L14_21 = iff(L14_21 > 0, L14_21, 0)
	L3_10 = L3_10 - Rotation:rotation_difference(L5_12, L6_13):roll() * L14_21 / L13_20
	L6_13 = Rotation(0, 0, L3_10)
	L3_10 = L4_11:slerp(L6_13, tweak_data.rail.TURRET_ROTATION_SPEED)
	A0_7._unit:set_rotation(L3_10)
end
function PlayerRailTurretState._update_animation(A0_22, A1_23)
	if A0_22:get_heavy_acceleration(A1_23) and A1_23 > A0_22._last_acc_time then
		A0_22._current_anim = "vehicle_acc"
		A0_22._last_acc_time = A1_23 + PlayerRailTurretState.ACC_ANIM_BLOCKED_DURATION
	elseif A0_22:get_heavy_acceleration(A1_23) and A1_23 > A0_22._last_dec_time then
		A0_22._current_anim = "vehicle_break"
		A0_22._last_dec_time = A1_23 + PlayerRailTurretState.ACC_ANIM_BLOCKED_DURATION
	elseif A0_22._unit:base():weapon():weapon_data()._firing then
		A0_22._current_anim = A0_22._seat:get_animation() .. "_fire"
	else
		A0_22._current_anim = A0_22:_get_turn(A1_23)
		if not A0_22._current_anim then
			A0_22._current_anim = A0_22._seat:get_animation()
		end
	end
end
function PlayerRailTurretState.get_heavy_acceleration(A0_24, A1_25)
	local L2_26, L3_27, L4_28
	L2_26 = A0_24._vehicle
	L3_27 = L2_26
	L2_26 = L2_26.base
	L2_26 = L2_26(L3_27)
	L3_27 = L2_26
	L2_26 = L2_26.get_acceleration_vec
	L2_26 = L2_26(L3_27)
	if L2_26 and L2_26 ~= 0 then
		do break end
		L3_27 = Draw
		L4_28 = L3_27
		L3_27 = L3_27.pen
		L3_27 = L3_27(L4_28)
		L4_28 = A0_24._unit
		L4_28 = L4_28.position
		L4_28 = L4_28(L4_28)
		L4_28 = L4_28 + Vector3(0, 0, 200)
		L3_27:set("white")
		if A1_25 < A0_24._last_acc_time then
			L3_27:sphere(L4_28, 250)
		end
		if A1_25 < A0_24._last_dec_time then
			L3_27:sphere(L4_28, 175)
		end
		L3_27 = A0_24._unit
		L4_28 = L3_27
		L3_27 = L3_27.orientation_object
		L3_27 = L3_27(L4_28)
		L4_28 = L3_27
		L3_27 = L3_27.rotation
		L3_27 = L3_27(L4_28)
		L4_28 = L3_27
		L3_27 = L3_27.y
		L3_27 = L3_27(L4_28)
		L4_28 = L2_26.dot
		L4_28 = L4_28(L2_26, L3_27)
		if (L4_28 * L3_27):length() > A0_24.ACC_ANIM_THRESHOLD and (A0_24._vehicle:orientation_object():rotation():y():angle(L3_27) < 35 or A0_24._vehicle:orientation_object():rotation():y():angle(L3_27) > 155) then
			if L4_28 > 0 then
				return true, false
			else
				return false, true
			end
		end
	end
	L3_27 = false
	L4_28 = false
	return L3_27, L4_28
end
function PlayerRailTurretState.update(A0_29, A1_30, A2_31)
	if A0_29._base:check_fully_damaged() then
		return (A0_29._base:check_fully_damaged())
	end
	if not alive(A0_29._vehicle) or A0_29._vehicle:vehicle_data().destroyed then
		A0_29._right_hand_aim:set_object(A0_29._unit:get_object("a_weapon_right_back"))
		A0_29._left_hand_aim:set_object(A0_29._unit:get_object("a_weapon_left_back"))
		A0_29._unit:rail():exit_vehicle()
		if tweak_data.rail.USE_RAGDOLLS then
			A0_29._unit:base():ragdoll()
		else
			A0_29._unit:set_visible(false)
		end
		A0_29._unit:player_data().rail_vehicle_camera = A0_29._vehicle:vehicle_data().death_camera
		A0_29._unit:player_data().rail_vehicle_permanent_camera = true
		A0_29._unit:player_data().rail_vehicle_camera_blend_time = 2
		A0_29._unit:set_extension_update_enabled("base", false)
		A0_29._unit:player_data().on_destroyed_rail_vehicle = true
		return
	end
	if A0_29._unit:player_data().leave_rail_vehicle then
		A0_29._unit:player_data().leave_rail_vehicle = nil
		A0_29._vehicle:base():unlink_player(A0_29._unit)
		return PlayerOnGround:new(A0_29._unit)
	end
	A0_29:_update_animation(A1_30)
	A0_29:_update_rotation(A2_31)
	if A0_29._unit:player_data().rail_exit_idle and not A0_29._idle_timer then
		A0_29._idle_timer = 0
		A0_29._dont_update_turret_weapon = true
	elseif A0_29._idle_timer then
		if A0_29._idle_timer > A0_29.IDLE_EXIT_TIME then
			A0_29._current_anim = "exit_idle"
			A0_29._unit:player_data().rail_exit_idle = false
			A0_29._dont_update_turret_weapon = false
			A0_29._idle_timer = nil
		else
			if A0_29._idle_timer > 0.1 then
				A0_29._dont_update_turret_weapon = false
			end
			A0_29._idle_timer = A0_29._idle_timer + A2_31
		end
	end
	A0_29._unit:play_redirect(A0_29._current_anim)
	A0_29:_check_for_damage()
	PlayerMountedWeaponState.update(A0_29, A1_30, A2_31)
	if A0_29._idle_timer or A0_29._unit:player_data().rail_idle then
		A0_29:_idle_aiming()
	end
end
function PlayerRailTurretState._idle_aiming(A0_32)
	local L1_33
	L1_33 = A0_32._idle_timer
	L1_33 = L1_33 or 0
	L1_33 = L1_33 / A0_32.IDLE_EXIT_TIME
	A0_32._machine:set_global("g_yaw", A0_32._machine:get_global("g_yaw") * L1_33)
	A0_32._machine:set_global("g_pitch", A0_32._machine:get_global("g_pitch") * L1_33)
end
function PlayerRailTurretState._update_turret(A0_34, A1_35, A2_36)
	local L3_37, L4_38, L5_39
	L3_37 = A0_34._player_data
	L3_37 = L3_37.rail_turret_bracing
	if L3_37 then
		L3_37 = A0_34._unit
		L4_38 = L3_37
		L3_37 = L3_37.input
		L3_37 = L3_37(L4_38)
		L5_39 = L3_37
		L4_38 = L3_37.eye_target_position
		L4_38 = L4_38(L5_39)
		L5_39 = Rotation
		L5_39 = L5_39.look_at
		L5_39 = L5_39(L5_39, A0_34._unit:position(), L4_38, math.UP)
		A0_34._aim_modifier:set_target_rotation(L5_39)
	end
	L3_37 = A0_34._weapon
	L4_38 = L3_37
	L3_37 = L3_37.turret
	L3_37 = L3_37(L4_38)
	L4_38 = L3_37
	L3_37 = L3_37.set_traverse_angle
	L5_39 = A0_34._unit
	L5_39 = L5_39.rotation
	L5_39 = L5_39(L5_39)
	L5_39 = L5_39.roll
	L5_39 = L5_39(L5_39)
	L3_37(L4_38, L5_39, L5_39(L5_39))
	L3_37 = PlayerMountedWeaponState
	L3_37 = L3_37._update_turret
	L4_38 = A0_34
	L5_39 = A1_35
	L3_37(L4_38, L5_39, A2_36)
end
function PlayerRailTurretState._update_aim_parameters(A0_40, A1_41)
	local L2_42, L3_43, L4_44, L5_45, L6_46, L7_47, L8_48, L9_49
	L3_43 = A0_40
	L2_42 = A0_40._get_aim_constraints
	L5_45 = L2_42(L3_43)
	L6_46 = A0_40._base
	L7_47 = L6_46
	L6_46 = L6_46._update_aim_parameters
	L8_48 = A1_41
	L9_49 = L2_42
	L6_46(L7_47, L8_48, L9_49, L3_43, L4_44, L5_45, true, A0_40._unit:control():is_ai_controlled())
end
function PlayerRailTurretState._next_turn(A0_50, A1_51)
	A0_50._next_turn_anim_time = A1_51 + math.rand(tweak_data.rail.MAX_TURN_ANIM_TIME - tweak_data.rail.MIN_TURN_ANIM_TIME) + tweak_data.rail.MIN_TURN_ANIM_TIME
end
function PlayerRailTurretState._get_turn(A0_52, A1_53)
	if A1_53 > A0_52._next_turn_anim_time then
		A0_52:_next_turn(A1_53)
		return A0_52.TURN_ANIMS[math.random(1, #A0_52.TURN_ANIMS)]
	end
	return nil
end
function PlayerRailTurretState.unit_afro_hit(A0_54, A1_55, A2_56, A3_57, A4_58, A5_59)
	A0_54:_trigger_hit_reaction()
end
function PlayerRailTurretState._check_for_damage(A0_60)
	if A0_60._vehicle:damage_data().damage - 1 > A0_60._last_damage then
		A0_60:_trigger_hit_reaction()
		A0_60._last_damgage = A0_60._vehicle:damage_data().damage
	end
end
function PlayerRailTurretState._trigger_hit_reaction(A0_61)
	local L1_62, L2_63
	L1_62 = Application
	L2_63 = L1_62
	L1_62 = L1_62.time
	L1_62 = L1_62(L2_63)
	L2_63 = A0_61._last_hit_reaction
	if L1_62 > L2_63 then
		L2_63 = math
		L2_63 = L2_63.random
		L2_63 = L2_63(10)
		L2_63 = L1_62 + L2_63
		A0_61._last_hit_reaction = L2_63
		L2_63 = A0_61.INCOMING_FIRE
		L2_63 = L2_63[math.random(1, #A0_61.INCOMING_FIRE)]
		A0_61._unit:play_redirect(L2_63)
	end
end
function PlayerRailTurretState._draw_constraints(A0_64, A1_65, A2_66)
	local L3_67, L4_68, L5_69, L6_70, L7_71, L8_72, L9_73, L10_74, L11_75
	L3_67 = A0_64._unit
	L4_68 = L3_67
	L3_67 = L3_67.rotation
	L3_67 = L3_67(L4_68)
	L4_68 = L3_67
	L3_67 = L3_67.y
	L3_67 = L3_67(L4_68)
	L4_68 = A0_64._unit
	L5_69 = L4_68
	L4_68 = L4_68.position
	L4_68 = L4_68(L5_69)
	L5_69 = Vector3
	L6_70 = 0
	L7_71 = 0
	L8_72 = 100
	L5_69 = L5_69(L6_70, L7_71, L8_72)
	L4_68 = L4_68 + L5_69
	L5_69 = L3_67 * 1000
	L6_70 = Rotation
	L7_71 = 0
	L8_72 = 0
	L9_73 = -A1_65
	L6_70 = L6_70(L7_71, L8_72, L9_73)
	L7_71 = Rotation
	L8_72 = 0
	L9_73 = 0
	L10_74 = A2_66
	L7_71 = L7_71(L8_72, L9_73, L10_74)
	L9_73 = L5_69
	L8_72 = L5_69.rotate_with
	L10_74 = L6_70
	L8_72 = L8_72(L9_73, L10_74)
	L10_74 = L5_69
	L9_73 = L5_69.rotate_with
	L11_75 = L7_71
	L9_73 = L9_73(L10_74, L11_75)
	L10_74 = L4_68 + L8_72
	L11_75 = L4_68 + L9_73
	Draw:pen():line(L4_68, L10_74)
	Draw:pen():line(L4_68, L11_75)
end
