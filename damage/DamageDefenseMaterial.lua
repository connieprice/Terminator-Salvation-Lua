DamageDefenseMaterial = DamageDefenseMaterial or class()
function DamageDefenseMaterial.init(A0_0)
	local L1_1
end
function DamageDefenseMaterial.calculate_damage(A0_2, A1_3)
	local L2_4, L3_5
	L2_4 = assert
	L3_5 = A1_3.damage_factor
	L3_5 = L3_5 >= 0
	L2_4(L3_5)
	L2_4, L3_5 = nil, nil
	for 