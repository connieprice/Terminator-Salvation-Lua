DamageData = DamageData or class()
function DamageData.init(A0_0, A1_1)
	A0_0.damage = 0
	A0_0.health = 1
	A0_0.is_affected_by_explosion_physics_effect = true
end
function DamageData.save(A0_2, A1_3)
	TableAlgorithms.merge_except_functions(A1_3, A0_2)
end
function DamageData.load(A0_4, A1_5)
	TableAlgorithms.merge_except_functions(A0_4, A1_5)
end
function DamageData.revive(A0_6)
	local L1_7
	A0_6.damage = 0
end
function DamageData.is_fully_damaged(A0_8)
	return A0_8.damage >= A0_8.health
end
function DamageData.scale_health(A0_9, A1_10)
	local L2_11, L3_12
	L2_11 = A0_9.damage
	L3_12 = A0_9.health
	L2_11 = L2_11 / L3_12
	A0_9.health = A1_10
	L3_12 = L2_11 * A1_10
	A0_9.damage = L3_12
end
