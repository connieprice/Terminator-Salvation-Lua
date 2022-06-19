core:module("CoreSongExporter")
core:require_module("CoreSong")
core:require_module("CoreKeywordArguments")
core:require_module("CoreClass")
core:require_module("CoreEvent")
parse_kwargs = CoreKeywordArguments.parse_kwargs
if not SongExporter then
	SongExporter = CoreClass.class()
end
local l_0_0 = "3.0"
SongExporter.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._song_project = l_1_1
	l_1_0._database = l_1_2
	l_1_0._jump_nodes = {}
	l_1_0._target_nodes = {}
	l_1_0._start_nodes = {}
	local l_1_3, l_1_4 = TargetNode:new, TargetNode
	local l_1_5 = {}
	l_1_5.marker_name = "END_SONG"
	l_1_5.sample = 0
	local l_1_6 = {}
	l_1_6.name = ""
	l_1_5.clip = l_1_6
	l_1_5.mode = ""
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_4 = l_1_0._target_nodes
	l_1_4.END_SONG = l_1_3
end

SongExporter.export = function(l_2_0, l_2_1)
	local l_2_2 = l_2_0:_check_sounds()
	if #l_2_2 > 0 then
		return l_2_2
	end
	local l_2_3 = l_2_0:_create_target_nodes()
	if #l_2_3 > 0 then
		return l_2_3
	end
	l_2_0:_create_mode_default_start_nodes()
	l_2_0:_create_marker_based_start_nodes()
	local l_2_4 = l_2_0:_create_jump_nodes()
	if #l_2_4 > 0 then
		return l_2_4
	end
	local l_2_5 = l_2_0:_remove_unused_nodes()
	if #l_2_5 > 0 then
		return l_2_5
	end
	local l_2_6, l_2_7 = l_2_0:_create_core_song(l_2_1)
	if #l_2_6 > 0 then
		return l_2_6
	end
	l_2_0:_save_core_song(l_2_1, l_2_7)
end

SongExporter._check_sounds = function(l_3_0)
	local l_3_5, l_3_6, l_3_7, l_3_8, l_3_9 = nil
	local l_3_1 = {}
	for i_0 in l_3_0._song_project:get_clips() do
		if Sound:make_bank(i_0.soundbank, i_0.sound) == nil then
			local l_3_11 = nil
			table.insert(l_3_1, string.format("unable to create sound for '%s'/'%s', is it correctly defined in DB?", l_3_10.soundbank, l_3_10.sound))
		end
	end
	return l_3_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SongExporter._create_target_nodes = function(l_4_0)
	local l_4_5, l_4_6 = nil
	local l_4_1 = {}
	for i_0 in l_4_0._song_project:get_markers() do
		local l_4_8 = l_4_0._song_project:find_clip_calc_baroffset
		local l_4_9 = l_4_0._song_project
		l_4_8 = l_4_8(l_4_9, {clip_name = l_4_7.clip, mode_name = l_4_7.mode})
		table.insert(l_4_1, l_4_8)
		local l_4_10 = TargetNode:new
		local l_4_11 = TargetNode
		l_4_10 = l_4_10(l_4_11, {marker_name = l_4_7.name, sample = tonumber(l_4_7.sample), clip = l_4_9, mode = l_4_7.mode})
		l_4_11 = l_4_0._target_nodes
		l_4_11[l_4_7.name] = l_4_10
		l_4_11 = table
		l_4_11 = l_4_11.insert
		l_4_11(l_4_1, l_4_0:_check_target_node_position(l_4_10))
	end
	return l_4_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SongExporter._check_target_node_position = function(l_5_0, l_5_1)
	local l_5_2, l_5_3 = l_5_0._song_project:find_clip, l_5_0._song_project
	local l_5_4 = {}
	l_5_4.name = l_5_1.clip.name
	l_5_2 = l_5_2(l_5_3, l_5_4)
	l_5_3 = tonumber
	l_5_4 = l_5_2.stop
	l_5_3 = l_5_3(l_5_4)
	l_5_4 = tonumber
	l_5_4 = l_5_4(l_5_2.start)
	l_5_3 = l_5_3 - l_5_4
	l_5_4 = l_5_1.sample
	if l_5_3 < l_5_4 then
		l_5_4 = string
		l_5_4 = l_5_4.format
		l_5_4 = l_5_4("Marker outside of Clip: Mode='%s', Clip='%s', Marker='%s' ( %d > %d )", l_5_1.mode, l_5_1.clip.name, l_5_1.marker_name, l_5_1.sample, l_5_3)
		return l_5_4
	end
	l_5_4 = nil
	return l_5_4
end

SongExporter._create_mode_default_start_nodes = function(l_6_0)
	local l_6_4, l_6_5 = nil
	for i_0 in l_6_0._song_project:get_modes() do
		local l_6_7 = StartNode:new
		local l_6_8 = StartNode
		l_6_7 = l_6_7(l_6_8, {mode = l_6_6.name, name = l_6_6.name, song_project = l_6_0._song_project})
		l_6_8 = l_6_0._song_project
		local l_6_10 = l_6_8
		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0 in l_6_8 do
			local l_6_12 = l_6_7:add_start_target
			local l_6_13 = l_6_7
			l_6_12(l_6_13, {target_node = l_6_0._target_nodes[l_6_11.marker], weight = tonumber(l_6_11.weight), fade_in = tonumber(l_6_11.fade_in)})
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_6_8[l_6_6.name] = l_6_7
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SongExporter._create_marker_based_start_nodes = function(l_7_0)
	local l_7_4, l_7_5 = nil
	for i_0 in l_7_0._song_project:get_markers() do
		local l_7_7 = l_7_0._song_project:is_start_marker_for_section
		local l_7_8 = l_7_0._song_project
		l_7_7 = l_7_7(l_7_8, {marker_name = l_7_6.name})
		if l_7_7 then
			l_7_7 = l_7_0._song_project
			l_7_7, l_7_8 = l_7_7:get_allowed_crossfades, l_7_7
			local l_7_9 = {}
			l_7_9.marker_name = l_7_6.name
			l_7_7 = l_7_7(l_7_8, l_7_9)
			for i_0 in l_7_7 do
				local l_7_11 = l_7_0._song_project:find_marker
				local l_7_12 = l_7_0._song_project
				l_7_11 = l_7_11(l_7_12, {name = l_7_10.marker})
				l_7_12 = l_7_0._start_nodes
				l_7_12 = l_7_12[l_7_11.name]
				if l_7_12 == nil then
					l_7_12 = StartNode
					local l_7_13 = l_7_12
					 -- DECOMPILER ERROR: Overwrote pending register.

					local l_7_14 = l_7_12
					l_7_13(l_7_14, {target_node = l_7_0._target_nodes[l_7_11.name], weight = 1, fade_in = 0})
					 -- DECOMPILER ERROR: Overwrote pending register.

					l_7_14 = l_7_11.name
					l_7_13[l_7_14] = l_7_12
				end
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SongExporter._create_jump_nodes = function(l_8_0)
	local l_8_5, l_8_6 = nil
	local l_8_1 = {}
	for i_0 in l_8_0._song_project:get_markers() do
		local l_8_8 = l_8_0._song_project:find_clip_calc_baroffset
		local l_8_9 = l_8_0._song_project
		l_8_8 = l_8_8(l_8_9, {clip_name = l_8_7.clip, mode_name = l_8_7.mode})
		table.insert(l_8_1, l_8_8)
		local l_8_10 = JumpNode:new
		local l_8_11 = JumpNode
		l_8_10 = l_8_10(l_8_11, {marker_name = l_8_7.name, marker_sample = tonumber(l_8_7.sample), clip = l_8_9, mode = l_8_7.mode, song_project = l_8_0._song_project})
		l_8_11 = l_8_0._song_project
		local l_8_13 = l_8_11
		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0 in l_8_11 do
			local l_8_15 = l_8_10:add_rule
			local l_8_16 = l_8_10
			l_8_15(l_8_16, {rule = l_8_14.rule, weight = tonumber(l_8_14.weight), target_node = l_8_0._target_nodes[l_8_14.jump_to], fade_in = tonumber(l_8_14.fade_in), fade_out = tonumber(l_8_14.fade_out)})
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_8_11(l_8_10) then
			l_8_0._jump_nodes[l_8_7.name] = l_8_10
			table.insert(l_8_1, l_8_0:_check_overlap(l_8_10, l_8_0._target_nodes[l_8_7.name]))
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	return l_8_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SongExporter._check_overlap = function(l_9_0, l_9_1, l_9_2)
	local l_9_6, l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_12, l_9_13, l_9_14, l_9_15, l_9_16, l_9_17 = nil
	for i_0,i_1 in pairs(l_9_0._target_nodes) do
		if i_1.mode == l_9_1.mode and i_1.clip.name == l_9_1.clip.name and l_9_1.sample < i_1.sample and i_1.sample < l_9_2.sample then
			return string.format("Marker '%s' (at %d) is within the crossfade area in front of marker '%s' (at %d). Min dist=%d", i_1.marker_name, i_1.sample, l_9_2.marker_name, l_9_2.sample, l_9_1:get_transition_length())
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SongExporter._remove_unused_nodes = function(l_10_0)
	local l_10_6, l_10_7, l_10_8, l_10_9, l_10_13, l_10_14, l_10_15, l_10_16, l_10_17, l_10_18, l_10_19, l_10_20, l_10_21, l_10_22 = nil
	local l_10_1 = {}
	local l_10_2 = l_10_0._target_nodes.END_SONG
	l_10_2.touched = true
	for i_0,i_1 in pairs(l_10_0._start_nodes) do
		for i_0 in i_1:get_start_targets() do
			table.insert(l_10_1, l_10_0:_touch_nodes(i_0))
		end
	end
	for i_0,i_1 in pairs(l_10_0._jump_nodes) do
		if not i_1.touched then
			l_10_0._jump_nodes[i_0] = nil
		end
	end
	for i_0,i_1 in pairs(l_10_0._target_nodes) do
		if not i_1.touched then
			l_10_0._target_nodes[i_0] = nil
		end
	end
	return l_10_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SongExporter._touch_nodes = function(l_11_0, l_11_1)
	local l_11_7, l_11_8, l_11_9, l_11_10 = nil
	local l_11_2, l_11_3 = l_11_0:_find_next_jump_node(l_11_1)
	if l_11_2 then
		return l_11_2
	end
	l_11_3.touched = true
	for i_0 in l_11_3:get_targets() do
		if not i_0.touched then
			i_0.touched = true
			if l_11_0:_touch_nodes(i_0) then
				return l_11_0:_touch_nodes(i_0)
			end
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SongExporter._find_next_jump_node = function(l_12_0, l_12_1)
	local l_12_2, l_12_5, l_12_6 = nil
	for i_0,i_1 in pairs(l_12_0._jump_nodes) do
		l_12_2 = l_12_0:_pick_closest_to_target_node(l_12_1, i_1, l_12_2)
	end
	if l_12_2 then
		return nil, l_12_2
	else
		return string.format("Arrived at end of Clip without finding a Marker with jump-rules, started at Mode='%s', Clip='%s', Marker='%s' (%d).", l_12_1.mode, l_12_1.clip.name, l_12_1.marker_name, l_12_1.sample), nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

SongExporter._find_next_node = function(l_13_0, l_13_1)
	local l_13_2, l_13_5, l_13_6, l_13_7, l_13_8 = nil
	for i_0,i_1 in pairs(l_13_0._jump_nodes) do
		l_13_2 = l_13_0:_pick_closest_to_target_node(l_13_1, i_1, l_13_2)
	end
	for i_0,i_1 in pairs(l_13_0._target_nodes) do
		l_13_2 = l_13_0:_pick_closest_to_target_node(l_13_1, i_1, l_13_2)
	end
	assert(l_13_2)
	return l_13_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SongExporter._pick_closest_to_target_node = function(l_14_0, l_14_1, l_14_2, l_14_3)
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_14_2.mode == l_14_1.mode and l_14_2.clip.name == l_14_1.clip.name and l_14_1.sample < l_14_2.sample and l_14_3 and l_14_2.sample < l_14_3.sample then
		return l_14_2
	end
	do return end
	return l_14_2
	return l_14_3
end

SongExporter._create_core_song = function(l_15_0)
	-- upvalues: l_0_0
	local l_15_1 = Node.from_xml(string.format("<song xml_version=\"%s\"/>", l_0_0))
	local l_15_2 = Node.from_xml("<playhead_control/>")
	local l_15_3 = Node.from_xml("<modes/>")
	local l_15_4 = Node.from_xml("<nodes/>")
	l_15_0:_create_playhead_control(l_15_2)
	l_15_0:_create_modes(l_15_3)
	local l_15_5 = l_15_0:_create_nodes(l_15_4)
	l_15_1:add_child(l_15_2)
	l_15_1:add_child(l_15_3)
	l_15_1:add_child(l_15_4)
	return l_15_5, l_15_1
end

SongExporter._create_playhead_control = function(l_16_0, l_16_1)
	local l_16_2 = Node.from_xml("<song_change_crossfade/>")
	local l_16_3 = Node.from_xml("<song_stop_fadeout/>")
	local l_16_4 = Node.from_xml("<mode_change_crossfade_transitions/>")
	l_16_0:_create_song_change_crossfade(l_16_2)
	l_16_0:_create_song_stop_fadeout(l_16_3)
	l_16_0:_create_mode_change_crossfade_transitions(l_16_4)
	l_16_1:add_child(l_16_2)
	l_16_1:add_child(l_16_3)
	l_16_1:add_child(l_16_4)
end

SongExporter._create_song_change_crossfade = function(l_17_0, l_17_1)
	local l_17_5, l_17_6, l_17_7, l_17_8 = nil
	for i_0 in l_17_0._song_project:get_modes() do
		local l_17_10 = nil
		l_17_1:add_child(Node.from_xml(string.format("<song_change mode=\"%s\" mode_start_fadein=\"%7.5f\" mode_stop_fadeout=\"%7.5f\"/>", i_0.name, tonumber(i_0.song_change_fadein), tonumber(i_0.song_change_fadeout))))
	end
end

SongExporter._create_song_stop_fadeout = function(l_18_0, l_18_1)
	local l_18_5, l_18_6, l_18_7, l_18_8 = nil
	for i_0 in l_18_0._song_project:get_modes() do
		if i_0.use_fadeout_to_stop == "yes" then
			local l_18_10 = nil
			l_18_1:add_child(Node.from_xml(string.format("<use_stop_fadeout mode=\"%s\" mode_stop_fadeout=\"%7.5f\"/>", i_0.name, tonumber(i_0.mode_stop_fadeout))))
		end
	end
end

SongExporter._create_mode_change_crossfade_transitions = function(l_19_0, l_19_1)
	local l_19_5, l_19_6 = nil
	for i_0 in l_19_0._song_project:get_markers() do
		local l_19_8 = l_19_0._song_project:is_start_marker_for_section
		local l_19_9 = l_19_0._song_project
		l_19_8 = l_19_8(l_19_9, {marker_name = l_19_7.name})
		if l_19_8 then
			l_19_9 = l_19_0._song_project
			local l_19_11 = l_19_9
			 -- DECOMPILER ERROR: Overwrote pending register.

			for i_0 in l_19_9 do
				local l_19_13, l_19_16, l_19_17 = l_19_0._song_project:find_marker, l_19_0._song_project
				local l_19_14, l_19_18 = nil
				l_19_14 = l_19_12.marker
				l_19_13, l_19_17 = l_19_13(l_19_16, l_19_17), {name = l_19_14}
				l_19_16 = l_19_13.mode
				l_19_17, l_19_8 = l_19_8[l_19_16], {}
				if not l_19_17 then
					l_19_17 = 0
				end
				l_19_14 = l_19_12.weight
				l_19_17 = l_19_17 + l_19_14
				l_19_8[l_19_16] = l_19_17
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			for i_0,i_1 in pairs(l_19_8) do
				do
					local l_19_22 = nil
					local l_19_24 = Node.from_xml(string.format("<to_mode name=\"%s\"/>", i_0))
					for i_0 in l_19_0._song_project:get_allowed_crossfades({marker_name = l_19_7.name}) do
						if l_19_0._song_project:find_marker({name = l_19_27.marker}).mode == l_19_20 then
							if l_19_27.add_time == "since_jump" then
								do return end
							end
							l_19_24:add_child(rc)
						end
					end
					Node.from_xml(l_19_9.format("<from_section name=\"%s\"/>", l_19_7.name)):add_child(l_19_24)
					 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

				end
				l_19_1:add_child(Node.from_xml(l_19_9.format("<from_section name=\"%s\"/>", l_19_7.name)))
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SongExporter._create_modes = function(l_20_0, l_20_1)
	local l_20_5, l_20_6, l_20_7, l_20_8, l_20_9 = nil
	for i_0 in l_20_0._song_project:get_modes() do
		local l_20_11 = nil
		local l_20_12 = nil
		l_20_1:add_child(Node.from_xml(string.format("<mode name=\"%s\" bpm=\"%s\" time_signature=\"%s\" start_node=\"%s\" end_node=\"END_SONG\"/>", l_20_10.name, l_20_10.mode_bpm, l_20_10.mode_time_signature, l_20_0._start_nodes[i_0.name]:get_name())))
	end
	return cause_list
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SongExporter._create_nodes = function(l_21_0, l_21_1)
	local l_21_6, l_21_7, l_21_8, l_21_9, l_21_12, l_21_13, l_21_14, l_21_15 = nil
	local l_21_2 = {}
	for i_0,i_1 in pairs(l_21_0._start_nodes) do
		table.insert(l_21_2, i_1:create_final_node(CoreEvent.callback(l_21_0, l_21_0, "_find_next_jump_node")))
		l_21_1:add_child(R12_PC20)
	end
	for i_0,i_1 in pairs(l_21_0._jump_nodes) do
		 -- DECOMPILER ERROR: Overwrote pending register.

		table.insert(l_21_2, R12_PC20)
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_21_1:add_child(R12_PC20)
	end
	return l_21_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SongExporter._save_core_song = function(l_22_0, l_22_1, l_22_2)
	l_22_0._database:save_node(l_22_2, l_22_1)
	l_22_0._database:save()
end

if not TargetNode then
	TargetNode = CoreClass.class()
end
TargetNode.init = function(l_23_0, ...)
	l_23_0.marker_name = CoreKeywordArguments.KeywordArguments:new(...):mandatory_string("marker_name")
	l_23_0.sample = CoreKeywordArguments.KeywordArguments:new(...):mandatory_number("sample")
	l_23_0.mode = CoreKeywordArguments.KeywordArguments:new(...):mandatory_string("mode")
	l_23_0.clip = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("clip")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
end

TargetNode.is_end_node = function(l_24_0)
	return l_24_0.marker_name == "END_SONG"
end

if not JumpNode then
	JumpNode = CoreClass.class()
end
JumpNode.init = function(l_25_0, ...)
	l_25_0.marker_name = CoreKeywordArguments.KeywordArguments:new(...):mandatory_string("marker_name")
	l_25_0.marker_sample = CoreKeywordArguments.KeywordArguments:new(...):mandatory_number("marker_sample")
	l_25_0.mode = CoreKeywordArguments.KeywordArguments:new(...):mandatory_string("mode")
	l_25_0.clip = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("clip")
	l_25_0._song_project = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("song_project")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_25_0._rules = {}
	l_25_0._weights = {}
	l_25_0._target_nodes = {}
	l_25_0._fade_ins = {}
	l_25_0._fade_outs = {}
	l_25_0._rules2weightsums = {}
	l_25_0.sample = l_25_0.marker_sample - l_25_0:get_transition_length()
end

JumpNode.get_name = function(l_26_0)
	return l_26_0.marker_name
end

JumpNode.add_rule = function(l_27_0, ...)
	local l_27_2, l_27_3, l_27_4, l_27_5 = parse_kwargs({...}, "string:rule", "number:weight", "table:target_node", "number:fade_in", "number:fade_out")
	table.insert(l_27_0._rules, l_27_2)
	table.insert(l_27_0._weights, l_27_3)
	table.insert(l_27_0._target_nodes, l_27_4)
	table.insert(l_27_0._fade_ins, l_27_5)
	table.insert(l_27_0._fade_outs, R9_PC34)
	l_27_0._rules2weightsums[l_27_2] = (l_27_0._rules2weightsums[l_27_2] or 0) + l_27_3
	l_27_0.sample = l_27_0.marker_sample - l_27_0:get_transition_length()
end

JumpNode.get_transition_length = function(l_28_0)
	local l_28_5, l_28_6 = nil
	local l_28_1 = 0
	for i_0,i_1 in ipairs(l_28_0._rules) do
		l_28_1 = math.max(l_28_1, l_28_0._fade_ins[i_0], l_28_0._fade_outs[i_0])
	end
	return math.ceil(l_28_1 * 44100) + CoreSong.ENGINE_WAIT * 44100
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

JumpNode.has_rules = function(l_29_0)
	return #l_29_0._rules > 0
end

JumpNode.get_targets = function(l_30_0)
	return function()
		-- upvalues: l_30_1 , l_30_0
		l_30_1 = l_30_1 + 1
		return l_30_0._target_nodes[l_30_1]
  end
	 -- WARNING: undefined locals caused missing assignments!
end

JumpNode.create_final_node = function(l_31_0, l_31_1)
	local l_31_2 = nil
	local l_31_7, l_31_8 = l_31_0:get_transition_length(), Node.from_xml
	l_31_8 = l_31_8(string.format("<node name=\"%s\"/>", l_31_0:get_name()))
	local l_31_3 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_31_3 and l_31_3 == nil then
		l_31_2 = l_31_3
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0,i_1 in l_31_3 do
		if i_1 == 0 then
			l_31_2 = string.format("For marker '%s', at least one of the jump rules must have a weight <> 0.", l_31_0.marker_name)
			i_1 = 1
		end
		local l_31_14 = Node.from_xml
		l_31_14 = l_31_14(string.format("<rule name=\"%s\"/>", l_31_6))
		local l_31_9 = nil
		l_31_9 = ipairs
		l_31_9 = l_31_9(l_31_0._rules)
		for i_0,i_1 in l_31_9 do
			if i_1 == l_31_6 then
				local l_31_16 = "<random_transition "
				if l_31_0._target_nodes[l_31_12]:is_end_node() then
					local l_31_17 = nil
					do
						local l_31_18 = nil
						 -- DECOMPILER ERROR: Overwrote pending register.

						 -- DECOMPILER ERROR: Overwrote pending register.

						 -- DECOMPILER ERROR: Overwrote pending register.

				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				else
					if l_31_17.marker_name == l_31_0.marker_name and l_31_0._fade_ins[l_31_12] == l_31_0._fade_outs[l_31_12] then
						local l_31_19, l_31_20 = , l_31_1(l_31_17)
						local l_31_21 = nil
						local l_31_22 = (tonumber(l_31_19.clip.start) + l_31_17.sample) / 44100
						local l_31_23, l_31_24 = (tonumber(l_31_19.clip.start) + l_31_19.sample) / 44100, l_31_0._song_project:find_first_marker_in_section
						local l_31_25 = l_31_0._song_project
						l_31_24 = l_31_24(l_31_25, {marker_name = l_31_19.marker_name})
						if l_31_24 == nil then
							l_31_25 = string
							l_31_25 = l_31_25.format
							l_31_25 = l_31_25("Marker '%s' is not within a section.", l_31_0.marker_name)
							l_31_2 = l_31_25
						end
					else
						l_31_25 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_25 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_25 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_25 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_25 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_25 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

					end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				else
					local l_31_26, l_31_27 = , l_31_1(l_31_19)
					local l_31_28 = nil
					local l_31_29 = (tonumber(l_31_26.clip.start) + l_31_26.sample - l_31_7) / 44100
					local l_31_30 = (tonumber(l_31_26.clip.start) + l_31_28.sample) / 44100
					local l_31_31 = (tonumber(l_31_26.clip.start) + l_31_26.sample) / 44100
					local l_31_32 = nil
					local l_31_33 = l_31_7 / 44100 - l_31_0._fade_ins[l_31_12]
					local l_31_34 = nil
					if l_31_29 < 0 then
						local l_31_35, l_31_36 = l_31_7 / 44100 - l_31_0._fade_outs[l_31_12], l_31_0._song_project:find_first_marker_in_section
						local l_31_37 = l_31_0._song_project
						l_31_36 = l_31_36(l_31_37, {marker_name = l_31_26.marker_name})
						if l_31_36 == nil then
							l_31_37 = string
							l_31_37 = l_31_37.format
							l_31_37 = l_31_37("Marker '%s' is not within a section.", l_31_0.marker_name)
							 -- DECOMPILER ERROR: Overwrote pending register.

						end
					else
						l_31_37 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_37 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_37 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_37 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_37 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_37 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_37 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_37 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_37 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_37 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_37 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_37 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_37 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_37 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_31_37 = l_31_16
						 -- DECOMPILER ERROR: Overwrote pending register.

					end
					 -- DECOMPILER ERROR: Overwrote pending register.

					local l_31_38 = nil
					l_31_14:add_child(Node.from_xml(l_31_16))
				end
			end
			l_31_8:add_child(l_31_14)
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		return l_31_3, l_31_8
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 235 
end

if not StartNode then
	StartNode = CoreClass.class()
end
StartNode.init = function(l_32_0, ...)
	l_32_0.mode = CoreKeywordArguments.KeywordArguments:new(...):mandatory_string("mode")
	l_32_0.name = CoreKeywordArguments.KeywordArguments:new(...):mandatory_string("name")
	l_32_0._song_project = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("song_project")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_32_0._start_target_nodes = {}
	l_32_0._weights = {}
	l_32_0._fade_ins = {}
	l_32_0._weight_sum = 0
end

StartNode.get_name = function(l_33_0)
	return "__START_" .. l_33_0.name .. "__"
end

StartNode.add_start_target = function(l_34_0, ...)
	local l_34_2, l_34_3 = parse_kwargs({...}, "table:target_node", "number:weight", "number:fade_in")
	table.insert(l_34_0._start_target_nodes, l_34_2)
	table.insert(l_34_0._weights, l_34_3)
	table.insert(l_34_0._fade_ins, R7_PC22)
	l_34_0._weight_sum = l_34_0._weight_sum + l_34_3
end

StartNode.get_start_targets = function(l_35_0)
	return function()
		-- upvalues: l_35_1 , l_35_0
		l_35_1 = l_35_1 + 1
		return l_35_0._start_target_nodes[l_35_1]
  end
	 -- WARNING: undefined locals caused missing assignments!
end

StartNode.create_final_node = function(l_36_0, l_36_1)
	local l_36_2, l_36_6, l_36_7, l_36_8, l_36_9, l_36_10, l_36_11, l_36_12, l_36_13, l_36_14, l_36_15, l_36_16, l_36_17, l_36_18, l_36_19, l_36_20, l_36_21, l_36_22 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_36_0._weight_sum ~= 0 or #l_36_0._start_target_nodes == 0 then
		for i_0,i_1 in pairs(l_36_0._start_target_nodes) do
			local l_36_3 = Node.from_xml("<rule name=\"default\"/>")
			local l_36_26 = l_36_1(i_1)
			local l_36_27 = nil
			local l_36_28 = nil
			local l_36_29 = 0
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Overwrote pending register.

			if (tonumber(l_36_25.clip.start) + l_36_25.sample) / 44100 - l_36_0._fade_ins[l_36_24] < 0 then
				local l_36_30, l_36_31 = , (tonumber(l_36_25.clip.start) + l_36_27.sample) / 44100
				local l_36_32 = (tonumber(l_36_25.clip.start) + l_36_25.sample) / 44100
				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_36_0._song_project:find_first_marker_in_section({marker_name = l_36_25.marker_name}) == nil then
					do return end
				end
				l_36_3:add_child(Node.from_xml("<random_transition " .. string.format("probability=\"%7.5f\" ", l_36_0._weights[l_36_24] / l_36_0._weight_sum) .. string.format("soundbank_name=\"%s\" ", l_36_25.clip.soundbank) .. string.format("sound_name=\"%s\" ", l_36_25.clip.sound) .. string.format("bar_offset=\"%7.5f\" ", tonumber(l_36_25.clip.bar_offset)) .. string.format("start_pos=\"%7.5f\" ", l_36_30) .. string.format("stop_pos=\"%7.5f\" ", l_36_31) .. string.format("wait_fadein=\"%7.5f\" ", l_36_29) .. string.format("fadein=\"%7.5f\" ", l_36_28) .. string.format("new_mode=\"%s\" ", l_36_25.mode) .. string.format("new_section=\"%s\" ", l_36_0._song_project:find_first_marker_in_section({marker_name = l_36_25.marker_name}).name) .. string.format("section_change_pos=\"%7.5f\" ", l_36_32) .. string.format("next_node=\"%s\" ", l_36_27:get_name()) .. "/>"))
			end
			Node.from_xml(string.format("<node name=\"%s\"/>", l_36_0:get_name())):add_child(l_36_3)
			return l_36_2, Node.from_xml(string.format("<node name=\"%s\"/>", l_36_0:get_name()))
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 25 69 
end


