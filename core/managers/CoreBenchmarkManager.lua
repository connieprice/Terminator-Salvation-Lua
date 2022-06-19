CoreBenchmarkNetHandler = CoreBenchmarkNetHandler or class()
function CoreBenchmarkNetHandler.init(A0_0, A1_1)
	A0_0._server_set = false
	A0_0._manager = A1_1
end
function CoreBenchmarkNetHandler.benchmark_start(A0_2, A1_3, A2_4, A3_5, A4_6)
	local L5_7, L6_8
	L5_7 = A0_2._manager
	L5_7 = L5_7._remote_table
	L5_7 = L5_7[A3_5]
	if not L5_7 then
		L5_7 = A0_2._manager
		L5_7 = L5_7._remote_table
		L6_8 = {}
		L5_7[A3_5] = L6_8
		L5_7 = A0_2._manager
		L5_7 = L5_7._remote_table
		L5_7 = L5_7[A3_5]
		L6_8 = {}
		L5_7._table = L6_8
		L5_7 = A0_2._manager
		L5_7 = L5_7._remote_table
		L5_7 = L5_7[A3_5]
		L6_8 = {}
		L5_7._data = L6_8
	end
	L5_7 = A0_2._manager
	L5_7 = L5_7._remote_table
	L5_7 = L5_7[A3_5]
	L5_7 = L5_7._table
	L5_7[A1_3] = A2_4
end
function CoreBenchmarkNetHandler.benchmark_data(A0_9, A1_10, A2_11, A3_12, A4_13, A5_14)
	if A0_9._manager._remote_table[A4_13] then
		if not A0_9._manager._remote_table[A4_13]._data[A1_10] then
			A0_9._manager._remote_table[A4_13]._data[A1_10] = {}
		end
		A0_9._manager._remote_table[A4_13]._data[A1_10][A2_11] = A3_12
	else
		cat_print("debug", "[CoreBenchmarkNetHandler] " .. A4_13 .. " is sending 'benchmark_data' without 'benchmark_start' message.")
	end
	if A0_9._manager._alive then
		A0_9._manager._alive[A4_13] = TimerManager:game():time()
	end
end
function CoreBenchmarkNetHandler.benchmark_end(A0_15, A1_16, A2_17)
	local L3_18, L4_19, L5_20, L6_21, L7_22, L8_23, L9_24, L10_25, L11_26, L12_27, L13_28, L14_29
	L3_18 = A0_15._manager
	L3_18 = L3_18._remote_table
	L3_18 = L3_18[A1_16]
	if L3_18 then
		L3_18 = table
		L3_18 = L3_18.size
		L3_18 = L3_18(L4_19)
		if L3_18 > 0 then
			L3_18 = A0_15._manager
			L3_18 = L3_18._stats_node
			L3_18 = L3_18.make_child
			L3_18 = L3_18(L4_19, L5_20)
			for L7_22, L8_23 in L4_19(L5_20) do
				L9_24 = L3_18.set_parameter
				L13_28 = L8_23
				L14_29 = L12_27(L13_28)
				L9_24(L10_25, L11_26, L12_27, L13_28, L14_29, L12_27(L13_28))
			end
			L7_22 = A1_16
			L4_19(L5_20, L6_21, L7_22)
			for L7_22, L8_23 in L4_19(L5_20) do
				L9_24 = L3_18.make_child
				L9_24 = L9_24(L10_25, L11_26)
				L13_28 = L7_22
				L10_25(L11_26, L12_27, L13_28)
				for L13_28, L14_29 in L10_25(L11_26) do
					L9_24:set_parameter(L13_28, tostring(L14_29))
				end
			end
			L4_19[A1_16] = L5_20
		end
		L3_18 = A0_15._manager
		L3_18 = L3_18._remote_table
		L3_18[A1_16] = nil
	else
		L3_18 = cat_print
		L7_22 = " is sending 'benchmark_end' without 'benchmark_start' message."
		L3_18(L4_19, L5_20)
	end
	L3_18 = A0_15._manager
	L3_18 = L3_18._client_count
	L3_18 = L3_18[A1_16]
	L3_18 = L3_18 or 0
	if L3_18 >= L4_19 then
		L3_18 = A0_15._manager
		L3_18 = L3_18._client_done
		L3_18[A1_16] = true
	end
	L3_18 = A0_15._manager
	L3_18 = L3_18.write_results
	L3_18(L4_19)
end
CoreBenchmarkManager = CoreBenchmarkManager or class()
function CoreBenchmarkManager.init(A0_30, A1_31)
	local L2_32
	A0_30._root_node = nil
	A0_30._path_node = nil
	A0_30._path_table = nil
	A0_30._server = nil
	A0_30._lua_start_cb = nil
	A0_30._lua_end_cb = nil
	A0_30._connected = false
	A0_30._is_server = false
	A0_30._file_dump = 0
	A0_30._results_size = 50
	A0_30._current_index = 1
	A0_30._current_len = 0
	A0_30._sync_time = 0
	A0_30._speed = 1000
	A0_30._client_time_out = 300
	A0_30._net_port = 12346
	A0_30._msg_port = 0
	L2_32 = Network
	L2_32 = L2_32.hostname
	L2_32 = L2_32(L2_32)
	A0_30._my_ip = L2_32
	L2_32 = {}
	A0_30._remote_table = L2_32
	L2_32 = {}
	A0_30._alive = L2_32
	L2_32 = {}
	A0_30._client_done = L2_32
	L2_32 = {}
	A0_30._client_count = L2_32
	L2_32 = Node
	L2_32 = L2_32("results")
	A0_30._stats_node = L2_32
	A0_30._flag = false
	L2_32 = A0_30.bm_loop_arg
	L2_32 = L2_32(A0_30)
	A0_30._loop_path = L2_32
	A0_30._pause_path = false
	if A1_31 then
		A0_30._speed = A1_31
	end
	L2_32 = rawget
	L2_32 = L2_32(_G, "setup")
	if L2_32 then
		L2_32 = setup
		L2_32 = L2_32.benchmark
		if L2_32 then
			L2_32 = A0_30.bm_level
			L2_32 = L2_32(A0_30)
			A0_30._bm_level = L2_32
			L2_32 = SystemInfo
			L2_32 = L2_32.platform
			L2_32 = L2_32(L2_32)
			if L2_32 == "WIN32" then
				L2_32 = Application
				L2_32 = L2_32.revision
				L2_32 = L2_32(L2_32, Application:base_path() .. "/")
				A0_30._proj_ver = L2_32
				L2_32 = Application
				L2_32 = L2_32.revision
				L2_32 = L2_32(L2_32, Application:base_path() .. "/core")
				A0_30._core_ver = L2_32
			else
				L2_32 = File
				L2_32 = L2_32.open
				L2_32 = L2_32(L2_32, "svn_revisions.txt", "r")
				assert(L2_32)
				A0_30._proj_ver = L2_32:gets()
				A0_30._core_ver = L2_32:gets()
				L2_32:close()
			end
		end
	end
end
function CoreBenchmarkManager.paused_update(A0_33, A1_34, A2_35)
	A0_33:update(A1_34, A2_35)
end
function CoreBenchmarkManager.absolute_end(A0_36)
	local L2_37, L3_38, L4_39, L5_40
	L2_37 = 0
	for _FORV_5_ = 1, L4_39 - 1 do
		L2_37 = L2_37 + (A0_36._path_table[_FORV_5_].pos - A0_36._path_table[_FORV_5_ + 1].pos):length()
	end
	return L2_37
end
function CoreBenchmarkManager.absolute_pos(A0_41)
	local L1_42
	L1_42 = 0
	for 