require("damage/DamageDefenseMaterial")
if not DamageDefenseMaterialManager then
	DamageDefenseMaterialManager = class()
end
DamageDefenseMaterialManager.init = function(l_1_0)
	l_1_0._name_to_material = {}
	local l_1_1 = File:new_parse_xml("data/settings/damage_defense_materials.xml")
	l_1_0:_load_materials(l_1_1:children())
end

DamageDefenseMaterialManager._load_materials = function(l_2_0, l_2_1)
	local l_2_5, l_2_6 = nil
	local l_2_2 = l_2_1
	for i_0 in l_2_2 do
		local l_2_8 = nil
		l_2_0._name_to_material[l_2_8] = DamageDefenseMaterial:new(i_0:parameter("name"))
		l_2_0:_setup_known_damage_types(DamageDefenseMaterial:new(i_0:parameter("name")), l_2_7)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

DamageDefenseMaterialManager._setup_known_damage_types = function(l_3_0, l_3_1, l_3_2)
	local l_3_6, l_3_7 = ipairs, l_3_2:keys()
	l_3_6 = l_3_6(l_3_7)
	for i_0,i_1 in l_3_6 do
		if l_3_5 ~= "name" then
			l_3_1[l_3_5] = l_3_2:parameter(l_3_5)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

DamageDefenseMaterialManager.material = function(l_4_0, l_4_1)
	return l_4_0._name_to_material[l_4_1]
end


