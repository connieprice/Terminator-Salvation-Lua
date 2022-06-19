require("units/beings/CharacterInput")
if not PlayerTankInput then
	PlayerTankInput = class(CharacterInput)
end
PlayerTankInputAccessControlled = access_control_wrapper(PlayerTankInput)
PlayerTankInput.init = function(l_1_0, l_1_1)
	CharacterInput.init(l_1_0, l_1_1)
end

PlayerTankInput.clear = function(l_2_0)
	l_2_0._aim_target_position = nil
	l_2_0._eye_target_position = nil
	l_2_0._primary_fire_l = false
	l_2_0._primary_fire_r = false
	l_2_0._secondary_fire_l = false
	l_2_0._secondary_fire_r = false
	l_2_0._miss_dispersion = 0
	l_2_0._look_input_axis = nil
	CharacterInput.clear(l_2_0)
end

PlayerTankInput.set_primary_fire_l = function(l_3_0)
	l_3_0._primary_fire_l = true
end

PlayerTankInput.set_primary_fire_r = function(l_4_0)
	l_4_0._primary_fire_r = true
end

PlayerTankInput.set_secondary_fire_l = function(l_5_0)
	l_5_0._secondary_fire_l = true
end

PlayerTankInput.set_secondary_fire_r = function(l_6_0)
	l_6_0._secondary_fire_r = true
end

PlayerTankInput.set_look_input_axis = function(l_7_0, l_7_1)
	l_7_0._look_input_axis = l_7_1
end

PlayerTankInput.primary_fire_l = function(l_8_0)
	return l_8_0._primary_fire_l
end

PlayerTankInput.primary_fire_r = function(l_9_0)
	return l_9_0._primary_fire_r
end

PlayerTankInput.secondary_fire_l = function(l_10_0)
	return l_10_0._secondary_fire_l
end

PlayerTankInput.secondary_fire_r = function(l_11_0)
	return l_11_0._secondary_fire_r
end

PlayerTankInput.look_input_axis = function(l_12_0)
	return l_12_0._look_input_axis
end


