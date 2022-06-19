if not DebugPrecisionAimableAimSettingsModifier then
	DebugPrecisionAimableAimSettingsModifier = class()
end
DebugPrecisionAimableAimSettingsModifier.update = function(l_1_0, l_1_1)
	l_1_0:_set_aiming_acceleration_enabled(true)
	local l_1_2 = tweak_data.player.camera
	if l_1_1 then
		l_1_0:_set_aiming_values(l_1_2.aiming_horizontal_coefficient, l_1_2.aiming_horizontal_exponent, l_1_2.aiming_horizontal_dead_zone, l_1_2.aiming_horizontal_start_value, l_1_2.aiming_vertical_coefficient, l_1_2.aiming_vertical_exponent, l_1_2.aiming_vertical_dead_zone, l_1_2.aiming_vertical_start_value)
		l_1_0:_set_aiming_acceleration_values(l_1_2.aiming_acceleration_threshold, l_1_2.aiming_acceleration_time, l_1_2.aiming_acceleration_factor)
	else
		l_1_0:_set_aiming_values(l_1_2.normal_horizontal_coefficient, l_1_2.normal_horizontal_exponent, l_1_2.normal_horizontal_dead_zone, l_1_2.normal_horizontal_start_value, l_1_2.normal_vertical_coefficient, l_1_2.normal_vertical_exponent, l_1_2.normal_vertical_dead_zone, l_1_2.normal_vertical_start_value)
		l_1_0:_set_aiming_acceleration_values(l_1_2.normal_acceleration_threshold, l_1_2.normal_acceleration_time, l_1_2.normal_acceleration_factor)
	end
end


