if not TankWeaponEffects then
	TankWeaponEffects = class()
end
TankWeaponEffects.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._obj_fire = l_1_0._unit:orientation_object()
	l_1_0._fire_started = false
	local l_1_2 = "rp_empty"
	l_1_0._fire_sound_instance = nil
	local l_1_3 = WeaponUtilities.sound_objects(l_1_0._unit, l_1_0._sound_prefix, l_1_0._sound_variant, l_1_0._sound_bank, l_1_0._is_once_sound, l_1_2)
	l_1_0._fire_end_sound_object = l_1_0._unit
	l_1_0._fire_sound_object = l_1_3
	l_1_3 = managers
	l_1_3 = l_1_3.action_event
	l_1_3(l_1_3, l_1_0, l_1_1, l_1_1)
end

TankWeaponEffects.destroy = function(l_2_0, l_2_1)
	if l_2_0._fire_sound_object and l_2_0._fire_sound_object:is_playing() then
		l_2_0._fire_sound_object:stop()
	end
	managers.action_event:unregister_listener(l_2_0)
end

TankWeaponEffects.unit_weapon_fire_start = function(l_3_0)
	assert(not l_3_0._fire_started)
	l_3_0._fire_started = true
	l_3_0._fire_sound_instance = l_3_0._fire_sound_object:play("offset", 0)
end

TankWeaponEffects.unit_weapon_fire_change = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5)
	assert(l_4_0._fire_started)
	l_4_0._fire_sound_instance = l_4_0._fire_sound_object:play("offset", 0)
	local l_4_6, l_4_7 = World:effect_manager():spawn, World:effect_manager()
	local l_4_8 = {}
	l_4_8.effect = l_4_0._fire_effect_name
	l_4_8.parent = l_4_5:orientation_object()
	l_4_8.normal = Vector3(0, 0, 1)
	l_4_8.force_synch = false
	l_4_6(l_4_7, l_4_8)
end

TankWeaponEffects.unit_weapon_fire_stop = function(l_5_0, l_5_1)
	assert(l_5_0._fire_started)
	l_5_0._fire_started = false
end


