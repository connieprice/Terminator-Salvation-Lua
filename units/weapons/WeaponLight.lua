if not WeaponLight then
	WeaponLight = class()
end
WeaponLight._SOUNDBANK_NAME = "flashlight_sound"
WeaponLight._TOGGLE_SOUND_NAME = "flashlight_switch"
WeaponLight.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._toggle_sound = Sound:make_bank(WeaponLight._SOUNDBANK_NAME, WeaponLight._TOGGLE_SOUND_NAME)
	local l_1_2 = l_1_0._unit:get_object(l_1_0._parent_object_name)
	l_1_0._toggle_sound:set_output(l_1_2)
	l_1_0._enabled = false
end

WeaponLight.enable = function(l_2_0)
	assert(not l_2_0:enabled())
	managers.sequence:run_sequence_simple("light_on", l_2_0._unit)
	l_2_0._toggle_sound:play()
	l_2_0._enabled = true
end

WeaponLight.disable = function(l_3_0)
	assert(l_3_0:enabled())
	managers.sequence:run_sequence_simple("light_off", l_3_0._unit)
	l_3_0._toggle_sound:play()
	l_3_0._enabled = false
end

WeaponLight.enabled = function(l_4_0)
	return l_4_0._enabled
end


