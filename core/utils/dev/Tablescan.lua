TS_StateValue = class()
function TS_StateValue.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	A0_0._name = A1_1
	A0_0._index = A2_2
	A0_0._value = A3_3
	A0_0._type = A4_4
end
TableScan = TableScan or class()
function TableScan.init(A0_5)
	local L1_6
	L1_6 = {}
	A0_5._TSValues = L1_6
	L1_6 = {}
	A0_5._TSValuesMap = L1_6
	A0_5._table = nil
	A0_5._list = nil
	A0_5._anka = true
	A0_5._ignoreclass = false
end
function TableScan.GetValue(A0_7, A1_8, A2_9)
	local L3_10, L4_11, L5_12
	L4_11 = type
	L5_12 = A2_9
	L4_11 = L4_11(L5_12)
	if L4_11 == "number" then
		L4_11 = tostring
		L5_12 = A2_9
		L4_11 = L4_11(L5_12)
		L3_10 = L4_11
	else
		L4_11 = type
		L5_12 = A2_9
		L4_11 = L4_11(L5_12)
		if L4_11 == "string" then
			L4_11 = tostring
			L5_12 = A2_9
			L4_11 = L4_11(L5_12)
			L3_10 = L4_11
		else
			L4_11 = type
			L5_12 = A2_9
			L4_11 = L4_11(L5_12)
			if L4_11 == "nil" then
				L3_10 = "nil"
			else
				L4_11 = type
				L5_12 = A2_9
				L4_11 = L4_11(L5_12)
				if L4_11 == "userdata" then
					L4_11 = getmetatable
					L5_12 = A2_9
					L4_11 = L4_11(L5_12)
					if L4_11 then
						L4_11 = getmetatable
						L5_12 = A2_9
						L4_11 = L4_11(L5_12)
						L5_12 = L4_11.tostring
						L3_10 = L5_12(A2_9)
					end
				else
					L4_11 = type
					L5_12 = A2_9
					L4_11 = L4_11(L5_12)
					if L4_11 == "boolean" then
						if A2_9 then
							L3_10 = "true"
						else
							L3_10 = "false"
						end
					else
						L4_11 = type
						L5_12 = A2_9
						L4_11 = L4_11(L5_12)
						if L4_11 == "function" then
							L4_11 = tostring
							L5_12 = A1_8
							L4_11 = L4_11(L5_12)
							L5_12 = string
							L5_12 = L5_12.rep
							L5_12 = L5_12(" ", 30 - #tostring(A1_8))
							L3_10 = L4_11 .. L5_12
							L4_11 = debug
							L4_11 = L4_11.getinfo
							L5_12 = A2_9
							L4_11 = L4_11(L5_12, "S")
							L5_12 = L4_11.what
							if L5_12 == "Lua" then
								L5_12 = L3_10
								L3_10 = L5_12 .. "(" .. L4_11.source .. ":" .. L4_11.linedefined .. ")"
							else
								L5_12 = L3_10
								L3_10 = L5_12 .. "(C)"
							end
						else
							L4_11 = type
							L5_12 = A2_9
							L4_11 = L4_11(L5_12)
							if L4_11 == "table" then
								L4_11 = tostring
								L5_12 = A2_9
								L4_11 = L4_11(L5_12)
								L3_10 = L4_11
							else
								L4_11 = "Unknown Data: "
								L5_12 = type
								L5_12 = L5_12(A2_9)
								L3_10 = L4_11 .. L5_12
							end
						end
					end
				end
			end
		end
	end
	return L3_10
end
function TableScan.is_class(A0_13, A1_14)
	local L2_15, L3_16, L4_17, L5_18, L6_19, L7_20, L8_21
	L2_15 = false
	L3_16 = false
	for L7_20, L8_21 in L4_17(L5_18) do
		if type(L8_21) ~= "function" and type(L8_21) == "table" and L7_20 ~= "__index" then
			return false
		end
		if L7_20 == "new" then
			L2_15 = true
		end
		if L7_20 == "init" then
			L3_16 = true
		end
	end
	if L2_15 == true and L3_16 == true then
		return L4_17
	end
	return L4_17
end
function TableScan.is_class_instance(A0_22, A1_23)
	local L2_24
	L2_24 = getmetatable
	L2_24 = L2_24(A1_23)
	if L2_24 == nil then
		return false
	end
	if A0_22:is_class(L2_24) == true then
		return true
	end
	return A0_22:is_class_instance(L2_24)
end
function GetLuaClassType(A0_25)
	for 