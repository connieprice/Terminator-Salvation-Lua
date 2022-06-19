if not HunterKillerInput then
	HunterKillerInput = class()
end
HunterKillerInput.init = function(l_1_0, l_1_1)
	l_1_0:clear()
end

HunterKillerInput.clear = function(l_2_0)
	l_2_0._primary_aim_target_position = nil
	l_2_0._secondary_aim_target_position = nil
	l_2_0._primary_fire = false
	l_2_0._secondary_fire = false
	l_2_0._miss_dispersion = 0
	l_2_0._flare = false
end

HunterKillerInput.primary_fire = function(l_3_0)
	return l_3_0._primary_fire
end

HunterKillerInput.secondary_fire = function(l_4_0)
	return l_4_0._secondary_fire
end

HunterKillerInput.set_primary_fire = function(l_5_0)
	l_5_0._primary_fire = true
end

HunterKillerInput.set_secondary_fire = function(l_6_0)
	l_6_0._secondary_fire = true
end

HunterKillerInput.primary_aim_target_position = function(l_7_0)
	return l_7_0._primary_aim_target_position
end

HunterKillerInput.secondary_aim_target_position = function(l_8_0)
	return l_8_0._secondary_aim_target_position
end

HunterKillerInput.set_primary_aim_target_position = function(l_9_0, l_9_1)
	l_9_0._primary_aim_target_position = l_9_1
end

HunterKillerInput.set_secondary_aim_target_position = function(l_10_0, l_10_1)
	l_10_0._secondary_aim_target_position = l_10_1
end

HunterKillerInput.set_flare = function(l_11_0, l_11_1)
	l_11_0._flare = l_11_1
end

HunterKillerInput.flare = function(l_12_0)
	return l_12_0._flare
end


