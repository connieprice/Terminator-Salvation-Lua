if not WalkerDriver then
	WalkerDriver = class()
end
require("units/beings/WeaponMounting/WeaponMounting")
require("units/beings/WeaponMounting/WeaponMountingPointSetup")
require("units/beings/WeaponLogic/WeaponLogicFactory")
local l_0_0 = function(l_1_0, l_1_1, l_1_2)
	local l_1_3 = World:spawn_unit(l_1_0, l_1_1, l_1_2)
	local l_1_4 = l_1_3:num_bodies()
	for l_1_8 = 0, l_1_4 - 1 do
		local l_1_9 = l_1_3:body(l_1_8)
		l_1_9:set_enabled(false)
	end
	return l_1_3
end

WalkerDriver._MAX_TURNING = 20
WalkerDriver._MAX_AIM_RIGHT = 58
WalkerDriver._MAX_AIM_LEFT = 56
WalkerDriver._MAX_ALLOWED_AIM_RIGHT = 51
WalkerDriver._MAX_ALLOWED_AIM_LEFT = 41
WalkerDriver.init = function(l_2_0, l_2_1)
	l_2_0._unit = l_2_1
	l_2_0._anim_machine = l_2_0._unit:anim_state_machine()
	l_2_0.ai = {}
	l_2_0.ai.started = false
	l_2_0.ai.fire = false
	l_2_0.ai.suppressed = false
	l_2_0.ai.next_attack_time = tweak_data.rail.walker.next_attack_time
	l_2_0.ai.next_attack_time_variation = tweak_data.rail.walker.next_attack_time_variation
	l_2_0.ai.attack_time = tweak_data.rail.walker.attack_time
	l_2_0.ai.attack_time_variation = tweak_data.rail.walker.attack_time_variation
	l_2_0._max_dispersion = tweak_data.rail.walker.max_dispersion
	l_2_0._suppressed_duration = tweak_data.rail.walker.suppressed_duration
	l_2_0._state = "drive"
	l_2_0._last_target_update_time = 0
	l_2_0:_reset_ai()
end

WalkerDriver.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	if l_3_0._state ~= "dead" then
		l_3_0:_update_drive_animation()
		if l_3_0.ai.started then
			l_3_0:_update_ai(l_3_2, l_3_3)
		else
			l_3_0:_update_pre_ai()
		end
	else
		if alive(l_3_0._primary_weapon) then
			l_3_0:_delete_weapon()
		end
	end
end

WalkerDriver.vehicle_destroyed = function(l_4_0)
	l_4_0._vehicle_destroyed = true
	l_4_0._extended_shoot_time = Application:time() + tweak_data.rail.walker.continue_shoot_after_deafeat
end

WalkerDriver._update_ai = function(l_5_0, l_5_1, l_5_2)
	if l_5_1 >= l_5_0._extended_shoot_time then
		l_5_0._can_shoot = not l_5_0._vehicle_destroyed
		do return end
		l_5_0._can_shoot = true
		if alive(l_5_0._vehicle) then
			local l_5_5 = l_5_0.ai
			l_5_5.suppressed = l_5_0._vehicle:damage():get_time_since_damage() < l_5_0._suppressed_duration
			l_5_5 = tweak_data
			l_5_5 = l_5_5.rail
			l_5_5 = l_5_5.walker
			l_5_5 = l_5_5.debug_suppression
		if l_5_5 then
			end
			l_5_5 = l_5_0.ai
			l_5_5 = l_5_5.suppressed
		if l_5_5 then
			end
			l_5_5 = Draw
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_5_5:sphere(l_5_0._vehicle:position(), 200)
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_5_5.target_vehicle = l_5_0:_update_target()
		if alive(l_5_0.ai.target_vehicle) and l_5_0.ai.next_attack_time_counter <= 0 and l_5_0._state == "drive" then
			l_5_0._state = "attack"
			l_5_0:_enter_attack()
		else
			l_5_0.ai.next_attack_time_counter = l_5_0.ai.next_attack_time_counter - l_5_2
		if alive(l_5_0._primary_weapon) then
			end
		if alive(l_5_0.ai.target_vehicle) then
			end
			l_5_0:_update_weapon(l_5_0._primary_weapon, false, l_5_0.ai.target_vehicle:position(), 0, l_5_2)
		end
		if l_5_0._state == "attack" then
			if l_5_0._last_target_update_time + 0.3 < l_5_1 then
				l_5_0._last_target_update_time = l_5_1
				if l_5_0.ai.target_vehicle then
					local l_5_8 = Draw:pen("green")
					Application:debug("Target vehicle=", l_5_0.ai.target_vehicle:name())
				end
			else
				Application:debug("No Target vehicle")
			end
			local l_5_9 = l_5_0:calc_dispersion()
			if alive(l_5_0._primary_weapon) and alive(l_5_0.ai.target_vehicle) then
				if l_5_0.ai.fire then
					l_5_0:_update_weapon(l_5_0._primary_weapon, not l_5_0.ai.suppressed, l_5_0.ai.target_vehicle:position(), l_5_9, l_5_2)
				end
				if l_5_0.ai.attack_time_counter <= 0 or l_5_0.ai.suppressed then
					l_5_0:_update_weapon(l_5_0._primary_weapon, false, l_5_0._unit:position(), l_5_9, l_5_2)
					l_5_0:_exit_attack()
					l_5_0:_reset_ai()
					l_5_0._state = "drive"
				end
			else
				l_5_0.ai.attack_time_counter = l_5_0.ai.attack_time_counter - l_5_2
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 8 147 
end

WalkerDriver._update_pre_ai = function(l_6_0)
	local l_6_1 = l_6_0._primary_weapon
	local l_6_2 = l_6_1:get_object("fire")
	local l_6_3 = l_6_1:weapon_data()
	if l_6_0.ai.fire and not l_6_3._bullets_in_clip == 0 then
		l_6_3.fire_input = 1
	else
		l_6_3.fire_input = 0
	end
	local l_6_8 = nil
	l_6_3.aim_target_position = l_6_2:position() + l_6_2:rotation():y() * 100000
	l_6_3.miss_dispersion = l_6_0:calc_dispersion()
end

WalkerDriver.calc_dispersion = function(l_7_0)
	return 0.3
end

WalkerDriver._update_target = function(l_8_0)
	local l_8_7, l_8_8 = World:find_units_quick, World
	l_8_7 = l_8_7(l_8_8, "all", managers.slot:get_mask("rail_vehicles"))
	local l_8_1 = nil
	l_8_8 = math
	l_8_8 = l_8_8.huge
	local l_8_2 = nil
	l_8_1 = nil
	local l_8_3 = nil
	l_8_2 = pairs
	l_8_3 = l_8_7
	l_8_2 = l_8_2(l_8_3)
	for i_0,i_1 in l_8_2 do
		local l_8_9 = l_8_0:target_pos_reachable(l_8_6)
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if l_8_9 and l_8_6:name() == "rail_vehicle_pickup" and not l_8_6:vehicle_data().destroyed then
			return l_8_6
		end
		for l_8_5,l_8_6 in l_8_2 do
			l_8_8 = l_8_9
			l_8_1 = l_8_5
		end
		if l_8_1 then
			return l_8_7[l_8_1]
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

WalkerDriver.target_pos_reachable = function(l_9_0, l_9_1)
	local l_9_2 = l_9_1:position() - l_9_0._unit:position()
	local l_9_6, l_9_7, l_9_8 = Rotation, l_9_2, Vector3(0, 0, 1)
	l_9_6 = l_9_6(l_9_7, l_9_8)
	l_9_6, l_9_7 = l_9_6:roll, l_9_6
	l_9_6 = l_9_6(l_9_7)
	l_9_7 = l_9_0._vehicle
	l_9_7, l_9_8 = l_9_7:rotation, l_9_7
	l_9_7 = l_9_7(l_9_8)
	l_9_7, l_9_8 = l_9_7:roll, l_9_7
	l_9_7 = l_9_7(l_9_8)
	l_9_6 = l_9_6 - l_9_7
	local l_9_3 = nil
	l_9_7 = WalkerDriver
	l_9_7 = l_9_7._MAX_ALLOWED_AIM_RIGHT
	l_9_7 = -l_9_7
	if l_9_7 < l_9_6 then
		l_9_7 = WalkerDriver
		l_9_7 = l_9_7._MAX_ALLOWED_AIM_LEFT
	if l_9_6 < l_9_7 then
		end
		l_9_7, l_9_8 = l_9_2:length, l_9_2
		local l_9_4, l_9_5 = nil
		return l_9_7(l_9_8)
	else
		l_9_7 = nil
		return l_9_7
	end
end

WalkerDriver._reset_ai = function(l_10_0)
	l_10_0.ai.next_attack_time_counter = l_10_0.ai.next_attack_time + l_10_0.ai.next_attack_time_variation * math.random()
	l_10_0.ai.attack_time_counter = l_10_0.ai.attack_time + l_10_0.ai.attack_time_variation * math.random()
end

WalkerDriver._update_weapon = function(l_11_0, l_11_1, l_11_2, l_11_3, l_11_4, l_11_5)
	if alive(l_11_1) then
		local l_11_6 = l_11_1:weapon_data()
		if l_11_2 and not l_11_6._bullets_in_clip == 0 and l_11_0._can_shoot then
			l_11_6.fire_input = 1
		else
			l_11_6.fire_input = 0
		end
		l_11_6.aim_target_position = l_11_3 + Vector3(0, 0, 75)
		l_11_6.miss_dispersion = l_11_4
		local l_11_11 = nil
		local l_11_12 = nil
		local l_11_13 = Rotation(l_11_6.aim_target_position - l_11_0._unit:position(), Vector3(0, 0, 1)):roll() - l_11_0._vehicle:rotation():roll()
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_11_13 < 0 then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_11_0._anim_machine:set_global("g_yaw", nil)
	if l_11_11 then
		end
		l_11_0.ai.attack_time_counter = 0
	end
end

WalkerDriver._update_drive_animation = function(l_12_0)
	if l_12_0._vehicle then
		local l_12_1 = l_12_0._turn_wheel:new_local_rotation():roll()
		local l_12_2 = 0.5 - l_12_1 / (2 * WalkerDriver._MAX_TURNING)
		l_12_0._anim_machine:set_parameter("driving/drive", "turn", l_12_2)
	end
end

WalkerDriver.destroy = function(l_13_0)
	if alive(l_13_0._primary_weapon) then
		World:delete_unit(l_13_0._primary_weapon)
	end
end

WalkerDriver.set_vehicle = function(l_14_0, l_14_1)
	l_14_0._vehicle = l_14_1
	l_14_0._turn_wheel = l_14_0._vehicle:get_object("at_wheel_lf")
end

WalkerDriver.remove_driver = function(l_15_0)
	l_15_0._unit:set_slot(0)
end

WalkerDriver._enter_attack = function(l_16_0)
	l_16_0._anim_machine:play_redirect("enter_attack")
end

WalkerDriver._exit_attack = function(l_17_0)
	l_17_0._anim_machine:play_redirect("exit_attack")
end

WalkerDriver._spawn_weapon = function(l_18_0)
	local l_18_1 = l_18_0._primary_weapon_setup
	if l_18_1 then
		local l_18_2 = l_18_0:_create_and_mount_weapon(l_18_1)
		l_18_0._primary_weapon_logic = l_18_0
		l_18_0._primary_weapon = l_18_2
		l_18_2 = l_18_0._primary_weapon
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_18_2._max_fire_object_and_aim_angle_diff = l_18_0._primary_fire_max_aim_weapon_angle_diff
	end
end

WalkerDriver._create_and_mount_weapon = function(l_19_0, l_19_1)
	-- upvalues: l_0_0
	local l_19_2 = l_19_1.unit_name
	local l_19_3 = l_19_0._unit
	local l_19_4 = l_0_0(l_19_2, l_19_3:position(), l_19_3:rotation())
	local l_19_5 = l_19_4:base()
	l_19_5:setup(l_19_3)
	l_19_5:enable(true)
	local l_19_6 = l_19_1.mounting_point_setups
	WeaponMounting.mount(l_19_3, l_19_4, l_19_6)
	local l_19_7 = l_19_1.weapon_logic
	local l_19_8 = WeaponLogicFactory.create_weapon_logic(l_19_7, l_19_3, l_19_4)
	l_19_4:base()._projectile_spawner:base()._damage.soft = tweak_data.rail.walker.driver_damage
	l_19_4:base()._projectile_spawner:base()._near_damage_threshold = 90000
	l_19_4:base()._projectile_spawner:base()._far_damage_threshold = 91000
	return l_19_4, l_19_8
end

WalkerDriver._delete_weapon = function(l_20_0)
	l_20_0._primary_weapon:unlink()
	World:delete_unit(l_20_0._primary_weapon)
end

WalkerDriver._enable_fire = function(l_21_0)
	l_21_0.ai.fire = true
end

WalkerDriver._disable_fire = function(l_22_0)
	l_22_0.ai.fire = false
end

WalkerDriver._enable_ai = function(l_23_0)
	l_23_0.ai.started = true
	l_23_0._primary_weapon:weapon_data().fire_input = 0
end

WalkerDriver._die = function(l_24_0)
	l_24_0._state = "dead"
	l_24_0._primary_weapon:weapon_data().fire_input = 0
end

WalkerDriver.debug_emul_attackpos = function(l_25_0, l_25_1)
	local l_25_2 = l_25_0._vehicle:rotation():y()
	local l_25_3 = l_25_0._vehicle:position() + l_25_2 * 2000
	local l_25_4 = l_25_3 + l_25_2:cross(Vector3(0, 0, 1)) * 4500
	local l_25_5 = l_25_3 + l_25_2:cross(Vector3(0, 0, -1)) * 4500
	local l_25_6 = 10
	l_25_0._current_simulated_attackpos = math.lerp(l_25_4, l_25_5, Application:time() % l_25_6 / l_25_6)
	local l_25_7 = Draw:pen("red")
	l_25_7:sphere(l_25_4, 50)
	l_25_7:sphere(l_25_5, 50)
	l_25_7:sphere(l_25_3, 50)
	l_25_7:sphere(l_25_0._current_simulated_attackpos, 10)
end


