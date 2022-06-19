require("units/beings/CharacterInput")
PlayerTankInput = PlayerTankInput or class(CharacterInput)
PlayerTankInputAccessControlled = access_control_wrapper(PlayerTankInput)
function PlayerTankInput.init(A0_0, A1_1)
	CharacterInput.init(A0_0, A1_1)
end
function PlayerTankInput.clear(A0_2)
	A0_2._aim_target_position = nil
	A0_2._eye_target_position = nil
	A0_2._primary_fire_l = false
	A0_2._primary_fire_r = false
	A0_2._secondary_fire_l = false
	A0_2._secondary_fire_r = false
	A0_2._miss_dispersion = 0
	A0_2._look_input_axis = nil
	CharacterInput.clear(A0_2)
end
function PlayerTankInput.set_primary_fire_l(A0_3)
	local L1_4
	A0_3._primary_fire_l = true
end
function PlayerTankInput.set_primary_fire_r(A0_5)
	local L1_6
	A0_5._primary_fire_r = true
end
function PlayerTankInput.set_secondary_fire_l(A0_7)
	local L1_8
	A0_7._secondary_fire_l = true
end
function PlayerTankInput.set_secondary_fire_r(A0_9)
	local L1_10
	A0_9._secondary_fire_r = true
end
function PlayerTankInput.set_look_input_axis(A0_11, A1_12)
	A0_11._look_input_axis = A1_12
end
function PlayerTankInput.primary_fire_l(A0_13)
	local L1_14
	L1_14 = A0_13._primary_fire_l
	return L1_14
end
function PlayerTankInput.primary_fire_r(A0_15)
	local L1_16
	L1_16 = A0_15._primary_fire_r
	return L1_16
end
function PlayerTankInput.secondary_fire_l(A0_17)
	local L1_18
	L1_18 = A0_17._secondary_fire_l
	return L1_18
end
function PlayerTankInput.secondary_fire_r(A0_19)
	local L1_20
	L1_20 = A0_19._secondary_fire_r
	return L1_20
end
function PlayerTankInput.look_input_axis(A0_21)
	local L1_22
	L1_22 = A0_21._look_input_axis
	return L1_22
end
