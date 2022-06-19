require("units/weapons/WeaponUtilities")
require("shared/VectorUtilities")
GenericWeapon = GenericWeapon or class(PlayerBaseWeapon)
function GenericWeapon.init(A0_0, A1_1)
	local L2_2, L3_3
	A0_0._dispersion = 0
	L2_2 = PlayerBaseWeapon
	L2_2 = L2_2.init
	L3_3 = A0_0
	L2_2(L3_3, A1_1)
	A0_0._unit = A1_1
	A0_0._enabled = false
	L2_2 = A0_0._unit
	L3_3 = L2_2
	L2_2 = L2_2.get_object
	L2_2 = L2_2(L3_3, "fire")
	A0_0._obj_fire = L2_2
	L2_2 = A0_0._wdata
	L2_2._fire_enabled = true
	L2_2 = "fire"
	A0_0._fire_sound_instance = nil
	L3_3 = WeaponUtilities
	L3_3 = L3_3.sound_objects
	A0_0._fire_end_sound_object, L3_3 = A0_0._unit, L3_3(A0_0._unit, A0_0._sound_prefix, A0_0._sound_variant, A0_0._sound_bank, A0_0._is_once_sound, L2_2)
	A0_0._fire_sound_object = L3_3
	L3_3 = A0_0._projectile_spawner_class
	if L3_3 then
		L3_3 = A0_0._projectile_spawner_class
		if L3_3 ~= "" then
			L3_3 = World
			L3_3 = L3_3.spawn_unit
			L3_3 = L3_3(L3_3, A0_0._projectile_spawner_class, A0_0._unit:position(), A0_0._unit:rotation())
			A0_0._projectile_spawner = L3_3
			L3_3 = A0_0._unit
			L3_3 = L3_3.link
			L3_3(L3_3, "fire", A0_0._projectile_spawner, A0_0._projectile_spawner:orientation_object():name())
			L3_3 = A0_0._spawner_offset
			if L3_3 then
				L3_3 = TableSerializer
				L3_3 = L3_3._load_vector
				L3_3 = L3_3(A0_0._spawner_offset)
				A0_0._projectile_spawner:set_local_position(L3_3)
			end
		end
	end
	L3_3 = string
	L3_3 = L3_3.upper
	L3_3 = L3_3(A1_1:name())
	L3_3 = L3_3 .. "_SHOOT"
	A0_0._event_type_id = L3_3 .. "_ID"
	if not managers.sensory_events:is_defined(L3_3) then
		managers.sensory_events:define_event(L3_3, managers.sensory_events.source_types[A0_0._event_source_type_id or "HUMAN_WEAPON_ID"], A0_0._shoot_event_visible_range, A0_0._shoot_event_sound_level, A0_0._shoot_event_sound_level_reference_distance)
	end
	A0_0._fire_sensory_event_handle = nil
	A0_0._play_fire_anim = false
	A0_0._event_emitter = managers.action_event:create_emitter(A1_1)
	A0_0._sound_object = A0_0._unit:get_object("sound")
	A0_0._muzzleflash_rate = 3
	A0_0._bullets_fired = 0
	A0_0._sync_muzzle_flash_effect = false
	A0_0._is_firing = false
end
function GenericWeapon.destroy(A0_4)
	if A0_4._is_firing then
		A0_4:fire_end()
	end
	managers.sensory_events:destroy_continuous_event_handle(A0_4._fire_sensory_event_handle)
	A0_4._event_emitter:destroy()
	A0_4._unit = nil
	if alive(A0_4._projectile_spawner) then
		A0_4._projectile_spawner:set_slot(0)
	end
	A0_4._projectile_spawner = nil
	if A0_4._fire_sound_object and A0_4._fire_sound_object:is_playing() then
		A0_4._fire_sound_object:stop()
	end
end
function GenericWeapon.setup(A0_5, A1_6)
	PlayerBaseWeapon.setup(A0_5, A1_6)
end
function GenericWeapon.enable(A0_7)
	A0_7:set_enabled(true)
end
function GenericWeapon.disable(A0_8)
	A0_8:set_enabled(false)
end
function GenericWeapon.recalculate_dispersion(A0_9)
	local L2_10, L3_11
	L2_10 = A0_9._wdata
	L3_11 = A0_9._dispersion
	L3_11 = L3_11 * A0_9._wdata._dispersion_modifier
	L2_10._dispersion = L3_11
end
function GenericWeapon.on_zoom_aim(A0_12, A1_13)
	if A1_13 then
	else
	end
end
function GenericWeapon.fire_start(A0_14, A1_15)
	A0_14._fire_sensory_event_handle = managers.sensory_events:begin_continuous_event(managers.sensory_events.event_types[A0_14._event_type_id], A0_14._unit)
	A0_14._fire_sound_instance = A0_14._fire_sound_object:play("offset", 0)
	A0_14._event_emitter:unit_weapon_fire_start(A0_14._unit)
	if A0_14._camera_shake then
		A0_14._event_emitter:unit_weapon_shake_start(A0_14._user_unit, A0_14._camera_shake)
	end
	A0_14._bullets_fired = 0
	A0_14._is_firing = true
end
function GenericWeapon.fire_end(A0_16, A1_17)
	managers.sensory_events:end_continuous_event(A0_16._fire_sensory_event_handle)
	if A0_16._is_once_sound == false and A0_16._fire_end_sound_object and A0_16._fire_sound_instance then
		A0_16._fire_end_sound_object:play("crossfade_with", A0_16._fire_sound_instance, "crossfade_time", 0)
	end
	A0_16._event_emitter:unit_weapon_fire_stop(A0_16._unit)
	if A0_16._camera_shake then
		A0_16._event_emitter:unit_weapon_shake_stop(A0_16._user_unit)
	end
	A0_16._is_firing = false
end
function GenericWeapon.fire(A0_18, A1_19)
	local L2_20, L3_21, L4_22, L5_23, L6_24, L7_25, L8_26, L9_27, L10_28, L11_29
	L2_20 = A0_18._unit
	L3_21 = A0_18._play_fire_anim
	if L3_21 then
		L4_22 = L2_20
		L3_21 = L2_20.anim_set_time
		L5_23 = "fire"
		L6_24 = 0
		L3_21(L4_22, L5_23, L6_24)
		L4_22 = L2_20
		L3_21 = L2_20.anim_play
		L5_23 = "fire"
		L3_21(L4_22, L5_23)
	end
	L3_21 = A0_18._fire_effect
	if L3_21 then
		L3_21 = A0_18._bullets_fired
		L4_22 = A0_18._muzzleflash_rate
		L3_21 = L3_21 % L4_22
		if L3_21 == 0 then
			L4_22 = World
			L5_23 = L4_22
			L4_22 = L4_22.effect_manager
			L4_22 = L4_22(L5_23)
			L5_23 = L4_22
			L4_22 = L4_22.spawn
			L6_24 = {}
			L7_25 = A0_18._fire_effect
			L6_24.effect = L7_25
			L7_25 = Rotation
			L8_26 = Vector3
			L9_27 = 0
			L10_28 = 0
			L11_29 = 1
			L8_26 = L8_26(L9_27, L10_28, L11_29)
			L9_27 = 0
			L7_25 = L7_25(L8_26, L9_27)
			L6_24.rotation = L7_25
			L7_25 = A0_18._sound_object
			L6_24.parent = L7_25
			L7_25 = A0_18._sync_muzzle_flash_effect
			L6_24.force_synch = L7_25
			L4_22(L5_23, L6_24)
		end
	end
	L3_21 = A0_18._projectile_spawner
	L4_22 = A0_18._bullets_fired
	L4_22 = L4_22 + 1
	A0_18._bullets_fired = L4_22
	L4_22 = A0_18._wdata
	L5_23 = L3_21
	L6_24 = L4_22.aim_target_position
	L8_26 = L5_23
	L7_25 = L5_23.rotation
	L7_25 = L7_25(L8_26)
	L9_27 = L5_23
	L8_26 = L5_23.position
	L8_26 = L8_26(L9_27)
	L9_27 = L6_24 - L8_26
	L10_28 = L9_27
	L9_27 = L9_27.normalized
	L9_27 = L9_27(L10_28)
	L10_28 = VectorUtilities
	L10_28 = L10_28.angle_constraint_direction
	L11_29 = L9_27
	L10_28 = L10_28(L11_29, L7_25:y(), A0_18._max_fire_object_and_aim_angle_diff)
	L9_27 = L10_28
	L11_29 = A0_18
	L10_28 = A0_18.get_target_dir
	L10_28 = L10_28(L11_29, L8_26, L9_27, L4_22)
	L11_29 = Rotation
	L11_29 = L11_29(L10_28, L7_25:z())
	A0_18._event_emitter:unit_weapon_fire_change(L2_20, L8_26, L11_29, L3_21)
	L3_21:base():spawn_projectile(A0_18._user_unit, L8_26, L11_29)
end
function GenericWeapon.get_target_dir(A0_30, A1_31, A2_32, A3_33)
	return WeaponUtilities.dispersion(A2_32, A3_33.miss_dispersion, A3_33._dispersion)
end
function GenericWeapon.drop(A0_34)
	A0_34:disable()
	A0_34._unit:unlink()
	A0_34._unit:body("main_body"):set_enabled(true)
end
