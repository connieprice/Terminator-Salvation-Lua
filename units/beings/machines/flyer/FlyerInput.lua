if not FlyerInput then
	FlyerInput = class()
end
FlyerInput.init = function(l_1_0, l_1_1)
	l_1_0._acceleration = Vector3()
	l_1_0._angular_acceleration = Vector3()
	l_1_0:clear()
end

FlyerInput.clear = function(l_2_0)
	mvector3.set_static(l_2_0._acceleration, 0, 0, 0)
	mvector3.set_static(l_2_0._angular_acceleration, 0, 0, 0)
	l_2_0._aim_target_position = nil
	l_2_0._fire = false
	l_2_0._miss_dispersion = 0
	l_2_0._self_destroy = false
end

FlyerInput.acceleration = function(l_3_0)
	return l_3_0._acceleration
end

FlyerInput.set_acceleration = function(l_4_0, l_4_1)
	assert(l_4_1)
	mvector3.set(l_4_0._acceleration, l_4_1)
end

FlyerInput.angular_acceleration = function(l_5_0)
	return l_5_0._angular_acceleration
end

FlyerInput.set_angular_acceleration = function(l_6_0, l_6_1)
	assert(l_6_1)
	mvector3.set(l_6_0._angular_acceleration, l_6_1)
end

FlyerInput.fire = function(l_7_0)
	return l_7_0._fire
end

FlyerInput.set_fire = function(l_8_0)
	l_8_0._fire = true
end

FlyerInput.aim_target_position = function(l_9_0)
	return l_9_0._aim_target_position
end

FlyerInput.set_aim_target_position = function(l_10_0, l_10_1)
	l_10_0._aim_target_position = l_10_1
end

FlyerInput.eye_target_position = function(l_11_0)
	return l_11_0._eye_target_position
end

FlyerInput.set_eye_target_position = function(l_12_0, l_12_1)
	l_12_0._eye_target_position = l_12_1
end

FlyerInput.miss_dispersion = function(l_13_0)
	return l_13_0._miss_dispersion
end

FlyerInput.set_miss_dispersion = function(l_14_0, l_14_1)
	l_14_0._miss_dispersion = l_14_1
end

FlyerInput.set_defensive = function(l_15_0, l_15_1)
	l_15_0._defensive = l_15_1
end

FlyerInput.is_defensive = function(l_16_0)
	return l_16_0._defensive
end

FlyerInput.set_self_destroy = function(l_17_0)
	l_17_0._self_destroy = true
end

FlyerInput.self_destroy = function(l_18_0)
	return l_18_0._self_destroy
end


