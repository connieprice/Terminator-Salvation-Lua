require("shared/String")
TableSerializer = {}
TableSerializer.pos = 0
TableSerializer.str = ""
function TableSerializer.save(A0_0)
	local L1_1
	L1_1 = {}
	return TableSerializer._save(A0_0, L1_1)
end
function TableSerializer._save_vector(A0_2)
	return "v" .. TableSerializer._save_vector_value(A0_2) .. "|"
end
function TableSerializer._save_vector_value(A0_3)
	return tostring(A0_3.x) .. " " .. tostring(A0_3.y) .. " " .. tostring(A0_3.z)
end
function TableSerializer._save_rotation(A0_4)
	local L1_5
	L1_5 = "r"
	L1_5 = L1_5 .. TableSerializer._save_vector_value(A0_4:x())
	L1_5 = L1_5 .. "," .. TableSerializer._save_vector_value(A0_4:y())
	L1_5 = L1_5 .. "," .. TableSerializer._save_vector_value(A0_4:z()) .. "|"
	return L1_5
end
function TableSerializer._save_value(A0_6, A1_7)
	local L2_8, L3_9, L4_10
	L2_8 = ""
	L3_9 = type
	L4_10 = A0_6
	L3_9 = L3_9(L4_10)
	if L3_9 == "table" then
		L4_10 = A1_7[A0_6]
		if not L4_10 then
			L4_10 = #A1_7
			A1_7[A0_6] = L4_10
			L2_8 = L2_8 .. "t" .. L4_10 .. "|"
			L2_8 = L2_8 .. TableSerializer._save(A0_6, A1_7)
		else
			L2_8 = L2_8 .. "p" .. tostring(L4_10) .. "|"
		end
	elseif L3_9 == "function" then
	elseif L3_9 == "number" then
		L4_10 = L2_8
		L2_8 = L4_10 .. "n" .. tostring(A0_6) .. "|"
	elseif L3_9 == "string" then
		L4_10 = L2_8
		L2_8 = L4_10 .. "s" .. A0_6 .. "|"
	elseif L3_9 == "boolean" then
		L4_10 = L2_8
		L2_8 = L4_10 .. "b" .. tostring(A0_6) .. "|"
	elseif L3_9 == "nil" then
	else
		L4_10 = A0_6.type_name
		if L4_10 then
			L4_10 = A0_6.type_name
			if L4_10 == "Vector3" then
				L4_10 = L2_8
				L2_8 = L4_10 .. TableSerializer._save_vector(A0_6)
			else
				L4_10 = A0_6.type_name
				if L4_10 == "Rotation" then
					L4_10 = L2_8
					L2_8 = L4_10 .. TableSerializer._save_rotation(A0_6)
				else
					L4_10 = A0_6.type_name
					if L4_10 == "Unit" then
					else
						L4_10 = error
						L4_10("unknown type:" .. A0_6.type_name)
					end
				end
			end
		else
			L4_10 = error
			L4_10("Invalid type:" .. L3_9)
		end
	end
	return L2_8
end
function TableSerializer._save(A0_11, A1_12)
	local L2_13, L3_14, L4_15, L5_16, L6_17, L7_18, L8_19
	L2_13 = ""
	L3_14 = ""
	for L7_18, L8_19 in L4_15(L5_16) do
		L2_13 = L2_13 .. TableSerializer._save_value(L7_18, A1_12)
		L2_13 = L2_13 .. TableSerializer._save_value(L8_19, A1_12)
	end
	L2_13 = L4_15 .. L5_16
	return L2_13
end
function TableSerializer.load(A0_20)
	local L1_21
	L1_21 = {}
	TableSerializer.str = A0_20
	TableSerializer.pos = 1
	return TableSerializer._load(L1_21)
end
function TableSerializer._load_vector(A0_22)
	local L1_23, L2_24, L3_25, L4_26
	L1_23 = String
	L1_23 = L1_23.split
	L2_24 = A0_22
	L1_23 = L1_23(L2_24)
	L2_24 = tonumber
	L3_25 = L1_23[1]
	L2_24 = L2_24(L3_25)
	L3_25 = tonumber
	L4_26 = L1_23[2]
	L3_25 = L3_25(L4_26)
	L4_26 = tonumber
	L4_26 = L4_26(L1_23[3])
	return (Vector3(L2_24, L3_25, L4_26))
end
function TableSerializer._load_rotation(A0_27)
	local L1_28, L2_29, L3_30, L4_31
	L1_28 = String
	L1_28 = L1_28.split
	L2_29 = A0_27
	L3_30 = "[,]"
	L1_28 = L1_28(L2_29, L3_30)
	L2_29 = TableSerializer
	L2_29 = L2_29._load_vector
	L3_30 = L1_28[1]
	L2_29 = L2_29(L3_30)
	L3_30 = TableSerializer
	L3_30 = L3_30._load_vector
	L4_31 = L1_28[2]
	L3_30 = L3_30(L4_31)
	L4_31 = TableSerializer
	L4_31 = L4_31._load_vector
	L4_31 = L4_31(L1_28[3])
	return (Rotation(L2_29, L3_30, L4_31))
end
function TableSerializer._get_next_command()
	if not string.find(TableSerializer.str, "|", TableSerializer.pos) then
		error("Couldn't find command in string: '" .. TableSerializer.str:sub(TableSerializer.pos, TableSerializer.pos) .. "'")
	end
	;({}).command = string.sub(TableSerializer.str, TableSerializer.pos, TableSerializer.pos)
	;({}).value = string.sub(TableSerializer.str, TableSerializer.pos + 1, string.find(TableSerializer.str, "|", TableSerializer.pos) - 1)
	TableSerializer.pos = string.find(TableSerializer.str, "|", TableSerializer.pos) + 1
	return {}
end
function TableSerializer.get_value(A0_32, A1_33, A2_34)
	local L3_35
	if A0_32 == "p" then
		L3_35 = A2_34[tonumber(A1_33)]
		assert(L3_35)
	elseif A0_32 == "n" then
		L3_35 = tonumber(A1_33)
	elseif A0_32 == "b" then
		L3_35 = A1_33 == "true"
	elseif A0_32 == "s" then
		L3_35 = A1_33
	elseif A0_32 == "v" then
		L3_35 = TableSerializer._load_vector(A1_33)
	elseif A0_32 == "r" then
		L3_35 = TableSerializer._load_rotation(A1_33)
	else
		error("Uknown type:'" .. A0_32 .. "'")
	end
	return L3_35
end
function TableSerializer._load(A0_36)
	local L1_37, L2_38, L3_39, L4_40, L5_41
	L1_37 = TableSerializer
	L1_37 = L1_37.str
	if L1_37 == "" then
		L1_37 = nil
		return L1_37
	end
	L1_37 = {}
	while true do
		L2_38 = string
		L2_38 = L2_38.sub
		L3_39 = TableSerializer
		L3_39 = L3_39.str
		L4_40 = TableSerializer
		L4_40 = L4_40.pos
		L5_41 = TableSerializer
		L5_41 = L5_41.pos
		L2_38 = L2_38(L3_39, L4_40, L5_41)
		if L2_38 == "*" then
			L2_38 = TableSerializer
			L3_39 = TableSerializer
			L3_39 = L3_39.pos
			L3_39 = L3_39 + 1
			L2_38.pos = L3_39
			return L1_37
		end
		L2_38 = TableSerializer
		L2_38 = L2_38._get_next_command
		L2_38 = L2_38()
		L3_39 = TableSerializer
		L3_39 = L3_39.get_value
		L4_40 = L2_38.command
		L5_41 = L2_38.value
		L3_39 = L3_39(L4_40, L5_41, A0_36)
		L4_40 = TableSerializer
		L4_40 = L4_40._get_next_command
		L4_40 = L4_40()
		L5_41 = nil
		if L4_40.command == "t" then
			L5_41 = TableSerializer._load(A0_36)
			A0_36[tonumber(L4_40.value)] = L5_41
		else
			L5_41 = TableSerializer.get_value(L4_40.command, L4_40.value, A0_36)
		end
		L1_37[L3_39] = L5_41
	end
end
