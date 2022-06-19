require("shared/String")
TableSerializer = {}
TableSerializer.pos = 0
TableSerializer.str = ""
TableSerializer.save = function(l_1_0)
	local l_1_1 = {}
	local l_1_2 = TableSerializer._save
	local l_1_3 = l_1_0
	local l_1_4 = l_1_1
	return l_1_2(l_1_3, l_1_4)
end

TableSerializer._save_vector = function(l_2_0)
	return "v" .. TableSerializer._save_vector_value(l_2_0) .. "|"
end

TableSerializer._save_vector_value = function(l_3_0)
	return tostring(l_3_0.x) .. " " .. tostring(l_3_0.y) .. " " .. tostring(l_3_0.z)
end

TableSerializer._save_rotation = function(l_4_0)
	local l_4_1 = "r" .. TableSerializer._save_vector_value(l_4_0:x())
	l_4_1 = l_4_1 .. "," .. TableSerializer._save_vector_value(l_4_0:y())
	l_4_1 = l_4_1 .. "," .. TableSerializer._save_vector_value(l_4_0:z()) .. "|"
	return l_4_1
end

TableSerializer._save_value = function(l_5_0, l_5_1)
	local l_5_2 = ""
	local l_5_3 = type(l_5_0)
	do
		if l_5_3 == "table" then
			if not l_5_1[l_5_0] then
				local l_5_4, l_5_5 = #l_5_1
				l_5_1[l_5_0] = l_5_4
				l_5_5 = l_5_2
				l_5_2 = l_5_5 .. "t" .. l_5_4 .. "|"
				l_5_5 = l_5_2
				l_5_2 = l_5_5 .. TableSerializer._save(l_5_0, l_5_1)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			l_5_2 = l_5_2 .. "p" .. tostring(l_5_4) .. "|"
		end
	elseif l_5_3 == "function" then
		do return end
	end
	if l_5_3 == "number" then
		l_5_2 = l_5_2 .. "n" .. tostring(l_5_0) .. "|"
	elseif l_5_3 == "string" then
		l_5_2 = l_5_2 .. "s" .. l_5_0 .. "|"
	elseif l_5_3 == "boolean" then
		l_5_2 = l_5_2 .. "b" .. tostring(l_5_0) .. "|"
	elseif l_5_3 == "nil" then
		do return end
	end
	if l_5_0.type_name then
		if l_5_0.type_name == "Vector3" then
			l_5_2 = l_5_2 .. TableSerializer._save_vector(l_5_0)
		elseif l_5_0.type_name == "Rotation" then
			l_5_2 = l_5_2 .. TableSerializer._save_rotation(l_5_0)
		elseif l_5_0.type_name == "Unit" then
			do return end
		end
		error("unknown type:" .. l_5_0.type_name)
	else
		error("Invalid type:" .. l_5_3)
	end
	return l_5_2
end

TableSerializer._save = function(l_6_0, l_6_1)
	local l_6_7, l_6_8, l_6_9 = nil
	local l_6_2 = ""
	local l_6_3 = ""
	for i_0,i_1 in pairs(l_6_0) do
		l_6_2 = l_6_2 .. TableSerializer._save_value(i_0, l_6_1)
		l_6_2 = l_6_2 .. TableSerializer._save_value(i_1, l_6_1)
	end
	l_6_2 = l_6_2 .. "*"
	return l_6_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

TableSerializer.load = function(l_7_0)
	local l_7_1 = {}
	TableSerializer.str = l_7_0
	TableSerializer.pos = 1
	local l_7_2 = TableSerializer._load
	local l_7_3 = l_7_1
	return l_7_2(l_7_3)
end

TableSerializer._load_vector = function(l_8_0)
	local l_8_1 = String.split(l_8_0)
	local l_8_2 = tonumber(l_8_1[1])
	local l_8_3 = tonumber(l_8_1[2])
	local l_8_4 = tonumber(l_8_1[3])
	return Vector3(l_8_2, l_8_3, l_8_4)
end

TableSerializer._load_rotation = function(l_9_0)
	local l_9_1 = String.split(l_9_0, "[,]")
	local l_9_2 = TableSerializer._load_vector(l_9_1[1])
	local l_9_3 = TableSerializer._load_vector(l_9_1[2])
	local l_9_4 = TableSerializer._load_vector(l_9_1[3])
	return Rotation(l_9_2, l_9_3, l_9_4)
end

TableSerializer._get_next_command = function()
	local l_10_0 = string.find(TableSerializer.str, "|", TableSerializer.pos)
	if not l_10_0 then
		error("Couldn't find command in string: '" .. TableSerializer.str:sub(TableSerializer.pos, TableSerializer.pos) .. "'")
	end
	local l_10_1 = {}
	l_10_1.command = string.sub(TableSerializer.str, TableSerializer.pos, TableSerializer.pos)
	l_10_1.value = string.sub(TableSerializer.str, TableSerializer.pos + 1, l_10_0 - 1)
	TableSerializer.pos = l_10_0 + 1
	return l_10_1
end

TableSerializer.get_value = function(l_11_0, l_11_1, l_11_2)
	if l_11_0 == "p" then
		local l_11_4 = nil
		l_11_4 = l_11_2[tonumber(l_11_1)]
		local l_11_3 = nil
		assert(l_11_4)
	elseif l_11_0 == "n" then
		local l_11_5 = tonumber(l_11_1)
	elseif l_11_0 == "b" then
		local l_11_6 = l_11_1 == "true"
	elseif l_11_0 == "s" then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_11_0 == "v" then
		local l_11_7, l_11_8, l_11_9 = l_11_1
	elseif l_11_0 == "r" then
		do return end
	end
	error("Uknown type:'" .. l_11_0 .. "'")
	return TableSerializer._load_rotation(l_11_1)
end

TableSerializer._load = function(l_12_0)
	if TableSerializer.str == "" then
		return nil
	end
	while 1 do
		local l_12_1 = {}
		while 1 do
			if string.sub(TableSerializer.str, TableSerializer.pos, TableSerializer.pos) == "*" then
				TableSerializer.pos = TableSerializer.pos + 1
				return l_12_1
			end
			local l_12_2 = TableSerializer._get_next_command()
			local l_12_3 = TableSerializer.get_value(l_12_2.command, l_12_2.value, l_12_0)
			local l_12_4 = (TableSerializer._get_next_command())
			do
				local l_12_5 = nil
				if l_12_4.command == "t" then
					l_12_0[tonumber(l_12_4.value)] = l_12_5
				 -- DECOMPILER ERROR: Overwrote pending register.

				else
					l_12_1[l_12_3] = l_12_5
				end
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end


