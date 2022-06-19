WeaponLight = WeaponLight or class()
WeaponLight._SOUNDBANK_NAME = "flashlight_sound"
WeaponLight._TOGGLE_SOUND_NAME = "flashlight_switch"
function WeaponLight.init(A0_0, A1_1)
	local L2_2
	A0_0._unit = A1_1
	L2_2 = Sound
	L2_2 = L2_2.make_bank
	L2_2 = L2_2(L2_2, WeaponLight._SOUNDBANK_NAME, WeaponLight._TOGGLE_SOUND_NAME)
	A0_0._toggle_sound = L2_2
	L2_2 = A0_0._unit
	L2_2 = L2_2.get_object
	L2_2 = L2_2(L2_2, A0_0._parent_object_name)
	A0_0._toggle_sound:set_output(L2_2)
	A0_0._enabled = false
end
function WeaponLight.enable(A0_3)
	assert(not A0_3:enabled())
	managers.sequence:run_sequence_simple("light_on", A0_3._unit)
	A0_3._toggle_sound:play()
	A0_3._enabled = true
end
function WeaponLight.disable(A0_4)
	assert(A0_4:enabled())
	managers.sequence:run_sequence_simple("light_off", A0_4._unit)
	A0_4._toggle_sound:play()
	A0_4._enabled = false
end
function WeaponLight.enabled(A0_5)
	local L1_6
	L1_6 = A0_5._enabled
	return L1_6
end
