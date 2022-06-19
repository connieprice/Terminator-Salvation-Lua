if not SkynetDefenceTurretInput then
	SkynetDefenceTurretInput = class()
end
SkynetDefenceTurretInput.init = function(l_1_0, l_1_1)
	l_1_0:clear()
end

SkynetDefenceTurretInput.clear = function(l_2_0)
	l_2_0._aim_target_position = nil
	l_2_0._aim_target_position_missile = nil
	l_2_0._fire_missile = false
	l_2_0._fire_gatling = false
end

SkynetDefenceTurretInput.fire_missile = function(l_3_0)
	return l_3_0._fire_missile
end

SkynetDefenceTurretInput.set_fire_missile = function(l_4_0)
	l_4_0._fire_missile = true
end

SkynetDefenceTurretInput.fire_gatling = function(l_5_0)
	return l_5_0._fire_gatling
end

SkynetDefenceTurretInput.set_fire_gatling = function(l_6_0)
	l_6_0._fire_gatling = true
end

SkynetDefenceTurretInput.aim_target_position = function(l_7_0)
	return l_7_0._aim_target_position
end

SkynetDefenceTurretInput.set_aim_target_position = function(l_8_0, l_8_1)
	l_8_0._aim_target_position = l_8_1
end

SkynetDefenceTurretInput.aim_target_position_missile = function(l_9_0)
	return l_9_0._aim_target_position_missile
end

SkynetDefenceTurretInput.set_aim_target_position_missile = function(l_10_0, l_10_1)
	l_10_0._aim_target_position_missile = l_10_1
end

SkynetDefenceTurretInput.miss_dispersion = function(l_11_0)
	return l_11_0._miss_dispersion
end

SkynetDefenceTurretInput.set_miss_dispersion = function(l_12_0, l_12_1)
	l_12_0._miss_dispersion = l_12_1
end


