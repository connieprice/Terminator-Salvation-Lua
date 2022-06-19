if not BikerWeaponEffects then
	BikerWeaponEffects = class()
end
BikerWeaponEffects.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._fire_started = false
	l_1_0._power_up_effect_id = nil
	l_1_0._fire_sound_instance = nil
	l_1_0._power_up_sound_instance = nil
	managers.action_event:register_listener(l_1_0, l_1_1, l_1_1)
end

BikerWeaponEffects.update = function(l_2_0, l_2_1, l_2_2, l_2_3)
	local l_2_4 = l_2_0._unit:logic():get_power_up_percent()
	local l_2_5 = l_2_0._unit:base()._projectile_spawners
	if l_2_4 > 0 and not l_2_0._power_up_effect_id and #l_2_5 > 0 then
		local l_2_6, l_2_7 = World:effect_manager():spawn, World:effect_manager()
		local l_2_8 = {}
		l_2_8.effect = l_2_0._power_up_effect
		l_2_8.parent = l_2_5[1]:orientation_object()
		l_2_8.force_synch = true
		l_2_6 = l_2_6(l_2_7, l_2_8)
		l_2_0._power_up_effect_id = l_2_6
	elseif l_2_4 <= 0 and l_2_0._power_up_effect_id then
		World:effect_manager():fade_kill(l_2_0._power_up_effect_id)
		l_2_0._power_up_effect_id = nil
	end
	if l_2_4 > 0 and not l_2_0._power_up_sound_instance and alive(l_2_0._unit) then
		l_2_0._power_up_sound_instance = l_2_0._unit:play(l_2_0._power_up_sound_cue_name)
	end
	if l_2_4 <= 0 and l_2_0._power_up_sound_instance and l_2_0._power_up_sound_instance:is_playing() then
		l_2_0._power_up_sound_instance:stop()
		l_2_0._power_up_sound_instance = nil
	end
end

BikerWeaponEffects.unit_weapon_fire_start = function(l_3_0)
	assert(not l_3_0._fire_started)
	l_3_0._fire_started = true
end

BikerWeaponEffects.unit_weapon_fire_change = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5)
	assert(l_4_0._fire_started)
	local l_4_6, l_4_7 = World:effect_manager():spawn, World:effect_manager()
	local l_4_8 = {}
	l_4_8.effect = l_4_0._fire_effect_name
	l_4_8.parent = l_4_5:orientation_object()
	l_4_8.normal = Vector3(0, 1, 0)
	l_4_8.force_synch = false
	l_4_6(l_4_7, l_4_8)
	l_4_6 = l_4_0._unit
	l_4_6, l_4_7 = l_4_6:play, l_4_6
	l_4_8 = l_4_0._fire_sound_cue_name
	l_4_6 = l_4_6(l_4_7, l_4_8)
	l_4_0._fire_sound_instance = l_4_6
end

BikerWeaponEffects.unit_weapon_fire_stop = function(l_5_0, l_5_1)
	assert(l_5_0._fire_started)
	l_5_0._fire_started = false
end

BikerWeaponEffects.destroy = function(l_6_0, l_6_1)
	l_6_0:_stop_effects()
	l_6_0:_stop_sounds()
	managers.action_event:unregister_listener(l_6_0)
end

BikerWeaponEffects._stop_effects = function(l_7_0)
	if l_7_0._power_up_effect_id then
		World:effect_manager():kill(l_7_0._power_up_effect_id)
		l_7_0._power_up_effect_id = nil
	end
end

BikerWeaponEffects._stop_sounds = function(l_8_0)
	local l_8_5, l_8_6, l_8_7, l_8_8, l_8_9, l_8_10, l_8_11, l_8_12 = nil
	local l_8_1 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0,i_1 in l_8_0._fire_sound_instance(l_8_0._power_up_sound_instance) do
		if i_1 and i_1:is_playing() then
			i_1:stop()
		end
	end
end


