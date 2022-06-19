PhysicsModifier = PhysicsModifier or class()
function PhysicsModifier.init(A0_0, A1_1)
	A0_0._acceleration = 0
	A0_0._velocity = 0
	A0_0._value = A1_1 or 0
	A0_0._damping_constant = 0
end
function PhysicsModifier.set_acceleration(A0_2, A1_3)
	A0_2._acceleration = A1_3
	A0_2._velocity_limit = 0
end
function PhysicsModifier.set_velocity_limit(A0_4, A1_5)
	A0_4._velocity_limit = A1_5
end
function PhysicsModifier.set_spring(A0_6, A1_7, A2_8, A3_9)
	A0_6._length = A1_7
	A0_6._position = A2_8
	A0_6._spring_constant = A3_9
end
function PhysicsModifier.set_damper(A0_10, A1_11, A2_12)
	A0_10._damping_constant = A1_11
	if A2_12 then
		A0_10._spring_damping_constant = A2_12
	else
		A0_10._spring_damping_constant = A1_11
	end
end
function PhysicsModifier.update(A0_13, A1_14)
	local L2_15, L3_16
	L3_16 = A0_13._value
	L3_16 = L3_16 - A0_13._position
	if math.abs(L3_16) > A0_13._length then
		if L3_16 > 0 then
		else
		end
		L2_15 = A0_13._acceleration + -(A0_13._value - (A0_13._position - A0_13._length)) * A0_13._spring_constant - A0_13._spring_damping_constant * A0_13._velocity
	else
		L2_15 = A0_13._acceleration - A0_13._damping_constant * A0_13._velocity
	end
	A0_13._velocity = A0_13._velocity + L2_15 * A1_14
	A0_13._velocity = math.clamp(A0_13._velocity, -A0_13._velocity_limit, A0_13._velocity_limit)
	A0_13._value = A0_13._value + A0_13._velocity * A1_14
end
function PhysicsModifier.value(A0_17)
	local L1_18
	L1_18 = A0_17._value
	return L1_18
end
function PhysicsModifier.velocity(A0_19)
	local L1_20
	L1_20 = A0_19._velocity
	return L1_20
end
