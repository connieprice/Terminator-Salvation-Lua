core:module("CoreDebug")
core:require_module("CoreCode")
core:require_module("CoreEvent")
core:require_module("CoreClass")
only_in_debug = function(l_1_0)
	local l_1_1 = getmetatable(Application)
	local l_1_2 = "old_" .. l_1_0
	if not l_1_1[l_1_2] then
		l_1_1[l_1_2] = l_1_1[l_1_0]
		l_1_1[l_1_0] = function(...)
			-- upvalues: l_1_1 , l_1_2
			if script_debug.draw_enabled then
				l_1_1[l_1_2](...)
			end
    end
	end
end

only_in_debug("draw")
only_in_debug("draw_sphere")
only_in_debug("draw_line")
only_in_debug("draw_cone")
only_in_debug("draw_circle")
only_in_debug("draw_rotation")
only_in_debug("draw_cylinder")
only_in_debug("draw_line_unpaused")
only_in_debug("draw_sphere_unpaused")
local l_0_0 = {}
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

green, l_0_0 = l_0_0, {1, 0, 0}
blue, l_0_0 = l_0_0, {0, 0, 1}
l_0_0 = function(l_2_0, l_2_1)
	debug.sethook(function()
		-- upvalues: l_2_0 , l_2_1
		if l_2_1 then
			if not rawget(_G, "__watch_previnfo") then
				cat_print("debug", string.format("[CoreVarTrace] %s", not l_2_0() or "? : -1"))
			end
		else
			local l_3_0 = debug.getinfo(2, "Sl")
			cat_print("debug", "[CoreVarTrace] Probably file: " .. (l_3_0 and l_3_0.source or "?"))
			cat_print("debug", "[CoreVarTrace] Might be line: " .. (l_3_0 and l_3_0.currentline or -1))
		end
		cat_print("debug", debug.traceback())
		debug.sethook()
		if l_2_1 then
			local l_3_1 = debug.getinfo(2, "Sl")
		if l_3_1 then
			end
			rawset(_G, "__watch_previnfo", string.format("%s : %i", l_3_1.source or "?", l_3_1.currentline or -1))
		end
  end, "l", 1)
end

watch = l_0_0
l_0_0 = function(l_3_0, l_3_1, l_3_2)
	do
		local l_3_3, l_3_4, l_3_5, l_3_6 = type(l_3_0) == "string" and getmetatable(assert(rawget(_G, l_3_0))) or l_3_0
	end
	local l_3_7 = nil
	local l_3_8 = function()
		if not rawget(_G, "_trace_ref_table") then
			local l_4_0 = {}
			rawset(_G, "_trace_ref_table", l_4_0)
			print("[CoreTraceRef] ---------------------- New Script Environment --------------------------")
		end
  end
	if not rawget(l_3_7, "_" .. l_3_1) then
		rawset(l_3_7, "_" .. l_3_1, assert(rawget(l_3_7, l_3_1)))
		rawset(l_3_7, l_3_1, function(...)
			-- upvalues: l_3_4 , l_3_3 , l_3_1 , l_3_5
			l_3_4()
			local l_6_1 = rawget(l_3_3, "_" .. l_3_1)(...)
			print("[CoreTraceRef] New ref:", l_6_1)
			rawget(_G, "_trace_ref_table")[l_6_1] = l_3_5()
			return l_6_1
    end)
	end
	if not rawget(l_3_7, "_" .. l_3_2) then
		rawset(l_3_7, "_" .. l_3_2, assert(rawget(l_3_7, l_3_2)))
		rawset(l_3_7, l_3_2, function(...)
			-- upvalues: l_3_4 , l_3_5 , l_3_3 , l_3_2
			l_3_4()
			local l_7_1 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if not ({...})[2] or ({...})[2].alive and not ({...})[2]:alive() then
				print("[CoreTraceRef] WARNING! Deleting NULL ref: ", ({...})[2], l_3_5())
			 -- DECOMPILER ERROR: Confused about usage of registers!

			else
				print("[CoreTraceRef] Delete ref:", ({...})[2])
			end
			local l_7_2 = nil
			return rawget(l_3_3, "_" .. l_3_2)(...)
    end)
	end
	if not rawget(_G, "_destroy") then
		rawset(_G, "_destroy", rawget(_G, "destroy"))
		rawset(_G, "destroy", function(...)
			-- upvalues: l_3_4
			l_3_4()
			if rawget(_G, "_destroy") then
				rawget(_G, "_destroy")(...)
			end
			local l_8_1 = nil
			local l_8_2 = 0
			for i_0,i_1 in pairs(assert(rawget(_G, "_trace_ref_table"))) do
				do
					local l_8_3 = nil
					l_8_2 = l_8_2 + 1
				end
				local l_8_6, l_8_7 = .end
				print(string.format("[CoreTraceRef] ---------------------- %i Script References Lost --------------------------", l_8_2), l_8_6, l_8_7)
				for l_8_7,i_1 in pairs(l_8_3) do
					print("[CoreTraceRef]", l_8_7, i_1)
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

    end)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

trace_ref = l_0_0
l_0_0 = function(l_4_0, l_4_1)
	do
		local l_4_2, l_4_3, l_4_4, l_4_5, l_4_6, l_4_7, l_4_8 = type(l_4_0) == "string" and getmetatable(assert(rawget(_G, l_4_0))) or l_4_0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	rawset(l_4_2, "_" .. l_4_1, assert(rawget(l_4_2, l_4_1)))
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not rawget(l_4_2, "_" .. l_4_1) then
		rawset(l_4_2, l_4_1, function(...)
		-- upvalues: l_4_2 , l_4_1
		print("[CoreTraceRef] WARNING! Called destroy all function:", l_4_1)
		return rawget(l_4_2, "_" .. l_4_1)(...)
  end)
	end
end

trace_ref_add_destroy_all = l_0_0
l_0_0 = function(...)
	local l_5_1 = "debug"
	local l_5_2 = "Spam"
	local l_5_3 = {...}
	do
		if #l_5_3 == 0 then
			return 
		end
		do return end
		do
			if #l_5_3 > 1 and type(l_5_3[1]) == "string" then
				local l_5_5 = function(...)
		local l_6_1 = {...}
		local l_6_5 = nil
		local l_6_4 = l_6_1[1]
		l_6_4 = l_6_4 .. " " .. tostring(({select(2, ...)})[1])
		l_6_5[1] = l_6_4
		l_6_4 = unpack
		local l_6_2 = nil
		l_6_2 = l_6_5
		local l_6_3 = nil
		return l_6_4(l_6_2)
  end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				function(l_7_0, ...)
		-- upvalues: l_5_1
		local l_7_2 = l_5_1
		local l_7_6 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0,i_1 in ...(.end.category_print) do
			if i_0 == l_7_0 then
				l_7_2 = l_7_0
		else
			end
		end
		cat_print(l_7_2, ...)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end(l_5_3[1], l_5_5(unpack(l_5_3)))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			function(l_7_0, ...)
		-- upvalues: l_5_1
		local l_7_2 = l_5_1
		local l_7_6 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0,i_1 in ...(.end.category_print) do
			if i_0 == l_7_0 then
				l_7_2 = l_7_0
		else
			end
		end
		cat_print(l_7_2, ...)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end(l_5_2, l_5_5("[" .. l_5_2 .. "]", unpack(l_5_3)))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

out = l_0_0
l_0_0 = function(l_6_0, ...)
	if Global.category_print[l_6_0] then
		_G.print(...)
	end
end

cat_print = l_0_0
l_0_0 = function(l_7_0, ...)
	if Global.category_print[l_7_0] then
		Application:debug(...)
	end
end

cat_debug = l_0_0
l_0_0 = function(l_8_0, ...)
	if Global.category_print[l_8_0] then
		Application:error(...)
	end
end

cat_error = l_0_0
l_0_0 = function(l_9_0)
	if Global.category_print[l_9_0] then
		Application:stack_dump()
	end
end

cat_stack_dump = l_0_0
l_0_0 = function(l_10_0, ...)
	if Global.category_print[l_10_0] then
		local l_10_4, l_10_5 = ipairs, {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		for i_0,i_1 in l_10_4 do
			cat_print(l_10_0, CoreCode.inspect(i_1))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- WARNING: undefined locals caused missing assignments!
end

cat_print_inspect = l_0_0
l_0_0 = function(l_11_0, ...)
	if Global.category_print[l_11_0] then
		local l_11_4, l_11_5 = ipairs, {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		for i_0,i_1 in l_11_4 do
			cat_debug(l_11_0, "\n" .. tostring(CoreCode.inspect(i_1)))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- WARNING: undefined locals caused missing assignments!
end

cat_debug_inspect = l_0_0
l_0_0 = function()
	local l_12_4, l_12_5, l_12_6, l_12_7, l_12_8, l_12_9, l_12_10, l_12_11 = nil
	local l_12_0 = File:open("data/settings/catprint.xml", "w")
	l_12_0:print("<catprints>\n")
	for i_0,i_1 in pairs(Global.category_print) do
		if Global.original_category_print[i_0] ~= i_1 then
			l_12_0:print("\t<cat name=\"" .. i_0 .. "\" value=\"" .. tostring(i_1) .. "\"/>\n")
		end
	end
	l_12_0:print("</catprints>\n")
	File:close(l_12_0)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

catprint_save = l_0_0
l_0_0 = function(l_13_0)
	local l_13_1 = tostring(l_13_0:parameter("name"))
	local l_13_2 = toboolean(l_13_0:parameter("value"))
	if Global.category_print[l_13_1] ~= nil then
		Global.category_print[l_13_1] = l_13_2
	end
end

catprint_loadcat = l_0_0
l_0_0 = function()
	local l_14_3, l_14_4 = nil
	if not Global.original_category_print then
		Global.original_category_print = {}
		for i_0,i_1 in pairs(Global.category_print) do
			Global.original_category_print[i_0] = i_1
		end
	end
	if File:config_exists("data/settings/catprint") then
		local l_14_5 = File:parse_xml("data/settings/catprint.xml")
		l_14_5:for_each("cat", function(...)
			catprint_loadcat(...)
    end)
	end
end

catprint_load = l_0_0
l_0_0 = function(...)
	for i = 1, select("#", ...) do
		cat_print("debug", CoreCode.full_representation(select(i, ...)))
	end
end

print_console_result = l_0_0

