MagneticChargeWeapon = MagneticChargeWeapon or class(PlayerBaseWeapon)
function MagneticChargeWeapon.init(A0_0, A1_1)
	PlayerBaseWeapon.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._enabled = false
	A0_0._obj_fire = A0_0._unit:get_object("rp_charge_magnetic")
	A0_0._wdata = A0_0._unit:weapon_data()
	A0_0._wdata._max_dispersion = A0_0._max_dispersion
	A0_0._wdata._min_dispersion = A0_0._min_dispersion
	A0_0._wdata._fire_enabled = true
	A0_0._fire_sound_instance = nil
	A0_0._fire_end_sound_instance = nil
	if A0_0._projectile_spawner_class and A0_0._projectile_spawner_class ~= "" then
		A0_0._projectile_spawner = World:spawn_unit(A0_0._projectile_spawner_class, A0_0._unit:position(), A0_0._unit:rotation())
		A0_0._unit:link("fire", A0_0._projectile_spawner, A0_0._projectile_spawner:orientation_object():name())
	end
	if A0_0._projectile_spawner_class_alt and A0_0._projectile_spawner_class_alt ~= "" then
		A0_0._projectile_spawner_alt = World:spawn_unit(A0_0._projectile_spawner_class_alt, A0_0._unit:position(), A0_0._unit:rotation())
		A0_0._unit:link("fire", A0_0._projectile_spawner_alt, A0_0._projectile_spawner_alt:orientation_object():name())
	end
	if not managers.sensory_events:is_defined("MAGNETIC_CHARGE_WEAPON_SHOOT") then
		managers.sensory_events:define_event("MAGNETIC_CHARGE_WEAPON_SHOOT", managers.sensory_events.source_types.HUMAN_WEAPON_ID, A0_0._shoot_event_visible_range, A0_0._shoot_event_sound_level, A0_0._shoot_event_sound_level_reference_distance)
	end
	A0_0._fire_sensory_event_handle = nil
end
function MagneticChargeWeapon.destroy(A0_2)
	managers.sensory_events:destroy_continuous_event_handle(A0_2._fire_sensory_event_handle)
	A0_2._unit = nil
	if alive(A0_2._projectile_spawner) then
		A0_2._projectile_spawner:set_slot(0)
	end
	A0_2._projectile_spawner = nil
	if alive(A0_2._projectile_spawner_alt) then
		A0_2._projectile_spawner_alt:set_slot(0)
	end
	A0_2._projectile_spawner_alt = nil
	if A0_2._fire_sound_instance and A0_2._fire_sound_instance:is_playing() then
		A0_2._fire_sound_instance:stop()
	end
end
function MagneticChargeWeapon.setup(A0_3, A1_4)
	PlayerBaseWeapon.setup(A0_3, A1_4)
end
function MagneticChargeWeapon.enable(A0_5)
	A0_5:set_enabled(true)
end
function MagneticChargeWeapon.disable(A0_6)
	A0_6:set_enabled(false)
end
function MagneticChargeWeapon.set_enabled(A0_7, A1_8)
	A0_7._enabled = A1_8
	A0_7._unit:set_extension_update_enabled("base", A1_8)
end
function MagneticChargeWeapon.on_zoom_aim(A0_9, A1_10)
	if A1_10 then
		A0_9._unit:play("aiming_on")
	else
		A0_9._unit:play("aiming_off")
	end
end
function MagneticChargeWeapon.fire_start(A0_11, A1_12)
	A0_11._fire_sensory_event_handle = managers.sensory_events:begin_continuous_event(managers.sensory_events.event_types.MAGNETIC_CHARGE_WEAPON_SHOOT_ID, A0_11._unit)
	if A0_11._wdata._dispersion_modifier >= 1 then
		A0_11._unit:play(A0_11._sound_prefix .. "shot_ezsqz")
		A0_11._fire_sound_instance = nil
		A0_11._fire_end_sound_instance = nil
	else
		A0_11._fire_sound_instance = A0_11._unit:play(A0_11._sound_prefix .. "shot")
	end
end
function MagneticChargeWeapon.fire_end(A0_13, A1_14)
	local L2_15
	L2_15 = managers
	L2_15 = L2_15.sensory_events
	L2_15 = L2_15.end_continuous_event
	L2_15(L2_15, A0_13._fire_sensory_event_handle)
	L2_15 = A0_13._fire_sound_instance
	if L2_15 then
		L2_15 = A0_13._fire_sound_instance
		L2_15 = L2_15.is_playing
		L2_15 = L2_15(L2_15)
		if L2_15 then
			L2_15 = A0_13._fire_sound_instance
			L2_15 = L2_15.stop
			L2_15(L2_15)
		end
	end
	L2_15 = A0_13._sound_prefix
	L2_15 = L2_15 .. "shot_end"
	assert(A0_13._unit:has_cue(L2_15))
	A0_13._fire_end_sound_instance = A0_13._unit:play(L2_15)
end
function MagneticChargeWeapon.fire(A0_16, A1_17)
	local L2_18, L3_19, L4_20, L5_21, L6_22, L7_23
	L2_18 = A0_16._unit
	L3_19 = L2_18
	L2_18 = L2_18.anim_set_time
	L4_20 = "fire"
	L5_21 = 0
	L2_18(L3_19, L4_20, L5_21)
	L2_18 = A0_16._unit
	L3_19 = L2_18
	L2_18 = L2_18.anim_play
	L4_20 = "fire"
	L2_18(L3_19, L4_20)
	L2_18, L3_19, L4_20 = nil, nil, nil
	A0_16._fire_time = A1_17
	L5_21 = A0_16._wdata
	L5_21 = L5_21.aim_target_position
	L6_22 = A0_16._max_dispersion
	L7_23 = A0_16._min_dispersion
	L7_23 = L7_23 - A0_16._max_dispersion
	L7_23 = L7_23 * A0_16._wdata._dispersion_modifier
	L6_22 = L6_22 + L7_23
	L7_23 = A0_16._obj_fire
	L7_23 = L7_23.position
	L7_23 = L7_23(L7_23)
	L3_19 = (L5_21 - L7_23):normalized()
	L4_20 = L3_19:spread(L6_22):normalized()
	L7_23 = L7_23 + L4_20 * 10
	if A0_16._projectile_spawner then
		A0_16._projectile_spawner:base():spawn_projectile(A0_16._user_unit, L7_23, Rotation(L4_20, A0_16._obj_fire:rotation():z()))
	end
end
function MagneticChargeWeapon.drop(A0_24)
	A0_24:disable()
	A0_24._unit:unlink()
	A0_24._unit:body("main_body"):set_enabled(true)
end
