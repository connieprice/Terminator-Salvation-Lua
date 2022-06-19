SimpleRandomGenerator = SimpleRandomGenerator or class()
function SimpleRandomGenerator.init(A0_0, A1_1)
	A0_0._rand_number = A1_1
end
function SimpleRandomGenerator.rand(A0_2)
	local L1_3
	L1_3 = A0_2._rand_number
	L1_3 = L1_3 + 1
	L1_3 = L1_3 * 75
	L1_3 = L1_3 - 1
	L1_3 = L1_3 % 65537
	A0_2._rand_number = L1_3
	L1_3 = A0_2._rand_number
	return L1_3
end
