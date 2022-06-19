core:module("CoreLocalizationManager")
core:require_module("CoreClass")
core:require_module("CoreEvent")
if not LocalizationManager then
	LocalizationManager = CoreClass.class()
end
LocalizationManager.init = function(l_1_0)
	local l_1_5, l_1_6, l_1_12 = Localizer:set_post_processor, Localizer, CoreEvent.callback(l_1_0, l_1_0, "_localizer_post_process")
	l_1_5(l_1_6, l_1_12)
	l_1_0._default_macros, l_1_5 = l_1_5, {}
	l_1_5, l_1_6 = l_1_0:set_default_macro, l_1_0
	l_1_12 = "NL"
	l_1_5(l_1_6, l_1_12, "\n")
	l_1_5, l_1_6 = l_1_0:set_default_macro, l_1_0
	l_1_12 = "EMPTY"
	l_1_5(l_1_6, l_1_12, "")
	l_1_0._string_map, l_1_5 = l_1_5, {}
	l_1_5 = File
	l_1_5, l_1_6 = l_1_5:list_config_files, l_1_5
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_5 = l_1_5(l_1_6, l_1_12, "*")
	local l_1_1 = nil
	l_1_6 = ipairs
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_6 = l_1_6(l_1_12)
	for i_0,i_1 in l_1_6 do
		local l_1_4 = nil
		l_1_4 = ""
		local l_1_7 = nil
		l_1_7 = 0
		local l_1_8 = nil
		l_1_8 = string
		l_1_8 = l_1_8.gmatch
		l_1_8 = l_1_8(l_1_3, "%a+")
		for i_0 in l_1_8 do
			if l_1_11 == "xml" then
				do return end
			end
			if l_1_7 == 0 then
				l_1_4 = l_1_11
			else
				l_1_4 = l_1_4 .. "_" .. l_1_11
			end
			l_1_7 = l_1_7 + 1
		end
		l_1_0:_parse_xml(l_1_4)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_1_0._macro_context = nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

LocalizationManager.string_map = function(l_2_0, l_2_1)
	return l_2_0._string_map[l_2_1]
end

LocalizationManager.xml_names = function(l_3_0)
	local l_3_1 = table.map_keys
	local l_3_2 = l_3_0._string_map
	return l_3_1(l_3_2)
end

LocalizationManager.add_default_macro = function(l_4_0, l_4_1, l_4_2)
	l_4_0:set_default_macro(l_4_1, l_4_2)
end

LocalizationManager.set_default_macro = function(l_5_0, l_5_1, l_5_2)
	if not l_5_0._default_macros then
		l_5_0._default_macros = {}
	end
	local l_5_3 = l_5_0._default_macros
	local l_5_4 = "$" .. l_5_1 .. ";"
	l_5_3[l_5_4] = tostring(l_5_2)
end

LocalizationManager.exists = function(l_6_0, l_6_1)
	local l_6_2, l_6_3 = Localizer:exists, Localizer
	local l_6_4 = l_6_1
	return l_6_2(l_6_3, l_6_4)
end

LocalizationManager.text = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = "ERROR: " .. l_7_1
	local l_7_4 = nil
	if not l_7_1 or l_7_1 == "" then
		l_7_3 = ""
	else
		if l_7_0:exists(l_7_1 .. "_" .. SystemInfo:platform()) then
			l_7_4 = l_7_1 .. "_" .. SystemInfo:platform()
		end
	else
		if l_7_0:exists(l_7_1) then
			l_7_4 = l_7_1
		end
	end
	if l_7_4 then
		l_7_0._macro_context = l_7_2
		l_7_3 = Localizer:lookup(l_7_4)
		l_7_0._macro_context = nil
	end
	return l_7_3
end

LocalizationManager._master_strings_dir = function(l_8_0)
	return "data/strings/"
end

LocalizationManager._localizer_post_process = function(l_9_0, l_9_1)
	local l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_12, l_9_13 = nil
	local l_9_2 = l_9_1
	local l_9_3 = {}
	if type(l_9_0._macro_context) ~= "table" then
		l_9_0._macro_context = {}
	end
	if l_9_0._pre_process_func then
		l_9_0._pre_process_func(l_9_3)
	end
	for i_0,i_1 in pairs(l_9_0._default_macros) do
		l_9_3[i_0] = i_1
	end
	for i_0,i_1 in pairs(l_9_0._macro_context) do
		l_9_3["$" .. i_0 .. ";"] = tostring(i_1)
	end
	l_9_2 = l_9_1.gsub(l_9_2, "%b$;", l_9_3)
	return l_9_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

LocalizationManager._parse_xml = function(l_10_0, l_10_1)
	local l_10_2 = l_10_0:_master_strings_dir() .. l_10_1 .. ".xml"
	local l_10_7 = Localizer:load
	l_10_7(Localizer, "data/strings/" .. l_10_1 .. ".xml")
	l_10_7 = File
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_10_7 and not l_10_7 then
		local l_10_3 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0 in l_10_3 do
			if l_10_0._string_map[l_10_1] == nil then
				l_10_0._string_map[l_10_1] = {}
			end
			local l_10_8 = l_10_6:parameter("id")
			table.insert(l_10_0._string_map[l_10_1], l_10_8)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


