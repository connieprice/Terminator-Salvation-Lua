FlyerInput = FlyerInput or class()
function FlyerInput.init(A0_0, A1_1)
	A0_0._acceleration = Vector3()
	A0_0._angular_acceleration = Vector3()
	A0_0:clear()
end
function FlyerInput.clear(A0_2)
	mvector3.set_static(A0_2._acceleration, 0, 0, 0)
	mvector3.set_static(A0_2._angular_acceleration, 0, 0, 0)
	A0_2._aim_target_position = nil
	A0_2._fire = false
	A0_2._miss_dispersion = 0
	A0_2._self_destroy = false
end
function FlyerInput.acceleration(A0_3)
	local L1_4
	L1_4 = A0_3._acceleration
	return L1_4
end
function FlyerInput.set_acceleration(A0_5, A1_6)
	assert(A1_6)
	mvector3.set(A0_5._acceleration, A1_6)
end
function FlyerInput.angular_acceleration(A0_7)
	local L1_8
	L1_8 = A0_7._angular_acceleration
	return L1_8
end
function FlyerInput.set_angular_acceleration(A0_9, A1_10)
	assert(A1_10)
	mvector3.set(A0_9._angular_acceleration, A1_10)
end
function FlyerInput.fire(A0_11)
	local L1_12
	L1_12 = A0_11._fire
	return L1_12
end
function FlyerInput.set_fire(A0_13)
	local L1_14
	A0_13._fire = true
end
function FlyerInput.aim_target_position(A0_15)
	local L1_16
	L1_16 = A0_15._aim_target_position
	return L1_16
end
function FlyerInput.set_aim_target_position(A0_17, A1_18)
	A0_17._aim_target_position = A1_18
end
function FlyerInput.eye_target_position(A0_19)
	local L1_20
	L1_20 = A0_19._eye_target_position
	return L1_20
end
function FlyerInput.set_eye_target_position(A0_21, A1_22)
	A0_21._eye_target_position = A1_22
end
function FlyerInput.miss_dispersion(A0_23)
	local L1_24
	L1_24 = A0_23._miss_dispersion
	return L1_24
end
function FlyerInput.set_miss_dispersion(A0_25, A1_26)
	A0_25._miss_dispersion = A1_26
end
function FlyerInput.set_defensive(A0_27, A1_28)
	A0_27._defensive = A1_28
end
function FlyerInput.is_defensive(A0_29)
	local L1_30
	L1_30 = A0_29._defensive
	return L1_30
end
function FlyerInput.set_self_destroy(A0_31)
	local L1_32
	A0_31._self_destroy = true
end
function FlyerInput.self_destroy(A0_33)
	local L1_34
	L1_34 = A0_33._self_destroy
	return L1_34
end
