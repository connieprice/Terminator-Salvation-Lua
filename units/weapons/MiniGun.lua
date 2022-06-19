require("units/weapons/PlayerBaseWeapon")
require("shared/VectorUtilities")
if not MiniGun then
	MiniGun = class(PlayerBaseWeapon)
end
MiniGun.init = function(l_1_0, l_1_1)
	PlayerBaseWeapon.init(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._enabled = false
	l_1_0._obj_fire = l_1_0._unit:get_object("fire")
	l_1_0._fire_sound_instance = nil
	local l_1_2 = "fire"
	l_1_0._fire_sound_instance = nil
	local l_1_3 = WeaponUtilities.sound_objects(l_1_0._unit, l_1_0._sound_prefix, l_1_0._sound_variant, l_1_0._sound_bank, l_1_0._is_once_sound, l_1_2)
	l_1_0._fire_end_sound_object = l_1_0._unit
	l_1_0._fire_sound_object = l_1_3
	l_1_3 = l_1_0._projectile_spawner_class
	if l_1_3 then
		l_1_3 = l_1_0._projectile_spawner_class
	if l_1_3 ~= "" then
		end
		l_1_3 = World
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_1_0._projectile_spawner = l_1_3
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_1_3(l_1_3, "fire", l_1_0._projectile_spawner, l_1_0._projectile_spawner:orientation_object():name())
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_1_3 and l_1_3 ~= "" then
		l_1_0._projectile_spawner_alt = l_1_3
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_1_3(l_1_3, "fire", l_1_0._projectile_spawner_alt, l_1_0._projectile_spawner_alt:orientation_object():name())
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if not l_1_3 then
		l_1_3(l_1_3, "MINIGUN_SHOOT", managers.sensory_events.source_types.MACHINE_WEAPON_ID, l_1_0._shoot_event_visible_range, l_1_0._shoot_event_sound_level, l_1_0._shoot_event_sound_level_reference_distance)
	end
	l_1_0._fire_sensory_event_handle = nil
	l_1_0._rpm = 0
	l_1_0._rpm_increase = 0
	l_1_0._rpm_decrease = 0
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_3(l_1_0)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._rotation_object = l_1_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_3(l_1_0._rotation_object, l_1_0._rotation_object_name)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._rotation_object_initial_local_rotation = l_1_3
	l_1_0._rotation_object_angle = 0
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._event_emitter = l_1_3
end

MiniGun._setup_sounds = function(l_2_0)
	local l_2_1 = l_2_0._unit:get_object(l_2_0._sound_output_object_name)
	assert(l_2_1, l_2_0._sound_output_object_name)
	if l_2_0._rpm_up_sound_cue_name and l_2_0._rpm_up_sound_cue_name ~= "" then
		l_2_0._rpm_up_sound = Sound:make_bank(l_2_0._soundbank_name, l_2_0._rpm_up_sound_cue_name)
		assert(l_2_0._rpm_up_sound, l_2_0._rpm_up_sound_cue_name)
		l_2_0._rpm_up_sound:set_output(l_2_1)
	end
	if l_2_0._rpm_down_sound_cue_name and l_2_0._rpm_down_sound_cue_name ~= "" then
		l_2_0._rpm_down_sound = Sound:make_bank(l_2_0._soundbank_name, l_2_0._rpm_down_sound_cue_name)
		assert(l_2_0._rpm_down_sound, l_2_0._rpm_down_sound_cue_name)
		l_2_0._rpm_down_sound:set_output(l_2_1)
	end
end

MiniGun.destroy = function(l_3_0)
	managers.sensory_events:destroy_continuous_event_handle(l_3_0._fire_sensory_event_handle)
	l_3_0._unit = nil
	if alive(l_3_0._projectile_spawner) then
		l_3_0._projectile_spawner:set_slot(0)
	end
	l_3_0._projectile_spawner = nil
	if alive(l_3_0._projectile_spawner_alt) then
		l_3_0._projectile_spawner_alt:set_slot(0)
	end
	l_3_0._projectile_spawner_alt = nil
	if l_3_0._fire_sound_object and l_3_0._fire_sound_object:is_playing() then
		l_3_0._fire_sound_object:stop()
	end
	l_3_0:_stop_sounds()
end

local l_0_0 = function(l_4_0)
	if l_4_0 and l_4_0:is_playing() then
		l_4_0:stop()
	end
end

MiniGun._stop_sounds = function(l_5_0)
	-- upvalues: l_0_0
	local l_5_5, l_5_6, l_5_7, l_5_8 = nil
	local l_5_1 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0,i_1 in l_5_0._fire_sound_instance(l_5_0._rpm_up_sound_instance) do
		l_0_0(i_1)
	end
end

MiniGun.setup = function(l_6_0, l_6_1)
	PlayerBaseWeapon.setup(l_6_0, l_6_1)
end

MiniGun.enable = function(l_7_0)
	l_7_0:set_enabled(true)
end

MiniGun.disable = function(l_8_0)
	l_8_0:set_enabled(false)
end

MiniGun.update = function(l_9_0, l_9_1, l_9_2, l_9_3)
	do
		local l_9_4 = l_9_0._wdata
		if l_9_4.fire_trigger_threshold > l_9_4.fire_input then
			local l_9_5 = l_9_4.prepare_fire
			l_9_5 = l_9_5
			do
				local l_9_6, l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_12, l_9_13, l_9_14, l_9_15 = nil
			end
			if l_9_5 then
				if not l_9_0._should_fire then
					l_9_0:_start_rpm_increase()
				end
				l_9_0._rpm_decrease = 0
				if l_9_0._rpm < l_9_0._fire_rpm then
					l_9_0._rpm_increase = l_9_0._rpm_increase + l_9_3 * l_9_0._rpm_acceleration
					l_9_0._rpm = l_9_0._rpm + l_9_3 * l_9_0._rpm_increase
				end
				if l_9_0._fire_rpm <= l_9_0._rpm then
					l_9_0._rpm = l_9_0._fire_rpm
					l_9_4._fire_enabled = true
				else
					l_9_4._fire_enabled = false
				end
			elseif l_9_0._should_fire then
				l_9_0:_start_rpm_decrease()
			end
			l_9_4._fire_enabled = false
			l_9_0._rpm_increase = 0
			if l_9_0._rpm > 0 then
				l_9_0._rpm_decrease = l_9_0._rpm_decrease + l_9_3 * l_9_0._rpm_decceleration
				l_9_0._rpm = l_9_0._rpm - l_9_3 * l_9_0._rpm_decrease
			end
			if l_9_0._rpm < 0 then
				l_9_0._rpm = 0
			end
			l_9_0:_update_weapon_rotation(l_9_3)
			l_9_0._should_fire = l_9_5
			l_9_4._dispersion = l_9_0._max_dispersion + (l_9_0._min_dispersion - l_9_0._max_dispersion) * l_9_4._dispersion_modifier
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 9 
end

MiniGun._update_weapon_rotation = function(l_10_0, l_10_1)
	local l_10_2 = l_10_0._rpm / 60 * 360 * l_10_1
	l_10_0._rotation_object_angle = angle_constrain(l_10_0._rotation_object_angle + l_10_2)
	local l_10_3 = l_10_0._rotation_object
	local l_10_4 = l_10_3:rotation()
	l_10_3:new_set_local_rotation(l_10_0._rotation_object_initial_local_rotation + Rotation(l_10_0._rotation_object_initial_local_rotation:y(), l_10_0._rotation_object_angle))
end

local l_0_1 = function(l_11_0, l_11_1, l_11_2, l_11_3)
	if l_11_0 and l_11_0:is_playing() then
		local l_11_4 = l_11_0:get_control("gain_abs")
		l_11_0:set_control("gain_abs", 0)
	end
	if l_11_1 and l_11_1:is_playing() then
		l_11_1:stop()
	end
	return l_11_2:play("running_offset", l_11_3)
end

MiniGun._start_rpm_increase = function(l_12_0)
	-- upvalues: l_0_1
	local l_12_1 = nil
	if l_12_0._rpm > 0 and l_12_0._fire_rpm > 0 then
		l_12_1 = math.sqrt(l_12_0._rpm / l_12_0._fire_rpm) * 0.3
	else
		l_12_1 = 0
	end
	if l_12_0._rpm_up_sound then
		l_12_0._rpm_up_sound_instance = l_0_1(l_12_0._rpm_down_sound_instance, l_12_0._rpm_up_sound_instance, l_12_0._rpm_up_sound, l_12_1)
	end
end

MiniGun._start_rpm_decrease = function(l_13_0)
	-- upvalues: l_0_1
	local l_13_1 = nil
	if l_13_0._rpm > 0 and l_13_0._fire_rpm > 0 then
		l_13_1 = (1 - l_13_0._rpm / l_13_0._fire_rpm) * 1.198
	else
		l_13_1 = 0
	end
	if l_13_0._rpm_down_sound then
		l_13_0._rpm_down_sound_instance = l_0_1(l_13_0._rpm_up_sound_instance, l_13_0._rpm_down_sound_instance, l_13_0._rpm_down_sound, l_13_1)
	end
end

MiniGun.on_zoom_aim = function(l_14_0, l_14_1)
	if l_14_1 then
		l_14_0._unit:play("aiming_on")
	else
		l_14_0._unit:play("aiming_off")
	end
end

MiniGun.fire_start = function(l_15_0, l_15_1)
	l_15_0._fire_sensory_event_handle = managers.sensory_events:begin_continuous_event(managers.sensory_events.event_types.MINIGUN_SHOOT_ID, l_15_0._unit)
	l_15_0._fire_sound_instance = l_15_0._fire_sound_object:play("offset", 0)
	l_15_0._event_emitter:unit_weapon_fire_start(l_15_0._unit)
end

MiniGun.fire_end = function(l_16_0, l_16_1)
	managers.sensory_events:end_continuous_event(l_16_0._fire_sensory_event_handle)
	if l_16_0._is_once_sound == false and l_16_0._fire_end_sound_object and l_16_0._fire_sound_instance then
		l_16_0._fire_end_sound_object:play("crossfade_with", l_16_0._fire_sound_instance, "crossfade_time", 0)
	end
	l_16_0._event_emitter:unit_weapon_fire_stop(l_16_0._unit)
end

MiniGun.fire = function(l_17_0, l_17_1)
	local l_17_2 = l_17_0._obj_fire:rotation() * Rotation(Vector3(1, 0, 0), -90)
	local l_17_3, l_17_4 = World:effect_manager():spawn, World:effect_manager()
	local l_17_5 = {}
	l_17_5.effect = l_17_0._fire_effect_name
	l_17_5.position = l_17_0._obj_fire:position()
	l_17_5.rotation = l_17_2
	l_17_3(l_17_4, l_17_5)
	l_17_5, l_17_4, l_17_3 = nil
	l_17_0._fire_time = l_17_1
	local l_17_6 = l_17_0._wdata.aim_target_position
	l_17_4 = l_17_6 - l_17_0._obj_fire:position():normalized()
	l_17_4 = VectorUtilities.angle_constraint_direction(l_17_4, l_17_0._obj_fire:rotation():y(), l_17_0._max_fire_object_and_aim_angle_diff)
	l_17_5 = WeaponUtilities.dispersion(l_17_4, l_17_0._wdata.miss_dispersion, l_17_0._wdata._dispersion)
	local l_17_7 = l_17_0._obj_fire:position() + l_17_5 * 10
	if l_17_0._wdata._dispersion_modifier >= 1 and l_17_0._projectile_spawner_alt then
		local l_17_8 = Rotation(l_17_5, l_17_0._obj_fire:rotation():z())
		l_17_0._projectile_spawner_alt:base():spawn_projectile(l_17_0._user_unit, l_17_7, l_17_8)
		l_17_0._event_emitter:unit_weapon_fire_change(l_17_0._unit, l_17_7, l_17_8, l_17_0._projectile_spawner_alt)
	end
	do return end
	if l_17_0._projectile_spawner then
		local l_17_9 = Rotation(l_17_5, l_17_0._obj_fire:rotation():z())
		l_17_0._projectile_spawner:base():spawn_projectile(l_17_0._user_unit, l_17_7, l_17_9)
		l_17_0._event_emitter:unit_weapon_fire_change(l_17_0._unit, l_17_7, l_17_9, l_17_0._projectile_spawner)
	end
end


