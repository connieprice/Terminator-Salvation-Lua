WorldDefinitionMenuUnit = WorldDefinitionMenuUnit or class()
function WorldDefinitionMenuUnit.init(A0_0, A1_1)
	A0_0._unit_name = A1_1:parameter("name")
	A0_0._generic = Generic:new(A1_1)
	A1_1:for_each("values", callback(A0_0, A0_0, "parse_values"))
end
function WorldDefinitionMenuUnit.parse_values(A0_2, A1_3)
	A0_2._values = WorldDefinitionMenuUnitValues:new(A1_3)
end
function WorldDefinitionMenuUnit.create_unit(A0_4, A1_5)
	A0_4._unit = managers.worlddefinition:make_unit(A0_4._unit_name, A0_4._generic, A1_5)
	if A0_4._values then
		A0_4._values:set_values(A0_4._unit)
	end
	return A0_4._unit
end
WorldDefinitionMenuUnitValues = WorldDefinitionMenuUnitValues or class()
function WorldDefinitionMenuUnitValues.init(A0_6, A1_7)
	local L2_8, L3_9, L4_10, L5_11
	A0_6._values = L2_8
	for L5_11 in L2_8(L3_9) do
		A0_6._values[L5_11:parameter("name")] = A0_6:parse_value(L5_11)
	end
end
function WorldDefinitionMenuUnitValues.parse_value(A0_12, A1_13)
	local L2_14, L3_15, L4_16, L5_17, L6_18, L7_19, L8_20
	L3_15 = A1_13
	L2_14 = A1_13.parameter
	L2_14 = L2_14(L3_15, L4_16)
	if L2_14 == "table" then
		L3_15 = {}
		for L7_19 in L4_16(L5_17) do
			L8_20 = L7_19.parameter
			L8_20 = L8_20(L7_19, "name")
			L8_20 = tonumber(L8_20) or L8_20
			L3_15[L8_20] = A0_12:parse_value(L7_19)
		end
		return L3_15
	end
	L3_15 = A1_13.parameter
	L3_15 = L3_15(L4_16, L5_17)
	return L4_16(L5_17, L6_18)
end
function WorldDefinitionMenuUnitValues.set_values(A0_21, A1_22)
	A1_22:menu_widget():data():load_data_from_table(A0_21._values)
end
