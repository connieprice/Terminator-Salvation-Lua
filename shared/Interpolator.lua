require("shared/TableAlgorithms")
Interpolator = Interpolator or class()
function Interpolator.init(A0_0, A1_1, A2_2)
	A0_0._value = A1_1
	A0_0._target = A1_1
	A0_0._speed = A2_2
	A0_0._reached_target = false
end
function Interpolator.save(A0_3, A1_4)
	TableAlgorithms.merge_except_functions(A1_4, A0_3)
end
function Interpolator.load(A0_5, A1_6)
	TableAlgorithms.merge_except_functions(A0_5, A1_6)
end
function Interpolator.update(A0_7, A1_8)
	local L2_9
	L2_9 = A0_7._target
	L2_9 = L2_9 - A0_7._value
	A0_7._value = A0_7._value + math.min(A0_7._speed * A1_8, 1) * L2_9
	if math.abs(A0_7._value - A0_7._target) < 1.0E-4 then
		A0_7._value = A0_7._target
	end
end
function Interpolator.set_target(A0_10, A1_11)
	A0_10._target = A1_11
end
function Interpolator.set_speed(A0_12, A1_13)
	A0_12._speed = A1_13
end
function Interpolator.set_value(A0_14, A1_15)
	A0_14._value = A1_15
	A0_14._target = A1_15
end
function Interpolator.value(A0_16)
	local L1_17
	L1_17 = A0_16._value
	return L1_17
end
function Interpolator.target(A0_18)
	local L1_19
	L1_19 = A0_18._target
	return L1_19
end
function Interpolator.has_reached_target(A0_20)
	return A0_20._value == A0_20._target
end
function Interpolator.has_reached_target_vec(A0_21)
	return (A0_21._target - A0_21._value):length() < 0.01
end
