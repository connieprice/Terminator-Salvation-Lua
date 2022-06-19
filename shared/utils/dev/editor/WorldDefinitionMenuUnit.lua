if not WorldDefinitionMenuUnit then
	WorldDefinitionMenuUnit = class()
end
WorldDefinitionMenuUnit.init = function(l_1_0, l_1_1)
	l_1_0._unit_name = l_1_1:parameter("name")
	l_1_0._generic = Generic:new(l_1_1)
	l_1_1:for_each("values", callback(l_1_0, l_1_0, "parse_values"))
end

WorldDefinitionMenuUnit.parse_values = function(l_2_0, l_2_1)
	l_2_0._values = WorldDefinitionMenuUnitValues:new(l_2_1)
end

WorldDefinitionMenuUnit.create_unit = function(l_3_0, l_3_1)
	l_3_0._unit = managers.worlddefinition:make_unit(l_3_0._unit_name, l_3_0._generic, l_3_1)
	if l_3_0._values then
		l_3_0._values:set_values(l_3_0._unit)
	end
	return l_3_0._unit
end

if not WorldDefinitionMenuUnitValues then
	WorldDefinitionMenuUnitValues = class()
end
WorldDefinitionMenuUnitValues.init = function(l_4_0, l_4_1)
	local l_4_5, l_4_6, l_4_7 = nil
	l_4_0._values = {}
	for i_0 in l_4_1:children() do
		l_4_0._values[i_0:parameter("name")] = l_4_0:parse_value(l_4_8)
	end
end

WorldDefinitionMenuUnitValues.parse_value = function(l_5_0, l_5_1)
	local l_5_7, l_5_8, l_5_14 = nil
	local l_5_2 = l_5_1:parameter("type")
	if l_5_2 == "table" then
		local l_5_3 = {}
		for i_0 in l_5_1:children() do
			local l_5_15 = i_0:parameter("name")
			if not tonumber(l_5_15) then
				local l_5_17 = l_5_0:parse_value
			end
			local l_5_18 = l_5_0
			l_5_17 = l_5_17(l_5_18, l_5_9)
			local l_5_16 = nil
			l_5_3[l_5_15] = l_5_17
		end
		return l_5_3
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_5_10 = nil
	local l_5_11 = nil
	local l_5_12 = nil
	do
		local l_5_13 = nil
		return string_to_value(l_5_2, l_5_10)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

WorldDefinitionMenuUnitValues.set_values = function(l_6_0, l_6_1)
	l_6_1:menu_widget():data():load_data_from_table(l_6_0._values)
end


