WalkerInput = WalkerInput or class()
function WalkerInput.init(A0_0, A1_1)
	A0_0:clear()
end
function WalkerInput.clear(A0_2)
	A0_2._movement = Vector3(0, 0, 0)
	A0_2._eye_target_position = nil
	A0_2._primary_aim_target_position = nil
	A0_2._secondary_aim_target_position = nil
	A0_2._prepare_primary_fire = false
	A0_2._primary_fire = false
	A0_2._prepare_secondary_fire = false
	A0_2._secondary_fire = false
	A0_2._special_kill_target = nil
	A0_2._special_kill_id = nil
	A0_2._remove_magcharge_attachment_point_name = nil
	A0_2._miss_dispersions = {0, 0}
	A0_2._strike_of_death_direction = nil
	A0_2._strike_of_death_target = nil
end
function WalkerInput.movement(A0_3)
	local L1_4
	L1_4 = A0_3._movement
	return L1_4
end
function WalkerInput.set_movement(A0_5, A1_6)
	A0_5._movement = A1_6
end
function WalkerInput.eye_target_position(A0_7)
	local L1_8
	L1_8 = A0_7._eye_target_position
	return L1_8
end
function WalkerInput.set_eye_target_position(A0_9, A1_10)
	A0_9._eye_target_position = A1_10
end
function WalkerInput.set_aim_target_position(A0_11, A1_12)
	A0_11:set_primary_aim_target_position(A1_12)
end
function WalkerInput.aim_target_position(A0_13)
	return A0_13:primary_aim_target_position()
end
function WalkerInput.primary_aim_target_position(A0_14)
	local L1_15
	L1_15 = A0_14._primary_aim_target_position
	return L1_15
end
function WalkerInput.set_primary_aim_target_position(A0_16, A1_17)
	A0_16._primary_aim_target_position = A1_17
end
function WalkerInput.secondary_aim_target_position(A0_18)
	local L1_19
	L1_19 = A0_18._secondary_aim_target_position
	return L1_19
end
function WalkerInput.set_secondary_aim_target_position(A0_20, A1_21)
	A0_20._secondary_aim_target_position = A1_21
end
function WalkerInput.primary_fire(A0_22)
	local L1_23
	L1_23 = A0_22._primary_fire
	return L1_23
end
function WalkerInput.set_primary_fire(A0_24)
	local L1_25
	A0_24._primary_fire = true
end
function WalkerInput.set_prepare_primary_fire(A0_26)
	local L1_27
	A0_26._prepare_primary_fire = true
end
function WalkerInput.prepare_primary_fire(A0_28)
	local L1_29
	L1_29 = A0_28._prepare_primary_fire
	return L1_29
end
function WalkerInput.secondary_fire(A0_30)
	local L1_31
	L1_31 = A0_30._secondary_fire
	return L1_31
end
function WalkerInput.set_secondary_fire(A0_32)
	local L1_33
	A0_32._secondary_fire = true
end
function WalkerInput.set_prepare_secondary_fire(A0_34)
	local L1_35
	A0_34._prepare_secondary_fire = true
end
function WalkerInput.prepare_secondary_fire(A0_36)
	local L1_37
	L1_37 = A0_36._prepare_secondary_fire
	return L1_37
end
function WalkerInput.special_kill_target(A0_38)
	local L1_39
	L1_39 = A0_38._special_kill_target
	return L1_39
end
function WalkerInput.special_kill_id(A0_40)
	local L1_41
	L1_41 = A0_40._special_kill_id
	return L1_41
end
function WalkerInput.special_kill_position(A0_42)
	local L1_43
	L1_43 = A0_42._special_kill_position
	return L1_43
end
function WalkerInput.special_kill_rotation(A0_44)
	local L1_45
	L1_45 = A0_44._special_kill_rotation
	return L1_45
end
function WalkerInput.set_special_kill(A0_46, A1_47, A2_48, A3_49, A4_50)
	A0_46._special_kill_target = A1_47
	A0_46._special_kill_id = A2_48
	A0_46._special_kill_position = A3_49
	A0_46._special_kill_rotation = A4_50
end
function WalkerInput.remove_magcharge_attachment_point_name(A0_51)
	local L1_52
	L1_52 = A0_51._remove_magcharge_attachment_point_name
	return L1_52
end
function WalkerInput.set_remove_magcharge(A0_53, A1_54)
	A0_53._remove_magcharge_attachment_point_name = A1_54
end
function WalkerInput.miss_dispersions(A0_55)
	assert(#A0_55._miss_dispersions == 1 or #A0_55._miss_dispersions == 2)
	return A0_55._miss_dispersions
end
function WalkerInput.set_miss_dispersions(A0_56, A1_57)
	assert(#A1_57 == 1 or #A1_57 == 2)
	A0_56._miss_dispersions = A1_57
end
function WalkerInput.strike_of_death_direction(A0_58)
	local L1_59
	L1_59 = A0_58._strike_of_death_direction
	return L1_59
end
function WalkerInput.strike_of_death_target(A0_60)
	local L1_61
	L1_61 = A0_60._strike_of_death_target
	return L1_61
end
function WalkerInput.set_strike_of_death(A0_62, A1_63, A2_64)
	A0_62._strike_of_death_direction = A1_63
	A0_62._strike_of_death_target = A2_64
end
