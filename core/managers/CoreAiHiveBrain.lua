if not CoreAiMachine then
	CoreAiMachine = class()
end
CoreAiMachine.PROFILE = false
CoreAiMachine._ai_logic_functions = {}
CoreAiMachine.register_logicfunctions = function(l_1_0, l_1_1)
	local l_1_5, l_1_6, l_1_7, l_1_8, l_1_9, l_1_10, l_1_11 = nil
	if type(l_1_1) == "table" then
		for i_0,i_1 in pairs(l_1_1) do
			if type(i_1) == "function" and string.find(i_0, "logic_") ~= nil then
				if l_1_0._ai_logic_functions[string.sub(l_1_12, 7)] == nil then
					l_1_0._ai_logic_functions[string.sub(l_1_12, 7)] = callback(l_1_1, l_1_1, l_1_12)
				end
			else
				Application:error("CoreAiMachine:register_logicfunctions: There is already a logic with the name '" .. string.sub(l_1_12, 7) .. "'")
			end
		end
	end
end

CoreAiMachine.init = function(l_2_0)
	l_2_0._brains_data = {}
	l_2_0._threads_data = {}
	l_2_0._brain_groups = {}
	l_2_0._ai_call_functions = {}
	l_2_0._enable = true
	l_2_0._debug = false
	cat_print("ai", "------------------------ CoreAiMachine:Init Done")
end

CoreAiMachine.parse_data = function(l_3_0)
	local l_3_5, l_3_6, l_3_7, l_3_9, l_3_11, l_3_13 = nil
	cat_print("ai", "------------------------ CoreAiMachine:parse_data")
	local l_3_1 = File:parse_xml("/data/lib/ai/ai_machine.xml")
	if l_3_1 == nil then
		error("CoreAiMachine:parse_data: File '/data/lib/ai/ai_machine.xml' not found.")
	end
	for i_0 in l_3_1:children() do
		local l_3_10, l_3_12, l_3_14 = l_3_0:parse_ai_graph, l_3_0
		l_3_14 = l_3_8
		l_3_10(l_3_12, l_3_14)
	end
	for i_0,i_1 in pairs(l_3_0._threads_data) do
		i_1:init_thread_data()
	end
	for i_0,i_1 in pairs(l_3_0._brains_data) do
		i_1:init_threads(l_3_0._threads_data)
	end
	cat_print("ai", "------------------------ CoreAiMachine:parse_data Done")
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreAiMachine.debug = function(l_4_0, l_4_1)
	l_4_0._debug = l_4_1
end

CoreAiMachine.print_aifunctions = function(l_5_0)
	cat_print("ai", "Hive Brain : _ai_logic_functions")
	help(l_5_0._ai_logic_functions)
end

CoreAiMachine.print = function(l_6_0, l_6_1)
	local l_6_6, l_6_7, l_6_8, l_6_9 = nil
	local l_6_2 = {}
	table.insert(l_6_2, "")
	table.insert(l_6_2, "****************************************")
	table.insert(l_6_2, "Hive Brain : Braingroups")
	for i_0,i_1 in pairs(l_6_0._brain_groups) do
		i_1:print(l_6_2)
	end
	table.insert(l_6_2, "****************************************")
	table.insert(l_6_2, "")
	l_6_0:print_textvec(l_6_2)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreAiMachine.print_textvec = function(l_7_0, l_7_1)
	local l_7_5, l_7_6, l_7_7, l_7_8 = nil
	for i_0,i_1 in pairs(l_7_1) do
		cat_print("ai", i_1)
	end
end

CoreAiMachine.update = function(l_8_0, l_8_1)
	local l_8_2, l_8_5, l_8_6, l_8_7, l_8_8 = nil
	if CoreAiMachine.PROFILE then
		l_8_2 = Profiler:start("AI_Machine")
	end
	if l_8_0._enable then
		for i_0,i_1 in pairs(l_8_0._brain_groups) do
			i_1:update(l_8_1)
		end
	if l_8_0._debug then
		end
		l_8_0:print(nil)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	if CoreAiMachine.PROFILE then
		Profiler:stop(l_8_2)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreAiMachine.set_enable = function(l_9_0, l_9_1)
	l_9_0._enable = l_9_1
end

CoreAiMachine.get_brain_group = function(l_10_0, l_10_1)
	if l_10_0._brain_groups[l_10_1] == nil then
		local l_10_2, l_10_3 = BrainGroup:new(l_10_1)
		l_10_3 = l_10_0._brain_groups
		l_10_3[l_10_1] = l_10_2
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_10_2
end

CoreAiMachine.add_brain_group = function(l_11_0, l_11_1)
	l_11_0._brain_groups[l_11_1._name] = l_11_1
end

CoreAiMachine.remove_brain_group = function(l_12_0, l_12_1)
	l_12_0._brain_groups[l_12_1] = nil
end

CoreAiMachine.get_brain_data = function(l_13_0, l_13_1)
	return l_13_0._brains_data[l_13_1]
end

CoreAiMachine.get_brain = function(l_14_0, l_14_1, l_14_2, l_14_3)
	local l_14_4 = l_14_0:get_brain_data(l_14_2)
	local l_14_5, l_14_6 = Brain:new, Brain
	local l_14_7 = l_14_2
	local l_14_8 = l_14_4
	local l_14_9 = l_14_1
	local l_14_10, l_14_11, l_14_12 = l_14_0:get_brain_group(l_14_3), .end
	return l_14_5(l_14_6, l_14_7, l_14_8, l_14_9, l_14_10, l_14_11, l_14_12)
end

CoreAiMachine.add_logic_function = function(l_15_0, l_15_1, l_15_2)
	l_15_0._ai_logic_functions[l_15_1] = l_15_2
end

CoreAiMachine.add_call_function = function(l_16_0, l_16_1, l_16_2)
	l_16_0._ai_call_functions[l_16_1] = l_16_2
end

CoreAiMachine.parse_ai_graph = function(l_17_0, l_17_1)
	l_17_1:for_each("brain", function(...)
		-- upvalues: l_17_0
		l_17_0:parse_brain(...)
  end)
	l_17_1:for_each("thread", function(...)
		-- upvalues: l_17_0
		l_17_0:parse_thread(...)
  end)
	l_17_1:for_each("link", function(...)
		-- upvalues: l_17_0
		l_17_0:parse_link(...)
  end)
	l_17_1:for_each("logic", function(...)
		-- upvalues: l_17_0
		l_17_0:parse_logic(...)
  end)
end

CoreAiMachine.parse_link = function(l_18_0, l_18_1)
	cat_print("ai", "function CoreAiMachine:parse_link( xml_node ): NOT DONE")
	local l_18_2 = l_18_1:parameter("name")
	local l_18_3 = Link:new(l_18_2, l_18_1)
	local l_18_4 = l_18_0._threads_data[l_18_3._thread]
	if l_18_4 == nil then
		error("AI : Parsing : Link named : " .. l_18_2 .. " : Could not find thread named : " .. l_18_3._thread)
	else
		l_18_4._links[l_18_3._name] = l_18_3
		cat_print("ai", "AI : Parsing : Link named : " .. l_18_2 .. " : Found thread named : " .. l_18_3._thread)
	end
end

CoreAiMachine.parse_brain = function(l_19_0, l_19_1)
	local l_19_2 = l_19_1:parameter("name")
	local l_19_3 = BrainData:new(l_19_1)
	l_19_0._brains_data[l_19_2] = l_19_3
	cat_print("ai", "AI : Parsing : Brain named : " .. l_19_2 .. " : Added")
end

CoreAiMachine.parse_thread = function(l_20_0, l_20_1)
	local l_20_2 = l_20_1:parameter("name")
	local l_20_3 = ThreadData:new(l_20_1)
	l_20_0._threads_data[l_20_2] = l_20_3
	cat_print("ai", "AI : Parsing : Thread named : " .. l_20_2 .. " : Added")
end

CoreAiMachine.parse_logic = function(l_21_0, l_21_1)
	local l_21_2 = l_21_1:parameter("name")
	local l_21_3 = Logic:new(l_21_2, l_21_1)
	local l_21_4 = l_21_0._threads_data[l_21_3._thread]
	if l_21_4 ~= nil then
		l_21_4:add_logic(l_21_3)
		cat_print("ai", "AI : Parsing : Logic named : " .. l_21_2 .. " : Added")
	else
		Application:error("AI : Parsing : There is no ThreadData named : " .. l_21_2 .. " : Logic was not added ")
	end
end

if not BrainData then
	BrainData = class()
end
BrainData.init = function(l_22_0, l_22_1)
	l_22_0._threads_data = {}
	l_22_0._numofthreads = 1
	l_22_0._x = 0
	l_22_0._y = 0
	l_22_1:for_each("param", callback(l_22_0, l_22_0, "parse_thread2"))
end

BrainData.parse_thread2 = function(l_23_0, l_23_1)
	local l_23_2 = l_23_1:parameter("value")
	local l_23_3 = l_23_1:parameter("name")
	if l_23_3 == "thread" then
		l_23_0._threads_data[l_23_0._numofthreads] = l_23_2
		l_23_0._numofthreads = l_23_0._numofthreads + 1
	end
end

BrainData.init_threads = function(l_24_0, l_24_1)
	local l_24_5, l_24_6, l_24_7, l_24_8 = nil
	for i_0,i_1 in ipairs(l_24_0._threads_data) do
		if l_24_1[i_1] == nil then
			l_24_0._threads_data[l_24_9] = nil
			error("AI : Parsing : There is no ThreadData named : " .. i_1 .. " : ThreadData was not added to BrainData")
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			l_24_0._threads_data[l_24_9] = l_24_1[i_1]
			cat_print("ai", "AI : Parsing : ThreadData named : " .. i_1 .. " : Added to BrainData")
		end
	end
end

if not ThreadData then
	ThreadData = class()
end
ThreadData.init = function(l_25_0, l_25_1)
	l_25_0._name = l_25_1:parameter("name")
	l_25_0._logics = {}
	l_25_0._links = {}
	l_25_0._x = tonumber(l_25_1:parameter("_x"))
	l_25_0._y = tonumber(l_25_1:parameter("_y"))
	l_25_1:for_each("param", function(...)
		-- upvalues: l_25_0
		l_25_0:parse_params(...)
  end)
	l_25_1:for_each("on", function(...)
		-- upvalues: l_25_0
		l_25_0:parse_start_logic(...)
  end)
end

ThreadData.parse_start_logic = function(l_26_0, l_26_1)
	l_26_0._start_logic = l_26_1:parameter("goto")
end

ThreadData.parse_params = function(l_27_0, l_27_1)
	local l_27_2 = l_27_1:parameter("name")
	local l_27_3 = l_27_1:parameter("value")
	if l_27_2 == "interval" then
		l_27_0._interval = l_27_3
	elseif l_27_2 == "update" then
		l_27_0._update_style = l_27_3
	elseif l_27_2 == "param1" then
		l_27_0._param1 = l_27_3
	elseif l_27_2 == "param2" then
		l_27_0._param2 = l_27_3
	elseif l_27_2 == "param3" then
		l_27_0._param3 = l_27_3
	elseif l_27_2 == "param4" then
		l_27_0._param4 = l_27_3
	end
end

ThreadData.init_thread_data = function(l_28_0, l_28_1)
	local l_28_6, l_28_7, l_28_8, l_28_9, l_28_10, l_28_11, l_28_12, l_28_13 = nil
	local l_28_2 = l_28_0._start_logic
	l_28_0._start_logic = nil
	l_28_0._start_logic = l_28_0._logics[l_28_2]
	if l_28_0._start_logic == nil then
		error("Thread_data : no start logic found named :" .. l_28_2)
	end
	for i_0,i_1 in pairs(l_28_0._links) do
		i_1:skip_links(l_28_0._links)
	end
	for i_0,i_1 in pairs(l_28_0._logics) do
		i_1:setup_exits(l_28_0, l_28_0._links)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ThreadData.add_logic = function(l_29_0, l_29_1)
	l_29_0._logics[l_29_1._name] = l_29_1
end

ThreadData.get_logic = function(l_30_0, l_30_1)
	local l_30_2 = l_30_0._logics[l_30_1]
	if l_30_2 == nil then
		return nil
	else
		return l_30_2
	end
end

if not Logic then
	Logic = class()
end
Logic.init = function(l_31_0, l_31_1, l_31_2)
	l_31_0._name = l_31_1
	l_31_0._enters = {}
	l_31_0._got_enters = false
	l_31_0._exits = {}
	l_31_0._enter = nil
	l_31_0._exit = nil
	l_31_0._param1 = 0
	l_31_0._param2 = 0
	l_31_0._param3 = 0
	l_31_0._param4 = 0
	l_31_0._x = tonumber(l_31_2:parameter("_x"))
	l_31_0._y = tonumber(l_31_2:parameter("_y"))
	l_31_2:for_each("super", function(...)
		-- upvalues: l_31_0
		l_31_0:parse_thread(...)
  end)
	l_31_2:for_each("param", function(...)
		-- upvalues: l_31_0
		l_31_0:parse_param(...)
  end)
	l_31_2:for_each("on", function(...)
		-- upvalues: l_31_0
		l_31_0:parse_exit(...)
  end)
end

Logic.parse_thread = function(l_32_0, l_32_1)
	l_32_0._thread = l_32_1:parameter("name")
end

Logic.parse_param = function(l_33_0, l_33_1)
	local l_33_2 = l_33_1:parameter("name")
	local l_33_3 = l_33_1:parameter("value")
	cat_print("ai", l_33_2 .. " - " .. l_33_3)
	if l_33_2 == "script" then
		l_33_0._logicfunc = managers.aihivebrain._ai_logic_functions[l_33_3]
		if l_33_0._logicfunc == nil then
			error("AI : Parsing : No logic function named " .. l_33_3)
		else
			cat_print("ai", "AI : Parsing : Logic " .. l_33_0._name .. " function set to " .. l_33_3)
		end
		l_33_0._enter = managers.aihivebrain._ai_logic_functions[l_33_3 .. "_enter"]
		l_33_0._exit = managers.aihivebrain._ai_logic_functions[l_33_3 .. "_exit"]
	elseif l_33_2 == "param" then
		l_33_0._param1 = l_33_3
	elseif l_33_2 == "param2" then
		l_33_0._param2 = l_33_3
	elseif l_33_2 == "param3" then
		l_33_0._param3 = l_33_3
	elseif l_33_2 == "param4" then
		l_33_0._param4 = l_33_3
	end
end

Logic.parse_exit = function(l_34_0, l_34_1)
	local l_34_2 = l_34_1:parameter("exit")
	local l_34_3 = l_34_1:parameter("goto")
	l_34_2 = tonumber(l_34_2)
	l_34_0._exits[l_34_2] = l_34_3
end

Logic.setup_exits = function(l_35_0, l_35_1, l_35_2)
	local l_35_6, l_35_7, l_35_8, l_35_9 = nil
	for i_0,i_1 in pairs(l_35_0._exits) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_35_1:get_logic(i_1) == nil then
			cat_print("ai", "No logic " .. i_1 .. " found, trying to find link")
			 -- DECOMPILER ERROR: Confused about usage of registers!

			local l_35_12 = nil
			if l_35_2[i_1] == nil then
				cat_print("ai", "AI : Init : No link named : " .. l_35_12 .. " : no Logic returned from ThreadData")
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			else
				cat_print("ai", "Link: " .. l_35_2[i_1]._thread .. " : " .. l_35_2[i_1]._link)
				 -- DECOMPILER ERROR: Confused about usage of registers!

				if l_35_1:get_logic(l_35_2[i_1]._link) == nil then
					error("AI : Init : No Logic named : " .. l_35_12 .. " : no Logic returned from ThreadData")
				end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			else
				l_35_0._exits[l_35_10] = l_35_1:get_logic(l_35_2[i_1]._link)
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			l_35_0._exits[l_35_10] = l_35_1:get_logic(l_35_2[i_1]._link)
		end
	end
	if l_35_0:count_exits() == 0 then
		l_35_0.try = l_35_0.update_no_exits
		cat_print("ai", "AI : Init : " .. l_35_0._name .. " Logic choose : update_no_exits")
	else
		l_35_0.try = l_35_0.update_safe
		cat_print("ai", "AI : Init : " .. l_35_0._name .. " Logic choose : update_safe")
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Logic.count_exit_type = function(l_36_0, l_36_1)
	local l_36_2 = 0
	do
		while 1 do
			local l_36_3 = 0
			while l_36_3 <= 5 do
				if _exits[l_36_3] == l_36_1 then
					l_36_2 = l_36_2 + 1
				end
				l_36_3 = l_36_3 + 1
			end
			return l_36_2
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

Logic.count_exits = function(l_37_0)
	local l_37_6, l_37_7 = nil
	local l_37_1 = 0
	local l_37_2 = 0
	for i_0,i_1 in pairs(l_37_0._exits) do
		if i_1 ~= nil then
			l_37_1 = l_37_1 + 1
		end
	end
	return l_37_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Logic.compare_exit = function(l_38_0, l_38_1)
end

Logic.exits_in_a_row = function(l_39_0, l_39_1)
end

Logic.enter = function(l_40_0, l_40_1, l_40_2, l_40_3)
	if l_40_0._enter then
		l_40_0._enter(l_40_1, l_40_2, l_40_3)
	end
end

Logic.exit = function(l_41_0, l_41_1, l_41_2, l_41_3)
	if l_41_0._exit then
		l_41_0._exit(l_41_1, l_41_2, l_41_3)
	end
end

Logic.update_fallthrough = function(l_42_0, l_42_1, l_42_2, l_42_3, l_42_4)
	l_42_0._logicfunc(l_42_2, l_42_3, l_42_4, l_42_0._param1, l_42_0._param2, l_42_0._param3, l_42_0._param4)
	l_42_1:switch_logic(l_42_0._exit, l_42_2, l_42_3)
end

Logic.update_with_only_one_exit = function(l_43_0, l_43_1, l_43_2, l_43_3, l_43_4)
end

Logic.update_true_false_exit = function(l_44_0, l_44_1, l_44_2, l_44_3, l_44_4)
end

Logic.update_less_then_exit = function(l_45_0, l_45_1, l_45_2, l_45_3, l_45_4)
end

Logic.update_without_void_as_exit = function(l_46_0, l_46_1, l_46_2, l_46_3, l_46_4)
end

Logic.update_with_void_as_exit = function(l_47_0, l_47_1, l_47_2, l_47_3, l_47_4)
end

Logic.update_safe = function(l_48_0, l_48_1, l_48_2, l_48_3, l_48_4)
	if not alive(l_48_3) then
		cat_print("ai", "Logic:update_safe on a dead unit.")
		return 
	end
	local l_48_5, l_48_6 = l_48_0._logicfunc(l_48_2, l_48_3, l_48_4, l_48_0._param1, l_48_0._param2, l_48_0._param3, l_48_0._param4)
	if l_48_5 ~= nil then
		local l_48_7 = l_48_0._exits[l_48_5]
	if l_48_7 ~= nil then
		end
		l_48_1:switch_logic(l_48_7, l_48_2, l_48_3, l_48_6)
	end
end

Logic.update_no_exits = function(l_49_0, l_49_1, l_49_2, l_49_3, l_49_4)
	if not alive(l_49_3) then
		cat_print("ai", "Logic:update_no_exits on a dead unit.")
		return 
	end
	if l_49_0._logicfunc == nil then
		Application:error("AI : Error : there is no logic named : " .. l_49_0._name .. " !!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	else
		 -- WARNING: undefined locals caused missing assignments!
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 31 
end

Logic.update_debug = function(l_50_0, l_50_1, l_50_2, l_50_3, l_50_4)
end

Logic.name = function(l_51_0)
	return l_51_0._name
end

if not Thread then
	Thread = class()
end
Thread.init = function(l_52_0, l_52_1, l_52_2)
	l_52_0._data = l_52_1
	l_52_0._name = l_52_0._data._name
	l_52_0._id = l_52_2
	l_52_0._logic = l_52_0._data._start_logic
	l_52_0._tries = 0
	l_52_0._enabled = false
	l_52_0._interval = tonumber(l_52_0._data._interval)
	if l_52_0._interval == 0 then
		l_52_0._next_update = 0.2
		Application:error("Interval is zero for thread \"" .. tostring(l_52_0._name) .. "\".")
	else
		l_52_0._next_update = l_52_0._interval + math.rand(l_52_0._interval)
	end
	cat_print("ai", "AI : Spawn : Thread named : " .. l_52_0._name .. " : Spawned")
end

Thread.activate = function(l_53_0)
	if l_53_0._enabled == false then
		l_53_0._logic = l_53_0._data._start_logic
		l_53_0._tries = 0
		l_53_0._enabled = true
	end
end

Thread.update = function(l_54_0, l_54_1, l_54_2, l_54_3)
	if l_54_0._enabled == true and l_54_0._next_update < l_54_1 then
		local l_54_4 = nil
		if CoreAiMachine.PROFILE then
			local l_54_5 = "AI:Logic:" .. l_54_0._name .. "->" .. l_54_0._logic._name
			l_54_4 = Profiler:start(l_54_5)
		end
		l_54_0._tries = l_54_0._tries + 1
		local l_54_6 = l_54_0._logic
		l_54_6:try(l_54_0, l_54_1, l_54_2, l_54_0._tries)
		if CoreAiMachine.PROFILE then
			Profiler:stop(l_54_4)
		end
		l_54_0._next_update = l_54_1 + l_54_0._interval - l_54_1 % l_54_0._next_update % l_54_0._interval
	end
end

Thread.deativate = function(l_55_0)
	if l_55_0._enabled == true then
		l_55_0._enabled = false
	end
end

Thread.force_logic = function(l_56_0, l_56_1, l_56_2, l_56_3)
	local l_56_4 = l_56_0._data:get_logic(l_56_1)
	if l_56_4 then
		l_56_0._logic:exit(l_56_2, l_56_3, l_56_4:name())
		l_56_4:enter(l_56_2, l_56_3, l_56_0._logic:name())
		l_56_0._logic = l_56_4
		l_56_0._tries = 0
	else
		if alive(l_56_3) then
			Application:error("There is not logic named " .. l_56_1 .. " on unit " .. tostring(l_56_3:name()))
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 37 
end

Thread.switch_logic = function(l_57_0, l_57_1, l_57_2, l_57_3, l_57_4)
	l_57_0._logic:exit(l_57_2, l_57_3, l_57_1:name())
	l_57_1:enter(l_57_2, l_57_3, l_57_0._logic:name())
	if l_57_1 ~= l_57_0._logic then
		l_57_0._tries = 0
	end
	l_57_0._logic = l_57_1
	if l_57_4 then
		l_57_0._tries = l_57_0._tries + 1
		l_57_0._logic:try(l_57_0, l_57_2, l_57_3, l_57_0._tries)
	end
end

Thread.set_interval = function(l_58_0, l_58_1)
	l_58_0._interval = l_58_1
end

Thread.interval = function(l_59_0)
	return l_59_0._interval
end

Thread.print = function(l_60_0)
	return "Thread : " .. l_60_0._name .. " : " .. l_60_0._logic._name
end

Thread.destroy = function(l_61_0, l_61_1)
	l_61_0._logic = nil
end

if not Brain then
	Brain = class()
end
Brain.init = function(l_62_0, l_62_1, l_62_2, l_62_3, l_62_4)
	local l_62_10, l_62_11 = nil
	l_62_0._name = l_62_1
	l_62_0._data = l_62_2
	l_62_0._unit = l_62_3
	l_62_0._group = l_62_4
	l_62_0._threads = {}
	l_62_0._threads_map = {}
	l_62_0._enabled = true
	local l_62_9 = cat_print
	l_62_9("ai", "AI : Spawn : Brain named : " .. l_62_0._name .. " : Spawned")
	l_62_9 = 0
	local l_62_5 = nil
	l_62_5 = pairs
	l_62_5 = l_62_5(l_62_2._threads_data)
	for i_0,i_1 in l_62_5 do
		l_62_0._threads_map[Thread:new(i_1, l_62_9)._name] = Thread:new(i_1, l_62_9)
		table.insert(l_62_0._threads, Thread:new(i_1, l_62_9))
		l_62_9 = l_62_9 + 1
	end
	l_62_0._group:add_brain(l_62_0)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Brain.update = function(l_63_0, l_63_1)
	local l_63_5, l_63_6, l_63_7, l_63_8 = nil
	if l_63_0._enabled == true then
		for i_0,i_1 in pairs(l_63_0._threads) do
			i_1:update(l_63_1, l_63_0._unit, l_63_0._name)
		end
	end
end

Brain.enable = function(l_64_0, l_64_1)
	l_64_0._enabled = l_64_1
end

Brain.get_thread_id = function(l_65_0, l_65_1)
	return l_65_0.threads[l_65_1]
end

Brain.get_thread_name = function(l_66_0, l_66_1)
	return l_66_0._threads_map[l_66_1]
end

Brain.activate_thread = function(l_67_0, l_67_1)
	l_67_0._threads_map[l_67_1]:activate()
end

Brain.deactivate_thread = function(l_68_0, l_68_1)
	l_68_0._threads_map[l_68_1]:deativate()
end

Brain.force_logic = function(l_69_0, l_69_1, l_69_2, l_69_3)
	l_69_0._threads_map[l_69_2]:force_logic(l_69_1, l_69_3, l_69_0._unit)
end

Brain.force_update = function(l_70_0, l_70_1)
	local l_70_2 = l_70_0._threads_map[l_70_1]
	local l_70_3 = TimerManager:game():time()
	if l_70_2._interval == 0 then
		l_70_0._next_update = math.max(0.2, l_70_3)
		Application:error("Interval is zero for thread \"" .. tostring(l_70_2._name) .. "\".")
	else
		l_70_2._next_update = l_70_2._next_update - l_70_2._interval
	if l_70_2._next_update == 0 then
		end
		l_70_2._next_update = l_70_2._interval + math.rand(l_70_2._interval)
	end
	l_70_2:update(l_70_3, l_70_0._unit, l_70_0._name)
end

Brain.set_thread_interval = function(l_71_0, l_71_1, l_71_2)
	l_71_0._threads_map[l_71_1]:set_interval(l_71_2)
end

Brain.thread_interval = function(l_72_0, l_72_1)
	local l_72_2, l_72_3 = l_72_0._threads_map[l_72_1]:interval, l_72_0._threads_map[l_72_1]
	return l_72_2(l_72_3)
end

Brain.print = function(l_73_0, l_73_1)
	local l_73_6, l_73_7, l_73_8, l_73_9 = nil
	local l_73_2 = "      Brain : " .. l_73_0._name .. " : Unit :"
	table.insert(l_73_1, l_73_2)
	for i_0,i_1 in pairs(l_73_0._threads) do
		table.insert(l_73_1, "         " .. i_1:print())
	end
end

Brain.get_info = function(l_74_0)
	local l_74_6, l_74_7, l_74_8, l_74_9, l_74_10, l_74_11, l_74_12, l_74_13, l_74_14, l_74_15, l_74_16, l_74_17, l_74_18, l_74_19, l_74_20, l_74_21, l_74_22, l_74_23 = nil
	local l_74_1 = {}
	local l_74_2 = {}
	for i_0,i_1 in pairs(l_74_0._threads) do
		l_74_2 = {}
		l_74_2._name = i_1._name
		l_74_2._logic = i_1._logic._name
		l_74_2._tries = i_1._tries
		l_74_2._interval = i_1._interval
		table.insert(l_74_1, l_74_2)
		l_74_2 = nil
	end
	return l_74_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Brain.get_graph = function(l_75_0)
	local l_75_6, l_75_7, l_75_8, l_75_9, l_75_10, l_75_11, l_75_12, l_75_13, l_75_14, l_75_15, l_75_16, l_75_17, l_75_18, l_75_19, l_75_20, l_75_21, l_75_22, l_75_23, l_75_24, l_75_25, l_75_26, l_75_27, l_75_28, l_75_29, l_75_33, l_75_34, l_75_35, l_75_36, l_75_37, l_75_38, l_75_39, l_75_40, l_75_41, l_75_42, l_75_43, l_75_44, l_75_45, l_75_46 = nil
	local l_75_1 = {}
	local l_75_2 = {}
	for i_0,i_1 in pairs(l_75_0._threads) do
		l_75_2 = {}
		l_75_2._logicname = nil
		l_75_2._name = i_1._name
		l_75_2._x = i_1._data._x
		l_75_2._y = i_1._data._y
		if i_1._logic._name ~= "l_look" then
			l_75_2._logicname = i_1._logic._name
		end
		table.insert(l_75_1, l_75_2)
		l_75_2 = nil
		for i_0,i_1 in pairs(i_1._data._logics) do
			l_75_2 = {}
			l_75_2._name = i_1._name
			l_75_2._x = i_1._x
			l_75_2._y = i_1._y
			table.insert(l_75_1, l_75_2)
			l_75_2 = nil
		end
	end
	return l_75_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Brain.destroy = function(l_76_0)
	local l_76_4, l_76_5, l_76_6, l_76_7 = nil
	l_76_0._group:remove_brain(l_76_0)
	for i_0,i_1 in pairs(l_76_0._threads) do
		i_1:destroy()
	end
	l_76_0._unit = nil
	l_76_0._threads = nil
	l_76_0._threads_map = nil
	l_76_0._enabled = false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if not BrainGroup then
	BrainGroup = class()
end
BrainGroup.init = function(l_77_0, l_77_1)
	l_77_0._name = l_77_1
	l_77_0._brains = {}
	l_77_0._step = 0
	l_77_0._update_times = 0
	l_77_0._size = 0
	cat_print("ai", "AI : Spawn : Braingroup named : " .. l_77_0._name .. " : Added")
end

BrainGroup.update = function(l_78_0, l_78_1)
	local l_78_2, l_78_5, l_78_6, l_78_7, l_78_8 = nil
	if CoreAiMachine.PROFILE then
		l_78_2 = Profiler:start("AI:BrainGroup")
	end
	if l_78_0._size == 0 then
		l_78_0:destroy()
	else
		if l_78_0._step == l_78_0._size then
			l_78_0._step = 0
		end
		for i_0,i_1 in pairs(l_78_0._brains) do
			i_1:update(l_78_1)
		end
	end
	if CoreAiMachine.PROFILE then
		Profiler:stop(l_78_2)
	end
end

BrainGroup.add_brain = function(l_79_0, l_79_1)
	l_79_0._brains[l_79_1] = l_79_1
	l_79_0._size = l_79_0._size + 1
end

BrainGroup.remove_brain = function(l_80_0, l_80_1)
	l_80_0._brains[l_80_1] = nil
	l_80_0._size = l_80_0._size - 1
	if l_80_0._size <= l_80_0._step then
		l_80_0._step = 0
	end
end

BrainGroup.print = function(l_81_0, l_81_1)
	local l_81_6, l_81_7, l_81_8, l_81_9 = nil
	local l_81_2 = "   Brain Group : " .. l_81_0._name .. " : brains : times to update : "
	table.insert(l_81_1, l_81_2)
	for i_0,i_1 in pairs(l_81_0._brains) do
		i_1:print(l_81_1)
	end
end

BrainGroup.destroy = function(l_82_0)
	if managers.aihivebrain ~= nil then
		managers.aihivebrain:remove_brain_group(l_82_0._name)
		cat_print("ai", "Braingroup : " .. l_82_0._name .. " : Removed")
		l_82_0._brains = nil
	end
end

if not Link then
	Link = class()
end
Link.init = function(l_83_0, l_83_1, l_83_2)
	l_83_0._name = l_83_1
	l_83_2:for_each("super", function(...)
		-- upvalues: l_83_0
		l_83_0:parse_thread(...)
  end)
	l_83_2:for_each("param", function(...)
		-- upvalues: l_83_0
		l_83_0:parse_param(...)
  end)
	l_83_2:for_each("on", function(...)
		-- upvalues: l_83_0
		l_83_0:parse_link(...)
  end)
end

Link.parse_thread = function(l_84_0, l_84_1)
	l_84_0._thread = l_84_1:parameter("name")
end

Link.parse_param = function(l_85_0, l_85_1)
	local l_85_2 = l_85_1:parameter("name")
	if l_85_2 == "thread" then
		l_85_0._thread = l_85_1:parameter("value")
	end
end

Link.parse_link = function(l_86_0, l_86_1)
	l_86_0._link = l_86_1:parameter("goto")
end

Link.skip_links = function(l_87_0, l_87_1)
	local l_87_2 = nil
	while 1 do
		while 1 do
			l_87_2 = l_87_1[l_87_0._link]
			if l_87_2 == nil then
				cat_print("ai", "Final Logic for link '" .. l_87_0._name .. "' is " .. l_87_0._link)
				return 
			end
			l_87_0._link = l_87_2._link
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end


