BikerWeaponEffects = BikerWeaponEffects or class()
function BikerWeaponEffects.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._fire_started = false
	A0_0._power_up_effect_id = nil
	A0_0._fire_sound_instance = nil
	A0_0._power_up_sound_instance = nil
	managers.action_event:register_listener(A0_0, A1_1, A1_1)
end
function BikerWeaponEffects.update(A0_2, A1_3, A2_4, A3_5)
	if A0_2._unit:logic():get_power_up_percent() > 0 and not A0_2._power_up_effect_id and #A0_2._unit:base()._projectile_spawners > 0 then
		A0_2._power_up_effect_id = World:effect_manager():spawn({
			effect = A0_2._power_up_effect,
			parent = A0_2._unit:base()._projectile_spawners[1]:orientation_object(),
			force_synch = true
		})
	elseif A0_2._unit:logic():get_power_up_percent() <= 0 and A0_2._power_up_effect_id then
		World:effect_manager():fade_kill(A0_2._power_up_effect_id)
		A0_2._power_up_effect_id = nil
	end
	if A0_2._unit:logic():get_power_up_percent() > 0 and not A0_2._power_up_sound_instance and alive(A0_2._unit) then
		A0_2._power_up_sound_instance = A0_2._unit:play(A0_2._power_up_sound_cue_name)
	end
	if A0_2._unit:logic():get_power_up_percent() <= 0 and A0_2._power_up_sound_instance and A0_2._power_up_sound_instance:is_playing() then
		A0_2._power_up_sound_instance:stop()
		A0_2._power_up_sound_instance = nil
	end
end
function BikerWeaponEffects.unit_weapon_fire_start(A0_6)
	assert(not A0_6._fire_started)
	A0_6._fire_started = true
end
function BikerWeaponEffects.unit_weapon_fire_change(A0_7, A1_8, A2_9, A3_10, A4_11, A5_12)
	assert(A0_7._fire_started)
	World:effect_manager():spawn({
		effect = A0_7._fire_effect_name,
		parent = A5_12:orientation_object(),
		normal = Vector3(0, 1, 0),
		force_synch = false
	})
	A0_7._fire_sound_instance = A0_7._unit:play(A0_7._fire_sound_cue_name)
end
function BikerWeaponEffects.unit_weapon_fire_stop(A0_13, A1_14)
	assert(A0_13._fire_started)
	A0_13._fire_started = false
end
function BikerWeaponEffects.destroy(A0_15, A1_16)
	A0_15:_stop_effects()
	A0_15:_stop_sounds()
	managers.action_event:unregister_listener(A0_15)
end
function BikerWeaponEffects._stop_effects(A0_17)
	if A0_17._power_up_effect_id then
		World:effect_manager():kill(A0_17._power_up_effect_id)
		A0_17._power_up_effect_id = nil
	end
end
function BikerWeaponEffects._stop_sounds(A0_18)
	local L1_19
	L1_19 = {
		A0_18._fire_sound_instance,
		A0_18._power_up_sound_instance
	}
	for 