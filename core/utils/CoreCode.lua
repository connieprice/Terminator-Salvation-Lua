local l_0_4, l_0_5, l_0_6 = nil
core:module("CoreCode")
core:require_module("CoreTable")
core:require_module("CoreDebug")
core:require_module("CoreClass")
get_prototype = function(l_1_0)
	if l_1_0.source == "=[C]" then
		return nil
	end
	if not File:exists(l_1_0.source) then
		return l_1_0.source
	end
	local l_1_1 = File:open(l_1_0.source, "r")
	if not l_1_1 then
		return l_1_0.source
	end
	for l_1_5 = 1, l_1_0.linedefined - 1 do
		l_1_1:gets()
	end
	local l_1_6 = l_1_1:gets()
	l_1_1:close()
	return l_1_6
end

get_source = function(l_2_0)
	if l_2_0.source == "=[C]" then
		return nil
	end
	if not File:exists(l_2_0.source) then
		return l_2_0.source
	end
	local l_2_1 = File:open(l_2_0.source, "r")
	if not l_2_1 then
		return l_2_0.source
	end
	local l_2_2 = {}
	for l_2_6 = 1, l_2_0.linedefined - 1 do
		local l_2_7 = l_2_1:gets()
		local l_2_20 = l_2_7:match
		l_2_20 = l_2_20(l_2_7, "^%s*%-%-")
		if l_2_20 then
			l_2_20 = #l_2_2
			l_2_20 = l_2_20 + 1
			l_2_2[l_2_20] = l_2_7
		else
			l_2_2, l_2_20 = l_2_20, {}
		end
	end
	for l_2_11 = l_2_0.linedefined, l_2_0.lastlinedefined do
		local l_2_16 = nil
		l_2_16 = #l_2_2
		l_2_16 = l_2_16 + 1
		local l_2_12, l_2_17 = nil
		l_2_12, l_2_17 = l_2_1:gets, l_2_1
		local l_2_19 = nil
		l_2_12 = l_2_12(l_2_17)
		local l_2_18 = nil
		l_2_2[l_2_16] = l_2_12
	end
	local l_2_13 = table.concat
	local l_2_14 = l_2_2
	local l_2_15 = "\n"
	return l_2_13(l_2_14, l_2_15)
end

traceback = function(l_3_0)
	if not l_3_0 then
		l_3_0 = 2
	end
	while 1 do
		local l_3_1 = 2
		while 1 do
			do
				local l_3_2 = debug.getinfo(l_3_1, "Sl")
				if l_3_2 then
					if l_3_0 + 2 <= l_3_1 then
						do break end
					end
				end
				if l_3_2.what == "C" then
					CoreDebug.cat_print("debug", l_3_1, "C function")
				else
					CoreDebug.cat_print("debug", string.format("[%s]:%d", l_3_2.source, l_3_2.currentline))
				end
				l_3_1 = l_3_1 + 1
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

alive = function(l_4_0)
	if l_4_0 and l_4_0:alive() then
		return true
	end
	return false
end

local l_0_0 = function(l_5_0, l_5_1)
	local l_5_6 = nil
	local l_5_2 = {}
	for i_0,i_1 in pairs(l_5_0) do
		l_5_2[#l_5_2 + 1] = i_0
	end
	table.sort(l_5_2, function(l_6_0, l_6_1)
		if type(l_6_1) == "number" then
			if l_6_0 >= l_6_1 then
				return type(l_6_0) ~= "number"
			end
		else
			return true
		end
		do return end
		if type(l_6_1) == "number" then
			return false
		end
		return tostring(l_6_0) < tostring(l_6_1)
  end)
	return function()
		-- upvalues: l_5_3 , l_5_2 , l_5_1 , l_5_0
		l_5_3 = l_5_3 + 1
		local l_7_0 = l_5_2[l_5_3]
		if l_5_1 then
			return l_7_0, rawget(l_5_0, l_7_0)
		else
			return l_7_0, l_5_0[l_7_0]
		end
  end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- WARNING: undefined locals caused missing assignments!
end

line_representation = function(l_6_0, l_6_1, l_6_2)
	-- upvalues: l_0_0
	local l_6_6, l_6_7, l_6_8, l_6_9, l_6_10, l_6_11, l_6_12, l_6_13, l_6_14, l_6_15, l_6_16, l_6_21, l_6_22, l_6_23, l_6_29, l_6_42 = nil
	local l_6_3 = 60
	if type(l_6_0) == "userdata" then
		local l_6_4 = tostring
		local l_6_5 = l_6_0
		return l_6_4(l_6_5)
	else
		if type(l_6_0) == "table" then
			if not l_6_1 then
				l_6_1 = {}
			end
			if l_6_1[l_6_0] then
				return "..."
			end
			l_6_1[l_6_0] = true
			local l_6_17 = "{"
			for i_0,i_1 in l_0_0(l_6_0, l_6_2) do
				local l_6_36, l_6_49 = l_6_17, line_representation(i_0, l_6_1, l_6_2)
				local l_6_34, l_6_47 = "=", line_representation(i_1, l_6_1, l_6_2)
				l_6_17 = l_6_36 .. l_6_49 .. l_6_34 .. l_6_47 .. ", "
				l_6_36, l_6_49 = l_6_17:len, l_6_17
				l_6_36 = l_6_36(l_6_49)
				if l_6_3 < l_6_36 then
					l_6_36, l_6_49 = l_6_17:sub, l_6_17
					l_6_34 = 1
					local l_6_32, l_6_45 = nil
					l_6_47 = l_6_3
					local l_6_33, l_6_46 = nil
					l_6_36 = l_6_36(l_6_49, l_6_34, l_6_47)
					l_6_17 = l_6_36
					l_6_36 = l_6_17
					local l_6_30, l_6_43 = nil
					l_6_49 = "..."
					local l_6_31, l_6_44 = nil
					l_6_17 = l_6_36 .. l_6_49
			else
				end
			end
			l_6_17 = l_6_17 .. "}"
			return l_6_17
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	else
		l_6_17 = type
		l_6_17 = l_6_17(l_6_0)
		if l_6_17 == "string" then
			l_6_17 = string
			l_6_17 = l_6_17.gsub
			l_6_17 = l_6_17(l_6_0, "\n", "\\n")
			l_6_0 = l_6_17
			l_6_17 = string
			l_6_17 = l_6_17.gsub
			l_6_17 = l_6_17(l_6_0, "\r", "\\r")
			l_6_0 = l_6_17
			l_6_17 = string
			l_6_17 = l_6_17.gsub
			l_6_17 = l_6_17(l_6_0, "\t", "\\t")
			l_6_0 = l_6_17
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_6_3 < l_6_17 then
				l_6_0 = l_6_17 .. "..."
			end
			return l_6_0
		end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		if l_6_17 == "function" then
			local l_6_24 = nil
			if l_6_17.source == "=[C]" then
				return "(C++ method)"
			end
		else
			local l_6_25 = nil
			local l_6_26, l_6_39 = nil
			 -- DECOMPILER ERROR: Overwrote pending register.

			local l_6_27, l_6_40 = nil
			local l_6_28, l_6_41 = nil
			return line_representation((get_prototype(l_6_24)), l_6_24, l_6_25)
		end
	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		local l_6_37 = l_6_24
		do
			local l_6_38 = l_6_25
			return l_6_17(l_6_0)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

full_representation = function(l_7_0, l_7_1)
	if type(l_7_0) == "function" then
		local l_7_2 = debug.getinfo(l_7_0)
		if l_7_2.source == "=[C]" then
			return "(C++ method)"
		else
			local l_7_3 = get_source
			local l_7_4 = l_7_2
			return l_7_3(l_7_4)
		end
	else
		if type(l_7_0) == "table" then
			local l_7_5 = ascii_table
			local l_7_6 = l_7_0
			local l_7_7, l_7_10 = true
			return l_7_5(l_7_6, l_7_7)
		end
	else
		local l_7_8 = tostring
		local l_7_9 = l_7_0
		return l_7_8(l_7_9)
	end
end

inspect = full_representation
properties = function(l_8_0)
	local l_8_5, l_8_6, l_8_7, l_8_8 = nil
	local l_8_1 = {}
	for i_0,i_1 in ipairs(l_8_0.__properties) do
		l_8_1[i_1] = l_8_0[i_1](l_8_0)
	end
	CoreDebug.cat_print("debug", ascii_table(l_8_1))
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

help = function(l_9_0)
	local l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_12, l_9_13 = nil
	local l_9_1 = {}
	function(l_10_0)
		-- upvalues: l_9_1 , l_9_2
		local l_10_4, l_10_5, l_10_6, l_10_7, l_10_8, l_10_9 = nil
		if type(l_10_0) == "table" then
			for i_0,i_1 in pairs(l_10_0) do
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				if type(i_1) == "function" then
					if not get_prototype(debug.getinfo(i_1, "S")) or ((((get_prototype(debug.getinfo(i_1, "S")):match("= function") and l_10_10) or not l_10_10) and l_10_10) or debug.getinfo(i_1, "S").what == "Lua") then
						do return end
					end
					 -- DECOMPILER ERROR: Overwrote pending register.

					l_9_1[l_10_10] = true
				end
			end
		end
		if getmetatable(l_10_0) then
			l_9_2(getmetatable(l_10_0))
		end
  end(l_9_0)
	local l_9_3 = nil
	for i_0,i_1 in pairs(l_9_1) do
		local l_9_4 = {}
		table.insert(l_9_4, i_0)
	end
	table.sort(l_9_4)
	for i_0,i_1 in ipairs(l_9_4) do
		CoreDebug.cat_print("debug", i_1)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ascii_table = function(l_10_0, l_10_1)
	-- upvalues: l_0_0
	local l_10_8, l_10_9, l_10_10, l_10_11, l_10_12, l_10_16 = nil
	local l_10_2 = ""
	local l_10_3 = 20
	local l_10_4 = 20
	for i_0,i_1 in pairs(l_10_0) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_10_3 >= line_representation(i_0, nil, l_10_1):len() + 2 or l_10_4 < line_representation(i_1, nil, l_10_1):len() + 2 then
			l_10_4 = line_representation(i_1, nil, l_10_1):len() + 2
		end
	end
	local l_10_15 = l_10_3 + (l_10_4) + 5
	l_10_2 = l_10_2 .. "-":rep(l_10_15) .. "\n"
	for l_10_15,i_1 in l_0_0(l_10_0, l_10_1) do
		l_10_2 = l_10_2 .. "| " .. line_representation(l_10_15, nil, l_10_1):left(l_10_3) .. "| " .. line_representation(i_1, nil, l_10_1):left(l_10_4) .. "|\n"
	end
	l_10_2 = l_10_2 .. "-":rep(l_10_3 + (l_10_4) + 5) .. "\n"
	return l_10_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

memory_report = function()
	local l_11_6, l_11_7, l_11_11, l_11_12, l_11_13, l_11_14, l_11_15, l_11_16 = nil
	local l_11_0 = {}
	local l_11_1 = {}
	local l_11_2 = {}
	l_11_2._G = _G
	for i_0,i_1 in pairs(_G) do
		l_11_2[i_1] = i_0
	end
	function(l_13_0, l_13_1, l_13_2)
		-- upvalues: l_11_0 , l_11_2 , l_11_1 , l_11_3 , l_11_4
		local l_13_10, l_13_11 = nil
		if l_11_0[l_13_0] then
			return 
		end
		l_11_0[l_13_0] = true
		if not l_11_2[l_13_0] and not l_11_2[getmetatable(l_13_0)] then
			local l_13_3, l_13_4, l_13_5, l_13_6, l_13_14, l_13_20, l_13_21 = l_13_1 .. "/" .. l_13_2
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_11_1[l_13_3] = (l_11_1[l_13_3] or 0) + 1
		if type(l_13_0) == "table" then
			for i_0,i_1 in pairs(l_13_0) do
				local l_13_7 = nil
				l_11_1[l_13_7 .. "/*"] = (l_11_1[l_13_7 .. "/*"] or 0) + 1
				if not l_11_3(i_1) and not l_11_0[i_1] then
					l_11_4(i_1, l_13_7, tostring(l_13_13))
				end
			end
		end
		if CoreClass.type_name(l_13_0) == "Unit" then
			local l_13_18, l_13_19 = , ipairs
			l_13_19 = l_13_19(l_13_0:extensions())
			for i_0,i_1 in l_13_19 do
				l_11_4(l_13_0[i_1](l_13_0), l_13_18, i_1)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		if getmetatable(l_13_0) and not l_11_0[getmetatable(l_13_0)] then
			l_11_4(getmetatable(l_13_0), l_13_18, "metatable")
		end
  end(_G, nil, nil)
	for i_0,i_1 in ipairs(World:unit_manager():get_units()) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_11_23, l_11_25, l_11_26, l_11_29, l_11_31 = function(l_13_0, l_13_1, l_13_2)
		-- upvalues: l_11_0 , l_11_2 , l_11_1 , l_11_3 , l_11_4
		local l_13_10, l_13_11 = nil
		if l_11_0[l_13_0] then
			return 
		end
		l_11_0[l_13_0] = true
		if not l_11_2[l_13_0] and not l_11_2[getmetatable(l_13_0)] then
			local l_13_3, l_13_4, l_13_5, l_13_6, l_13_14, l_13_20, l_13_21 = l_13_1 .. "/" .. l_13_2
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_11_1[l_13_3] = (l_11_1[l_13_3] or 0) + 1
		if type(l_13_0) == "table" then
			for i_0,i_1 in pairs(l_13_0) do
				local l_13_7 = nil
				l_11_1[l_13_7 .. "/*"] = (l_11_1[l_13_7 .. "/*"] or 0) + 1
				if not l_11_3(i_1) and not l_11_0[i_1] then
					l_11_4(i_1, l_13_7, tostring(l_13_13))
				end
			end
		end
		if CoreClass.type_name(l_13_0) == "Unit" then
			local l_13_18, l_13_19 = , ipairs
			l_13_19 = l_13_19(l_13_0:extensions())
			for i_0,i_1 in l_13_19 do
				l_11_4(l_13_0[i_1](l_13_0), l_13_18, i_1)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		if getmetatable(l_13_0) and not l_11_0[getmetatable(l_13_0)] then
			l_11_4(getmetatable(l_13_0), l_13_18, "metatable")
		end
  end
		local l_11_20, l_11_22, l_11_24, l_11_27, l_11_30, l_11_32 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_11_23(l_11_25, l_11_26, l_11_29, l_11_31, l_11_20, l_11_22, l_11_24, l_11_27, l_11_30, l_11_32)
	end
	for i_0,i_1 in pairs(l_11_1) do
		 -- DECOMPILER ERROR: Overwrote pending register.

		do
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Confused about usage of registers!

	end
	if i_1 > 100 then
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		table.sort({})
		 -- DECOMPILER ERROR: Confused about usage of registers!

		for i_0,i_1 in ipairs({}) do
			CoreDebug.cat_print("debug", i_1)
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		CoreDebug.cat_print("debug", string.format("\n%6i  TOTAL", i_1))
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: undefined locals caused missing assignments!
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 59 
end

if not __old_profiled then
	__old_profiled = {}
end
if __profiled then
	__old_profiled = __profiled
	for i_0,i_1 in pairs(__profiled) do
		Application:console_command("profiler remove " .. i_0)
	end
end
__profiled = {}
profile = function(l_12_0)
	if __profiled[l_12_0] then
		return 
	end
	local l_12_1 = {}
	l_12_1.s = l_12_0
	local l_12_2, l_12_3 = l_12_0:find(":")
	if l_12_2 then
		l_12_1.class = l_12_0:sub(0, l_12_2 - 1)
		l_12_1.name = l_12_0:sub(l_12_3 + 1)
		if not rawget(_G, l_12_1.class) then
			CoreDebug.cat_print("debug", "Could not find class " .. l_12_1.class)
			return 
		end
		l_12_1.f = rawget(_G, l_12_1.class)[l_12_1.name]
		l_12_1.patch = function(l_13_0)
			-- upvalues: l_12_1
			_G[l_12_1.class][l_12_1.name] = l_13_0
    end
	else
		l_12_1.name = l_12_0
		l_12_1.f = rawget(_G, l_12_1.name)
		l_12_1.patch = function(l_14_0)
			-- upvalues: l_12_1
			_G[l_12_1.name] = l_14_0
    end
	end
	if not l_12_1.f or type(l_12_1.f) ~= "function" then
		CoreDebug.cat_print("debug", "Could not find function " .. l_12_0)
		return 
	end
	l_12_1.instrumented = function(...)
		-- upvalues: l_12_1
		Profiler:stop(Profiler:start(l_12_1.s))
		return res
  end
	l_12_1.patch(l_12_1.instrumented)
	__profiled[l_12_0] = l_12_1
	Application:console_command("profiler add " .. l_12_0)
end

unprofile = function(l_13_0)
	local l_13_1 = __profiled[l_13_0]
	if l_13_1 then
		l_13_1.patch(l_13_1.f)
	end
	Application:console_command("profiler remove " .. l_13_0)
	__profiled[l_13_0] = nil
end

reprofile = function()
	local l_14_3, l_14_4, l_14_5 = nil
	for i_0,i_1 in pairs(__old_profiled) do
		profile(i_0)
	end
	__old_profiled = {}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


