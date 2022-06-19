core:module("CoreSong")
core:require_module("CoreClass")
if not Song then
	Song = CoreClass.class()
end
ENGINE_WAIT = 0.5
local l_0_0 = "3.0,"
local l_0_1 = "default"
local l_0_2 = "stop"
local l_0_3 = "modes"
Song.init = function(l_1_0, l_1_1, l_1_2)
	-- upvalues: l_0_0
	l_1_0._song_name = l_1_1
	local l_1_3 = l_1_2:lookup("song", l_1_1)
	if not l_1_3:valid() then
		local l_1_7, l_1_8, l_1_9 = error, string.format("Can not load song (song_name=%s), check song in DB.", l_1_1), .end
		l_1_7(l_1_8, l_1_9)
	end
	l_1_0._song = l_1_2:load_node(l_1_3)
	for i_0 in l_1_0._song:children() do
		if i_0:name() == "modes" then
			l_1_0._modes = l_1_10
		elseif i_0:name() == "nodes" then
			l_1_0._nodes = l_1_10
		elseif i_0:name() == "playhead_control" then
			l_1_0._playhead_control = l_1_10
		end
	end
	xml_version = l_1_0._song:parameter("xml_version") or "<not found>"
	if not string.find(l_0_0, xml_version) then
		error(string.format("XML version: '%s' not supported (valid versions: %s)", xml_version, l_0_0))
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Song.get_name = function(l_2_0)
	return l_2_0._song_name
end

Song.has_mode = function(l_3_0, l_3_1)
	local l_3_5 = nil
	for i_0 in l_3_0._modes:children() do
		if i_0:parameter("name") == l_3_1 then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Song.get_default_mode = function(l_4_0)
	local l_4_1 = l_4_0._modes:child(0)
	local l_4_2, l_4_3 = l_4_1:parameter, l_4_1
	local l_4_4 = "name"
	return l_4_2(l_4_3, l_4_4)
end

Song.get_mode = function(l_5_0, l_5_1)
	local l_5_5, l_5_6, l_5_7 = nil
	for i_0 in l_5_0._modes:children() do
		if i_0:parameter("name") == l_5_1 then
			local l_5_8, l_5_9 = l_5_10:parameters, l_5_10
			return l_5_8(l_5_9)
		end
	end
	error(string.format("Could not find mode '%s'", l_5_1))
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Song.get_modes = function(l_6_0)
	local l_6_5, l_6_6 = nil
	local l_6_1 = {}
	for i_0 in l_6_0._modes:children() do
		table.insert(l_6_1, i_0:parameter("name"))
	end
	return l_6_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Song.get_song_change_fadeout = function(l_7_0, l_7_1)
	local l_7_5, l_7_6, l_7_7, l_7_11, l_7_12, l_7_13 = nil
	for i_0 in l_7_0._playhead_control:children() do
		if i_0:name() == "song_change_crossfade" then
			for i_0 in i_0:children() do
				if i_0:parameter("mode") == l_7_1 then
					local l_7_16, l_7_17, l_7_18 = assert, tonumber(i_0:parameter("mode_stop_fadeout")), .end
					return l_7_16(l_7_17, l_7_18)
				end
			end
		end
	end
	error(string.format("Could not find song_change for mode (%s) in song (%s)", l_7_1, l_7_0._song_name))
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Song.get_song_change_fadein = function(l_8_0, l_8_1)
	local l_8_5, l_8_6, l_8_7, l_8_11, l_8_12, l_8_13 = nil
	for i_0 in l_8_0._playhead_control:children() do
		if i_0:name() == "song_change_crossfade" then
			for i_0 in i_0:children() do
				if i_0:parameter("mode") == l_8_1 then
					local l_8_16, l_8_17, l_8_18 = assert, tonumber(i_0:parameter("mode_start_fadein")), .end
					return l_8_16(l_8_17, l_8_18)
				end
			end
		end
	end
	error(string.format("Could not find song_change for mode (%s) in song (%s)", l_8_1, l_8_0._song_name))
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Song.get_mode_change_crossfade = function(l_9_0, l_9_1, l_9_2)
	local l_9_6, l_9_7, l_9_8, l_9_12, l_9_13, l_9_14, l_9_18, l_9_19, l_9_20, l_9_26, l_9_27, l_9_28 = nil
	for i_0 in l_9_0._playhead_control:children() do
		if i_0:name() == "mode_change_crossfade_transitions" then
			for i_0 in i_0:children() do
				if i_0:parameter("name") == l_9_1 then
					for i_0 in i_0:children() do
						if i_0:parameter("name") == l_9_2 then
							for i_0 in i_0:children() do
								local l_9_24, l_9_25 = math.random(), 0
								l_9_25 = l_9_25 + i_0:parameter("probability")
								if l_9_24 <= l_9_25 then
									local l_9_33 = nil
									setmetatable(i_0:parameters(), {__index = function(l_10_0, l_10_1)
									local l_10_2 = rawget(l_10_0, l_10_1)
									local l_10_3 = assert
									l_10_3(l_10_2 ~= nil, "Attempt to index a non-existent key.")
									return l_10_2
                end})
									assert(l_9_33.start_node)
									assert(l_9_33.add_time)
									l_9_33.fadein = assert(tonumber(l_9_33.fadein))
									l_9_33.fadeout = assert(tonumber(l_9_33.fadeout))
									return l_9_33
								end
							end
						end
					end
				end
			end
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Song.pick_transition = function(l_10_0, l_10_1, l_10_2)
	-- upvalues: l_0_1
	local l_10_9, l_10_10, l_10_11, l_10_12 = nil
	local l_10_3 = (l_10_0:_name2node(l_10_0, l_10_1))
	local l_10_4, l_10_5 = nil, nil
	for i_0 in l_10_3:children() do
		if i_0:parameter("name") == l_10_2 then
			l_10_4 = i_0
		else
			local l_10_16, l_10_17 = i_0:parameter("name"), l_0_1
		if l_10_16 == l_10_17 then
			end
			l_10_5 = l_10_15
		end
	end
	if not l_10_4 then
		l_10_4 = l_10_5
	end
	for i_0 in l_10_4:children() do
		if math.random() <= 0 + i_0:parameter("probability") then
			local l_10_19 = i_0:parameters()
			local l_10_20 = function(l_11_0, l_11_1)
			local l_11_2 = rawget(l_11_0, l_11_1)
			local l_11_3 = assert
			l_11_3(l_11_2 ~= nil, "Attempt to index a non-existent key.")
			return l_11_2
    end
			local l_10_21 = setmetatable
			local l_10_22 = l_10_19
			l_10_21(l_10_22, {__index = l_10_20})
			l_10_21 = l_10_19.action
			if l_10_21 == "fade_to_end" then
				l_10_21 = assert
				l_10_22 = tonumber
				l_10_21 = l_10_21(l_10_22)
				l_10_19.wait_fadeout = l_10_21
				l_10_21 = assert
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				l_10_21 = l_10_21(l_10_22)
				l_10_19.fadeout = l_10_21
			else
				l_10_21 = l_10_19.action
				if l_10_21 == "continue" then
					l_10_21 = assert
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					l_10_21 = l_10_21(l_10_22)
					l_10_19.new_stop_pos = l_10_21
					l_10_21 = assert
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					l_10_21 = l_10_21(l_10_22)
					l_10_19.new_section_change_pos = l_10_21
					l_10_21 = assert
					 -- DECOMPILER ERROR: Overwrote pending register.

					l_10_21(l_10_22)
					l_10_21 = assert
					 -- DECOMPILER ERROR: Overwrote pending register.

					l_10_21(l_10_22)
				end
			else
				l_10_21 = l_10_19.action
				if l_10_21 == "crossfade" then
					l_10_21 = assert
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					l_10_21 = l_10_21(l_10_22)
					l_10_19.wait_fadeout = l_10_21
					l_10_21 = assert
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					l_10_21 = l_10_21(l_10_22)
					l_10_19.fadeout = l_10_21
					l_10_21 = assert
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					l_10_21 = l_10_21(l_10_22)
					l_10_19.start_pos = l_10_21
					l_10_21 = assert
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					l_10_21 = l_10_21(l_10_22)
					l_10_19.stop_pos = l_10_21
					l_10_21 = assert
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					l_10_21 = l_10_21(l_10_22)
					l_10_19.wait_fadein = l_10_21
					l_10_21 = assert
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					l_10_21 = l_10_21(l_10_22)
					l_10_19.fadein = l_10_21
					l_10_21 = assert
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					l_10_21 = l_10_21(l_10_22)
					l_10_19.bar_offset = l_10_21
					l_10_21 = assert
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					l_10_21 = l_10_21(l_10_22)
					l_10_19.section_change_pos = l_10_21
					l_10_21 = assert
					 -- DECOMPILER ERROR: Overwrote pending register.

					l_10_21(l_10_22)
					l_10_21 = assert
					 -- DECOMPILER ERROR: Overwrote pending register.

					l_10_21(l_10_22)
					l_10_21 = assert
					 -- DECOMPILER ERROR: Overwrote pending register.

					l_10_21(l_10_22)
					l_10_21 = assert
					 -- DECOMPILER ERROR: Overwrote pending register.

					l_10_21(l_10_22)
					l_10_21 = assert
					 -- DECOMPILER ERROR: Overwrote pending register.

					l_10_21(l_10_22)
				end
			else
				l_10_21 = error
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_10_21(l_10_22)
			end
			return l_10_19
		end
	end
	error(string.format("could not find rule '%s'", l_10_2))
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Song.pick_start_transition = function(l_11_0, l_11_1)
	local l_11_9, l_11_10, l_11_11 = nil
	local l_11_2 = l_11_0:_name2node(l_11_0, l_11_1)
	local l_11_3 = l_11_2:child(0)
	local l_11_4 = math.random()
	local l_11_5 = 0
	for i_0 in l_11_3:children() do
		l_11_5 = l_11_5 + i_0:parameter("probability")
		if l_11_4 <= l_11_5 then
			local l_11_13 = i_0:parameters()
			local l_11_14 = function(l_12_0, l_12_1)
			local l_12_2 = rawget(l_12_0, l_12_1)
			local l_12_3 = assert
			l_12_3(l_12_2 ~= nil, "Attempt to index a non-existent key.")
			return l_12_2
    end
			local l_11_15 = setmetatable
			local l_11_16 = l_11_13
			l_11_15(l_11_16, {__index = l_11_14})
			l_11_15 = assert
			l_11_16 = tonumber
			l_11_15 = l_11_15(l_11_16)
			l_11_13.start_pos = l_11_15
			l_11_15 = assert
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_11_15 = l_11_15(l_11_16)
			l_11_13.stop_pos = l_11_15
			l_11_15 = assert
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_11_15 = l_11_15(l_11_16)
			l_11_13.wait_fadein = l_11_15
			l_11_15 = assert
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_11_15 = l_11_15(l_11_16)
			l_11_13.fadein = l_11_15
			l_11_15 = assert
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_11_15 = l_11_15(l_11_16)
			l_11_13.bar_offset = l_11_15
			l_11_15 = assert
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_11_15 = l_11_15(l_11_16)
			l_11_13.section_change_pos = l_11_15
			l_11_15 = assert
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_11_15(l_11_16)
			l_11_15 = assert
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_11_15(l_11_16)
			l_11_15 = assert
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_11_15(l_11_16)
			l_11_15 = assert
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_11_15(l_11_16)
			l_11_15 = assert
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_11_15(l_11_16)
			return l_11_13
		end
	end
	error(string.format("could not find start transition for mode '%s'", mode_name))
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Song.get_default_start_node = function(l_12_0, l_12_1)
	local l_12_2 = l_12_0:_name2mode(l_12_0, l_12_1)
	return l_12_2:parameter("start_node")
end

Song.get_stop_rule = function(l_13_0)
	-- upvalues: l_0_2
	return l_0_2
end

Song.get_use_fadeout_to_stop_mode = function(l_14_0, l_14_1)
	local l_14_5, l_14_6, l_14_7, l_14_11, l_14_12, l_14_13 = nil
	for i_0 in l_14_0._playhead_control:children() do
		if i_0:name() == "song_stop_fadeout" then
			for i_0 in i_0:children() do
				if i_0:parameter("mode") == l_14_1 then
					local l_14_16, l_14_17, l_14_18 = assert, tonumber(i_0:parameter("mode_stop_fadeout")), .end
					return l_14_16(l_14_17, l_14_18)
				end
			end
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Song._name2node = function(l_15_0, l_15_1)
	local l_15_5, l_15_6 = nil
	for i_0 in l_15_0._nodes:children() do
		if i_0:parameter("name") == l_15_1 then
			return i_0
		end
	end
	error(string.format("Could not find node '%s' in song '%s'", l_15_1, l_15_0._song_name))
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Song._name2mode = function(l_16_0, l_16_1)
	local l_16_5, l_16_6 = nil
	for i_0 in l_16_0._modes:children() do
		if i_0:parameter("name") == l_16_1 then
			return i_0
		end
	end
	error(string.format("Could not find mode '%s' in song '%s'", l_16_1, l_16_0._song_name))
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


