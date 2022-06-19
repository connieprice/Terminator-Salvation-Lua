RailDriveTestInput = RailDriveTestInput or class()
function RailDriveTestInput.init(A0_0, A1_1)
	A0_0:clear()
end
function RailDriveTestInput.clear(A0_2)
	A0_2._movement = Vector3(0, 0, 0)
	A0_2._aim_target_position = nil
	A0_2._fire = false
end
function RailDriveTestInput.movement(A0_3)
	local L1_4
	L1_4 = A0_3._movement
	return L1_4
end
function RailDriveTestInput.set_movement(A0_5, A1_6)
	A0_5._movement = A1_6
end
function RailDriveTestInput.set_eye_target_position(A0_7, A1_8)
	A0_7._eye_target_position = A1_8
end
function RailDriveTestInput.eye_target_position(A0_9, A1_10)
	local L2_11
	L2_11 = A0_9._eye_target_position
	return L2_11
end
function RailDriveTestInput.aim_target_position(A0_12)
	local L1_13
	L1_13 = A0_12._aim_target_position
	return L1_13
end
function RailDriveTestInput.set_aim_target_position(A0_14, A1_15)
	A0_14._aim_target_position = A1_15
end
function RailDriveTestInput.aim_target_unit(A0_16)
	local L1_17
	L1_17 = A0_16._aim_target_unit
	return L1_17
end
function RailDriveTestInput.set_aim_target_unit(A0_18, A1_19)
	A0_18._aim_target_unit = A1_19
end
function RailDriveTestInput.attack_mode(A0_20)
	local L1_21
	L1_21 = A0_20._attack_mode
	return L1_21
end
function RailDriveTestInput.set_attack_mode(A0_22, A1_23)
	if A1_23 == nil then
		A0_22._attack_mode = true
	else
		A0_22._attack_mode = A1_23
	end
end
function RailDriveTestInput.track(A0_24)
	local L1_25
	L1_25 = A0_24._track
	return L1_25
end
function RailDriveTestInput.set_track(A0_26)
	local L1_27
	A0_26._track = true
end
function RailDriveTestInput.fire(A0_28)
	local L1_29
	L1_29 = A0_28._fire
	return L1_29
end
function RailDriveTestInput.set_fire(A0_30)
	local L1_31
	A0_30._fire = true
end
function RailDriveTestInput.shield_enabled(A0_32)
	local L1_33
	L1_33 = A0_32._shield_enabled
	return L1_33
end
function RailDriveTestInput.enable_shield(A0_34)
	local L1_35
	A0_34._shield_enabled = true
end
function RailDriveTestInput.investigate_mode(A0_36)
	local L1_37
	L1_37 = A0_36._investigate_mode
	return L1_37
end
function RailDriveTestInput.set_investigate_mode(A0_38, A1_39)
	A0_38._investigate_mode = A1_39
end
function RailDriveTestInput.abort_investigate_mode(A0_40)
	local L1_41
	L1_41 = A0_40._abort_investigate_mode
	return L1_41
end
function RailDriveTestInput.set_abort_investigate_mode(A0_42, A1_43)
	A0_42._abort_investigate_mode = A1_43
end
function RailDriveTestInput.charge_direction(A0_44)
	local L1_45
	L1_45 = A0_44._charge_direction
	return L1_45
end
function RailDriveTestInput.set_charge_direction(A0_46, A1_47)
	A0_46._charge_direction = A1_47
end
function RailDriveTestInput.miss_dispersion(A0_48)
	local L1_49
	L1_49 = A0_48._miss_dispersion
	return L1_49
end
function RailDriveTestInput.set_miss_dispersion(A0_50, A1_51)
	A0_50._miss_dispersion = A1_51
end
