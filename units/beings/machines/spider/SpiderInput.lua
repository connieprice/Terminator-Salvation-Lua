SpiderInput = SpiderInput or class()
function SpiderInput.init(A0_0, A1_1)
	A0_0:clear()
end
function SpiderInput.clear(A0_2)
	A0_2._movement = Vector3(0, 0, 0)
	A0_2._aim_target_position = nil
	A0_2._eye_target_position = nil
	A0_2._aim_target_unit = nil
	A0_2._track = false
	A0_2._attack_mode = false
	A0_2._fire = false
	A0_2._is_scanning = false
	A0_2._charge_direction = nil
	A0_2._miss_dispersion = 0
	A0_2._wants_to_look_at = false
end
function SpiderInput.wants_to_look_at(A0_3)
	local L1_4
	L1_4 = A0_3._wants_to_look_at
	return L1_4
end
function SpiderInput.set_wants_to_look_at(A0_5, A1_6)
	A0_5._wants_to_look_at = A1_6
end
function SpiderInput.movement(A0_7)
	local L1_8
	L1_8 = A0_7._movement
	return L1_8
end
function SpiderInput.set_movement(A0_9, A1_10)
	A0_9._movement = A1_10
end
function SpiderInput.set_eye_target_position(A0_11, A1_12)
	A0_11._eye_target_position = A1_12
end
function SpiderInput.eye_target_position(A0_13, A1_14)
	local L2_15
	L2_15 = A0_13._eye_target_position
	return L2_15
end
function SpiderInput.aim_target_position(A0_16)
	local L1_17
	L1_17 = A0_16._aim_target_position
	return L1_17
end
function SpiderInput.set_aim_target_position(A0_18, A1_19)
	A0_18._aim_target_position = A1_19
end
function SpiderInput.aim_target_unit(A0_20)
	local L1_21
	L1_21 = A0_20._aim_target_unit
	return L1_21
end
function SpiderInput.set_aim_target_unit(A0_22, A1_23)
	A0_22._aim_target_unit = A1_23
end
function SpiderInput.attack_mode(A0_24)
	local L1_25
	L1_25 = A0_24._attack_mode
	return L1_25
end
function SpiderInput.set_attack_mode(A0_26, A1_27)
	if A1_27 == nil then
		A0_26._attack_mode = true
	else
		A0_26._attack_mode = A1_27
	end
end
function SpiderInput.track(A0_28)
	local L1_29
	L1_29 = A0_28._track
	return L1_29
end
function SpiderInput.set_track(A0_30)
	local L1_31
	A0_30._track = true
end
function SpiderInput.fire(A0_32)
	local L1_33
	L1_33 = A0_32._fire
	return L1_33
end
function SpiderInput.set_fire(A0_34)
	local L1_35
	A0_34._fire = true
end
function SpiderInput.is_scanning(A0_36)
	local L1_37
	L1_37 = A0_36._is_scanning
	return L1_37
end
function SpiderInput.set_is_scanning(A0_38, A1_39)
	A0_38._is_scanning = A1_39
end
function SpiderInput.scan_started(A0_40)
	local L1_41
	L1_41 = A0_40._scan_negative_flank
	return L1_41
end
function SpiderInput.scan_stopped(A0_42)
	local L1_43
	L1_43 = A0_42._scan_positive_flank
	return L1_43
end
function SpiderInput.charge_direction(A0_44)
	local L1_45
	L1_45 = A0_44._charge_direction
	return L1_45
end
function SpiderInput.set_charge_direction(A0_46, A1_47)
	A0_46._charge_direction = A1_47
end
function SpiderInput.miss_dispersion(A0_48)
	local L1_49
	L1_49 = A0_48._miss_dispersion
	return L1_49
end
function SpiderInput.set_miss_dispersion(A0_50, A1_51)
	A0_50._miss_dispersion = A1_51
end
