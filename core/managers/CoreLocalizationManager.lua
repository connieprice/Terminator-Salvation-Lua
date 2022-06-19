core:module("CoreLocalizationManager")
core:require_module("CoreClass")
core:require_module("CoreEvent")
LocalizationManager = LocalizationManager or CoreClass.class()
function LocalizationManager.init(A0_0)
	local L1_1, L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11, L12_12
	L1_1 = Localizer
	L1_1 = L1_1.set_post_processor
	L5_5 = A0_0
	L6_6 = "_localizer_post_process"
	L12_12 = L3_3(L4_4, L5_5, L6_6)
	L1_1(L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11, L12_12, L3_3(L4_4, L5_5, L6_6))
	L1_1 = {}
	A0_0._default_macros = L1_1
	L1_1 = A0_0.set_default_macro
	L1_1(L2_2, L3_3, L4_4)
	L1_1 = A0_0.set_default_macro
	L1_1(L2_2, L3_3, L4_4)
	L1_1 = {}
	A0_0._string_map = L1_1
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
	A0_0._macro_context = nil
end
function LocalizationManager.string_map(A0_13, A1_14)
	return A0_13._string_map[A1_14]
end
function LocalizationManager.xml_names(A0_15)
	return table.map_keys(A0_15._string_map)
end
function LocalizationManager.add_default_macro(A0_16, A1_17, A2_18)
	A0_16:set_default_macro(A1_17, A2_18)
end
function LocalizationManager.set_default_macro(A0_19, A1_20, A2_21)
	local L3_22
	L3_22 = A0_19._default_macros
	if not L3_22 then
		L3_22 = {}
		A0_19._default_macros = L3_22
	end
	L3_22 = A0_19._default_macros
	L3_22["$" .. A1_20 .. ";"] = tostring(A2_21)
end
function LocalizationManager.exists(A0_23, A1_24)
	return Localizer:exists(A1_24)
end
function LocalizationManager.text(A0_25, A1_26, A2_27)
	local L3_28, L4_29
	L3_28 = "ERROR: "
	L4_29 = A1_26
	L3_28 = L3_28 .. L4_29
	L4_29 = nil
	if not A1_26 or A1_26 == "" then
		L3_28 = ""
	elseif A0_25:exists(A1_26 .. "_" .. SystemInfo:platform()) then
		L4_29 = A1_26 .. "_" .. SystemInfo:platform()
	elseif A0_25:exists(A1_26) then
		L4_29 = A1_26
	end
	if L4_29 then
		A0_25._macro_context = A2_27
		L3_28 = Localizer:lookup(L4_29)
		A0_25._macro_context = nil
	end
	return L3_28
end
function LocalizationManager._master_strings_dir(A0_30)
	local L1_31
	L1_31 = "data/strings/"
	return L1_31
end
function LocalizationManager._localizer_post_process(A0_32, A1_33)
	local L2_34, L3_35, L4_36, L5_37, L6_38, L7_39, L8_40
	L2_34 = A1_33
	L3_35 = {}
	if L4_36 ~= "table" then
		A0_32._macro_context = L4_36
	end
	if L4_36 then
		L4_36(L5_37)
	end
	for L7_39, L8_40 in L4_36(L5_37) do
		L3_35[L7_39] = L8_40
	end
	for L7_39, L8_40 in L4_36(L5_37) do
		L3_35["$" .. L7_39 .. ";"] = tostring(L8_40)
	end
	L7_39 = L3_35
	L2_34 = L4_36
	return L2_34
end
function LocalizationManager._parse_xml(A0_41, A1_42)
	local L2_43, L3_44, L4_45, L5_46, L6_47, L7_48, L8_49
	L3_44 = A0_41
	L2_43 = A0_41._master_strings_dir
	L2_43 = L2_43(L3_44)
	L3_44 = A1_42
	L2_43 = L2_43 .. L3_44 .. L4_45
	L3_44 = Localizer
	L3_44 = L3_44.load
	L7_48 = ".xml"
	L3_44(L4_45, L5_46)
	L3_44 = File
	L3_44 = L3_44.config_exists
	L3_44 = L3_44(L4_45, L5_46)
	if L3_44 then
		L3_44 = File
		L3_44 = L3_44.is_dir
		L3_44 = L3_44(L4_45, L5_46)
		if not L3_44 then
			L3_44 = File
			L3_44 = L3_44.parse_xml
			L3_44 = L3_44(L4_45, L5_46)
			for L7_48 in L4_45(L5_46) do
				L8_49 = A0_41._string_map
				L8_49 = L8_49[A1_42]
				if L8_49 == nil then
					L8_49 = A0_41._string_map
					L8_49[A1_42] = {}
				end
				L8_49 = L7_48.parameter
				L8_49 = L8_49(L7_48, "id")
				table.insert(A0_41._string_map[A1_42], L8_49)
			end
		end
	end
end
