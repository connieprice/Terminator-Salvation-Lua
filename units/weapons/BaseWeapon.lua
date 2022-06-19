if not BaseWeapon then
	BaseWeapon = class()
end
BaseWeapon.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._enabled = false
	l_1_0._equiped = false
	l_1_0._wdata = l_1_0._unit:weapon_data()
	l_1_0._wdata._max_dispersion = l_1_0._max_dispersion
	l_1_0._wdata._min_dispersion = l_1_0._min_dispersion
	l_1_0._max_fire_object_and_aim_angle_diff = tweak_data.weapon.DEFAULT_MAX_WEAPON_DIRECTION_AND_AIM_DIRECTION_ANGLE_DIFF
	l_1_0._shoot_event_visible_range = tweak_data.sensory_events.weapons.DEFAULT_SHOOT_VISIBLE_RANGE
	l_1_0._shoot_event_sound_level = tweak_data.sensory_events.weapons.DEFAULT_SHOOT_SOUND_LEVEL
	l_1_0._shoot_event_sound_level_reference_distance = tweak_data.sensory_events.weapons.DEFAULT_SHOOT_SOUND_LEVEL_REFERENCE_DISTANCE
	l_1_0._sound_variant = ""
	if l_1_0._num_sound_variants and l_1_0._num_sound_variants > 0 then
		l_1_0._sound_variant = "_" .. math.random(l_1_0._num_sound_variants)
	end
	l_1_0:set_extensions_enabled(l_1_0._enabled)
	l_1_0:recalculate_dispersion()
	l_1_0._extension_enabled = true
end

BaseWeapon.set_enabled = function(l_2_0, l_2_1)
	l_2_0._enabled = l_2_1
	l_2_0:set_extensions_enabled(l_2_0._enabled)
end

BaseWeapon.set_extensions_enabled = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0._unit:logic()
	if l_3_2 then
		l_3_2:on_extension_update_enabled(l_3_1)
	end
	local l_3_3 = l_3_0._unit:base()
	if l_3_3 then
		l_3_3:on_extension_update_enabled(l_3_1)
	end
end

BaseWeapon.on_extension_update_enabled = function(l_4_0, l_4_1)
	l_4_0._update_enabled = l_4_1
	l_4_0._unit:set_extension_update_enabled("base", l_4_1)
	l_4_0._extension_enabled = l_4_1
end

BaseWeapon.set_dispersion_modifier = function(l_5_0, l_5_1)
	l_5_0._wdata._dispersion_modifier = l_5_1
	l_5_0:recalculate_dispersion()
end

BaseWeapon.recalculate_dispersion = function(l_6_0)
	l_6_0._wdata._dispersion = l_6_0._max_dispersion + (l_6_0._min_dispersion - l_6_0._max_dispersion) * l_6_0._wdata._dispersion_modifier
end

BaseWeapon.set_equiped = function(l_7_0, l_7_1)
	l_7_0._equiped = l_7_1
	l_7_0:set_extensions_enabled(l_7_0._equiped)
end

BaseWeapon.equiped = function(l_8_0)
	return l_8_0._equiped
end

BaseWeapon.set_visible = function(l_9_0, l_9_1)
	l_9_0._unit:set_visible(l_9_1)
end

BaseWeapon.play_indoor_check_sound = function(l_10_0, l_10_1)
end

BaseWeapon.setup = function(l_11_0, l_11_1)
	l_11_0._user_unit = l_11_1
end

BaseWeapon.user_unit = function(l_12_0)
	return l_12_0._user_unit
end

BaseWeapon.reload_unit = function(l_13_0)
	return l_13_0._reload
end


