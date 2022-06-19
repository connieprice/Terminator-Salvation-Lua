BikerInput = BikerInput or class()
function BikerInput.init(A0_0, A1_1)
	A0_0:clear()
end
function BikerInput.clear(A0_2)
	A0_2._aim_target_position = Vector3(0, 0, 100)
	A0_2._primary_fire = false
	A0_2._secondary_fire = false
	A0_2._primary_damage = nil
	A0_2._secondary_damage = nil
	A0_2._speed = nil
	A0_2._warp = false
	A0_2._warp_distance = nil
	A0_2._target_unit = nil
end
function BikerInput.primary_fire(A0_3)
	local L1_4
	L1_4 = A0_3._primary_fire
	return L1_4
end
function BikerInput.secondary_fire(A0_5)
	local L1_6
	L1_6 = A0_5._secondary_fire
	return L1_6
end
function BikerInput.set_primary_fire(A0_7)
	local L1_8
	A0_7._primary_fire = true
end
function BikerInput.set_secondary_fire(A0_9)
	local L1_10
	A0_9._secondary_fire = true
end
function BikerInput.primary_damage(A0_11)
	local L1_12
	L1_12 = A0_11._primary_damage
	return L1_12
end
function BikerInput.set_primary_damage(A0_13, A1_14)
	A0_13._primary_damage = A1_14
end
function BikerInput.secondary_damage(A0_15)
	local L1_16
	L1_16 = A0_15._secondary_damage
	return L1_16
end
function BikerInput.set_secondary_damage(A0_17, A1_18)
	A0_17._secondary_damage = A1_18
end
function BikerInput.speed(A0_19)
	local L1_20
	L1_20 = A0_19._speed
	return L1_20
end
function BikerInput.set_speed(A0_21, A1_22)
	A0_21._speed = A1_22
end
function BikerInput.warp(A0_23)
	local L1_24
	L1_24 = A0_23._warp
	return L1_24
end
function BikerInput.set_warp(A0_25)
	local L1_26
	A0_25._warp = true
end
function BikerInput.warp_distance(A0_27)
	local L1_28
	L1_28 = A0_27._warp_distance
	return L1_28
end
function BikerInput.set_warp_distance(A0_29, A1_30)
	A0_29._warp_distance = A1_30
end
function BikerInput.target_unit(A0_31)
	local L1_32
	L1_32 = A0_31._target_unit
	return L1_32
end
function BikerInput.set_target_unit(A0_33, A1_34)
	A0_33._target_unit = A1_34
end
