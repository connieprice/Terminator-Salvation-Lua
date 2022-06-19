core:module("CoreModePlayHead")
core:require_module("CoreSoundPlayHead")
core:require_module("CoreSong")
core:require_module("CoreClass")
if not ModePlayHead then
	ModePlayHead = CoreClass.class()
end
local l_0_0 = 0
local l_0_1 = 1
local l_0_2 = 2
local l_0_3 = 3
local l_0_4 = 4
local l_0_5 = 0
local l_0_6 = 1
local l_0_7 = 2
ModePlayHead.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	-- upvalues: l_0_0 , l_0_5
	l_1_0._song = l_1_1
	l_1_0._mode_name = l_1_2
	l_1_0._time_ctrl = l_1_3
	l_1_0._stopped_cb = l_1_4
	l_1_0._state1 = l_0_0
	l_1_0._rule = "default"
	l_1_0._playhead1 = nil
	l_1_0._playhead2 = nil
	l_1_0._next_node = nil
	l_1_0._state2 = l_0_5
	l_1_0._master_volume = 1
	l_1_0._volume = 0
	l_1_0._slope = 1
end

ModePlayHead.update = function(l_2_0, l_2_1, l_2_2)
	-- upvalues: l_0_0 , l_0_1 , l_0_3 , l_0_7 , l_0_2 , l_0_4 , l_0_5 , l_0_6
	if l_2_0._state1 == l_0_0 then
		do return end
	end
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_2_0._state1 == l_0_1 and l_2_0._playhead1:get_stop_time() < l_2_0._time_ctrl:time() then
		local l_2_3 = l_2_0._song:pick_transition(l_2_0._next_node, l_2_0._rule)
		if l_2_3.action == "fade_to_end" then
			l_2_0._playhead1:set_fadeout(l_2_3.wait_fadeout, l_2_3.fadeout)
			l_2_0._state1 = l_0_3
		end
	elseif l_2_3.action == "continue" then
		l_2_0._playhead1:continue_playing(l_2_3.new_stop_pos, l_2_3.new_section, l_2_3.new_section_change_pos)
		l_2_0._next_node = l_2_3.new_next_node
	elseif l_2_3.action == "crossfade" then
		l_2_0._playhead2 = l_2_0._playhead1
		l_2_0._playhead2:set_fadeout(l_2_3.wait_fadeout, l_2_3.fadeout)
		local l_2_4, l_2_5 = CoreSoundPlayHead.SoundPlayHead:new, CoreSoundPlayHead.SoundPlayHead
		local l_2_6 = l_2_3.soundbank_name
		local l_2_7 = l_2_3.sound_name
		local l_2_8 = l_2_3.bar_offset
		local l_2_9 = l_2_0._time_ctrl
		local l_2_10 = l_2_0._volume * l_2_0._master_volume
		l_2_4 = l_2_4(l_2_5, l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_0._state2 == l_0_7)
		l_2_0._playhead1 = l_2_4
		l_2_4 = l_2_0._playhead1
		l_2_4, l_2_5 = l_2_4:play_synchronized, l_2_4
		l_2_6 = l_2_3.start_pos
		l_2_7 = l_2_3.stop_pos
		l_2_8 = l_2_0._playhead2
		l_2_8, l_2_9 = l_2_8:get_stop_time, l_2_8
		l_2_8 = l_2_8(l_2_9)
		l_2_9 = l_2_3.wait_fadein
		l_2_10 = l_2_3.fadein
		l_2_4(l_2_5, l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_3.new_section, l_2_3.section_change_pos)
		l_2_4 = l_2_3.new_mode
		l_2_0._mode_name = l_2_4
		l_2_4 = l_2_3.next_node
		l_2_0._next_node = l_2_4
		l_2_4 = l_0_2
		l_2_0._state1 = l_2_4
	else
		error("unknown transition action")
	end
	do return end
	if l_2_0._state1 == l_0_2 and l_2_0._playhead2:is_stopped() then
		l_2_0._playhead2 = nil
		l_2_0._state1 = l_0_1
	end
	do return end
	if l_2_0._state1 == l_0_3 then
		local l_2_13 = l_2_0._playhead1:is_stopped()
		if l_2_0._playhead2 then
			local l_2_14 = not not l_2_0._playhead2:is_stopped()
			l_2_14 = l_2_14
			do
				local l_2_15, l_2_16, l_2_17 = nil
			end
			if l_2_13 and l_2_14 then
				l_2_0._stopped_cb(l_2_0)
				l_2_0._playhead1 = nil
				l_2_0._playhead2 = nil
				l_2_0._state1 = l_0_4
				l_2_0._state2 = l_0_5
			end
		else
			l_2_13 = l_2_0._state1
		if l_2_13 == l_0_4 then
			end
		end
		l_2_13 = l_2_0._state2
		if l_2_13 == l_0_5 then
			do return end
		end
		l_2_13 = l_2_0._state2
		if l_2_13 == l_0_6 then
			l_2_13 = l_2_0._time_ctrl
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_2_0._start_fade_time < l_2_13 then
				l_2_0._volume = l_2_13
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_2_13 then
					l_2_13(l_2_13, l_2_0._volume * l_2_0._master_volume)
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_2_13 then
					l_2_13(l_2_13, l_2_0._volume * l_2_0._master_volume)
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

			if l_2_13 == 1 then
				end
				l_2_0._state2 = l_2_13
			end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		else
			if l_2_13 == l_0_7 and l_2_0._start_fade_time < l_2_13 then
				l_2_0._volume = l_2_13
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_2_13 then
					l_2_13(l_2_13, l_2_0._volume * l_2_0._master_volume)
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_2_13 then
					l_2_13(l_2_13, l_2_0._volume * l_2_0._master_volume)
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

			if l_2_13 == 0 then
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_2_13 then
					l_2_13(l_2_13)
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_2_13 then
					l_2_13(l_2_13)
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_2_0._state1 = l_2_13
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_2_0._state2 = l_2_13
			end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_2_18 = nil
		l_2_18 = l_2_0._playhead1
		if l_2_18 then
			l_2_18 = l_2_0._playhead1
			l_2_18(l_2_18, l_2_1, l_2_2, l_2_13)
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_2_18 then
			l_2_18(l_2_18, l_2_1, l_2_2, l_2_13)
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 127 
end

ModePlayHead.play = function(l_3_0, l_3_1)
	-- upvalues: l_0_0 , l_0_5 , l_0_6 , l_0_1
	if l_3_0._state1 == l_0_0 then
		if l_3_1 == 0 then
			l_3_0._volume = l_3_0._master_volume
			l_3_0._state2 = l_0_5
		else
			l_3_0._volume = 0
			l_3_0._start_fade_time = l_3_0._time_ctrl:time()
			l_3_0._slope = 1 / math.max(l_3_1, 0.01)
			l_3_0._state2 = l_0_6
		end
		local l_3_2 = l_3_0._song:get_default_start_node(l_3_0._mode_name)
		local l_3_3 = l_3_0._song:pick_start_transition(l_3_2)
		l_3_0._playhead1 = CoreSoundPlayHead.SoundPlayHead:new(l_3_3.soundbank_name, l_3_3.sound_name, l_3_3.bar_offset, l_3_0._time_ctrl, l_3_0._volume * l_3_0._master_volume, false)
		l_3_0._playhead1:play(l_3_3.start_pos, l_3_3.stop_pos, l_3_3.fadein, l_3_3.new_section, l_3_3.section_change_pos)
		l_3_0._mode_name = l_3_3.new_mode
		l_3_0._next_node = l_3_3.next_node
		l_3_0._state1 = l_0_1
	else
		error("Can only play fresh ModePlayHead")
	end
end

ModePlayHead.play_synchronized = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5, l_4_6)
	-- upvalues: l_0_0 , l_0_6 , l_0_1
	if l_4_0._state1 == l_0_0 then
		local l_4_7 = l_4_0._song:pick_start_transition(l_4_1)
		l_4_0._volume = 0
		l_4_0._start_fade_time = l_4_0._time_ctrl:time() + l_4_5
		l_4_0._slope = 1 / math.max(l_4_6, 0.01)
		l_4_0._state2 = l_0_6
		local l_4_8 = l_4_0._time_ctrl:time() - l_4_2
		local l_4_9 = l_4_0._song:get_mode(l_4_0._mode_name)
		local l_4_10 = tonumber(l_4_9.time_signature) * 60 / tonumber(l_4_9.bpm)
		local l_4_11 = l_4_7.start_pos + (l_4_3 - l_4_8)
		local l_4_12 = (l_4_11 - l_4_7.bar_offset) % l_4_10 / l_4_10
		local l_4_13 = l_4_4 - l_4_12
		local l_4_14 = (l_4_13 + CoreSong.ENGINE_WAIT / 2 / l_4_10) % 1 - CoreSong.ENGINE_WAIT / 2 / l_4_10
		local l_4_15 = l_4_14 * l_4_10
		l_4_0._playhead1 = CoreSoundPlayHead.SoundPlayHead:new(l_4_7.soundbank_name, l_4_7.sound_name, l_4_7.bar_offset, l_4_0._time_ctrl, l_4_0._volume * l_4_0._master_volume, false)
		l_4_0._playhead1:play_synchronized(l_4_7.start_pos, l_4_7.stop_pos, l_4_8 - l_4_15, l_4_7.wait_fadein, l_4_7.fadein, l_4_7.new_section, l_4_7.section_change_pos)
		l_4_0._mode_name = l_4_7.new_mode
		l_4_0._next_node = l_4_7.next_node
		l_4_0._state1 = l_0_1
	else
		error("Can only play fresh ModePlayHead")
	end
end

ModePlayHead.stop_nice = function(l_5_0)
	-- upvalues: l_0_0 , l_0_4 , l_0_1 , l_0_2 , l_0_3
	if l_5_0._state1 == l_0_0 then
		l_5_0._stopped_cb(l_5_0)
		l_5_0._state1 = l_0_4
	else
		if l_5_0._state1 == l_0_1 then
			local l_5_1 = l_5_0._song:get_use_fadeout_to_stop_mode(l_5_0._mode_name)
			if l_5_1 then
				l_5_0:stop_with_fadeout(0, l_5_1)
			end
		else
			l_5_0._rule = l_5_0._song:get_stop_rule()
		end
	else
		if l_5_0._state1 == l_0_2 then
			local l_5_2 = l_5_0._song:get_use_fadeout_to_stop_mode(l_5_0._mode_name)
			if l_5_2 then
				l_5_0:stop_with_fadeout(0, l_5_2)
			end
		else
			l_5_0._rule = l_5_0._song:get_stop_rule()
		end
	else
		if l_5_0._state1 == l_0_3 then
			do return end
		end
	end
	if l_5_0._state1 == l_0_4 then
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 60 
end

ModePlayHead.stop_with_fadeout = function(l_6_0, l_6_1, l_6_2)
	-- upvalues: l_0_0 , l_0_4 , l_0_7
	if l_6_0._state1 == l_0_0 then
		l_6_0._stopped_cb(l_6_0)
		l_6_0._state1 = l_0_4
	else
		if l_6_0._state1 == l_0_4 then
			do return end
		end
	end
	l_6_0._start_fade_time = l_6_0._time_ctrl:time() + l_6_1
	l_6_0._slope = math.min(-1 / math.max(l_6_2, 0.01), l_6_0._slope)
	l_6_0._state2 = l_0_7
end

ModePlayHead.set_rule = function(l_7_0, l_7_1)
	l_7_0._rule = l_7_1
end

ModePlayHead.set_master_volume = function(l_8_0, l_8_1)
	l_8_0._master_volume = l_8_1
	if l_8_0._playhead1 then
		l_8_0._playhead1:set_master_volume(l_8_0._volume * l_8_0._master_volume)
	end
	if l_8_0._playhead2 then
		l_8_0._playhead2:set_master_volume(l_8_0._volume * l_8_0._master_volume)
	end
end

ModePlayHead.get_mode = function(l_9_0)
	return l_9_0._mode_name
end

ModePlayHead.get_section_info = function(l_10_0)
	-- upvalues: l_0_1 , l_0_2 , l_0_3
	if l_10_0._state1 == l_0_1 or l_10_0._state1 == l_0_2 or l_10_0._state1 == l_0_3 then
		local l_10_1 = l_10_0._playhead1:get_section_info()
		if l_10_0._playhead1 < 0 and l_10_0.playhead2 then
			local l_10_2 = R2_PC24
			l_10_1 = l_10_0._playhead2:get_section_info()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_10_3 = math.max(0, l_10_2)
		local l_10_4 = {}
		l_10_4.section = l_10_1
		l_10_4.time_since_jump = l_10_3
		return l_10_4
	else
		error("ModePlayHead:get_section_info() called in wrong state, contact core team...")
	end
end

ModePlayHead.get_timing_info = function(l_11_0, l_11_1)
	-- upvalues: l_0_1 , l_0_2 , l_0_3
	if l_11_0._state1 == l_0_1 or l_11_0._state1 == l_0_2 or l_11_0._state1 == l_0_3 then
		local l_11_2 = l_11_0._playhead1:get_timing_info()
		local l_11_3 = l_11_0._song:get_mode(l_11_0._mode_name)
		local l_11_4 = l_11_3.time_signature * 60 / l_11_3.bpm
		local l_11_5 = l_11_2.start_pos + (l_11_1 - l_11_2.start_time)
		local l_11_6 = (l_11_5 - l_11_2.bar_offset) / l_11_4 % 1
		local l_11_7 = {}
		l_11_7.mode_name = l_11_0._mode_name
		l_11_7.bpm = l_11_3.bpm
		l_11_7.time_signature = l_11_3.time_signature
		l_11_7.bar_pos = l_11_6
		l_11_7.bar_len = l_11_4
		return l_11_7
	else
		error("ModePlayHead:get_now_playing() called in wrong state, contact core team...")
	end
end

ModePlayHead.is_playing = function(l_12_0)
	-- upvalues: l_0_1 , l_0_2 , l_0_3
	if l_12_0._state1 == l_0_1 or l_12_0._state1 == l_0_2 or l_12_0._state1 == l_0_3 then
		return true
	else
		return false
	end
end


