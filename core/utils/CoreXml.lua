core:module("CoreXml")
core:require_module("CoreClass")
core:require_module("CoreMath")
function simple_value_string(A0_0, A1_1, A2_2)
	local L3_3, L4_4, L5_5
	A2_2 = A2_2 or ""
	L3_3 = A2_2
	L4_4 = CoreClass
	L4_4 = L4_4.type_name
	L5_5 = A1_1
	L4_4 = L4_4(L5_5)
	L5_5 = tostring
	L5_5 = L5_5(A1_1)
	if L4_4 == "Vector3" then
		L5_5 = CoreMath.vector_to_string(A1_1, "%.4f")
	elseif L4_4 == "Rotation" then
		L5_5 = CoreMath.rotation_to_string(A1_1, "%.4f")
	elseif L4_4 == "table" then
		L3_3 = L3_3 .. "<value name=\"" .. A0_0 .. "\" type=\"" .. L4_4 .. "\">\n"
		L3_3 = L3_3 .. save_table_value_string(A1_1, "", A2_2)
		L3_3 = L3_3 .. A2_2 .. "</value>"
		return L3_3
	end
	L3_3 = L3_3 .. "<value name=\"" .. A0_0 .. "\" value=\"" .. L5_5 .. "\" type=\"" .. L4_4 .. "\"/>"
	return L3_3
end
function save_value_string(A0_6, A1_7, A2_8, A3_9)
	local L4_10, L5_11, L6_12
	A2_8 = A2_8 or ""
	L4_10 = A2_8
	if A1_7 == "unit:position" then
		A1_7 = "position"
		L6_12 = A3_9
		L5_11 = A3_9.position
		L5_11 = L5_11(L6_12)
		A0_6[A1_7] = L5_11
	end
	if A1_7 == "unit:rotation" then
		A1_7 = "rotation"
		L6_12 = A3_9
		L5_11 = A3_9.rotation
		L5_11 = L5_11(L6_12)
		A0_6[A1_7] = L5_11
	end
	L5_11 = CoreClass
	L5_11 = L5_11.type_name
	L6_12 = A0_6[A1_7]
	L5_11 = L5_11(L6_12)
	L6_12 = tostring
	L6_12 = L6_12(A0_6[A1_7])
	if L5_11 == "Vector3" then
		L6_12 = CoreMath.vector_to_string(A0_6[A1_7], "%.4f")
	elseif L5_11 == "Rotation" then
		L6_12 = CoreMath.rotation_to_string(A0_6[A1_7], "%.4f")
	elseif L5_11 == "table" then
		L4_10 = L4_10 .. "<value name=\"" .. A1_7 .. "\" type=\"" .. L5_11 .. "\">\n"
		L4_10 = L4_10 .. save_table_value_string(A0_6[A1_7], "", A2_8)
		L4_10 = L4_10 .. A2_8 .. "</value>"
		return L4_10
	end
	L4_10 = L4_10 .. "<value name=\"" .. A1_7 .. "\" value=\"" .. L6_12 .. "\" type=\"" .. L5_11 .. "\"/>"
	return L4_10
end
function save_table_value_string(A0_13, A1_14, A2_15)
	local L3_16, L4_17, L5_18, L6_19, L7_20, L8_21, L9_22
	A2_15 = L3_16 .. L4_17
	for L6_19, L7_20 in L3_16(L4_17) do
		L8_21 = CoreClass
		L8_21 = L8_21.type_name
		L9_22 = L7_20
		L8_21 = L8_21(L9_22)
		L9_22 = tostring
		L9_22 = L9_22(L7_20)
		if L8_21 == "table" then
			A1_14 = A1_14 .. A2_15 .. "<value name=\"" .. L6_19 .. "\" type=\"" .. L8_21 .. "\">\n"
			A1_14 = A1_14 .. save_table_value_string(L7_20, "", A2_15)
			A1_14 = A1_14 .. A2_15 .. "</value>\n"
		else
			if L8_21 == "Vector3" then
				L9_22 = CoreMath.vector_to_string(L7_20, "%.4f")
			elseif L8_21 == "Rotation" then
				L9_22 = CoreMath.rotation_to_string(L7_20, "%.4f")
			end
			A1_14 = A1_14 .. A2_15 .. "<value name=\"" .. L6_19 .. "\" value=\"" .. L9_22 .. "\" type=\"" .. L8_21 .. "\"/>\n"
		end
	end
	return A1_14
end
function parse_values_node(A0_23)
	local L1_24, L2_25, L3_26, L4_27, L5_28
	L1_24 = {}
	for L5_28 in L2_25(L3_26) do
		L1_24[parse_value_node(L5_28)] = parse_value_node(L5_28)
	end
	return L1_24
end
function parse_value_node(A0_29)
	local L1_30, L2_31, L3_32, L4_33, L5_34, L6_35, L7_36, L8_37
	L2_31 = A0_29
	L1_30 = A0_29.parameter
	L3_32 = "name"
	L1_30 = L1_30(L2_31, L3_32)
	L3_32 = A0_29
	L2_31 = A0_29.parameter
	L2_31 = L2_31(L3_32, L4_33)
	if L2_31 == "table" then
		L3_32 = {}
		for L7_36 in L4_33(L5_34) do
			L8_37 = L7_36.parameter
			L8_37 = L8_37(L7_36, "name")
			L8_37 = tonumber(L8_37) or L8_37
			L3_32[L8_37] = parse_value_node(L7_36)
		end
		return L4_33, L5_34
	end
	L3_32 = A0_29.parameter
	L3_32 = L3_32(L4_33, L5_34)
	L7_36 = L3_32
	L8_37 = L5_34(L6_35, L7_36)
	return L4_33, L5_34, L6_35, L7_36, L8_37, L5_34(L6_35, L7_36)
end
