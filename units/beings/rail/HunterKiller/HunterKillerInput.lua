HunterKillerInput = HunterKillerInput or class()
function HunterKillerInput.init(A0_0, A1_1)
	A0_0:clear()
end
function HunterKillerInput.clear(A0_2)
	local L1_3
	A0_2._primary_aim_target_position = nil
	A0_2._secondary_aim_target_position = nil
	A0_2._primary_fire = false
	A0_2._secondary_fire = false
	A0_2._miss_dispersion = 0
	A0_2._flare = false
end
function HunterKillerInput.primary_fire(A0_4)
	local L1_5
	L1_5 = A0_4._primary_fire
	return L1_5
end
function HunterKillerInput.secondary_fire(A0_6)
	local L1_7
	L1_7 = A0_6._secondary_fire
	return L1_7
end
function HunterKillerInput.set_primary_fire(A0_8)
	local L1_9
	A0_8._primary_fire = true
end
function HunterKillerInput.set_secondary_fire(A0_10)
	local L1_11
	A0_10._secondary_fire = true
end
function HunterKillerInput.primary_aim_target_position(A0_12)
	local L1_13
	L1_13 = A0_12._primary_aim_target_position
	return L1_13
end
function HunterKillerInput.secondary_aim_target_position(A0_14)
	local L1_15
	L1_15 = A0_14._secondary_aim_target_position
	return L1_15
end
function HunterKillerInput.set_primary_aim_target_position(A0_16, A1_17)
	A0_16._primary_aim_target_position = A1_17
end
function HunterKillerInput.set_secondary_aim_target_position(A0_18, A1_19)
	A0_18._secondary_aim_target_position = A1_19
end
function HunterKillerInput.set_flare(A0_20, A1_21)
	A0_20._flare = A1_21
end
function HunterKillerInput.flare(A0_22)
	local L1_23
	L1_23 = A0_22._flare
	return L1_23
end
