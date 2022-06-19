local L0_0
L0_0 = WalkerDriver
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0()
end
WalkerDriver = L0_0
L0_0 = require
L0_0("units/beings/WeaponMounting/WeaponMounting")
L0_0 = require
L0_0("units/beings/WeaponMounting/WeaponMountingPointSetup")
L0_0 = require
L0_0("units/beings/WeaponLogic/WeaponLogicFactory")
function L0_0(A0_1, A1_2, A2_3)
	local L3_4, L4_5, L5_6, L6_7, L7_8, L8_9
	L3_4 = World
	L4_5 = L3_4
	L3_4 = L3_4.spawn_unit
	L3_4 = L3_4(L4_5, L5_6, L6_7, L7_8)
	L4_5 = L3_4.num_bodies
	L4_5 = L4_5(L5_6)
	for L8_9 = 0, L4_5 - 1 do
		L3_4:body(L8_9):set_enabled(false)
	end
	return L3_4
end
WalkerDriver._MAX_TURNING = 20
WalkerDriver._MAX_AIM_RIGHT = 58
WalkerDriver._MAX_AIM_LEFT = 56
WalkerDriver._MAX_ALLOWED_AIM_RIGHT = 51
WalkerDriver._MAX_ALLOWED_AIM_LEFT = 41
function WalkerDriver.init(A0_10, A1_11)
	A0_10._unit = A1_11
	A0_10._anim_machine = A0_10._unit:anim_state_machine()
	A0_10.ai = {}
	A0_10.ai.started = false
	A0_10.ai.fire = false
	A0_10.ai.suppressed = false
	A0_10.ai.next_attack_time = tweak_data.rail.walker.next_attack_time
	A0_10.ai.next_attack_time_variation = tweak_data.rail.walker.next_attack_time_variation
	A0_10.ai.attack_time = tweak_data.rail.walker.attack_time
	A0_10.ai.attack_time_variation = tweak_data.rail.walker.attack_time_variation
	A0_10._max_dispersion = tweak_data.rail.walker.max_dispersion
	A0_10._suppressed_duration = tweak_data.rail.walker.suppressed_duration
	A0_10._state = "drive"
	A0_10._last_target_update_time = 0
	A0_10:_reset_ai()
end
function WalkerDriver.update(A0_12, A1_13, A2_14, A3_15)
	if A0_12._state ~= "dead" then
		A0_12:_update_drive_animation()
		if A0_12.ai.started then
			A0_12:_update_ai(A2_14, A3_15)
		else
			A0_12:_update_pre_ai()
		end
	elseif alive(A0_12._primary_weapon) then
		A0_12:_delete_weapon()
	end
end
function WalkerDriver.vehicle_destroyed(A0_16)
	A0_16._vehicle_destroyed = true
	A0_16._extended_shoot_time = Application:time() + tweak_data.rail.walker.continue_shoot_after_deafeat
end
function WalkerDriver._update_ai(A0_17, A1_18, A2_19)
	local L3_20
	L3_20 = A0_17._vehicle_destroyed
	if L3_20 then
		L3_20 = A0_17._extended_shoot_time
		L3_20 = A1_18 < L3_20
		A0_17._can_shoot = L3_20
	else
		A0_17._can_shoot = true
	end
	L3_20 = alive
	L3_20 = L3_20(A0_17._vehicle)
	if L3_20 then
		L3_20 = A0_17.ai
		L3_20.suppressed = A0_17._vehicle:damage():get_time_since_damage() < A0_17._suppressed_duration
		L3_20 = tweak_data
		L3_20 = L3_20.rail
		L3_20 = L3_20.walker
		L3_20 = L3_20.debug_suppression
		if L3_20 then
			L3_20 = A0_17.ai
			L3_20 = L3_20.suppressed
			if L3_20 then
				L3_20 = Draw
				L3_20 = L3_20.pen
				L3_20 = L3_20(L3_20, "normal")
				L3_20:sphere(A0_17._vehicle:position(), 200)
			end
		end
	end
	L3_20 = A0_17.ai
	L3_20.target_vehicle = A0_17:_update_target()
	L3_20 = alive
	L3_20 = L3_20(A0_17.ai.target_vehicle)
	if L3_20 then
		L3_20 = A0_17.ai
		L3_20 = L3_20.next_attack_time_counter
		if L3_20 <= 0 then
			L3_20 = A0_17._state
			if L3_20 == "drive" then
				A0_17._state = "attack"
				L3_20 = A0_17._enter_attack
				L3_20(A0_17)
			end
		end
	else
		L3_20 = A0_17.ai
		L3_20.next_attack_time_counter = A0_17.ai.next_attack_time_counter - A2_19
		L3_20 = alive
		L3_20 = L3_20(A0_17._primary_weapon)
		if L3_20 then
			L3_20 = alive
			L3_20 = L3_20(A0_17.ai.target_vehicle)
			if L3_20 then
				L3_20 = A0_17._update_weapon
				L3_20(A0_17, A0_17._primary_weapon, false, A0_17.ai.target_vehicle:position(), 0, A2_19)
			end
		end
	end
	L3_20 = A0_17._state
	if L3_20 == "attack" then
		L3_20 = A0_17._last_target_update_time
		L3_20 = L3_20 + 0.3
		if A1_18 > L3_20 then
			A0_17._last_target_update_time = A1_18
			L3_20 = A0_17.ai
			L3_20 = L3_20.target_vehicle
			if L3_20 then
				L3_20 = Draw
				L3_20 = L3_20.pen
				L3_20 = L3_20(L3_20, "green")
				Application:debug("Target vehicle=", A0_17.ai.target_vehicle:name())
			else
				L3_20 = Application
				L3_20 = L3_20.debug
				L3_20(L3_20, "No Target vehicle")
			end
		end
		L3_20 = A0_17.calc_dispersion
		L3_20 = L3_20(A0_17)
		if alive(A0_17._primary_weapon) and alive(A0_17.ai.target_vehicle) then
			A0_17:_update_weapon(A0_17._primary_weapon, A0_17.ai.fire and not A0_17.ai.suppressed, A0_17.ai.target_vehicle:position(), L3_20, A2_19)
		end
		if 0 >= A0_17.ai.attack_time_counter or A0_17.ai.suppressed then
			A0_17:_update_weapon(A0_17._primary_weapon, false, A0_17._unit:position(), L3_20, A2_19)
			A0_17:_exit_attack()
			A0_17:_reset_ai()
			A0_17._state = "drive"
		else
			A0_17.ai.attack_time_counter = A0_17.ai.attack_time_counter - A2_19
		end
	end
end
function WalkerDriver._update_pre_ai(A0_21)
	local L1_22
	L1_22 = A0_21._primary_weapon
	if A0_21.ai.fire and not (L1_22:weapon_data()._bullets_in_clip == 0) then
		L1_22:weapon_data().fire_input = 1
	else
		L1_22:weapon_data().fire_input = 0
	end
	L1_22:weapon_data().aim_target_position = L1_22:get_object("fire"):position() + L1_22:get_object("fire"):rotation():y() * 100000
	L1_22:weapon_data().miss_dispersion = A0_21:calc_dispersion()
end
function WalkerDriver.calc_dispersion(A0_23)
	local L1_24
	L1_24 = 0.3
	return L1_24
end
function WalkerDriver._update_target(A0_25)
	local L1_26, L2_27, L3_28, L4_29, L5_30, L6_31, L7_32, L8_33
	L1_26 = World
	L2_27 = L1_26
	L1_26 = L1_26.find_units_quick
	L3_28 = "all"
	L8_33 = L4_29(L5_30, L6_31)
	L1_26 = L1_26(L2_27, L3_28, L4_29, L5_30, L6_31, L7_32, L8_33, L4_29(L5_30, L6_31))
	L2_27 = math
	L2_27 = L2_27.huge
	L3_28 = nil
	for L7_32, L8_33 in L4_29(L5_30) do
		if A0_25:target_pos_reachable(L8_33) then
			if L8_33:name() == "rail_vehicle_pickup" then
				if not L8_33:vehicle_data().destroyed then
					return L8_33
				end
			else
				L2_27 = A0_25:target_pos_reachable(L8_33)
				L3_28 = L7_32
			end
		end
	end
	if L3_28 then
		return L4_29
	end
end
function WalkerDriver.target_pos_reachable(A0_34, A1_35)
	local L2_36
	L2_36 = A1_35.position
	L2_36 = L2_36(A1_35)
	L2_36 = L2_36 - A0_34._unit:position()
	if Rotation(L2_36, Vector3(0, 0, 1)):roll() - A0_34._vehicle:rotation():roll() > -WalkerDriver._MAX_ALLOWED_AIM_RIGHT and Rotation(L2_36, Vector3(0, 0, 1)):roll() - A0_34._vehicle:rotation():roll() < WalkerDriver._MAX_ALLOWED_AIM_LEFT then
		return L2_36:length()
	else
		return nil
	end
end
function WalkerDriver._reset_ai(A0_37)
	local L1_38, L2_39, L3_40
	L1_38 = A0_37.ai
	L2_39 = A0_37.ai
	L2_39 = L2_39.next_attack_time
	L3_40 = A0_37.ai
	L3_40 = L3_40.next_attack_time_variation
	L3_40 = L3_40 * math.random()
	L2_39 = L2_39 + L3_40
	L1_38.next_attack_time_counter = L2_39
	L1_38 = A0_37.ai
	L2_39 = A0_37.ai
	L2_39 = L2_39.attack_time
	L3_40 = A0_37.ai
	L3_40 = L3_40.attack_time_variation
	L3_40 = L3_40 * math.random()
	L2_39 = L2_39 + L3_40
	L1_38.attack_time_counter = L2_39
end
function WalkerDriver._update_weapon(A0_41, A1_42, A2_43, A3_44, A4_45, A5_46)
	local L6_47, L7_48, L8_49, L9_50, L10_51
	L6_47 = alive
	L7_48 = A1_42
	L6_47 = L6_47(L7_48)
	if L6_47 then
		L7_48 = A1_42
		L6_47 = A1_42.weapon_data
		L6_47 = L6_47(L7_48)
		L7_48 = L6_47._bullets_in_clip
		L7_48 = L7_48 == 0
		if A2_43 and not L7_48 then
			L8_49 = A0_41._can_shoot
			if L8_49 then
				L6_47.fire_input = 1
			end
		else
			L6_47.fire_input = 0
		end
		L8_49 = Vector3
		L9_50 = 0
		L10_51 = 0
		L8_49 = L8_49(L9_50, L10_51, 75)
		L8_49 = A3_44 + L8_49
		L6_47.aim_target_position = L8_49
		L6_47.miss_dispersion = A4_45
		L8_49 = L6_47.aim_target_position
		L9_50 = A0_41._unit
		L10_51 = L9_50
		L9_50 = L9_50.position
		L9_50 = L9_50(L10_51)
		L8_49 = L8_49 - L9_50
		L9_50 = Rotation
		L10_51 = L8_49
		L9_50 = L9_50(L10_51, Vector3(0, 0, 1))
		L10_51 = L9_50
		L9_50 = L9_50.roll
		L9_50 = L9_50(L10_51)
		L10_51 = A0_41._vehicle
		L10_51 = L10_51.rotation
		L10_51 = L10_51(L10_51)
		L10_51 = L10_51.roll
		L10_51 = L10_51(L10_51)
		L9_50 = L9_50 - L10_51
		L10_51 = nil
		if L9_50 < 0 then
			L10_51 = math.clamp(L9_50, -WalkerDriver._MAX_AIM_RIGHT, WalkerDriver._MAX_AIM_LEFT) / WalkerDriver._MAX_AIM_RIGHT
		else
			L10_51 = math.clamp(L9_50, -WalkerDriver._MAX_AIM_RIGHT, WalkerDriver._MAX_AIM_LEFT) / WalkerDriver._MAX_AIM_LEFT
		end
		A0_41._anim_machine:set_global("g_yaw", L10_51)
		if L7_48 then
			A0_41.ai.attack_time_counter = 0
		end
	end
end
function WalkerDriver._update_drive_animation(A0_52)
	local L1_53, L2_54
	L1_53 = A0_52._vehicle
	if L1_53 then
		L1_53 = A0_52._turn_wheel
		L2_54 = L1_53
		L1_53 = L1_53.new_local_rotation
		L1_53 = L1_53(L2_54)
		L2_54 = L1_53
		L1_53 = L1_53.roll
		L1_53 = L1_53(L2_54)
		L2_54 = WalkerDriver
		L2_54 = L2_54._MAX_TURNING
		L2_54 = 2 * L2_54
		L2_54 = L1_53 / L2_54
		L2_54 = 0.5 - L2_54
		A0_52._anim_machine:set_parameter("driving/drive", "turn", L2_54)
	end
end
function WalkerDriver.destroy(A0_55)
	if alive(A0_55._primary_weapon) then
		World:delete_unit(A0_55._primary_weapon)
	end
end
function WalkerDriver.set_vehicle(A0_56, A1_57)
	A0_56._vehicle = A1_57
	A0_56._turn_wheel = A0_56._vehicle:get_object("at_wheel_lf")
end
function WalkerDriver.remove_driver(A0_58)
	A0_58._unit:set_slot(0)
end
function WalkerDriver._enter_attack(A0_59)
	A0_59._anim_machine:play_redirect("enter_attack")
end
function WalkerDriver._exit_attack(A0_60)
	A0_60._anim_machine:play_redirect("exit_attack")
end
function WalkerDriver._spawn_weapon(A0_61)
	local L1_62
	L1_62 = A0_61._primary_weapon_setup
	if L1_62 then
		A0_61._primary_weapon, A0_61._primary_weapon_logic = A0_61:_create_and_mount_weapon(L1_62)
		A0_61._primary_weapon:base()._max_fire_object_and_aim_angle_diff = A0_61._primary_fire_max_aim_weapon_angle_diff
	end
end
function WalkerDriver._create_and_mount_weapon(A0_63, A1_64)
	local L2_65, L3_66, L4_67, L5_68, L6_69, L7_70, L8_71
	L2_65 = A1_64.unit_name
	L3_66 = A0_63._unit
	L4_67 = _UPVALUE0_
	L5_68 = L2_65
	L7_70 = L3_66
	L6_69 = L3_66.position
	L6_69 = L6_69(L7_70)
	L8_71 = L3_66
	L7_70 = L3_66.rotation
	L8_71 = L7_70(L8_71)
	L4_67 = L4_67(L5_68, L6_69, L7_70, L8_71, L7_70(L8_71))
	L6_69 = L4_67
	L5_68 = L4_67.base
	L5_68 = L5_68(L6_69)
	L7_70 = L5_68
	L6_69 = L5_68.setup
	L8_71 = L3_66
	L6_69(L7_70, L8_71)
	L7_70 = L5_68
	L6_69 = L5_68.enable
	L8_71 = true
	L6_69(L7_70, L8_71)
	L6_69 = A1_64.mounting_point_setups
	L7_70 = WeaponMounting
	L7_70 = L7_70.mount
	L8_71 = L3_66
	L7_70(L8_71, L4_67, L6_69)
	L7_70 = A1_64.weapon_logic
	L8_71 = WeaponLogicFactory
	L8_71 = L8_71.create_weapon_logic
	L8_71 = L8_71(L7_70, L3_66, L4_67)
	L4_67:base()._projectile_spawner:base()._damage.soft = tweak_data.rail.walker.driver_damage
	L4_67:base()._projectile_spawner:base()._near_damage_threshold = 90000
	L4_67:base()._projectile_spawner:base()._far_damage_threshold = 91000
	return L4_67, L8_71
end
function WalkerDriver._delete_weapon(A0_72)
	A0_72._primary_weapon:unlink()
	World:delete_unit(A0_72._primary_weapon)
end
function WalkerDriver._enable_fire(A0_73)
	A0_73.ai.fire = true
end
function WalkerDriver._disable_fire(A0_74)
	A0_74.ai.fire = false
end
function WalkerDriver._enable_ai(A0_75)
	A0_75.ai.started = true
	A0_75._primary_weapon:weapon_data().fire_input = 0
end
function WalkerDriver._die(A0_76)
	A0_76._state = "dead"
	A0_76._primary_weapon:weapon_data().fire_input = 0
end
function WalkerDriver.debug_emul_attackpos(A0_77, A1_78)
	local L2_79, L3_80, L4_81, L5_82
	L2_79 = A0_77._vehicle
	L3_80 = L2_79
	L2_79 = L2_79.rotation
	L2_79 = L2_79(L3_80)
	L3_80 = L2_79
	L2_79 = L2_79.y
	L2_79 = L2_79(L3_80)
	L3_80 = A0_77._vehicle
	L4_81 = L3_80
	L3_80 = L3_80.position
	L3_80 = L3_80(L4_81)
	L4_81 = L2_79 * 2000
	L3_80 = L3_80 + L4_81
	L5_82 = L2_79
	L4_81 = L2_79.cross
	L4_81 = L4_81(L5_82, Vector3(0, 0, 1))
	L4_81 = L4_81 * 4500
	L4_81 = L3_80 + L4_81
	L5_82 = L2_79.cross
	L5_82 = L5_82(L2_79, Vector3(0, 0, -1))
	L5_82 = L5_82 * 4500
	L5_82 = L3_80 + L5_82
	A0_77._current_simulated_attackpos = math.lerp(L4_81, L5_82, Application:time() % 10 / 10)
	Draw:pen("red"):sphere(L4_81, 50)
	Draw:pen("red"):sphere(L5_82, 50)
	Draw:pen("red"):sphere(L3_80, 50)
	Draw:pen("red"):sphere(A0_77._current_simulated_attackpos, 10)
end
