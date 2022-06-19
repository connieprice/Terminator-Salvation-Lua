if not HunterKillerWeaponEffects then
	HunterKillerWeaponEffects = class()
end
HunterKillerWeaponEffects.init = function(l_1_0, l_1_1)
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
	l_1_0._listener_registered = true
end

HunterKillerWeaponEffects.destroy = function(l_2_0, l_2_1)
	if l_2_0._fire_sound_object and l_2_0._fire_sound_object:is_playing() then
		l_2_0._fire_sound_object:stop()
	end
	if l_2_0._listener_registered then
		l_2_0:_unregister_listener()
	end
end

HunterKillerWeaponEffects.unit_weapon_fire_start = function(l_3_0, l_3_1)
	assert(not l_3_0._fire_started)
	l_3_0._fire_started = true
	local l_3_2 = l_3_0._unit:base()
	assert(l_3_2)
	l_3_1.base = l_3_2
	l_3_0._fire_sound_instance = l_3_0._fire_sound_object:play("offset", 0)
end

HunterKillerWeaponEffects.unit_weapon_fire_change = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5)
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

HunterKillerWeaponEffects.unit_weapon_fire_stop = function(l_5_0, l_5_1)
	assert(l_5_0._fire_started)
	l_5_0._fire_started = false
	if l_5_0._listener_registered then
		local l_5_2 = l_5_1.base
		assert(l_5_2)
		local l_5_3 = l_5_2._projectile_spawners
		local l_5_4 = l_5_2._disabled_projectile_spawners
	if #l_5_3 == #l_5_4 then
		end
		l_5_0:_unregister_listener()
	end
end

HunterKillerWeaponEffects._unregister_listener = function(l_6_0)
	assert(l_6_0._listener_registered)
	l_6_0._listener_registered = false
	managers.action_event:unregister_listener(l_6_0)
end


