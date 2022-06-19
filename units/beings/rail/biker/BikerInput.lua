if not BikerInput then
	BikerInput = class()
end
BikerInput.init = function(l_1_0, l_1_1)
	l_1_0:clear()
end

BikerInput.clear = function(l_2_0)
	l_2_0._aim_target_position = Vector3(0, 0, 100)
	l_2_0._primary_fire = false
	l_2_0._secondary_fire = false
	l_2_0._primary_damage = nil
	l_2_0._secondary_damage = nil
	l_2_0._speed = nil
	l_2_0._warp = false
	l_2_0._warp_distance = nil
	l_2_0._target_unit = nil
end

BikerInput.primary_fire = function(l_3_0)
	return l_3_0._primary_fire
end

BikerInput.secondary_fire = function(l_4_0)
	return l_4_0._secondary_fire
end

BikerInput.set_primary_fire = function(l_5_0)
	l_5_0._primary_fire = true
end

BikerInput.set_secondary_fire = function(l_6_0)
	l_6_0._secondary_fire = true
end

BikerInput.primary_damage = function(l_7_0)
	return l_7_0._primary_damage
end

BikerInput.set_primary_damage = function(l_8_0, l_8_1)
	l_8_0._primary_damage = l_8_1
end

BikerInput.secondary_damage = function(l_9_0)
	return l_9_0._secondary_damage
end

BikerInput.set_secondary_damage = function(l_10_0, l_10_1)
	l_10_0._secondary_damage = l_10_1
end

BikerInput.speed = function(l_11_0)
	return l_11_0._speed
end

BikerInput.set_speed = function(l_12_0, l_12_1)
	l_12_0._speed = l_12_1
end

BikerInput.warp = function(l_13_0)
	return l_13_0._warp
end

BikerInput.set_warp = function(l_14_0)
	l_14_0._warp = true
end

BikerInput.warp_distance = function(l_15_0)
	return l_15_0._warp_distance
end

BikerInput.set_warp_distance = function(l_16_0, l_16_1)
	l_16_0._warp_distance = l_16_1
end

BikerInput.target_unit = function(l_17_0)
	return l_17_0._target_unit
end

BikerInput.set_target_unit = function(l_18_0, l_18_1)
	l_18_0._target_unit = l_18_1
end


