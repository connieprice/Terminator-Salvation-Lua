DebugPrecisionAimableAimSettingsModifier = DebugPrecisionAimableAimSettingsModifier or class()
function DebugPrecisionAimableAimSettingsModifier.update(A0_0, A1_1)
	A0_0:_set_aiming_acceleration_enabled(true)
	if A1_1 then
		A0_0:_set_aiming_values(tweak_data.player.camera.aiming_horizontal_coefficient, tweak_data.player.camera.aiming_horizontal_exponent, tweak_data.player.camera.aiming_horizontal_dead_zone, tweak_data.player.camera.aiming_horizontal_start_value, tweak_data.player.camera.aiming_vertical_coefficient, tweak_data.player.camera.aiming_vertical_exponent, tweak_data.player.camera.aiming_vertical_dead_zone, tweak_data.player.camera.aiming_vertical_start_value)
		A0_0:_set_aiming_acceleration_values(tweak_data.player.camera.aiming_acceleration_threshold, tweak_data.player.camera.aiming_acceleration_time, tweak_data.player.camera.aiming_acceleration_factor)
	else
		A0_0:_set_aiming_values(tweak_data.player.camera.normal_horizontal_coefficient, tweak_data.player.camera.normal_horizontal_exponent, tweak_data.player.camera.normal_horizontal_dead_zone, tweak_data.player.camera.normal_horizontal_start_value, tweak_data.player.camera.normal_vertical_coefficient, tweak_data.player.camera.normal_vertical_exponent, tweak_data.player.camera.normal_vertical_dead_zone, tweak_data.player.camera.normal_vertical_start_value)
		A0_0:_set_aiming_acceleration_values(tweak_data.player.camera.normal_acceleration_threshold, tweak_data.player.camera.normal_acceleration_time, tweak_data.player.camera.normal_acceleration_factor)
	end
end
