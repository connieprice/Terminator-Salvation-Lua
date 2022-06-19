UnitMaterials = UnitMaterials or class()
function UnitMaterials.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._unit:set_extension_update_enabled("unit_materials", false)
end
function UnitMaterials.update(A0_2)
	local L1_3, L2_4, L3_5, L4_6, L5_7, L6_8, L7_9
	for L5_7, L6_8 in L2_4(L3_5) do
		L7_9 = L6_8
		L7_9 = L7_9()
		if L7_9 then
			L1_3 = L1_3 or {}
			table.insert(L1_3, L7_9)
		end
	end
	if L1_3 then
		for L5_7, L6_8 in L2_4(L3_5) do
			L7_9 = L6_8
			L7_9()
		end
	end
end
function UnitMaterials.set_material_variable(A0_10, A1_11, A2_12, A3_13)
	local L4_14
	L4_14 = assert
	L4_14(A0_10._unit:has_material_assigned(A1_11))
	L4_14 = A0_10._unit
	L4_14 = L4_14.get_objects_by_type
	L4_14 = L4_14(L4_14, "material")
	for 