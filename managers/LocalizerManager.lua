LocalizerManager = LocalizerManager or class()
function LocalizerManager.init(A0_0)
	local L1_1, L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11, L12_12
	L1_1 = {}
	A0_0._table = L1_1
	L1_1 = File
	L1_1 = L1_1.list_config_files
	L1_1 = L1_1(L2_2, L3_3, L4_4)
	for L5_5, L6_6 in L2_2(L3_3) do
		L7_7 = ""
		L8_8 = 0
		for L12_12 in L9_9(L10_10, L11_11) do
			if L12_12 == "xml" then
			else
				if L8_8 == 0 then
					L7_7 = L12_12
				else
					L7_7 = L7_7 .. "_" .. L12_12
				end
				L8_8 = L8_8 + 1
			end
		end
		L9_9(L10_10, L11_11)
	end
end
function LocalizerManager.parse_xml(A0_13, A1_14)
	local L2_15, L3_16, L4_17, L5_18, L6_19, L7_20, L8_21
	L2_15 = "data/strings/"
	L3_16 = A1_14
	L2_15 = L2_15 .. L3_16 .. L4_17
	L3_16 = Localizer
	L3_16 = L3_16.load
	L3_16(L4_17, L5_18)
	L3_16 = File
	L3_16 = L3_16.config_exists
	L3_16 = L3_16(L4_17, L5_18)
	if L3_16 then
		L3_16 = File
		L3_16 = L3_16.is_dir
		L3_16 = L3_16(L4_17, L5_18)
		if not L3_16 then
			L3_16 = File
			L3_16 = L3_16.parse_xml
			L3_16 = L3_16(L4_17, L5_18)
			for L7_20 in L4_17(L5_18) do
				L8_21 = A0_13._table
				L8_21 = L8_21[A1_14]
				if L8_21 == nil then
					L8_21 = A0_13._table
					L8_21[A1_14] = {}
				end
				L8_21 = L7_20.parameter
				L8_21 = L8_21(L7_20, "id")
				table.insert(A0_13._table[A1_14], L8_21)
			end
		end
	end
end
function LocalizerManager.string_map(A0_22, A1_23)
	return A0_22._table[A1_23]
end
