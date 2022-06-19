core:module("CoreXml")
core:require_module("CoreClass")
core:require_module("CoreMath")
simple_value_string = function(l_1_0, l_1_1, l_1_2)
	if not l_1_2 then
		l_1_2 = ""
	end
	local l_1_3 = l_1_2
	local l_1_4 = CoreClass.type_name(l_1_1)
	local l_1_5 = tostring(l_1_1)
	if l_1_4 == "Vector3" then
		l_1_5 = CoreMath.vector_to_string(l_1_1, "%.4f")
	elseif l_1_4 == "Rotation" then
		l_1_5 = CoreMath.rotation_to_string(l_1_1, "%.4f")
	elseif l_1_4 == "table" then
		l_1_3 = l_1_3 .. "<value name=\"" .. l_1_0 .. "\" type=\"" .. l_1_4 .. "\">\n"
		l_1_3 = l_1_3 .. save_table_value_string(l_1_1, "", l_1_2)
		l_1_3 = l_1_3 .. l_1_2 .. "</value>"
		return l_1_3
	end
	l_1_3 = l_1_3 .. "<value name=\"" .. l_1_0 .. "\" value=\"" .. l_1_5 .. "\" type=\"" .. l_1_4 .. "\"/>"
	return l_1_3
end

save_value_string = function(l_2_0, l_2_1, l_2_2, l_2_3)
	if not l_2_2 then
		l_2_2 = ""
	end
	local l_2_4 = l_2_2
	if l_2_1 == "unit:position" then
		l_2_1 = "position"
		l_2_0[l_2_1] = l_2_3:position()
	end
	if l_2_1 == "unit:rotation" then
		l_2_1 = "rotation"
		l_2_0[l_2_1] = l_2_3:rotation()
	end
	local l_2_5 = CoreClass.type_name(l_2_0[l_2_1])
	local l_2_6 = tostring(l_2_0[l_2_1])
	if l_2_5 == "Vector3" then
		l_2_6 = CoreMath.vector_to_string(l_2_0[l_2_1], "%.4f")
	elseif l_2_5 == "Rotation" then
		l_2_6 = CoreMath.rotation_to_string(l_2_0[l_2_1], "%.4f")
	elseif l_2_5 == "table" then
		l_2_4 = l_2_4 .. "<value name=\"" .. l_2_1 .. "\" type=\"" .. l_2_5 .. "\">\n"
		l_2_4 = l_2_4 .. save_table_value_string(l_2_0[l_2_1], "", l_2_2)
		l_2_4 = l_2_4 .. l_2_2 .. "</value>"
		return l_2_4
	end
	l_2_4 = l_2_4 .. "<value name=\"" .. l_2_1 .. "\" value=\"" .. l_2_6 .. "\" type=\"" .. l_2_5 .. "\"/>"
	return l_2_4
end

save_table_value_string = function(l_3_0, l_3_1, l_3_2)
	local l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11, l_3_12 = nil
	l_3_2 = l_3_2 .. "\t"
	for i_0,i_1 in pairs(l_3_0) do
		do
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if CoreClass.type_name(i_1) == "table" then
				for l_3_13,l_3_14 in l_3_3 do
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				if CoreClass.type_name(i_1) == "Vector3" then
					do return end
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

		end
		if CoreClass.type_name(i_1) == "Rotation" then
			end
			return l_3_1
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 54 
end

parse_values_node = function(l_4_0)
	local l_4_5, l_4_6 = nil
	local l_4_1 = {}
	for i_0 in l_4_0:children() do
		l_4_1[parse_value_node(i_0)] = i_0
	end
	return l_4_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

parse_value_node = function(l_5_0)
	local l_5_7, l_5_8 = nil
	local l_5_1 = l_5_0:parameter("name")
	local l_5_2 = l_5_0:parameter("type")
	if l_5_2 == "table" then
		local l_5_3 = {}
		for i_0 in l_5_0:children() do
			if not tonumber(i_0:parameter("name")) then
				local l_5_10 = nil
			end
			return l_5_1, l_5_3
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		do
			local l_5_11 = nil
			 -- DECOMPILER ERROR: Overwrote pending register.

			return l_5_1, CoreMath.string_to_value(l_5_11, l_5_3), l_5_11
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: undefined locals caused missing assignments!
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 21 
end


