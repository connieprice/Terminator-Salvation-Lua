require("damage/DamageDefenseMaterial")
DamageDefenseMaterialManager = DamageDefenseMaterialManager or class()
function DamageDefenseMaterialManager.init(A0_0)
	A0_0._name_to_material = {}
	A0_0:_load_materials(File:new_parse_xml("data/settings/damage_defense_materials.xml"):children())
end
function DamageDefenseMaterialManager._load_materials(A0_1, A1_2)
	local L2_3, L3_4, L4_5, L5_6, L6_7, L7_8
	for L5_6 in A1_2, nil, nil do
		L7_8 = L5_6
		L6_7 = L5_6.parameter
		L6_7 = L6_7(L7_8, "name")
		L7_8 = DamageDefenseMaterial
		L7_8 = L7_8.new
		L7_8 = L7_8(L7_8, L6_7)
		A0_1._name_to_material[L6_7] = L7_8
		A0_1:_setup_known_damage_types(L7_8, L5_6)
	end
end
function DamageDefenseMaterialManager._setup_known_damage_types(A0_9, A1_10, A2_11)
	local L3_12, L4_13, L5_14, L6_15, L7_16
	L7_16 = L4_13(L5_14)
	for L6_15, L7_16 in L3_12(L4_13, L5_14, L6_15, L7_16, L4_13(L5_14)) do
		if L7_16 ~= "name" then
			A1_10[L7_16] = A2_11:parameter(L7_16)
		end
	end
end
function DamageDefenseMaterialManager.material(A0_17, A1_18)
	return A0_17._name_to_material[A1_18]
end
