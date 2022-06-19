require("units/weapons/WeaponUtilities")
require("shared/VectorUtilities")
if not GenericWeapon then
	GenericWeapon = class(PlayerBaseWeapon)
end
GenericWeapon.init = function(l_1_0, l_1_1)
	l_1_0._dispersion = 0
	PlayerBaseWeapon.init(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._enabled = false
	l_1_0._obj_fire = l_1_0._unit:get_object("fire")
	l_1_0._wdata._fire_enabled = true
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
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

	if l_1_3 then
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_1_0._projectile_spawner:set_local_position(l_1_3)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._event_type_id = l_1_3 .. "_ID"
	if not l_1_0._event_source_type_id then
		local l_1_4 = managers.sensory_events:is_defined(l_1_3) or "HUMAN_WEAPON_ID"
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	managers.sensory_events:define_event(l_1_3, managers.sensory_events.source_types[l_1_4], l_1_0._shoot_event_visible_range, l_1_0._shoot_event_sound_level, l_1_0._shoot_event_sound_level_reference_distance)
	l_1_0._fire_sensory_event_handle = nil
	l_1_0._play_fire_anim = false
	l_1_0._event_emitter = managers.action_event:create_emitter(l_1_1)
	l_1_0._sound_object = l_1_0._unit:get_object("sound")
	l_1_0._muzzleflash_rate = 3
	l_1_0._bullets_fired = 0
	l_1_0._sync_muzzle_flash_effect = false
	l_1_0._is_firing = false
end

GenericWeapon.destroy = function(l_2_0)
	if l_2_0._is_firing then
		l_2_0:fire_end()
	end
	managers.sensory_events:destroy_continuous_event_handle(l_2_0._fire_sensory_event_handle)
	l_2_0._event_emitter:destroy()
	l_2_0._unit = nil
	if alive(l_2_0._projectile_spawner) then
		l_2_0._projectile_spawner:set_slot(0)
	end
	l_2_0._projectile_spawner = nil
	if l_2_0._fire_sound_object and l_2_0._fire_sound_object:is_playing() then
		l_2_0._fire_sound_object:stop()
	end
end

GenericWeapon.setup = function(l_3_0, l_3_1)
	PlayerBaseWeapon.setup(l_3_0, l_3_1)
end

GenericWeapon.enable = function(l_4_0)
	l_4_0:set_enabled(true)
end

GenericWeapon.disable = function(l_5_0)
	l_5_0:set_enabled(false)
end

GenericWeapon.recalculate_dispersion = function(l_6_0)
	l_6_0._wdata._dispersion = l_6_0._dispersion * l_6_0._wdata._dispersion_modifier
end

GenericWeapon.on_zoom_aim = function(l_7_0, l_7_1)
	if l_7_1 then
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 4 
end

GenericWeapon.fire_start = function(l_8_0, l_8_1)
	l_8_0._fire_sensory_event_handle = managers.sensory_events:begin_continuous_event(managers.sensory_events.event_types[l_8_0._event_type_id], l_8_0._unit)
	l_8_0._fire_sound_instance = l_8_0._fire_sound_object:play("offset", 0)
	l_8_0._event_emitter:unit_weapon_fire_start(l_8_0._unit)
	if l_8_0._camera_shake then
		l_8_0._event_emitter:unit_weapon_shake_start(l_8_0._user_unit, l_8_0._camera_shake)
	end
	l_8_0._bullets_fired = 0
	l_8_0._is_firing = true
end

GenericWeapon.fire_end = function(l_9_0, l_9_1)
	managers.sensory_events:end_continuous_event(l_9_0._fire_sensory_event_handle)
	if l_9_0._is_once_sound == false and l_9_0._fire_end_sound_object and l_9_0._fire_sound_instance then
		l_9_0._fire_end_sound_object:play("crossfade_with", l_9_0._fire_sound_instance, "crossfade_time", 0)
	end
	l_9_0._event_emitter:unit_weapon_fire_stop(l_9_0._unit)
	if l_9_0._camera_shake then
		l_9_0._event_emitter:unit_weapon_shake_stop(l_9_0._user_unit)
	end
	l_9_0._is_firing = false
end

GenericWeapon.fire = function(l_10_0, l_10_1)
	local l_10_2 = l_10_0._unit
	if l_10_0._play_fire_anim then
		l_10_2:anim_set_time("fire", 0)
		l_10_2:anim_play("fire")
	end
	if l_10_0._fire_effect then
		local l_10_3 = l_10_0._bullets_fired % l_10_0._muzzleflash_rate
	if l_10_3 == 0 then
		end
		local l_10_4, l_10_5 = World:effect_manager():spawn, World:effect_manager()
		local l_10_6 = {}
		l_10_6.effect = l_10_0._fire_effect
		l_10_6.rotation = Rotation(Vector3(0, 0, 1), 0)
		l_10_6.parent = l_10_0._sound_object
		l_10_6.force_synch = l_10_0._sync_muzzle_flash_effect
		l_10_4(l_10_5, l_10_6)
	end
	local l_10_7 = l_10_0._projectile_spawner
	l_10_0._bullets_fired = l_10_0._bullets_fired + 1
	local l_10_8 = l_10_0._wdata
	local l_10_9 = l_10_7
	local l_10_10 = l_10_8.aim_target_position
	local l_10_11 = l_10_9:rotation()
	local l_10_12 = l_10_9:position()
	local l_10_13 = l_10_10 - l_10_12:normalized()
	l_10_13 = VectorUtilities.angle_constraint_direction(l_10_13, l_10_11:y(), l_10_0._max_fire_object_and_aim_angle_diff)
	local l_10_14 = l_10_0:get_target_dir(l_10_12, l_10_13, l_10_8)
	local l_10_15 = Rotation(l_10_14, l_10_11:z())
	l_10_0._event_emitter:unit_weapon_fire_change(l_10_2, l_10_12, l_10_15, l_10_7)
	l_10_7:base():spawn_projectile(l_10_0._user_unit, l_10_12, l_10_15)
end

GenericWeapon.get_target_dir = function(l_11_0, l_11_1, l_11_2, l_11_3)
	local l_11_4 = WeaponUtilities.dispersion
	local l_11_5 = l_11_2
	local l_11_6 = l_11_3.miss_dispersion
	local l_11_7 = l_11_3._dispersion
	return l_11_4(l_11_5, l_11_6, l_11_7)
end

GenericWeapon.drop = function(l_12_0)
	l_12_0:disable()
	l_12_0._unit:unlink()
	l_12_0._unit:body("main_body"):set_enabled(true)
end


