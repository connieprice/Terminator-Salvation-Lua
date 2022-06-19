core:module("CoreSky")
core:require_module("CoreClass")
Sky = Sky or CoreClass.class()
function Sky.init(A0_0)
	A0_0._params = {}
	A0_0._name = "default"
end
function Sky.set_name(A0_1, A1_2)
	A0_1._name = A1_2
end
function Sky.set_value(A0_3, A1_4, A2_5)
	A0_3._params[A1_4] = A2_5
end
function Sky.value(A0_6, A1_7)
	return A0_6._params[A1_7]
end
function Sky.parse(A0_8, A1_9)
	local L2_10, L3_11, L4_12, L5_13, L6_14, L7_15
	A0_8._params = L2_10
	for L5_13 in L2_10(L3_11) do
		L7_15 = L5_13
		L6_14 = L5_13.parameter
		L6_14 = L6_14(L7_15, "key")
		L7_15 = L5_13.parameter
		L7_15 = L7_15(L5_13, "value")
		if L5_13:name() == "param" and L6_14 and L6_14 ~= "" and L7_15 and L7_15 ~= "" then
			if math.string_is_good_vector(L7_15) then
				A0_8._params[L6_14] = math.string_to_vector(L7_15)
			elseif tonumber(L7_15) then
				A0_8._params[L6_14] = tonumber(L7_15)
			elseif string.sub(L7_15, 1, 1) == "#" then
				A0_8._params[L6_14] = A0_8:database_lookup(string.sub(L7_15, 2))
			else
				A0_8._params[L6_14] = tostring(L7_15)
			end
		end
	end
end
function Sky.copy(A0_16, A1_17)
	local L2_18, L3_19, L4_20, L5_21, L6_22
	for L5_21, L6_22 in L2_18(L3_19) do
		if type(L6_22) == "string" then
			A0_16._params[L5_21] = L6_22
		elseif type(L6_22) ~= "number" then
			A0_16._params[L5_21] = Vector3(L6_22.x, L6_22.y, L6_22.z)
		else
			A0_16._params[L5_21] = L6_22
		end
	end
	A0_16._name = L2_18
end
function Sky.interpolate(A0_23, A1_24, A2_25, A3_26)
	local L4_27, L5_28, L6_29, L7_30, L8_31, L9_32
	L4_27 = 1 - A3_26
	for L8_31, L9_32 in L5_28(L6_29) do
		if not A1_24._params[L8_31] then
			return
		elseif type(L9_32) ~= "string" then
			A0_23._params[L8_31] = A1_24._params[L8_31] * L4_27 + L9_32 * A3_26
		else
			A0_23._params[L8_31] = L9_32
		end
	end
	A0_23._name = L5_28
end
function Sky.database_lookup(A0_33, A1_34)
	local L2_35, L3_36, L4_37, L5_38
	L2_35 = string
	L2_35 = L2_35.find
	L3_36 = A1_34
	L4_37 = "#"
	L2_35 = L2_35(L3_36, L4_37)
	L3_36 = string
	L3_36 = L3_36.sub
	L4_37 = A1_34
	L5_38 = 1
	L3_36 = L3_36(L4_37, L5_38, L2_35 - 1)
	L4_37 = string
	L4_37 = L4_37.sub
	L5_38 = A1_34
	L4_37 = L4_37(L5_38, L2_35 + 1)
	L5_38 = assert
	L5_38(L3_36 == "LightIntensityDB")
	L5_38 = LightIntensityDB
	L5_38 = L5_38.lookup
	L5_38 = L5_38(L5_38, L4_37)
	assert(L5_38)
	return L5_38
end
