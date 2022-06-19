core:module("CoreMusicPlayer")
core:require_module("CoreSong")
core:require_module("CoreModePlayHead")
core:require_module("CoreMusicTimeControl")
core:require_module("CoreClass")
core:require_module("CoreEvent")
core:require_module("CoreDebug")
PRIORITY_GAMEPLAY_NORMAL = 1
PRIORITY_LVLDESIGN_NORMAL = 2
PRIORITY_GAMEPLAY_HIGH = 3
PRIORITY_LVLDESIGN_HIGH = 4
local l_0_0 = 1
if not MusicPlayer then
	MusicPlayer = CoreClass.class()
end
local l_0_1 = 0
local l_0_2 = 1
local l_0_3 = 2
local l_0_4 = 3
local l_0_5 = 0
local l_0_6 = 0
local l_0_7 = 0
MusicPlayer.init = function(l_1_0, l_1_1, l_1_2)
	-- upvalues: l_0_1 , l_0_0
	l_1_0._state = l_0_1
	l_1_0._song = nil
	l_1_0._next_song_name = nil
	l_1_0._mode_change_queue = {}
	l_1_0._next_song_mode = ""
	l_1_0._current_playhead = nil
	l_1_0._stopping_playheads = {}
	l_1_0._sub_mode_playheads = {}
	l_1_0._sub_mode_mixer_cbs = {}
	l_1_0._database = l_1_1
	l_1_0._loadedsongs = l_1_2
	l_1_0._time_ctrl = CoreMusicTimeControl.MusicTimeControl:new()
	l_1_0._stopped_cb = CoreEvent.callback(l_1_0, l_1_0, "_playhead_stopped_cb")
	l_1_0._debugnum = l_0_0
	l_0_0 = l_0_0 + 1
end

MusicPlayer.update = function(l_2_0, l_2_1, l_2_2)
	-- upvalues: l_0_2
	if l_2_0._state == l_0_2 then
		local l_2_3 = table.maxn(l_2_0._mode_change_queue)
	if l_2_3 > 0 then
		end
	if l_2_0._current_playhead:get_mode() == l_2_0._mode_change_queue[l_2_3] then
		end
		l_2_0._next_song_mode = l_2_0._mode_change_queue[l_2_3]
		l_2_0._mode_change_queue[l_2_3] = nil
		local l_2_4 = table.maxn(l_2_0._mode_change_queue)
	if l_2_4 > 0 then
		end
		local l_2_9, l_2_11, l_2_13, l_2_15 = l_2_0:_request_mode_change, l_2_0, l_2_0._mode_change_queue[l_2_4]
		l_2_9(l_2_11, l_2_13)
	end
	if l_2_0._current_playhead ~= nil then
		local l_2_8, l_2_10, l_2_12, l_2_14 = l_2_0._current_playhead:update, l_2_0._current_playhead, l_2_1, l_2_2
		l_2_8(l_2_10, l_2_12, l_2_14)
	end
	if l_2_0._state == l_0_2 then
		l_2_0:_update_sub_mode_mixing()
	end
	for i_0,i_1 in ipairs(l_2_0._sub_mode_playheads) do
		i_1:update(l_2_1, l_2_2)
	end
	for i_0,i_1 in ipairs(l_2_0._stopping_playheads) do
		i_1:update(l_2_1, l_2_2)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MusicPlayer.paused_update = function(l_3_0, l_3_1, l_3_2)
	l_3_0:update(l_3_1, l_3_2)
end

MusicPlayer.pause = function(l_4_0)
	l_4_0:_log("pause")
	if not l_4_0._time_ctrl:is_paused() then
		l_4_0._time_ctrl:pause()
	end
end

MusicPlayer.resume = function(l_5_0)
	l_5_0:_log("resume")
	if l_5_0._time_ctrl:is_paused() then
		l_5_0._time_ctrl:resume()
	end
end

MusicPlayer.set_pitch = function(l_6_0, l_6_1)
	l_6_0:_log("set_pitch", l_6_1)
	l_6_0._time_ctrl:set_pitch(l_6_1)
end

MusicPlayer.play_nice = function(l_7_0, l_7_1)
	-- upvalues: l_0_1 , l_0_5 , l_0_2 , l_0_4 , l_0_3
	local l_7_6, l_7_7, l_7_8, l_7_9 = nil
	local l_7_5 = l_7_0:_log
	l_7_5(l_7_0, "play_nice", l_7_1)
	l_7_5(l_7_0, l_7_1)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_5(l_7_0)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_7_5 == l_0_1 then
		l_7_5(l_7_0, l_7_1)
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_7_5(l_7_0, l_0_5)
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_7_0._state = l_7_5
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if l_7_5 == l_0_2 and l_7_1 ~= l_7_5 then
			l_7_5(l_7_5)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_7_5(l_7_0._stopping_playheads, l_7_0._current_playhead)
			l_7_0._current_playhead = nil
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			for i_0,i_1 in l_7_5 do
				i_1:stop_nice()
				table.insert(l_7_0._stopping_playheads, 1, i_1)
			end
			l_7_0._sub_mode_playheads = {}
			l_7_0._next_song_name = l_7_1
			l_7_0:_clear_mode_queue()
			l_7_0._state = l_0_4
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	do return end
	if l_7_0._state == l_0_3 then
		l_7_0._state = l_0_4
		l_7_0._next_song_name = l_7_1
	else
		if l_7_0._state == l_0_4 then
			l_7_0._next_song_name = l_7_1
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
end

MusicPlayer.play_now = function(l_8_0, l_8_1)
	-- upvalues: l_0_1 , l_0_5 , l_0_2 , l_0_6 , l_0_3 , l_0_4
	l_8_0:_log("play_now", l_8_1)
	l_8_0:_check_song(l_8_1)
	l_8_0:_stop_and_resume()
	if l_8_0._state == l_0_1 then
		l_8_0:_set_song(l_8_1)
		l_8_0:_play_song(l_0_5)
		l_8_0._state = l_0_2
	else
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if l_8_0._state == l_0_2 and l_8_1 ~= l_8_0._song:get_name() then
			l_8_0:_clear_mode_queue()
			local l_8_2 = l_8_0._song:get_song_change_fadeout(l_8_0._current_playhead:get_mode())
			l_8_0:_set_song(l_8_1)
			local l_8_7, l_8_8 = l_8_0._song:get_song_change_fadein, l_8_0._song
			l_8_7 = l_8_7(l_8_8, l_8_0:_get_start_song_mode())
			local l_8_3 = nil
			l_8_8 = table
			l_8_8 = l_8_8.insert
			l_8_3 = l_8_0._stopping_playheads
			l_8_8(l_8_3, l_8_0._current_playhead)
			l_8_8 = ipairs
			l_8_3 = l_8_0._sub_mode_playheads
			l_8_8 = l_8_8(l_8_3)
			for i_0,i_1 in l_8_8 do
				table.insert(l_8_0._stopping_playheads, 1, l_8_6)
			end
			l_8_0._sub_mode_playheads = {}
			for i_0,i_1 in ipairs(l_8_0._stopping_playheads) do
				i_1:stop_with_fadeout(l_0_6, l_8_2)
			end
			l_8_0:_play_song(l_8_7)
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	do return end
	l_8_2 = l_8_0._state
	l_8_7 = l_0_3
	if l_8_2 == l_8_7 then
		l_8_2 = l_8_0._stopping_playheads
		l_8_7 = table
		l_8_7 = l_8_7.maxn
		l_8_7 = l_8_7(l_8_0._stopping_playheads)
		l_8_2 = l_8_2[l_8_7]
		local l_8_9 = nil
		l_8_7 = l_8_0._song
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_8_10 = nil
		l_8_0:_set_song(l_8_1)
		do
			local l_8_15, l_8_16 = nil
			local l_8_11 = nil
			for l_8_9,l_8_10 in ipairs(l_8_0._stopping_playheads) do
				local l_8_12, l_8_13, l_8_14 = nil
				l_8_15(l_8_16, l_8_11, l_8_12)
			end
			l_8_0:_play_song(l_8_0._song:get_song_change_fadein(l_8_0:_get_start_song_mode()))
			l_8_0._state = l_0_2
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_8_2 = l_8_0._state
		 -- DECOMPILER ERROR: Overwrote pending register.

	if l_8_2 == l_8_7 then
		end
		l_8_2 = l_8_0._stopping_playheads
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_8_2 = l_8_2[l_8_7]
		local l_8_17 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_8_18 = l_8_15
		l_8_0:_set_song(l_8_1)
		do
			local l_8_23, l_8_24 = l_8_16, l_8_11
			local l_8_19 = l_8_12
			for i_0,l_8_17 in ipairs(l_8_0._stopping_playheads) do
				local l_8_20, l_8_21, l_8_22 = nil
				l_8_18(l_8_23, l_8_24, l_8_19)
			end
			l_8_0:_play_song(l_8_0._song:get_song_change_fadein(l_8_0:_get_start_song_mode()))
			l_8_0._state = l_0_2
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

MusicPlayer.stop_nice = function(l_9_0)
	-- upvalues: l_0_1 , l_0_2 , l_0_3 , l_0_4
	local l_9_4, l_9_5, l_9_6, l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_15, l_9_16, l_9_17, l_9_18, l_9_22, l_9_23, l_9_24, l_9_25 = nil
	l_9_0:_log("stop_nice")
	l_9_0:_stop_and_resume()
	if l_9_0._state == l_0_1 then
		do return end
	end
	if l_9_0._state == l_0_2 then
		l_9_0._current_playhead:stop_nice()
		table.insert(l_9_0._stopping_playheads, l_9_0._current_playhead)
		l_9_0._current_playhead = nil
		for i_0,i_1 in ipairs(l_9_0._sub_mode_playheads) do
			i_1:stop_nice()
			table.insert(l_9_0._stopping_playheads, 1, i_1)
		end
		l_9_0:_clear_mode_queue()
		l_9_0._sub_mode_playheads = {}
		l_9_0._state = l_0_3
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		if l_9_0._state == l_0_3 then
			for i_0,i_1 in ipairs(l_9_0._stopping_playheads) do
				l_9_14:stop_nice()
			end
		end
	else
		if l_9_0._state == l_0_4 then
			l_9_0._state = l_0_3
			for i_0,i_1 in ipairs(l_9_0._stopping_playheads) do
				l_9_21:stop_nice()
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
end

MusicPlayer.stop_now = function(l_10_0)
	-- upvalues: l_0_1 , l_0_2 , l_0_6 , l_0_7 , l_0_3 , l_0_4
	local l_10_4, l_10_5, l_10_6, l_10_7, l_10_8, l_10_9, l_10_10, l_10_11, l_10_15, l_10_16, l_10_17, l_10_18, l_10_22, l_10_23, l_10_24, l_10_25 = nil
	l_10_0:_log("stop_now")
	l_10_0:_stop_and_resume()
	if l_10_0._state == l_0_1 then
		do return end
	end
	if l_10_0._state == l_0_2 then
		table.insert(l_10_0._stopping_playheads, l_10_0._current_playhead)
		l_10_0._current_playhead = nil
		for i_0,i_1 in ipairs(l_10_0._sub_mode_playheads) do
			table.insert(l_10_0._stopping_playheads, 1, i_1)
		end
		l_10_0._sub_mode_playheads = {}
		for i_0,i_1 in ipairs(l_10_0._stopping_playheads) do
			i_1:stop_with_fadeout(l_0_6, l_0_7)
		end
		l_10_0:_clear_mode_queue()
		l_10_0._state = l_0_3
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		if l_10_0._state == l_0_3 then
			for i_0,i_1 in ipairs(l_10_0._stopping_playheads) do
				l_10_14:stop_with_fadeout(l_0_6, l_0_7)
			end
		end
	else
		if l_10_0._state == l_0_4 then
			l_10_0._state = l_0_3
			for i_0,i_1 in ipairs(l_10_0._stopping_playheads) do
				l_10_21:stop_with_fadeout(l_0_6, l_0_7)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
end

MusicPlayer.set_mode = function(l_11_0, l_11_1, l_11_2)
	-- upvalues: l_0_2
	l_11_0:_log("set_mode", l_11_1, l_11_2)
	local l_11_3 = assert
	l_11_3(type(l_11_1) == "string", "Parameter new_mode_name must be of type string")
	l_11_3 = assert
	l_11_3(not l_11_2 or (type(l_11_2) == "number" and l_11_2 > 0), "Parameter priority must be nil or of type number, and larger than one.")
	if not l_11_2 then
		l_11_2 = 1
	end
	l_11_3 = l_11_0._state
	if l_11_3 == l_0_2 then
		l_11_3 = l_11_0._song
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_11_3 then
			l_11_3[l_11_2] = l_11_1
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

		if l_11_2 == l_11_3 then
			end
			l_11_3(l_11_0, l_11_1)
		end
	else
		l_11_0._next_song_mode = l_11_1
	end
end

MusicPlayer.register_sub_mode_mixer_cb = function(l_12_0, l_12_1, l_12_2)
	-- upvalues: l_0_2
	l_12_0:_log("register_sub_mode_mixer_cb", l_12_1, "<callback>")
	l_12_0._sub_mode_mixer_cbs[l_12_1] = l_12_2
	if l_12_0._state == l_0_2 then
		l_12_0:_update_sub_mode_mixing()
	end
end

MusicPlayer.unregister_sub_mode_mixer_cb = function(l_13_0, l_13_1)
	-- upvalues: l_0_2 , l_0_6 , l_0_7
	local l_13_6, l_13_7, l_13_8, l_13_9 = nil
	local l_13_5 = l_13_0:_log
	l_13_5(l_13_0, "unregister_sub_mode_mixer_cb", l_13_1)
	l_13_5 = l_13_0._sub_mode_mixer_cbs
	l_13_5[l_13_1] = nil
	l_13_5 = l_13_0._state
	if l_13_5 == l_0_2 then
		l_13_5 = l_13_0._current_playhead
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

	if l_13_1 == l_13_5 then
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_13_5(l_13_5, 1)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0,i_1 in l_13_5 do
			i_1:stop_with_fadeout(l_0_6, l_0_7)
			table.insert(l_13_0._stopping_playheads, 1, i_1)
		end
		l_13_0._sub_mode_playheads = {}
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

MusicPlayer.get_songs = function(l_14_0)
	l_14_0:_log("get_songs")
	local l_14_1 = {}
	local l_14_5, l_14_6 = ipairs, l_14_0._database:all(false, "song")
	l_14_5 = l_14_5(l_14_6)
	for i_0,i_1 in l_14_5 do
		local l_14_7 = l_14_4:name()
		table.insert(l_14_1, l_14_7)
	end
	return l_14_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MusicPlayer.playing_song_has_mode = function(l_15_0, l_15_1)
	local l_15_5 = l_15_0:_log
	l_15_5(l_15_0, "playing_song_has_mode", l_15_1)
	l_15_5 = l_15_0._song
	if l_15_5 then
		l_15_5 = l_15_0._current_playhead
	if l_15_5 then
		end
		l_15_5 = l_15_0._current_playhead
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

	if l_15_5 then
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_15_2, l_15_3 = l_15_5
		l_15_3 = l_15_1
		do
			local l_15_4 = nil
			return l_15_5(l_15_2, l_15_3)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		return l_15_5
	end
end

MusicPlayer.get_now_playing = function(l_16_0)
	if l_16_0._song and l_16_0._current_playhead and l_16_0._current_playhead:is_playing() then
		local l_16_1 = l_16_0._time_ctrl:time()
		local l_16_2 = l_16_0._current_playhead:get_timing_info(l_16_1)
		l_16_2.song_name = l_16_0._song:get_name()
		l_16_2.sync_time = TimerManager:wall():time()
		l_16_2.pitch = l_16_0._time_ctrl:pitch()
		return l_16_2
	else
		return nil
	end
end

MusicPlayer._request_mode_change = function(l_17_0, l_17_1)
	-- upvalues: l_0_2 , l_0_6
	if l_17_0._state == l_0_2 and l_17_0._current_playhead:is_playing() and l_17_0._song:has_mode(l_17_1) then
		local l_17_2 = l_17_0._current_playhead:get_section_info()
		local l_17_3 = l_17_0._song:get_mode_change_crossfade(l_17_2.section, l_17_1)
		if l_17_3 then
			local l_17_4 = math.max(l_17_3.fadeout, l_17_3.fadein) + CoreSong.ENGINE_WAIT
			local l_17_5 = l_17_0._time_ctrl:time() + (l_17_4 - math.min(l_17_3.fadeout, l_17_3.fadein) / 2)
			local l_17_6 = (l_17_0._current_playhead:get_timing_info(l_17_5))
			local l_17_7, l_17_16 = nil
			l_17_16 = l_17_3.add_time
			if l_17_16 == "yes" then
				l_17_7 = l_17_2.time_since_jump
			else
				l_17_7 = 0
			end
			l_17_16 = l_17_0._current_playhead
			l_17_16(l_17_16, l_17_4 - l_17_3.fadeout, l_17_3.fadeout)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_17_16(l_17_0._stopping_playheads, l_17_0._current_playhead)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_17_0._current_playhead = l_17_16
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			local l_17_11 = l_17_16
			local l_17_12 = l_17_3.start_node
			l_17_16(l_17_11, l_17_12, l_17_7, l_17_5, l_17_6.bar_pos, l_17_4 - l_17_3.fadein, l_17_3.fadein)
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_17_11 = l_17_0._sub_mode_playheads
			 -- DECOMPILER ERROR: Overwrote pending register.

			for l_17_17,i_1 in l_17_16 do
				do
					local l_17_10, l_17_17 = nil
					l_17_10, l_17_17 = l_17_9:stop_with_fadeout, l_17_9
					l_17_10(l_17_17, l_0_6, l_17_3.fadeout)
					l_17_10 = table
					l_17_10 = l_17_10.insert
					l_17_17 = l_17_0._stopping_playheads
					l_17_10(l_17_17, 1, l_17_9)
				end
				l_17_0._sub_mode_playheads = {}
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	else
		l_17_4 = l_17_0._current_playhead
		l_17_4, l_17_5 = l_17_4:set_rule, l_17_4
		l_17_6 = l_17_1
		l_17_4(l_17_5, l_17_6)
		l_17_4 = ipairs
		l_17_5 = l_17_0._sub_mode_playheads
		l_17_4 = l_17_4(l_17_5)
		for l_17_7,i_1 in l_17_4 do
			local l_17_13, l_17_14, l_17_15 = nil
			error("not allowed to have sub-modes for a mode that jumps to other mode")
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

MusicPlayer._playhead_stopped_cb = function(l_18_0, l_18_1)
	-- upvalues: l_0_2 , l_0_6 , l_0_7 , l_0_1 , l_0_3 , l_0_4 , l_0_5
	local l_18_5, l_18_6, l_18_7, l_18_8, l_18_9, l_18_10, l_18_11, l_18_12, l_18_16, l_18_17, l_18_18, l_18_19, l_18_20, l_18_21, l_18_22, l_18_23, l_18_24, l_18_25, l_18_29, l_18_30, l_18_31, l_18_32, l_18_33, l_18_37, l_18_38, l_18_39, l_18_40, l_18_41 = nil
	if l_18_0._state == l_0_2 then
		if l_18_1 == l_18_0._current_playhead then
			l_18_0._current_playhead = nil
			for i_0,i_1 in ipairs(l_18_0._sub_mode_playheads) do
				i_1:stop_with_fadeout(l_0_6, l_0_7)
				table.insert(l_18_0._stopping_playheads, 1, i_1)
			end
			l_18_0._sub_mode_playheads = {}
			l_18_0:_clear_mode_queue()
			if #l_18_0._stopping_playheads == 0 then
				l_18_0._state = l_0_1
				l_18_0._song = nil
			else
				l_18_0._state = l_0_3
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		else
			for i_0,i_1 in ipairs(l_18_0._sub_mode_playheads) do
				do
					if l_18_15 == l_18_1 then
						table.remove(l_18_0._sub_mode_playheads, l_18_14)
					end
				end
				for i_0,i_1 in ipairs(l_18_0._stopping_playheads) do
					if i_1 == l_18_1 then
						table.remove(l_18_0._stopping_playheads, i_0)
					end
					 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

				end
			end
		end
	else
		if l_18_0._state == l_0_3 then
			for i_0,i_1 in ipairs(l_18_0._stopping_playheads) do
				if l_18_28 == l_18_1 then
					table.remove(l_18_0._stopping_playheads, l_18_27)
				end
			end
		if #l_18_0._stopping_playheads == 0 then
			end
			l_18_0._state = l_0_1
			l_18_0._song = nil
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	else
		if l_18_0._state == l_0_4 then
			for i_0,i_1 in ipairs(l_18_0._stopping_playheads) do
				do
					local l_18_35, l_18_36 = nil
					if l_18_34 == l_18_1 then
						l_18_35 = table
						l_18_35 = l_18_35.remove
						l_18_36 = l_18_0._stopping_playheads
						l_18_35(l_18_36, i_0)
					end
				end
			if #l_18_0._stopping_playheads == 0 then
				end
				l_18_0:_set_song(l_18_0._next_song_name)
				l_18_0:_play_song(l_0_5)
				l_18_0._state = l_0_2
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
end

MusicPlayer._check_song = function(l_19_0, l_19_1)
	if l_19_0._loadedsongs[l_19_1] == nil then
		Application:error(string.format("SONG NOT PRELOADED, in setup add: managers.music:preload_songs('%s')\n\t\t", l_19_1))
		l_19_0._loadedsongs[l_19_1] = CoreSong.Song:new(l_19_1, l_19_0._database)
	end
end

MusicPlayer._set_song = function(l_20_0, l_20_1)
	assert(l_20_0._loadedsongs[l_20_1])
	l_20_0._song = l_20_0._loadedsongs[l_20_1]
end

MusicPlayer._clear_mode_queue = function(l_21_0)
	local l_21_4, l_21_5 = nil
	for i_0,i_1 in pairs(l_21_0._mode_change_queue) do
		l_21_0._next_song_mode = i_1
		do return end
	end
	l_21_0._mode_change_queue = {}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MusicPlayer._get_start_song_mode = function(l_22_0)
	if l_22_0._song == nil then
		return l_22_0._next_song_mode
	else
		local l_22_3 = l_22_0._song:has_mode
		l_22_3 = l_22_3(l_22_0._song, l_22_0._next_song_mode)
		if l_22_3 then
			l_22_3 = l_22_0._next_song_mode
			return l_22_3
		end
	else
		l_22_3 = l_22_0._song
		local l_22_1, l_22_2 = l_22_3
		return l_22_3(l_22_1)
	end
end

MusicPlayer._play_song = function(l_23_0, l_23_1)
	l_23_0._current_playhead = CoreModePlayHead.ModePlayHead:new(l_23_0._song, l_23_0:_get_start_song_mode(), l_23_0._time_ctrl, l_23_0._stopped_cb)
	l_23_0._current_playhead:play(l_23_1)
	l_23_0:_update_sub_mode_mixing()
end

MusicPlayer._update_sub_mode_mixing = function(l_24_0)
	local l_24_7, l_24_8, l_24_9, l_24_10, l_24_11, l_24_13, l_24_14, l_24_15, l_24_16 = nil
	assert(l_24_0._current_playhead)
	local l_24_1 = l_24_0._current_playhead:get_mode()
	local l_24_2 = l_24_0._sub_mode_mixer_cbs[l_24_1]
	if l_24_2 then
		local l_24_3 = l_24_2()
		for i_0,i_1 in pairs(l_24_3) do
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_24_0._song:has_mode(i_0) then
				if not l_24_0:_find_sub_mode_ph(i_0) then
					l_24_0:_create_sub_mode_ph(i_0):set_master_volume(l_24_17)
				end
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 31 
end

MusicPlayer._find_sub_mode_ph = function(l_25_0, l_25_1)
	local l_25_5, l_25_6, l_25_7, l_25_8 = nil
	if l_25_1 == l_25_0._current_playhead:get_mode() then
		return l_25_0._current_playhead
	end
	for i_0,i_1 in ipairs(l_25_0._sub_mode_playheads) do
		if l_25_1 == i_1:get_mode() then
			return i_1
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MusicPlayer._create_sub_mode_ph = function(l_26_0, l_26_1)
	local l_26_2 = l_26_0._time_ctrl:time()
	local l_26_3 = l_26_0._current_playhead:get_timing_info(l_26_2)
	local l_26_4 = l_26_0._current_playhead:get_section_info()
	local l_26_5 = l_26_0._song:get_mode_change_crossfade(l_26_4.section, l_26_1)
	assert(l_26_5, string.format("sub-mode '%s' must have cross-fade path from mode '%s'", l_26_1, l_26_0._current_playhead:get_mode()))
	local l_26_6 = nil
	if l_26_5.add_time == "yes" then
		l_26_6 = l_26_4.time_since_jump
	else
		l_26_6 = 0
	end
	local l_26_7 = CoreModePlayHead.ModePlayHead:new(l_26_0._song, l_26_1, l_26_0._time_ctrl, l_26_0._stopped_cb)
	l_26_7:play_synchronized(l_26_5.start_node, l_26_6, l_26_2, l_26_3.bar_pos, 0, l_26_5.fadein)
	table.insert(l_26_0._sub_mode_playheads, l_26_7)
	return l_26_7
end

MusicPlayer._stop_and_resume = function(l_27_0)
	if l_27_0._time_ctrl:is_paused() then
		l_27_0._time_ctrl:resume()
		l_27_0:stop_now()
	end
end

MusicPlayer._log = function(l_28_0, l_28_1, l_28_2, l_28_3)
	if l_28_2 == nil then
		local l_28_4 = ""
	else
		if type(l_28_2) == "string" then
			do return end
		end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	do
		local l_28_5 = "'" .. l_28_2 .. "'"
	end
	local l_28_6 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_28_3 == nil then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if type(l_28_3) == "string" then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	CoreDebug.cat_print("debug", string.format("[MusicSystem] player%d:%s(%s%s)", l_28_0._debugnum, l_28_1, l_28_6, nil))
end


