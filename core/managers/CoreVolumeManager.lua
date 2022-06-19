if not CoreVolumeManager then
	CoreVolumeManager = class()
end
CoreVolumeManager.HACK_TIME = 1e-007
CoreVolumeManager.DEFAULT_MASTER_VOLUME = 0
CoreVolumeManager.init = function(l_1_0, l_1_1)
	l_1_0._config_file_name = l_1_1
	l_1_0._affected_sounds = {}
	l_1_0:read_config()
	l_1_0._gain_list = {}
	l_1_0._pitch_list = {}
	l_1_0._fade_out_gain = {}
	l_1_0._fade_out_pitch = {}
	l_1_0._fade_out_hf = {}
	l_1_0._fade_out_lf = {}
	l_1_0._paused_counter = 0
end

CoreVolumeManager.set_paused = function(l_2_0, l_2_1)
	local l_2_6, l_2_7, l_2_8, l_2_9, l_2_13, l_2_14, l_2_15, l_2_16 = nil
	local l_2_2 = l_2_0:is_paused()
	if l_2_1 then
		l_2_0._paused_counter = l_2_0._paused_counter + 1
	else
		l_2_0._paused_counter = l_2_0._paused_counter - 1
	end
	if l_2_0._paused_category_list and l_2_2 ~= l_2_0:is_paused() then
		if l_2_1 then
			for i_0,i_1 in ipairs(l_2_0._paused_category_list) do
				Sound:pause(i_1)
			end
		end
	else
		for i_0,i_1 in ipairs(l_2_0._paused_category_list) do
			Sound:unpause(i_1)
		end
	end
end

CoreVolumeManager.is_paused = function(l_3_0)
	return l_3_0._paused_counter or 0 > 0
end

CoreVolumeManager.destroy = function(l_4_0)
	local l_4_4, l_4_5, l_4_6, l_4_7, l_4_8, l_4_9 = nil
	for i_0 in pairs(l_4_0._categories) do
		local l_4_11 = l_4_0._master_vol[i_0]
		local l_4_12 = l_4_0._master_pitch_map[l_4_10]
		local l_4_13 = l_4_0._master_hf_filter_map[l_4_10]
		Sound:set_control_ramp(l_4_10, "gain_db", l_4_11, l_4_11, l_4_0.HACK_TIME)
		Sound:set_control_ramp(l_4_10, "pitch_abs", l_4_12, l_4_12, l_4_0.HACK_TIME)
		Sound:set_control_ramp(l_4_10, "hf_filter_db", l_4_13, l_4_13, l_4_0.HACK_TIME)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		Sound:set_control_ramp(l_4_10, "lf_filter_db", l_4_0._master_lf_filter_map[l_4_10], l_4_0._master_lf_filter_map[l_4_10], l_4_0.HACK_TIME)
		Sound:set_volume(l_4_10, l_4_11)
		Sound:set_control(l_4_10, "pitch_abs", l_4_12)
		Sound:set_control(l_4_10, "hf_filter_db", l_4_13)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		Sound:set_control(l_4_10, "lf_filter_db", l_4_0._master_lf_filter_map[l_4_10])
	end
end

CoreVolumeManager.read_config = function(l_5_0)
	local l_5_5, l_5_6, l_5_7 = nil
	l_5_0._master_vol = {}
	l_5_0._master_pitch_map = {}
	l_5_0._master_hf_filter_map = {}
	l_5_0._master_lf_filter_map = {}
	l_5_0._volume_set_map = {}
	l_5_0._sphere_set_map = {}
	l_5_0._active_nodes = {}
	l_5_0._active_sphere_nodes = {}
	l_5_0._id_count = 0
	l_5_0._categories = {}
	local l_5_1 = File:parse_xml(l_5_0._config_file_name)
	if l_5_1 and l_5_1:name() == "volume_manager" then
		for i_0 in l_5_1:children() do
			if i_0:parameter("name") ~= "" then
				local l_5_9 = nil
				if l_5_8:name() == "category" then
					l_5_0._master_vol[l_5_9] = l_5_0.DEFAULT_MASTER_VOLUME
					l_5_0._master_pitch_map[l_5_9] = 1
					l_5_0._master_hf_filter_map[l_5_9] = 0
					l_5_0._master_lf_filter_map[l_5_9] = 0
					l_5_0._categories[l_5_9] = false
				elseif l_5_8:name() == "volume_set" then
					l_5_0:log("Found set with name: " .. l_5_9)
					local l_5_10 = nil
					if l_5_0._volume_set_map[l_5_8:parameter("name")] then
						Application:error("Duplicate volume set \"" .. tostring(l_5_8:parameter("name")) .. "\" found in \"" .. tostring(l_5_0._config_file_name) .. "\". Overwriting.")
					end
					local l_5_11 = nil
					local l_5_12 = {}
					local l_5_13 = {}
					local l_5_14 = {}
					do
						local l_5_15 = {}
						l_5_12.name = l_5_11
						l_5_12.priority = tonumber(l_5_8:parameter("priority"))
						l_5_12.time = tonumber(l_5_8:parameter("time"))
						l_5_12.zero_distance = tonumber(l_5_8:parameter("zero_distance"))
						if l_5_12.zero_distance and l_5_12.zero_distance <= 0 then
							l_5_12.zero_distance = nil
						end
						l_5_0:parse_volume_controls(l_5_8, l_5_12)
						l_5_0._volume_set_map[l_5_11] = l_5_12
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				elseif l_5_10 == "sphere_set" then
					l_5_0:log("Found sphere set with name: " .. l_5_9)
					local l_5_16 = nil
					 -- DECOMPILER ERROR: Overwrote pending register.

					if l_5_0._sphere_set_map[l_5_8:parameter("name")] then
						Application:error("Duplicate volume set \"" .. tostring({}) .. "\" found in \"" .. tostring(l_5_0._config_file_name) .. "\". Overwriting.")
					end
					local l_5_17 = nil
					local l_5_24 = {name = l_5_17, priority = tonumber(l_5_8:parameter("priority")), time = tonumber(l_5_8:parameter("time")), invert = l_5_8:parameter("invert") == "true", listener_inside = tonumber(l_5_8:parameter("listener_inside")), listener_outside = tonumber(l_5_8:parameter("listener_outside"))}
					l_5_24.radius = tonumber(l_5_8:parameter("radius"))
					local l_5_20 = {}
					for i_0 in l_5_8:children() do
						if i_0:name() == "gain_control" then
							if l_5_24.gain then
								Application:error("Duplicate gain found on sphere set \"" .. tostring(l_5_17) .. "\" in \"" .. tostring(l_5_0._config_file_name) .. "\". Overwriting.")
							end
							l_5_24.gain = tonumber(l_5_8:parameter("gain")) or 0
							l_5_24.enter_gain = math.max(tonumber(l_5_8:parameter("enter_gain")) or 0, l_5_0.HACK_TIME)
							l_5_24.exit_gain = math.max(tonumber(l_5_8:parameter("exit_gain")) or 0, l_5_0.HACK_TIME)
						elseif i_0:name() == "pitch_control" then
							if l_5_24.pitch then
								Application:error("Duplicate pitch found on sphere set \"" .. tostring(l_5_17) .. "\" in \"" .. tostring(l_5_0._config_file_name) .. "\". Overwriting.")
							end
							l_5_24.pitch = tonumber(l_5_8:parameter("pitch")) or 0
							l_5_24.enter_pitch = math.max(tonumber(l_5_8:parameter("enter_pitch")) or 0, l_5_0.HACK_TIME)
							l_5_24.exit_pitch = math.max(tonumber(l_5_8:parameter("exit_pitch")) or 0, l_5_0.HACK_TIME)
						elseif i_0:name() == "ignore" then
							local l_5_26 = nil
							local l_5_27 = l_5_25:parameter("cue")
							if l_5_27 == "" or l_5_25:parameter("bank") == "" then
								Application:error("Invalid cue-attribute \"" .. tostring(l_5_27) .. "\" and/or bank-attribute \"" .. tostring(l_5_25:parameter("bank")) .. "\" found on set \"" .. tostring(l_5_24.name) .. "\" in \"" .. tostring(l_5_0._config_file_name) .. "\". Overwriting.")
							end
						else
							local l_5_28 = nil
							local l_5_29 = table.insert
							local l_5_30 = l_5_20
							l_5_29(l_5_30, {cue = l_5_27, bank = l_5_28})
						end
					end
					l_5_24.gain = l_5_24.gain or 0
					l_5_24.pitch = l_5_24.pitch or 0
					l_5_24.ignore_cue_list = l_5_20
					l_5_0._sphere_set_map[l_5_17] = l_5_24
					 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

				end
			else
				l_5_16 = Application
				l_5_16, l_5_17 = l_5_16:error, l_5_16
				l_5_24 = "Empty name attribute in \""
				l_5_20 = tostring
				l_5_20 = l_5_20(l_5_0._config_file_name)
				l_5_24 = l_5_24 .. l_5_20 .. "\"."
				l_5_16(l_5_17, l_5_24)
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreVolumeManager.parse_volume_controls = function(l_6_0, l_6_1, l_6_2)
	local l_6_10, l_6_11, l_6_12, l_6_13, l_6_14, l_6_15 = nil
	local l_6_3 = {}
	local l_6_4 = {}
	local l_6_5 = {}
	local l_6_6 = {}
	for i_0 in l_6_1:children() do
		local l_6_17 = i_0:name()
		if l_6_17 == "gain_control" then
			local l_6_19 = l_6_16:parameter("category")
			local l_6_20 = tonumber(l_6_16:parameter("gain"))
			if not l_6_20 then
				local l_6_18 = tonumber(l_6_16:parameter("fade_in"))
			end
			if l_6_3[l_6_19] then
				Application:error("Duplicate gain_control category \"" .. tostring(l_6_19) .. "\" found on volume set \"" .. tostring(l_6_2.name) .. "\" in \"" .. tostring(l_6_0._config_file_name) .. "\". Overwriting.")
			end
			do
				local l_6_21 = nil
				l_6_3[l_6_19] = {gain = l_6_20, fade_in = l_6_21, fade_out = tonumber(l_6_16:parameter("fade_out"))}
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		elseif l_6_17 == "pitch_control" then
			local l_6_23 = nil
			local l_6_24 = l_6_20(l_6_16:parameter("pitch"))
			if not l_6_24 then
				local l_6_22 = tonumber(l_6_16:parameter("fade_in"))
			end
			if l_6_4[l_6_23] then
				Application:error("Duplicate pitch_control category \"" .. tostring(l_6_23) .. "\" found on volume set \"" .. tostring(l_6_2.name) .. "\" in \"" .. tostring(l_6_0._config_file_name) .. "\". Overwriting.")
			end
			do
				local l_6_25 = nil
				l_6_4[l_6_23] = {pitch = l_6_24, fade_in = l_6_25, fade_out = tonumber(l_6_16:parameter("fade_out"))}
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		elseif l_6_17 == "hf_control" then
			local l_6_27 = nil
			local l_6_28 = l_6_24(l_6_16:parameter("gain"))
			if not l_6_28 then
				local l_6_26 = tonumber(l_6_16:parameter("fade_in"))
			end
			if l_6_5[l_6_27] then
				Application:error("Duplicate hf_control category \"" .. tostring(l_6_27) .. "\" found on volume set \"" .. tostring(l_6_2.name) .. "\" in \"" .. tostring(l_6_0._config_file_name) .. "\". Overwriting.")
			end
			do
				local l_6_29 = nil
				l_6_5[l_6_27] = {gain = l_6_28, fade_in = l_6_29, fade_out = tonumber(l_6_16:parameter("fade_out"))}
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		elseif l_6_17 == "lf_control" then
			local l_6_31 = nil
			local l_6_32 = l_6_28(l_6_16:parameter("gain"))
			if not l_6_32 then
				local l_6_30 = tonumber(l_6_16:parameter("fade_in"))
			end
			if l_6_6[l_6_31] then
				Application:error("Duplicate lf_control category \"" .. tostring(l_6_31) .. "\" found on volume set \"" .. tostring(l_6_2.name) .. "\" in \"" .. tostring(l_6_0._config_file_name) .. "\". Overwriting.")
			end
			local l_6_33 = nil
			l_6_6[l_6_31] = {gain = l_6_32, fade_in = l_6_33, fade_out = tonumber(l_6_16:parameter("fade_out"))}
		end
	end
	l_6_2.gain_map = l_6_3
	l_6_2.pitch_map = l_6_4
	l_6_2.hf_filter_map = l_6_5
	l_6_2.lf_filter_map = l_6_6
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreVolumeManager.log = function(l_7_0, l_7_1, l_7_2)
	if l_7_2 then
		cat_print("debug", "[CoreVolumeManager] " .. l_7_1)
	else
		cat_print("volume_manager", "[CoreVolumeManager] " .. l_7_1)
	end
	if l_7_0._editor then
		l_7_0._editor:log(l_7_1)
	end
end

CoreVolumeManager.is_active = function(l_8_0, l_8_1)
	local l_8_5, l_8_6, l_8_10, l_8_11, l_8_15, l_8_16, l_8_20, l_8_21 = nil
	if type(l_8_1) == "number" then
		for i_0,i_1 in ipairs(l_8_0._active_nodes) do
			if l_8_1 == i_1.id then
				return true
			end
		end
	else
		for i_0,i_1 in ipairs(l_8_0._active_nodes) do
			if l_8_1 == i_1.name then
				return true
			end
		end
	end
	if type(l_8_1) == "number" then
		for i_0,i_1 in ipairs(l_8_0._active_sphere_nodes) do
			if l_8_1 == i_1.id then
				return true
			end
		end
	else
		for i_0,i_1 in ipairs(l_8_0._active_sphere_nodes) do
			if l_8_1 == i_1.name then
				return true
			end
		end
	end
	return false
end

CoreVolumeManager.set_master_vol = function(l_9_0, l_9_1, l_9_2)
	Sound:set_volume(l_9_1, l_9_2)
	Sound:set_control_ramp(l_9_1, "gain_db", l_9_2, l_9_2, l_9_0.HACK_TIME)
	l_9_0._master_vol[l_9_1] = l_9_2
end

CoreVolumeManager.get_master_vol = function(l_10_0, l_10_1)
	return l_10_0._master_vol[l_10_1]
end

CoreVolumeManager.set_fade_out = function(l_11_0, l_11_1, l_11_2)
	Application:stack_dump_error("Deprecated function call.")
	return false
end

CoreVolumeManager.set_fade_in = function(l_12_0, l_12_1, l_12_2)
	Application:stack_dump_error("Deprecated function call.")
	return false
end

CoreVolumeManager.set_time = function(l_13_0, l_13_1, l_13_2)
	Application:stack_dump_error("Deprecated function call.")
	return false
end

CoreVolumeManager.set_gain = function(l_14_0, l_14_1, l_14_2)
	Application:stack_dump_error("Deprecated function call.")
	return false
end

CoreVolumeManager.set_zero_distance = function(l_15_0, l_15_1, l_15_2)
	Application:stack_dump_error("Deprecated function call.")
	return false
end

CoreVolumeManager.debug_print = function(l_16_0)
	local l_16_5, l_16_6, l_16_7, l_16_8, l_16_9, l_16_10 = nil
	local l_16_4 = l_16_0:log
	l_16_4(l_16_0, "--------- Active Volume Sets ---------", true)
	l_16_4 = ipairs
	l_16_4 = l_16_4(l_16_0._active_nodes)
	for i_0,i_1 in l_16_4 do
		l_16_0:log(l_16_3 .. " Name: " .. i_1.structure.name .. ", Id: " .. i_1.id, true)
	end
	l_16_0:log("--------- Active Sphere Sets ---------", true)
	for i_0,i_1 in ipairs(l_16_0._active_sphere_nodes) do
		l_16_0:log(i_0 .. " Name: " .. i_1.structure.name .. ", Id: " .. i_1.id, true)
	end
	l_16_0:log("--------------------------------------", true)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreVolumeManager.activate_set = function(l_17_0, l_17_1, l_17_2)
	local l_17_3 = l_17_0._volume_set_map[l_17_1]
	if l_17_3 then
		local l_17_4 = {}
		l_17_4.first_update = true
		l_17_4.start_time = TimerManager:game():time()
		l_17_4.id = l_17_0._id_count
		l_17_4.structure = l_17_3
		l_17_4.name = l_17_3.name
		l_17_4.position = l_17_2
		local l_17_5 = #l_17_0._active_nodes + 1
		local l_17_6 = l_17_4.structure.priority
		for l_17_10 = l_17_5 - 1, 1, -1 do
			local l_17_11 = l_17_0._active_nodes[l_17_10].structure.priority
			if l_17_11 then
				if l_17_6 and l_17_11 <= l_17_6 then
					do break end
				end
				do return end
			end
			l_17_5 = l_17_10
		end
		table.insert(l_17_0._active_nodes, l_17_5, l_17_4)
		l_17_0._id_count = l_17_0._id_count + 1
		l_17_0:log("Activated volume set: \"" .. l_17_1 .. "\", Id: " .. l_17_4.id)
		return l_17_4.id
	elseif l_17_2 then
		local l_17_12 = l_17_0._sphere_set_map[l_17_1]
	if l_17_12 then
		end
		local l_17_13 = {}
		l_17_13.position = l_17_2
		l_17_13.first_update = true
		l_17_13.start_time = TimerManager:game():time()
		l_17_13.id = l_17_0._id_count
		l_17_13.priority = l_17_12.pritiority
		l_17_13.structure = l_17_12
		l_17_13.name = l_17_12.name
		local l_17_14 = #l_17_0._active_sphere_nodes + 1
		local l_17_15 = l_17_13.structure.priority
		for l_17_19 = l_17_14 - 1, 1, -1 do
			local l_17_20 = l_17_0._active_sphere_nodes[l_17_19].structure.priority
			if l_17_20 then
				if l_17_15 and l_17_20 <= l_17_15 then
					do break end
				end
				do return end
			end
			l_17_14 = l_17_19
		end
		table.insert(l_17_0._active_sphere_nodes, l_17_14, l_17_13)
		l_17_0._id_count = l_17_0._id_count + 1
		l_17_0:log("Activated sphere set: \"" .. l_17_1 .. "\", Id: " .. l_17_13.id)
		return l_17_13.id
	end
	return -1
end

CoreVolumeManager.deactivate_set = function(l_18_0, l_18_1)
	local l_18_2, l_18_5, l_18_6, l_18_7, l_18_8, l_18_9, l_18_10, l_18_11, l_18_14, l_18_15, l_18_16, l_18_17, l_18_18, l_18_19, l_18_20 = nil
	if type(l_18_1) == "number" then
		for i_0,i_1 in ipairs(l_18_0._active_nodes) do
			if i_1.id == l_18_1 then
				l_18_2 = i_1
				table.remove(l_18_0._active_nodes, i_0)
		else
			end
		end
	else
		for i_0,i_1 in ipairs(l_18_0._active_nodes) do
			if i_1.name == l_18_1 then
				l_18_2 = i_1
				table.remove(l_18_0._active_nodes, i_0)
			end
	else
		end
	end
	if l_18_2 then
		l_18_0:fade_out(l_18_2)
		local l_18_23, l_18_25, l_18_27, l_18_28, l_18_32, l_18_34, l_18_36, l_18_37 = l_18_0:log, l_18_0, "Deactivated volume set: ", l_18_2.name
		l_18_32 = ", Id: "
		local l_18_24, l_18_26, l_18_29, l_18_33, l_18_35, l_18_38 = nil
		l_18_34 = l_18_2.id
		l_18_27 = l_18_27 .. l_18_28 .. l_18_32 .. l_18_34
		l_18_23(l_18_25, l_18_27)
		l_18_23 = true
		return l_18_23
	else
		if type(l_18_1) == "number" then
			for i_0,i_1 in ipairs(l_18_0._active_sphere_nodes) do
				if i_1.id == l_18_1 then
					l_18_2 = i_1
					table.remove(l_18_0._active_sphere_nodes, i_0)
			else
				end
			end
		else
			for i_0,i_1 in ipairs(l_18_0._active_sphere_nodes) do
				if i_1.name == l_18_1 then
					l_18_2 = i_1
					table.remove(l_18_0._active_sphere_nodes, i_0)
				end
		else
			end
		end
	if l_18_2 then
		end
		l_18_0:log("Deactivated sphere set: " .. l_18_2.name .. ", Id: " .. l_18_2.id)
		return true
	end
	return false
end

CoreVolumeManager.fade_out = function(l_19_0, l_19_1)
	local l_19_6, l_19_7, l_19_8, l_19_9, l_19_12, l_19_13, l_19_14, l_19_15 = nil
	local l_19_2 = l_19_1.structure
	for i_0,i_1 in pairs(l_19_2.gain_map) do
		l_19_0._fade_out_gain[l_19_10] = {fade_out = l_19_11.fade_out}
	end
	for i_0,i_1 in pairs(l_19_2.pitch_map) do
		do
			l_19_0._fade_out_pitch[l_19_16] = {fade_out = l_19_17.fade_out}
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreVolumeManager.update = function(l_20_0, l_20_1, l_20_2)
	l_20_0:update_volume_sets(l_20_1, l_20_2)
	l_20_0:update_sphere_sets(l_20_1, l_20_2)
end

CoreVolumeManager.toggle_debug = function(l_21_0)
	if managers.debug then
		l_21_0._debug = not l_21_0._debug
		if l_21_0._debug then
			managers.debug:set_enabled(true)
			managers.debug:set_enabled_paused(true)
			managers.debug.gui:set_enabled(true)
			managers.debug.func:set_enabled(true)
			managers.debug.func:set("CoreVolumeManager", callback(l_21_0, l_21_0, "debug"))
		end
	else
		managers.debug.gui:clear()
		managers.debug.func:set("CoreVolumeManager", nil)
	end
end

CoreVolumeManager.paused_update = function(l_22_0)
	l_22_0:update(TimerManager:game():time(), TimerManager:game():delta_time())
end

CoreVolumeManager.reload = function(l_23_0)
	l_23_0:read_config()
end

CoreVolumeManager.debug = function(l_24_0)
	local l_24_4, l_24_5, l_24_6, l_24_7, l_24_8, l_24_9, l_24_10, l_24_11, l_24_12, l_24_13, l_24_14, l_24_15, l_24_16, l_24_17 = nil
	for i_0,i_1 in ipairs(l_24_0._active_sphere_nodes) do
		if i_1.invert then
			Application:draw_sphere(i_1.position, i_1.structure.radius, 1, 0, 0)
		else
			Application:draw_sphere(i_1.position, i_1.structure.radius, 0, 1, 0)
		end
	end
	managers.debug.gui:clear()
	managers.debug.gui:set(1, "SFX: " .. tostring(Sound:get_control("sfx", "gain_db")))
	managers.debug.gui:set(2, "Music: " .. tostring(Sound:get_control("music", "gain_db")))
	managers.debug.gui:set(4, "Active volume sets:")
	local l_24_18 = 1
	local l_24_19 = 1
	managers.debug.gui:set_color(4, l_24_18, l_24_19, 1)
	for l_24_18,l_24_19 in ipairs(l_24_0._active_nodes) do
		managers.debug.gui:set(4 + l_24_18, tostring(l_24_19.name) .. " (Prio: " .. tostring(l_24_19.structure.priority) .. ")")
		managers.debug.gui:set_color(4 + l_24_18, 0, 1, 0)
	end
	managers.debug.gui:set(4 + #l_24_0._active_nodes + 2, "Active sphere sets:")
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_24_20 = 1
	managers.debug.gui:set_color(4 + #l_24_0._active_nodes + 2, 1, l_24_20, 1)
	for i_0,l_24_20 in ipairs(l_24_0._active_sphere_nodes) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		do
			local l_24_21 = 4 + #l_24_0._active_nodes + 2 + i_0
			managers.debug.gui:set(l_24_21, tostring(l_24_20.name) .. " (Prio: " .. tostring(l_24_20.structure.priority) .. ")")
			managers.debug.gui:set_color(l_24_21, 0, 0, 1)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreVolumeManager.reset_affected_list = function(l_25_0)
	local l_25_4, l_25_5 = nil
	for i_0,i_1 in pairs(l_25_0._affected_sounds) do
		i_1.found = false
	end
end

CoreVolumeManager.calc_gain_and_pitch = function(l_26_0, l_26_1)
	local l_26_7, l_26_8, l_26_9, l_26_10, l_26_11, l_26_12 = nil
	local l_26_2 = 0
	local l_26_3 = 0
	for i_0,i_1 in pairs(l_26_1.sphere_nodes) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if i_1.structure.gain < l_26_2 then
			l_26_3 = l_26_3 + i_1.structure.pitch
		end
	end
	if table.size(l_26_1.sphere_nodes) > 0 then
		l_26_3 = (l_26_3) / table.size(l_26_1.sphere_nodes)
	end
	l_26_1.gain = l_26_2
	l_26_1.pitch = math.clamp(l_26_3, -15, 15)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreVolumeManager.clean_affected_sounds = function(l_27_0)
	local l_27_4, l_27_5, l_27_6, l_27_7, l_27_8, l_27_9, l_27_10, l_27_11, l_27_12, l_27_13, l_27_14, l_27_15, l_27_16, l_27_17, l_27_18, l_27_19, l_27_20, l_27_21, l_27_22, l_27_23, l_27_24, l_27_25, l_27_26, l_27_27, l_27_28, l_27_29, l_27_30, l_27_31 = nil
	for i_0,i_1 in pairs(l_27_0._affected_sounds) do
		if not i_1.found then
			if alive(i_1.sound) and i_1.sound:is_playing() then
				i_1.sound:set_control_ramp("gain_db", i_1.sound:get_control("gain_db"), 0, i_1.structure.exit_gain)
				local l_27_37 = i_1.sound:set_control_ramp
				l_27_37(i_1.sound, "pitch_tones", i_1.sound:get_control("pitch_tones"), 0, l_27_36.structure.exit_pitch)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_27_0._affected_sounds[l_27_35] = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			for i_0,i_1 in pairs(l_27_36.sphere_nodes) do
				local l_27_32, l_27_33 = nil
				if not l_27_0:is_active(i_0) then
					l_27_33.sphere_nodes[i_0] = nil
				end
			end
		end
	end
end

CoreVolumeManager.check_listener_pos = function(l_28_0, l_28_1)
	if not l_28_1.listener_outside and not l_28_1.listener_inside then
		return true
	end
	local l_28_2, l_28_3 = managers.listener:get_closest_listener_position(l_28_1.position)
	if l_28_3 then
		if l_28_1.listener_inside and l_28_3 < l_28_1.structure.radius then
			return true
		end
	else
		if l_28_1.structure.radius < l_28_3 then
			return true
		end
	end
	return false
end

CoreVolumeManager.in_ignore_list = function(l_29_0, l_29_1, l_29_2)
	local l_29_6, l_29_7, l_29_8, l_29_9 = nil
	for i_0,i_1 in ipairs(l_29_1.structure.ignore_cue_list) do
		if l_29_2:cue() == i_1.cue and l_29_2:bank() == i_1.bank then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreVolumeManager.update_sphere_sets = function(l_30_0, l_30_1, l_30_2)
	local l_30_7, l_30_8, l_30_9, l_30_10, l_30_11, l_30_17, l_30_18, l_30_19, l_30_22, l_30_23 = nil
	do
		local l_30_6 = l_30_0:check_timeout
		l_30_6(l_30_0, l_30_1, l_30_0._active_sphere_nodes)
		l_30_6(l_30_0)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0,i_1 in l_30_6 do
			if l_30_0:check_listener_pos(i_1) then
				local l_30_12 = Sound:playing_in_sphere(i_1.position, i_1.structure.radius, i_1.structure.invert)
				for i_0,i_1 in ipairs(l_30_12) do
					if not l_30_0._affected_sounds[i_1:key()] and not l_30_0:in_ignore_list(l_30_16, i_1) then
						({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).sphere_nodes[l_30_16.id] = l_30_16
						 -- DECOMPILER ERROR: Confused about usage of registers!

						l_30_0._affected_sounds[i_1:key()] = {found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}
						 -- DECOMPILER ERROR: Confused about usage of registers!

						l_30_0:calc_gain_and_pitch({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}})
						 -- DECOMPILER ERROR: Confused about usage of registers!

						 -- DECOMPILER ERROR: Confused about usage of registers!

						 -- DECOMPILER ERROR: Confused about usage of registers!

						 -- DECOMPILER ERROR: Confused about usage of registers!

						if l_30_16.first_update then
							({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).sound:set_control_ramp("gain_db", ({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).sound:get_control("gain_db"), ({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).gain, ({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).structure.enter_gain)
							 -- DECOMPILER ERROR: Confused about usage of registers!

							 -- DECOMPILER ERROR: Confused about usage of registers!

							 -- DECOMPILER ERROR: Confused about usage of registers!

							 -- DECOMPILER ERROR: Confused about usage of registers!

							({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).sound:set_control_ramp("pitch_tones", ({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).sound:get_control("pitch_tones"), ({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).structure.pitch, ({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).structure.enter_pitch)
						end
					 -- DECOMPILER ERROR: Confused about usage of registers!

					 -- DECOMPILER ERROR: Confused about usage of registers!

					else
						({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).sound:set_control("gain_db", ({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).structure.gain)
						 -- DECOMPILER ERROR: Confused about usage of registers!

						 -- DECOMPILER ERROR: Confused about usage of registers!

						 -- DECOMPILER ERROR: Confused about usage of registers!

						({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).sound:set_control_ramp("gain_db", ({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).structure.gain, ({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).structure.gain, l_30_0.HACK_TIME)
						 -- DECOMPILER ERROR: Confused about usage of registers!

						 -- DECOMPILER ERROR: Confused about usage of registers!

						({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).sound:set_control("pitch_tones", ({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).structure.pitch)
						 -- DECOMPILER ERROR: Confused about usage of registers!

						 -- DECOMPILER ERROR: Confused about usage of registers!

						 -- DECOMPILER ERROR: Confused about usage of registers!

						({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).sound:set_control_ramp("pitch_tones", ({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).structure.gain, ({found = true, sound = l_30_21, structure = l_30_16.structure, 
sphere_nodes = {}}).structure.gain, l_30_0.HACK_TIME)
					end
					for l_30_20,i_1 in l_30_13 do
						if not l_30_0._affected_sounds[i_1:key()].sphere_nodes[l_30_16.id] then
							l_30_0._affected_sounds[i_1:key()].sphere_nodes[l_30_16.id] = l_30_16
						end
						l_30_0._affected_sounds[i_1:key()].found = true
					end
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				if l_30_16.first_update then
					l_30_16.first_update = false
				end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_30_3 = l_30_0
			l_30_6(l_30_3)
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

CoreVolumeManager.update_volume_sets = function(l_31_0, l_31_1, l_31_2)
	l_31_0._gain_list = {}
	l_31_0._pitch_list = {}
	l_31_0:check_timeout(l_31_1, l_31_0._active_nodes)
	for l_31_6 = #l_31_0._active_nodes, 1, -1 do
		local l_31_7 = l_31_0._active_nodes[l_31_6]
		local l_31_8 = l_31_7.structure
		local l_31_9 = l_31_8.zero_distance
		local l_31_10 = nil
		local l_31_11 = l_31_7.first_update
		if l_31_9 and l_31_7.position then
			local l_31_12, l_31_13 = managers.listener:get_closest_listener_position(l_31_7.position)
			if l_31_13 then
				local l_31_18, l_31_19, l_31_21, l_31_23, l_31_28, l_31_29, l_31_31, l_31_33 = math.clamp, l_31_13 / l_31_9
				l_31_21 = 0
				local l_31_20, l_31_22, l_31_24, l_31_30, l_31_32, l_31_34 = nil
				l_31_23 = 1
				l_31_18 = l_31_18(l_31_19, l_31_21, l_31_23)
				l_31_18 = 1 - l_31_18
				local l_31_14 = nil
				l_31_10 = (l_31_18) * (l_31_18)
			end
		else
			l_31_10 = 0
		end
		for i_0,i_1 in pairs(l_31_8.gain_map) do
			if not l_31_0._gain_list[i_0] then
				if l_31_10 then
					local l_31_27 = {}
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				l_31_27.gain = i_1.gain * l_31_10
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				l_31_27.fade_in = l_31_26.fade_in
				 -- DECOMPILER ERROR: Confused about usage of registers!

				l_31_0._gain_list[l_31_25] = l_31_27
			end
		end
		for i_0,i_1 in pairs(l_31_8.pitch_map) do
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if not l_31_0._pitch_list[i_0] then
				if l_31_10 then
					l_31_0._pitch_list[l_31_35] = {data = l_31_36, first_update = l_31_11, gain = i_1.pitch * l_31_10}
				end
			end
			l_31_7.first_update = false
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		l_31_0:apply_volume_set_values(l_31_1, l_31_2)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 77 
end

CoreVolumeManager.check_timeout = function(l_32_0, l_32_1, l_32_2)
	local l_32_3, l_32_6, l_32_7, l_32_8, l_32_9, l_32_10, l_32_11, l_32_13, l_32_14, l_32_15, l_32_16 = nil
	for i_0,i_1 in pairs(l_32_2) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if i_1.structure.time and i_1.structure.time <= l_32_1 - i_1.start_time then
			if not l_32_3 then
				l_32_3 = {}
			end
			table.insert(l_32_3, i_1)
		end
	end
	if l_32_3 then
		for i_0,i_1 in ipairs(l_32_3) do
			l_32_0:deactivate_set(i_1.id)
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreVolumeManager.apply_volume_set_values = function(l_33_0, l_33_1, l_33_2)
	local l_33_6, l_33_7, l_33_8 = nil
	for i_0 in pairs(l_33_0._categories) do
		local l_33_10 = l_33_0._fade_out_gain[i_0]
		local l_33_11 = l_33_0._gain_list[l_33_9]
		local l_33_12 = 0
		if l_33_10 then
			local l_33_13 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_33_10.fade_out then
				l_33_12 = l_33_10.fade_out
			end
			l_33_13 = l_33_11 and l_33_11.gain or 0
			l_33_0._fade_out_gain[l_33_9] = nil
		end
		if l_33_11 and l_33_11.first_update and (not l_33_11.gain) then
			local l_33_14 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_33_11.data.fade_in then
			end
			l_33_12 = l_33_12 + l_33_11.data.fade_in
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_33_14 then
			if l_33_12 > 0 then
				Sound:set_control_ramp(l_33_9, "gain_db", Sound:get_control(l_33_9, "gain_db"), l_33_14 + l_33_0._master_vol[l_33_9], l_33_12)
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			Sound:set_control_ramp(l_33_9, "gain_db", l_33_14 + l_33_0._master_vol[l_33_9], l_33_14 + l_33_0._master_vol[l_33_9], l_33_0.HACK_TIME)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			Sound:set_control(l_33_9, "gain_db", l_33_14 + l_33_0._master_vol[l_33_9])
		end
		local l_33_15 = nil
		local l_33_16 = l_33_0._fade_out_pitch[l_33_9]
		local l_33_17 = l_33_0._pitch_list[l_33_9]
		local l_33_18 = 0
		if l_33_16 then
			local l_33_19 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_33_16.fade_out then
				l_33_18 = l_33_16.fade_out
			end
			if not l_33_17 or not l_33_17.pitch then
				l_33_19 = l_33_0._master_pitch_map[l_33_9]
			end
			l_33_0._fade_out_pitch[l_33_9] = nil
		end
		if l_33_17 and l_33_17.first_update and (not l_33_17.pitch) then
			local l_33_20 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_33_17.data.fade_in then
			end
			l_33_18 = l_33_18 + l_33_17.data.fade_in
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_33_20 then
			if l_33_18 > 0 then
				Sound:set_control_ramp(l_33_9, "pitch_tones", Sound:get_control(l_33_9, "pitch_tones"), l_33_20, l_33_18)
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			Sound:set_control_ramp(l_33_9, "pitch_tones", l_33_20, l_33_20, l_33_0.HACK_TIME)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			Sound:set_control(l_33_9, "pitch_tones", l_33_20)
		end
	end
end

CoreVolumeManager.volume_set_names = function(l_34_0)
	local l_34_1 = table.map_keys
	if not l_34_0._volume_set_map then
		local l_34_2 = {}
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_34_1(l_34_2)
end

CoreVolumeManager.is_valid_volume_set_name = function(l_35_0, l_35_1)
	return l_35_0._volume_set_map ~= nil and l_35_0._volume_set_map[l_35_1] ~= nil
end


