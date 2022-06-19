if not WalkerInput then
	WalkerInput = class()
end
WalkerInput.init = function(l_1_0, l_1_1)
	l_1_0:clear()
end

WalkerInput.clear = function(l_2_0)
	l_2_0._movement = Vector3(0, 0, 0)
	l_2_0._eye_target_position = nil
	l_2_0._primary_aim_target_position = nil
	l_2_0._secondary_aim_target_position = nil
	l_2_0._prepare_primary_fire = false
	l_2_0._primary_fire = false
	l_2_0._prepare_secondary_fire = false
	l_2_0._secondary_fire = false
	l_2_0._special_kill_target = nil
	l_2_0._special_kill_id = nil
	l_2_0._remove_magcharge_attachment_point_name = nil
	do
		local l_2_1 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	end
	 -- WARNING: undefined locals caused missing assignments!
end

WalkerInput.movement = function(l_3_0)
	return l_3_0._movement
end

WalkerInput.set_movement = function(l_4_0, l_4_1)
	l_4_0._movement = l_4_1
end

WalkerInput.eye_target_position = function(l_5_0)
	return l_5_0._eye_target_position
end

WalkerInput.set_eye_target_position = function(l_6_0, l_6_1)
	l_6_0._eye_target_position = l_6_1
end

WalkerInput.set_aim_target_position = function(l_7_0, l_7_1)
	l_7_0:set_primary_aim_target_position(l_7_1)
end

WalkerInput.aim_target_position = function(l_8_0)
	local l_8_1, l_8_2 = l_8_0:primary_aim_target_position, l_8_0
	return l_8_1(l_8_2)
end

WalkerInput.primary_aim_target_position = function(l_9_0)
	return l_9_0._primary_aim_target_position
end

WalkerInput.set_primary_aim_target_position = function(l_10_0, l_10_1)
	l_10_0._primary_aim_target_position = l_10_1
end

WalkerInput.secondary_aim_target_position = function(l_11_0)
	return l_11_0._secondary_aim_target_position
end

WalkerInput.set_secondary_aim_target_position = function(l_12_0, l_12_1)
	l_12_0._secondary_aim_target_position = l_12_1
end

WalkerInput.primary_fire = function(l_13_0)
	return l_13_0._primary_fire
end

WalkerInput.set_primary_fire = function(l_14_0)
	l_14_0._primary_fire = true
end

WalkerInput.set_prepare_primary_fire = function(l_15_0)
	l_15_0._prepare_primary_fire = true
end

WalkerInput.prepare_primary_fire = function(l_16_0)
	return l_16_0._prepare_primary_fire
end

WalkerInput.secondary_fire = function(l_17_0)
	return l_17_0._secondary_fire
end

WalkerInput.set_secondary_fire = function(l_18_0)
	l_18_0._secondary_fire = true
end

WalkerInput.set_prepare_secondary_fire = function(l_19_0)
	l_19_0._prepare_secondary_fire = true
end

WalkerInput.prepare_secondary_fire = function(l_20_0)
	return l_20_0._prepare_secondary_fire
end

WalkerInput.special_kill_target = function(l_21_0)
	return l_21_0._special_kill_target
end

WalkerInput.special_kill_id = function(l_22_0)
	return l_22_0._special_kill_id
end

WalkerInput.special_kill_position = function(l_23_0)
	return l_23_0._special_kill_position
end

WalkerInput.special_kill_rotation = function(l_24_0)
	return l_24_0._special_kill_rotation
end

WalkerInput.set_special_kill = function(l_25_0, l_25_1, l_25_2, l_25_3, l_25_4)
	l_25_0._special_kill_target = l_25_1
	l_25_0._special_kill_id = l_25_2
	l_25_0._special_kill_position = l_25_3
	l_25_0._special_kill_rotation = l_25_4
end

WalkerInput.remove_magcharge_attachment_point_name = function(l_26_0)
	return l_26_0._remove_magcharge_attachment_point_name
end

WalkerInput.set_remove_magcharge = function(l_27_0, l_27_1)
	l_27_0._remove_magcharge_attachment_point_name = l_27_1
end

WalkerInput.miss_dispersions = function(l_28_0)
	local l_28_1 = assert
	l_28_1(#l_28_0._miss_dispersions == 1 or #l_28_0._miss_dispersions == 2)
	l_28_1 = l_28_0._miss_dispersions
	return l_28_1
end

WalkerInput.set_miss_dispersions = function(l_29_0, l_29_1)
	local l_29_2 = assert
	l_29_2(#l_29_1 == 1 or #l_29_1 == 2)
	l_29_0._miss_dispersions = l_29_1
end

WalkerInput.strike_of_death_direction = function(l_30_0)
	return l_30_0._strike_of_death_direction
end

WalkerInput.strike_of_death_target = function(l_31_0)
	return l_31_0._strike_of_death_target
end

WalkerInput.set_strike_of_death = function(l_32_0, l_32_1, l_32_2)
	l_32_0._strike_of_death_direction = l_32_1
	l_32_0._strike_of_death_target = l_32_2
end


