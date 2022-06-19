BaseWeapon = BaseWeapon or class()
function BaseWeapon.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._enabled = false
	A0_0._equiped = false
	A0_0._wdata = A0_0._unit:weapon_data()
	A0_0._wdata._max_dispersion = A0_0._max_dispersion
	A0_0._wdata._min_dispersion = A0_0._min_dispersion
	A0_0._max_fire_object_and_aim_angle_diff = tweak_data.weapon.DEFAULT_MAX_WEAPON_DIRECTION_AND_AIM_DIRECTION_ANGLE_DIFF
	A0_0._shoot_event_visible_range = tweak_data.sensory_events.weapons.DEFAULT_SHOOT_VISIBLE_RANGE
	A0_0._shoot_event_sound_level = tweak_data.sensory_events.weapons.DEFAULT_SHOOT_SOUND_LEVEL
	A0_0._shoot_event_sound_level_reference_distance = tweak_data.sensory_events.weapons.DEFAULT_SHOOT_SOUND_LEVEL_REFERENCE_DISTANCE
	A0_0._sound_variant = ""
	if A0_0._num_sound_variants and A0_0._num_sound_variants > 0 then
		A0_0._sound_variant = "_" .. math.random(A0_0._num_sound_variants)
	end
	A0_0:set_extensions_enabled(A0_0._enabled)
	A0_0:recalculate_dispersion()
	A0_0._extension_enabled = true
end
function BaseWeapon.set_enabled(A0_2, A1_3)
	A0_2._enabled = A1_3
	A0_2:set_extensions_enabled(A0_2._enabled)
end
function BaseWeapon.set_extensions_enabled(A0_4, A1_5)
	if A0_4._unit:logic() then
		A0_4._unit:logic():on_extension_update_enabled(A1_5)
	end
	if A0_4._unit:base() then
		A0_4._unit:base():on_extension_update_enabled(A1_5)
	end
end
function BaseWeapon.on_extension_update_enabled(A0_6, A1_7)
	A0_6._update_enabled = A1_7
	A0_6._unit:set_extension_update_enabled("base", A1_7)
	A0_6._extension_enabled = A1_7
end
function BaseWeapon.set_dispersion_modifier(A0_8, A1_9)
	A0_8._wdata._dispersion_modifier = A1_9
	A0_8:recalculate_dispersion()
end
function BaseWeapon.recalculate_dispersion(A0_10)
	local L2_11, L3_12, L4_13
	L2_11 = A0_10._wdata
	L3_12 = A0_10._max_dispersion
	L4_13 = A0_10._min_dispersion
	L4_13 = L4_13 - A0_10._max_dispersion
	L4_13 = L4_13 * A0_10._wdata._dispersion_modifier
	L3_12 = L3_12 + L4_13
	L2_11._dispersion = L3_12
end
function BaseWeapon.set_equiped(A0_14, A1_15)
	A0_14._equiped = A1_15
	A0_14:set_extensions_enabled(A0_14._equiped)
end
function BaseWeapon.equiped(A0_16)
	local L1_17
	L1_17 = A0_16._equiped
	return L1_17
end
function BaseWeapon.set_visible(A0_18, A1_19)
	A0_18._unit:set_visible(A1_19)
end
function BaseWeapon.play_indoor_check_sound(A0_20, A1_21)
end
function BaseWeapon.setup(A0_22, A1_23)
	A0_22._user_unit = A1_23
end
function BaseWeapon.user_unit(A0_24)
	local L1_25
	L1_25 = A0_24._user_unit
	return L1_25
end
function BaseWeapon.reload_unit(A0_26)
	local L1_27
	L1_27 = A0_26._reload
	return L1_27
end
