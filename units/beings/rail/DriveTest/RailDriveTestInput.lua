if not RailDriveTestInput then
	RailDriveTestInput = class()
end
RailDriveTestInput.init = function(l_1_0, l_1_1)
	l_1_0:clear()
end

RailDriveTestInput.clear = function(l_2_0)
	l_2_0._movement = Vector3(0, 0, 0)
	l_2_0._aim_target_position = nil
	l_2_0._fire = false
end

RailDriveTestInput.movement = function(l_3_0)
	return l_3_0._movement
end

RailDriveTestInput.set_movement = function(l_4_0, l_4_1)
	l_4_0._movement = l_4_1
end

RailDriveTestInput.set_eye_target_position = function(l_5_0, l_5_1)
	l_5_0._eye_target_position = l_5_1
end

RailDriveTestInput.eye_target_position = function(l_6_0, l_6_1)
	return l_6_0._eye_target_position
end

RailDriveTestInput.aim_target_position = function(l_7_0)
	return l_7_0._aim_target_position
end

RailDriveTestInput.set_aim_target_position = function(l_8_0, l_8_1)
	l_8_0._aim_target_position = l_8_1
end

RailDriveTestInput.aim_target_unit = function(l_9_0)
	return l_9_0._aim_target_unit
end

RailDriveTestInput.set_aim_target_unit = function(l_10_0, l_10_1)
	l_10_0._aim_target_unit = l_10_1
end

RailDriveTestInput.attack_mode = function(l_11_0)
	return l_11_0._attack_mode
end

RailDriveTestInput.set_attack_mode = function(l_12_0, l_12_1)
	if l_12_1 == nil then
		l_12_0._attack_mode = true
	else
		l_12_0._attack_mode = l_12_1
	end
end

RailDriveTestInput.track = function(l_13_0)
	return l_13_0._track
end

RailDriveTestInput.set_track = function(l_14_0)
	l_14_0._track = true
end

RailDriveTestInput.fire = function(l_15_0)
	return l_15_0._fire
end

RailDriveTestInput.set_fire = function(l_16_0)
	l_16_0._fire = true
end

RailDriveTestInput.shield_enabled = function(l_17_0)
	return l_17_0._shield_enabled
end

RailDriveTestInput.enable_shield = function(l_18_0)
	l_18_0._shield_enabled = true
end

RailDriveTestInput.investigate_mode = function(l_19_0)
	return l_19_0._investigate_mode
end

RailDriveTestInput.set_investigate_mode = function(l_20_0, l_20_1)
	l_20_0._investigate_mode = l_20_1
end

RailDriveTestInput.abort_investigate_mode = function(l_21_0)
	return l_21_0._abort_investigate_mode
end

RailDriveTestInput.set_abort_investigate_mode = function(l_22_0, l_22_1)
	l_22_0._abort_investigate_mode = l_22_1
end

RailDriveTestInput.charge_direction = function(l_23_0)
	return l_23_0._charge_direction
end

RailDriveTestInput.set_charge_direction = function(l_24_0, l_24_1)
	l_24_0._charge_direction = l_24_1
end

RailDriveTestInput.miss_dispersion = function(l_25_0)
	return l_25_0._miss_dispersion
end

RailDriveTestInput.set_miss_dispersion = function(l_26_0, l_26_1)
	l_26_0._miss_dispersion = l_26_1
end


