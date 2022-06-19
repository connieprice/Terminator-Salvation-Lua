WeaponUtilities = WeaponUtilities or class()
function WeaponUtilities.circular_dispersion(A0_0, A1_1, A2_2)
	local L3_3, L4_4, L5_5, L6_6
	L3_3 = SharedMath
	L3_3 = L3_3.normalized_rand
	L4_4 = A1_1
	L5_5 = A2_2
	L3_3 = L3_3(L4_4, L5_5)
	L4_4 = math
	L4_4 = L4_4.random
	L4_4 = L4_4()
	L4_4 = L4_4 * 360
	L5_5 = Rotation
	L6_6 = A0_0
	L5_5 = L5_5(L6_6, math.UP)
	L6_6 = Rotation
	L6_6 = L6_6(L3_3, L4_4, 0)
	return (Vector3(0, 1, 0):rotate_with(L6_6):rotate_with(L5_5))
end
function WeaponUtilities.elliptical_dispersion(A0_7, A1_8, A2_9, A3_10)
	local L4_11, L5_12, L6_13, L7_14, L8_15, L9_16, L10_17
	L4_11 = SharedMath
	L4_11 = L4_11.normalized_rand
	L5_12 = A1_8
	L6_13 = A2_9
	L4_11 = L4_11(L5_12, L6_13)
	L5_12 = math
	L5_12 = L5_12.random
	L5_12 = L5_12()
	L5_12 = L5_12 * 360
	L5_12 = L5_12 - 180
	L6_13 = math
	L6_13 = L6_13.tan
	L7_14 = L4_11
	L6_13 = L6_13(L7_14)
	L7_14 = SharedMath
	L7_14 = L7_14.point_on_ellipse
	L8_15 = L6_13 * A3_10
	L9_16 = L6_13
	L10_17 = L5_12
	L8_15 = L7_14(L8_15, L9_16, L10_17)
	L9_16 = Rotation
	L10_17 = A0_7
	L9_16 = L9_16(L10_17, math.UP)
	L10_17 = Rotation
	L10_17 = L10_17(Vector3(L8_15, 1, L7_14):normalized(), math.UP)
	return (Vector3(0, 1, 0):rotate_with(L10_17):rotate_with(L9_16))
end
function WeaponUtilities.dispersion(A0_18, A1_19, A2_20)
	return WeaponUtilities.circular_dispersion(A0_18, A1_19, A2_20)
end
function WeaponUtilities.sound_objects(A0_21, A1_22, A2_23, A3_24, A4_25, A5_26)
	local L6_27, L7_28, L8_29, L9_30
	L6_27 = A1_22
	L7_28 = "shot"
	L6_27 = L6_27 .. L7_28
	if A2_23 then
		L7_28 = L6_27
		L8_29 = A2_23
		L6_27 = L7_28 .. L8_29
	end
	L7_28 = Sound
	L8_29 = L7_28
	L7_28 = L7_28.make_bank
	L9_30 = A3_24
	L7_28 = L7_28(L8_29, L9_30, L6_27)
	L9_30 = L7_28
	L8_29 = L7_28.set_output
	L8_29(L9_30, A0_21:get_object(A5_26))
	if A4_25 == false then
		L8_29 = A1_22
		L9_30 = "shot_end"
		L8_29 = L8_29 .. L9_30
		if A2_23 then
			L9_30 = L8_29
			L8_29 = L9_30 .. A2_23
		end
		L9_30 = Sound
		L9_30 = L9_30.make_bank
		L9_30 = L9_30(L9_30, A3_24, L8_29)
		L9_30:set_output(A0_21:get_object(A5_26))
		return L7_28, L9_30
	end
	return L7_28
end
WeaponUtilities.weapon_name_to_short_name = {
	m4_carbine = "m4",
	m249_machinegun = "m249",
	r870_shotgun = "r870",
	rpg7_grenadelauncher_onfoot = "rpg",
	m67_grenade = "grenade",
	pipebomb = "pipebomb",
	m79_grenadelauncher = "m79"
}
