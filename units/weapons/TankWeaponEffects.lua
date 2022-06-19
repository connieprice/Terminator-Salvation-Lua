TankWeaponEffects = TankWeaponEffects or class()
function TankWeaponEffects.init(A0_0, A1_1)
	local L2_2
	A0_0._unit = A1_1
	L2_2 = A0_0._unit
	L2_2 = L2_2.orientation_object
	L2_2 = L2_2(L2_2)
	A0_0._obj_fire = L2_2
	A0_0._fire_started = false
	L2_2 = "rp_empty"
	A0_0._fire_sound_instance = nil
	A0_0._fire_sound_object, A0_0._fire_end_sound_object = WeaponUtilities.sound_objects(A0_0._unit, A0_0._sound_prefix, A0_0._sound_variant, A0_0._sound_bank, A0_0._is_once_sound, L2_2)
	managers.action_event:register_listener(A0_0, A1_1, A1_1)
end
function TankWeaponEffects.destroy(A0_3, A1_4)
	if A0_3._fire_sound_object and A0_3._fire_sound_object:is_playing() then
		A0_3._fire_sound_object:stop()
	end
	managers.action_event:unregister_listener(A0_3)
end
function TankWeaponEffects.unit_weapon_fire_start(A0_5)
	assert(not A0_5._fire_started)
	A0_5._fire_started = true
	A0_5._fire_sound_instance = A0_5._fire_sound_object:play("offset", 0)
end
function TankWeaponEffects.unit_weapon_fire_change(A0_6, A1_7, A2_8, A3_9, A4_10, A5_11)
	assert(A0_6._fire_started)
	A0_6._fire_sound_instance = A0_6._fire_sound_object:play("offset", 0)
	World:effect_manager():spawn({
		effect = A0_6._fire_effect_name,
		parent = A5_11:orientation_object(),
		normal = Vector3(0, 0, 1),
		force_synch = false
	})
end
function TankWeaponEffects.unit_weapon_fire_stop(A0_12, A1_13)
	assert(A0_12._fire_started)
	A0_12._fire_started = false
end
