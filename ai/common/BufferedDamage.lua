BufferedDamage = BufferedDamage or class()
function BufferedDamage.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._attack_unit = A3_3
	A0_0._damage = A1_1
	A0_0._direction = A2_2
	A0_0._read = false
end
function BufferedDamage.equal(A0_4, A1_5, A2_6)
	if A2_6 ~= A0_4._attack_unit then
		return false
	end
	if mvector3.dot(A1_5, A0_4._direction) < 0.9 then
		return false
	end
	return true
end
function BufferedDamage.add_damage(A0_7, A1_8)
	local L2_9
	L2_9 = A0_7._damage
	L2_9 = L2_9 + A1_8
	A0_7._damage = L2_9
end
function BufferedDamage.direction(A0_10)
	local L1_11
	L1_11 = A0_10._direction
	return L1_11
end
function BufferedDamage.damage(A0_12)
	local L1_13
	L1_13 = A0_12._damage
	return L1_13
end
function BufferedDamage.read(A0_14)
	local L1_15
	L1_15 = A0_14._read
	return L1_15
end
function BufferedDamage.set_read(A0_16)
	local L1_17
	A0_16._read = true
end
