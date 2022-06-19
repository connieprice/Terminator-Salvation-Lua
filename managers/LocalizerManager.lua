if not LocalizerManager then
	LocalizerManager = class()
end
LocalizerManager.init = function(l_1_0)
	local l_1_5, l_1_6, l_1_7, l_1_8, l_1_14, l_1_15, l_1_16 = nil
	l_1_0._table = {}
	local l_1_1 = File:list_config_files("data/strings/", "*")
	for i_0,i_1 in ipairs(l_1_1) do
		for i_0 in string.gmatch(l_1_10, "%a+") do
			local l_1_11, l_1_12 = "", 0
			if i_0 == "xml" then
				do return end
			end
			if l_1_12 == 0 then
				l_1_11 = i_0
			else
				l_1_11 = l_1_11 .. "_" .. i_0
			end
			l_1_12 = l_1_12 + 1
		end
		l_1_0:parse_xml(l_1_11)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

LocalizerManager.parse_xml = function(l_2_0, l_2_1)
	local l_2_7, l_2_8, l_2_9 = nil
	local l_2_2 = "data/strings/" .. l_2_1 .. ".xml"
	Localizer:load(l_2_2)
	if File:config_exists(l_2_2) and not File:is_dir(l_2_2) then
		local l_2_3 = File:parse_xml(l_2_2)
		for i_0 in l_2_3:children() do
			if l_2_0._table[l_2_1] == nil then
				l_2_0._table[l_2_1] = {}
			end
			table.insert(l_2_0._table[l_2_1], i_0:parameter("id"))
		end
	end
end

LocalizerManager.string_map = function(l_3_0, l_3_1)
	return l_3_0._table[l_3_1]
end


