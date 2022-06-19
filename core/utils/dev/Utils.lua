function core_change_unit_type(A0_0, A1_1)
	local L2_2, L3_3, L4_4, L5_5, L6_6, L7_7
	L5_5 = false
	L6_6 = "unit"
	L7_7 = L3_3(L4_4, L5_5, L6_6)
	for L5_5, L6_6 in L2_2(L3_3, L4_4, L5_5, L6_6, L7_7, L3_3(L4_4, L5_5, L6_6)) do
		L7_7 = string
		L7_7 = L7_7.find
		L7_7 = L7_7(L6_6:name(), A0_0)
		if L7_7 then
			L7_7 = ProjectDatabase
			L7_7 = L7_7.load_node
			L7_7 = L7_7(L7_7, L6_6)
			L7_7:set_parameter("type", A1_1)
			ProjectDatabase:save_node(L7_7, L6_6)
		end
	end
	L2_2(L3_3)
end
function core_convert_material_configs_to_version_3()
	core_do_convert_material_configs_to_version_3(ProjectDatabase)
	ProjectDatabase:save()
	core_do_convert_material_configs_to_version_3(CoreDatabase)
	CoreDatabase:save()
	cat_print("debug", "[core_convert_material_configs_to_version_3] Done!")
end
function core_do_convert_material_configs_to_version_3(A0_8)
	local L1_9, L2_10, L3_11, L4_12, L5_13, L6_14, L7_15, L8_16
	L1_9 = cat_print
	L5_13 = A0_8
	L1_9(L2_10, L3_11)
	L1_9 = A0_8.all
	L1_9 = L1_9(L2_10, L3_11, L4_12)
	for L5_13, L6_14 in L2_10(L3_11) do
		L7_15 = math
		L7_15 = L7_15.floor
		L8_16 = #L1_9
		L8_16 = L5_13 / L8_16
		L8_16 = L8_16 * 100
		L7_15 = L7_15(L8_16)
		L8_16 = cat_print
		L8_16("debug", "[core_convert_material_configs_to_version_3] " .. L6_14:name() .. " " .. tostring(L7_15) .. "%")
		L8_16 = A0_8.load_node
		L8_16 = L8_16(A0_8, L6_14)
		if L8_16 and L8_16:parameter("version") ~= "3" then
			if L8_16:parameter("version") == "2" and L6_14:name() ~= "global_v2" then
				for 