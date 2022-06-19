if not CoreBenchmarkNetHandler then
	CoreBenchmarkNetHandler = class()
end
CoreBenchmarkNetHandler.init = function(l_1_0, l_1_1)
	l_1_0._server_set = false
	l_1_0._manager = l_1_1
end

CoreBenchmarkNetHandler.benchmark_start = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4)
	if not l_2_0._manager._remote_table[l_2_3] then
		l_2_0._manager._remote_table[l_2_3] = {}
		l_2_0._manager._remote_table[l_2_3]._table = {}
		l_2_0._manager._remote_table[l_2_3]._data = {}
	end
	l_2_0._manager._remote_table[l_2_3]._table[l_2_1] = l_2_2
end

CoreBenchmarkNetHandler.benchmark_data = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5)
	if l_3_0._manager._remote_table[l_3_4] then
		if not l_3_0._manager._remote_table[l_3_4]._data[l_3_1] then
			l_3_0._manager._remote_table[l_3_4]._data[l_3_1] = {}
		end
		l_3_0._manager._remote_table[l_3_4]._data[l_3_1][l_3_2] = l_3_3
	else
		cat_print("debug", "[CoreBenchmarkNetHandler] " .. l_3_4 .. " is sending 'benchmark_data' without 'benchmark_start' message.")
	end
	if l_3_0._manager._alive then
		l_3_0._manager._alive[l_3_4] = TimerManager:game():time()
	end
end

CoreBenchmarkNetHandler.benchmark_end = function(l_4_0, l_4_1, l_4_2)
	local l_4_7, l_4_8, l_4_9, l_4_10, l_4_11, l_4_13 = nil
	if l_4_0._manager._remote_table[l_4_1] then
		if table.size(l_4_0._manager._remote_table[l_4_1]._data) > 0 then
			local l_4_3 = l_4_0._manager._stats_node:make_child("result")
			for i_0,i_1 in pairs(l_4_0._manager._remote_table[l_4_1]._table) do
				l_4_3:set_parameter(i_0, tostring(i_1))
			end
			local l_4_12 = l_4_1
			l_4_3:set_parameter("client", l_4_12)
			for l_4_12,i_1 in pairs(l_4_0._manager._remote_table[l_4_1]._data) do
				local l_4_18 = nil
				l_4_3:make_child("sample"):set_parameter("pos", l_4_12)
				for i_0,i_1 in pairs(l_4_14) do
					l_4_18:set_parameter(i_0, tostring(i_1))
				end
			end
			l_4_0._manager._client_count[l_4_1] = (l_4_0._manager._client_count[l_4_1] or 0) + 1
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		l_4_3 = l_4_0._manager
		l_4_3 = l_4_3._remote_table
		l_4_3[l_4_1] = nil
	else
		l_4_3 = cat_print
		l_4_3("debug", "[CoreBenchmarkNetHandler] " .. l_4_1 .. " is sending 'benchmark_end' without 'benchmark_start' message.")
	end
	l_4_3 = l_4_0._manager
	l_4_3 = l_4_3._client_count
	l_4_3 = l_4_3[l_4_1]
	if not l_4_3 then
		l_4_3 = 0
	end
	if l_4_0._manager._results_size <= l_4_3 then
		l_4_3 = l_4_0._manager
		l_4_3 = l_4_3._client_done
		l_4_3[l_4_1] = true
	end
	l_4_3 = l_4_0._manager
	l_4_3(l_4_3)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if not CoreBenchmarkManager then
	CoreBenchmarkManager = class()
end
CoreBenchmarkManager.init = function(l_5_0, l_5_1)
	l_5_0._root_node = nil
	l_5_0._path_node = nil
	l_5_0._path_table = nil
	l_5_0._server = nil
	l_5_0._lua_start_cb = nil
	l_5_0._lua_end_cb = nil
	l_5_0._connected = false
	l_5_0._is_server = false
	l_5_0._file_dump = 0
	l_5_0._results_size = 50
	l_5_0._current_index = 1
	l_5_0._current_len = 0
	l_5_0._sync_time = 0
	l_5_0._speed = 1000
	l_5_0._client_time_out = 300
	l_5_0._net_port = 12346
	l_5_0._msg_port = 0
	l_5_0._my_ip = Network:hostname()
	l_5_0._remote_table = {}
	l_5_0._alive = {}
	l_5_0._client_done = {}
	l_5_0._client_count = {}
	l_5_0._stats_node = Node("results")
	l_5_0._flag = false
	l_5_0._loop_path = l_5_0:bm_loop_arg()
	l_5_0._pause_path = false
	if l_5_1 then
		l_5_0._speed = l_5_1
	end
	if rawget(_G, "setup") and setup.benchmark then
		l_5_0._bm_level = l_5_0:bm_level()
		if SystemInfo:platform() == "WIN32" then
			l_5_0._proj_ver = Application:revision(Application:base_path() .. "/")
			l_5_0._core_ver = Application:revision(Application:base_path() .. "/core")
		end
	else
		local l_5_2 = File:open("svn_revisions.txt", "r")
		assert(l_5_2)
		l_5_0._proj_ver = l_5_2:gets()
		l_5_0._core_ver = l_5_2:gets()
		l_5_2:close()
	end
end

CoreBenchmarkManager.paused_update = function(l_6_0, l_6_1, l_6_2)
	l_6_0:update(l_6_1, l_6_2)
end

CoreBenchmarkManager.absolute_end = function(l_7_0)
	local l_7_1 = 0
	for l_7_5 = 1, #l_7_0._path_table - 1 do
		l_7_1 = l_7_1 + l_7_0._path_table[l_7_5].pos - l_7_0._path_table[l_7_5 + 1].pos:length()
	end
	return l_7_1
end

CoreBenchmarkManager.absolute_pos = function(l_8_0)
	local l_8_5, l_8_6, l_8_7, l_8_8 = nil
	local l_8_1 = 0
	for i_0,i_1 in ipairs(l_8_0._path_table) do
		if i_0 == l_8_0._current_index then
			return l_8_1 + l_8_0._current_len
		else
			l_8_1 = l_8_1 + i_1.pos - l_8_0._path_table[i_0 + 1].pos:length()
		end
	end
	return l_8_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreBenchmarkManager.set_absolute_pos = function(l_9_0, l_9_1)
	local l_9_7, l_9_8 = math.clamp, l_9_1
	l_9_7 = l_9_7(l_9_8, 0, l_9_0:absolute_end())
	local l_9_2 = nil
	l_9_8 = 0
	local l_9_3 = nil
	l_9_2 = ipairs
	l_9_3 = l_9_0._path_table
	l_9_2 = l_9_2(l_9_3)
	for i_0,i_1 in l_9_2 do
		local l_9_9 = l_9_6.pos - l_9_0._path_table[l_9_5 + 1].pos:length()
		if l_9_7 <= l_9_8 + l_9_9 then
			l_9_0._current_len = l_9_7 - l_9_8
			l_9_0._current_index = l_9_5
			return 
		else
			l_9_8 = l_9_8 + l_9_9
		end
	end
	error("[CoreBenchmarkManager] Position is out of range!")
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreBenchmarkManager.update = function(l_10_0, l_10_1, l_10_2)
	local l_10_6, l_10_7 = nil
	if SystemInfo:platform() == "WIN32" then
		if Input:keyboard():pressed("space") then
			l_10_0._pause_path = not l_10_0._pause_path
		end
		if Input:keyboard():pressed("l") then
			l_10_0._loop_path = not l_10_0._loop_path
		end
		if Input:keyboard():pressed("num +") then
			l_10_0._speed = l_10_0._speed + 250
		end
	else
		if Input:keyboard():pressed("num -") then
			l_10_0._speed = l_10_0._speed - 250
		end
	end
	if l_10_0._path_node then
		for i_0 in l_10_0._path_node:children() do
			Application:draw_sphere(math.string_to_vector(i_0:parameter("pos")), 100, 1, 0, 0)
		end
	end
	if l_10_0._is_server then
		l_10_0:update_remote()
		if l_10_0._alive then
			l_10_0:update_alive(l_10_1, l_10_2)
			l_10_0:update_end()
		end
	elseif l_10_0._path_table and not l_10_0._pause_path then
		local l_10_8 = math.clamp(l_10_0._path_table[l_10_0._current_index].pos - l_10_0._path_table[l_10_0._current_index + 1].pos:length(), 0.1, math.huge)
		l_10_0._current_len = l_10_0._current_len + l_10_2 * l_10_0._speed
		if l_10_8 < l_10_0._current_len then
			l_10_0._current_len = l_10_0._current_len - l_10_8
			l_10_0._current_index = l_10_0._current_index + 1
		if l_10_0._current_index == #l_10_0._path_table - 1 then
			end
		if not l_10_0._is_server then
			end
		if l_10_0._connected then
			end
			Benchmark:stop()
			if Global.benchmark_use_network then
				l_10_0._net_peer:benchmark_end(l_10_0._my_ip)
			end
			l_10_0._flag = true
		end
		if #l_10_0._path_table <= l_10_0._current_index then
			l_10_0:setup_globals_and_restart()
			return 
		end
		local l_10_9 = math.lerp(l_10_0._path_table[l_10_0._current_index].pos, l_10_0._path_table[l_10_0._current_index + 1].pos, l_10_0._current_len / l_10_8)
		local l_10_10 = l_10_0._path_table[l_10_0._current_index].rot:slerp(l_10_0._path_table[l_10_0._current_index + 1].rot, l_10_0._current_len / l_10_8)
		l_10_0._camera:set_position(l_10_9)
		l_10_0._camera:new_set_rotation(Rotation(l_10_10:x(), -l_10_10:z(), l_10_10:y()))
	if not l_10_0._flag then
		end
		l_10_0:update_remote((l_10_0._current_index - 1 + l_10_0._current_len / l_10_8) / #l_10_0._path_table * 100, l_10_2)
	end
end

CoreBenchmarkManager.setup_globals_and_restart = function(l_11_0)
	if l_11_0._loop_path then
		l_11_0._current_index = 1
		l_11_0._current_len = 0
	else
		Application:quit()
	end
end

CoreBenchmarkManager.update_end = function(l_12_0)
end

CoreBenchmarkManager.update_alive = function(l_13_0, l_13_1, l_13_2)
	local l_13_6, l_13_7 = nil
	for i_0,i_1 in pairs(l_13_0._alive) do
	end
	if l_13_0._client_time_out < l_13_1 - i_1 then
		end
	end
end

CoreBenchmarkManager.update_remote = function(l_14_0, l_14_1, l_14_2)
	local l_14_7, l_14_8, l_14_9, l_14_10, l_14_12, l_14_14, l_14_17, l_14_19, l_14_20, l_14_22, l_14_29, l_14_36, l_14_38 = nil
	if l_14_0._is_server and not l_14_0._connected then
		l_14_0._net_handler = CoreBenchmarkNetHandler:new(l_14_0)
		Network:bind(l_14_0._net_port, l_14_0._net_handler)
		l_14_0._connected = true
		cat_print("debug", "")
		cat_print("debug", ".--------------------------------------------------.")
		cat_print("debug", "| [CoreBenchmarkManager] Server is up and running! |")
		cat_print("debug", "'--------------------------------------------------'")
		cat_print("debug", "")
	elseif not l_14_0._is_server and not l_14_0._connected then
		if Global.benchmark_use_network then
			l_14_0._net_peer = Network:handshake(l_14_0._server_ip, l_14_0._net_port)
		end
		l_14_0._connected = true
		local l_14_3 = Benchmark:start(Global.benchmark_profile)
		for i_0,i_1 in pairs(l_14_3) do
			local l_14_21, l_14_23, l_14_30 = tostring(i_1)
			l_14_3[l_14_13] = l_14_21
		end
		if l_14_0._lua_start_cb then
			for i_0,i_1 in pairs(l_14_0._lua_start_cb()) do
				l_14_3[l_14_16] = tostring(i_1)
			end
		end
		for i_0,i_1 in pairs(Global.benchmark_tags) do
			l_14_3[i_0] = i_1
		end
		l_14_3.project = Application:short_game_name()
		l_14_3.level = l_14_0._level
		l_14_3.path = l_14_0._path_name
		l_14_3.profile = Global.benchmark_profile
		l_14_3.app_ver = Application:version()
		if Application:debug_build() then
			l_14_3.build = "debug"
		else
			l_14_3.build = "public"
		end
		l_14_3.platform = SystemInfo:platform()
		l_14_3.proj_ver = l_14_0._proj_ver
		l_14_3.core_ver = l_14_0._core_ver
		if SystemInfo:platform() == "WIN32" then
			l_14_3.dx_version = SystemInfo:dx_version()
			l_14_3.video_memory = SystemInfo:video_memory()
			l_14_3.system_memory = SystemInfo:system_memory()
			l_14_3.sound_device_description = SystemInfo:sound_device_description()
			l_14_3.sound_device_driver_version = SystemInfo:sound_device_driver_version()
			if SystemInfo:gpu_power() == 0 then
				l_14_3.gpu_power = "HIGHEND CARD"
			end
		elseif SystemInfo:gpu_power() == 1 then
			l_14_3.gpu_power = "RECOMMENDED CARD"
		else
			l_14_3.gpu_power = "MINIMAL CARD"
		end
		if Global.benchmark_use_network then
			for i_0,i_1 in pairs(l_14_3) do
				do
					l_14_0._net_peer:benchmark_start(i_0, i_1, l_14_0._my_ip)
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	else
		l_14_3 = l_14_0._connected
	if l_14_3 then
		end
		l_14_3 = l_14_0._is_server
	if not l_14_3 then
		end
		l_14_3 = l_14_0._sync_time
		if l_14_3 >= 1 then
			l_14_3 = Benchmark
			 -- DECOMPILER ERROR: Overwrote pending register.

			local l_14_24 = nil
			if l_14_0._lua_data_cb then
				local l_14_25 = nil
				l_14_25 = l_14_0._lua_data_cb()
				 -- DECOMPILER ERROR: Overwrote pending register.

				for l_14_34,l_14_35 in l_14_24 do
					local l_14_34, l_14_35, l_14_37 = nil
					l_14_3[l_14_27] = l_14_28
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			if Global.benchmark_use_network then
				for i_0,i_1 in pairs(l_14_24) do
					local l_14_33 = nil
					l_14_33 = l_14_0._net_peer
					l_14_33(l_14_33, tostring(l_14_1), R12_PC215, l_14_32, l_14_0._my_ip)
				end
			end
			l_14_0._sync_time = 0
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		l_14_0._sync_time = l_14_3
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreBenchmarkManager.add_point = function(l_15_0, l_15_1, l_15_2, l_15_3, l_15_4)
	if not l_15_0._path_node then
		local l_15_5 = File:open("/data/settings/benchmark_paths.xml", "r")
		local l_15_9 = Node.from_xml
		l_15_9 = l_15_9(l_15_5:read())
		l_15_0._root_node = l_15_9
		l_15_9(l_15_5)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0 in l_15_9 do
			if l_15_8:parameter("name") == l_15_1 and l_15_8:parameter("level") == l_15_2 then
				l_15_0._root_node:remove_child_at(l_15_0._root_node:index_of_child(l_15_8))
		else
			end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_15_0._path_node = l_15_9:make_child("path")
		l_15_0._path_node:set_parameter("name", l_15_1)
		l_15_0._path_node:set_parameter("level", l_15_2)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_15_5 = l_15_0._path_node
	 -- DECOMPILER ERROR: Overwrote pending register.

	do
		local l_15_10 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_15_5:set_parameter("pos", l_15_10)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_15_5:set_parameter("rot_x", l_15_10)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_15_5:set_parameter("rot_y", l_15_10)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_15_5:set_parameter("rot_z", l_15_10)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreBenchmarkManager.save_points = function(l_16_0)
	if l_16_0._path_node then
		local l_16_1 = File:open("/data/settings/benchmark_paths.xml", "w")
		l_16_1:write(l_16_0._root_node:to_xml())
		l_16_1:close()
	end
end

CoreBenchmarkManager.write_results = function(l_17_0)
	local l_17_1 = "benchmark_results" .. l_17_0._file_dump .. ".xml"
	local l_17_2 = File:open("/" .. l_17_1, "w")
	l_17_2:write(l_17_0._stats_node:to_xml())
	l_17_0._stats_node = Node("results")
	l_17_0._file_dump = l_17_0._file_dump + 1
	l_17_2:close()
	cat_print("debug", "[CoreBenchmarkManager] Running: ruby " .. Application:base_path() .. "benchmark_done " .. l_17_1 .. " " .. tostring(l_17_0._msg_port))
	Application:system("ruby \"" .. Application:base_path() .. "benchmark_done\" " .. l_17_1 .. " " .. tostring(l_17_0._msg_port), false)
end

CoreBenchmarkManager.server_write_results_and_exit = function(l_18_0)
	l_18_0:write_results()
	Application:quit()
end

CoreBenchmarkManager.start_server = function(l_19_0)
	l_19_0._is_server = true
	local l_19_1 = File:open("/data/settings/benchmark.xml", "r")
	local l_19_2 = Node.from_xml(l_19_1:read())
	l_19_1:close()
	l_19_1 = File:open("/data/settings/benchmark_paths.xml", "r")
	local l_19_6 = Node.from_xml
	l_19_6 = l_19_6(l_19_1:read())
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_19_0._results_size = l_19_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_19_6(l_19_1)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0 in l_19_6 do
		if l_19_5:name() == "server_settings" then
			local l_19_10 = tonumber
			l_19_10 = l_19_10(l_19_5:parameter("msg_port"))
			l_19_0._msg_port = l_19_10
			 -- DECOMPILER ERROR: Overwrote pending register.

			for i_0 in l_19_10 do
				if l_19_9:name() == "client" then
					local l_19_11 = l_19_0._alive
					local l_19_12 = l_19_9:parameter("name")
					l_19_11[l_19_12] = TimerManager:game():time()
				end
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_19_6.size(l_19_0._alive) == 0 then
		l_19_0._alive = nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreBenchmarkManager.set_callbacks = function(l_20_0, l_20_1, l_20_2)
	l_20_0._lua_start_cb = l_20_1
	l_20_0._lua_data_cb = l_20_2
end

CoreBenchmarkManager.set_callbacks = function(l_21_0, l_21_1, l_21_2)
	l_21_0._lua_start_cb = l_21_1
	l_21_0._lua_data_cb = l_21_2
end

CoreBenchmarkManager.bm_level_arg = function(l_22_0)
	local l_22_1 = nil
	local l_22_4, l_22_5 = ipairs, Application:argv()
	l_22_4 = l_22_4(l_22_5)
	for i_0,i_1 in l_22_4 do
		if i_1 == "-bm_level" then
			l_22_1 = i_1
		elseif l_22_1 then
			return i_1
		end
	end
	error("Expected the -bm_level parameter!")
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreBenchmarkManager.bm_loop_arg = function(l_23_0)
	local l_23_4, l_23_5 = ipairs, Application:argv()
	l_23_4 = l_23_4(l_23_5)
	for i_0,i_1 in l_23_4 do
		if l_23_3 == "-bm_loop" then
			return l_23_3
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreBenchmarkManager.bm_level = function(l_24_0)
	local l_24_1 = l_24_0:bm_level_arg()
	if l_24_1 == "NEXT" then
		local l_24_2 = "next_benchmark_level.inf"
		local l_24_3 = File:open("/data/settings/benchmark_paths.xml", "r")
		local l_24_4 = Node.from_xml(l_24_3:read())
		l_24_3:close()
		local l_24_5 = 0
		if File:exists(l_24_2) then
			l_24_3 = File:open(l_24_2, "r")
			assert(l_24_3)
			l_24_5 = tonumber(l_24_3:read())
			assert(l_24_5)
			l_24_3:close()
		end
		if l_24_4:num_children() <= l_24_5 then
			l_24_5 = 0
		end
		local l_24_6 = l_24_4:child(l_24_5)
		assert(l_24_6)
		l_24_1 = l_24_6:parameter("level")
		l_24_5 = l_24_5 + 1
		l_24_3 = File:open(l_24_2, "w")
		l_24_3:write(tostring(l_24_5))
		l_24_3:close()
		out("[CoreBenchmarkManager] Next level is: " .. l_24_1)
	end
	return l_24_1
end

CoreBenchmarkManager.start_client = function(l_25_0)
	if not Global.benchmark_level then
		local l_25_1 = File:open("/data/settings/benchmark.xml", "r")
		local l_25_6 = Node.from_xml
		l_25_6 = l_25_6(l_25_1:read())
		local l_25_2 = nil
		l_25_2(l_25_1)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0 in l_25_2 do
			if l_25_5:name() == "client_settings" then
				local l_25_7 = Global
				l_25_7.benchmark_use_network = l_25_5:parameter("use_network") ~= "false"
				l_25_7 = Global
				l_25_7.benchmark_count = 0
				l_25_7 = Global
				l_25_7.benchmark_tries = 1
				l_25_7 = Global
				l_25_7.benchmark_level = l_25_0._bm_level
				l_25_7 = Global
				l_25_7.benchmark_path = "default"
				l_25_7 = Global
				l_25_7.benchmark_ip = l_25_5:parameter("server")
				l_25_7 = Global
				l_25_7.benchmark_profile = l_25_5:parameter("profile")
				l_25_7 = Global
				l_25_7.benchmark_tags = {}
				l_25_7 = tonumber
				local l_25_12 = l_25_5:parameter("msg_port")
				l_25_7 = l_25_7(l_25_12)
				l_25_0._msg_port = l_25_7
				l_25_7, l_25_12 = l_25_5:children, l_25_5
				l_25_7 = l_25_7(l_25_12)
				for i_0 in l_25_7 do
					if l_25_11:name() == "tag" then
						local l_25_13 = Global.benchmark_tags
						local l_25_14 = l_25_11:parameter("name")
						l_25_13[l_25_14] = l_25_11:parameter("value")
					end
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreBenchmarkManager.set_speed = function(l_26_0, l_26_1)
	l_26_0._speed = l_26_1
end

CoreBenchmarkManager.running = function(l_27_0)
	return l_27_0._path_table ~= nil
end

CoreBenchmarkManager.fly = function(l_28_0, l_28_1)
	local l_28_2 = File:open("/data/settings/benchmark_paths.xml", "r")
	local l_28_6, l_28_10 = Node.from_xml, l_28_2:read()
	l_28_6 = l_28_6(l_28_10)
	l_28_0._root_node = l_28_6
	l_28_6, l_28_10 = l_28_2:close, l_28_2
	l_28_6(l_28_10)
	l_28_6 = l_28_0._root_node
	l_28_6, l_28_10 = l_28_6:children, l_28_6
	l_28_6 = l_28_6(l_28_10)
	for i_0 in l_28_6 do
		local l_28_5 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_28_5 == Global.benchmark_path and l_28_5 == Global.benchmark_level then
			l_28_0._path_table, l_28_5 = l_28_5, {}
			l_28_5 = Global
			l_28_5 = l_28_5.benchmark_level
			l_28_0._level = l_28_5
			l_28_5 = Global
			l_28_5 = l_28_5.benchmark_ip
			l_28_0._server_ip = l_28_5
			l_28_5 = Global
			l_28_5 = l_28_5.benchmark_path
			l_28_0._path_name = l_28_5
			l_28_0._camera = l_28_1
			 -- DECOMPILER ERROR: Overwrote pending register.

			for i_0 in l_28_5 do
				local l_28_11 = {}
				l_28_11.pos = math.string_to_vector(l_28_9:parameter("pos"))
				l_28_11.rot = Rotation:look_at(math.string_to_vector(l_28_9:parameter("rot_y")) * -1, math.string_to_vector(l_28_9:parameter("rot_z")) * -1)
				table.insert(l_28_0._path_table, l_28_11)
			end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


