if not SpiderInput then
	SpiderInput = class()
end
SpiderInput.init = function(l_1_0, l_1_1)
	l_1_0:clear()
end

SpiderInput.clear = function(l_2_0)
	l_2_0._movement = Vector3(0, 0, 0)
	l_2_0._aim_target_position = nil
	l_2_0._eye_target_position = nil
	l_2_0._aim_target_unit = nil
	l_2_0._track = false
	l_2_0._attack_mode = false
	l_2_0._fire = false
	l_2_0._is_scanning = false
	l_2_0._charge_direction = nil
	l_2_0._miss_dispersion = 0
	l_2_0._wants_to_look_at = false
end

SpiderInput.wants_to_look_at = function(l_3_0)
	return l_3_0._wants_to_look_at
end

SpiderInput.set_wants_to_look_at = function(l_4_0, l_4_1)
	l_4_0._wants_to_look_at = l_4_1
end

SpiderInput.movement = function(l_5_0)
	return l_5_0._movement
end

SpiderInput.set_movement = function(l_6_0, l_6_1)
	l_6_0._movement = l_6_1
end

SpiderInput.set_eye_target_position = function(l_7_0, l_7_1)
	l_7_0._eye_target_position = l_7_1
end

SpiderInput.eye_target_position = function(l_8_0, l_8_1)
	return l_8_0._eye_target_position
end

SpiderInput.aim_target_position = function(l_9_0)
	return l_9_0._aim_target_position
end

SpiderInput.set_aim_target_position = function(l_10_0, l_10_1)
	l_10_0._aim_target_position = l_10_1
end

SpiderInput.aim_target_unit = function(l_11_0)
	return l_11_0._aim_target_unit
end

SpiderInput.set_aim_target_unit = function(l_12_0, l_12_1)
	l_12_0._aim_target_unit = l_12_1
end

SpiderInput.attack_mode = function(l_13_0)
	return l_13_0._attack_mode
end

SpiderInput.set_attack_mode = function(l_14_0, l_14_1)
	if l_14_1 == nil then
		l_14_0._attack_mode = true
	else
		l_14_0._attack_mode = l_14_1
	end
end

SpiderInput.track = function(l_15_0)
	return l_15_0._track
end

SpiderInput.set_track = function(l_16_0)
	l_16_0._track = true
end

SpiderInput.fire = function(l_17_0)
	return l_17_0._fire
end

SpiderInput.set_fire = function(l_18_0)
	l_18_0._fire = true
end

SpiderInput.is_scanning = function(l_19_0)
	return l_19_0._is_scanning
end

SpiderInput.set_is_scanning = function(l_20_0, l_20_1)
	l_20_0._is_scanning = l_20_1
end

SpiderInput.scan_started = function(l_21_0)
	return l_21_0._scan_negative_flank
end

SpiderInput.scan_stopped = function(l_22_0)
	return l_22_0._scan_positive_flank
end

SpiderInput.charge_direction = function(l_23_0)
	return l_23_0._charge_direction
end

SpiderInput.set_charge_direction = function(l_24_0, l_24_1)
	l_24_0._charge_direction = l_24_1
end

SpiderInput.miss_dispersion = function(l_25_0)
	return l_25_0._miss_dispersion
end

SpiderInput.set_miss_dispersion = function(l_26_0, l_26_1)
	l_26_0._miss_dispersion = l_26_1
end


