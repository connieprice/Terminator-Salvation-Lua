core:module("CoreMusicManager")
core:require_module("CoreMusicPlayer")
core:require_module("CoreClass")
core:require_module("CoreSong")
if not MusicManager then
	MusicManager = CoreClass.class()
end
MusicManager.USER_MUSIC_OVERRIDE_WAIT_FRAMES = 2
MusicManager.init = function(l_1_0)
	l_1_0._database = Database
	l_1_0._loadedsongs = {}
	l_1_0._defaultplayer = CoreMusicPlayer.MusicPlayer:new(l_1_0._database, l_1_0._loadedsongs)
	local l_1_1 = {}
	local l_1_2 = l_1_0._defaultplayer
	l_1_1[l_1_2] = l_1_0._defaultplayer
	l_1_0._players = l_1_1
	l_1_1 = setmetatable
	l_1_2 = l_1_0._players
	local l_1_3 = {}
	l_1_3.__mode = "kv"
	l_1_1(l_1_2, l_1_3)
end

MusicManager.update = function(l_2_0, l_2_1, l_2_2)
	local l_2_7, l_2_8 = nil
	local l_2_6 = l_2_0:_apply_user_music_override
	l_2_6(l_2_0, l_2_1, l_2_2)
	l_2_6 = pairs
	l_2_6 = l_2_6(l_2_0._players)
	for i_0,i_1 in l_2_6 do
		i_1:update(l_2_1, l_2_2)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MusicManager.paused_update = function(l_3_0, l_3_1, l_3_2)
	l_3_0:update(l_3_1, l_3_2)
end

MusicManager.destroy = function(l_4_0)
	Sound:override_music(false)
end

MusicManager.player = function(l_5_0)
	return l_5_0._defaultplayer
end

MusicManager.new_player = function(l_6_0)
	local l_6_1 = CoreMusicPlayer.MusicPlayer:new(l_6_0._database, l_6_0._loadedsongs)
	l_6_0._players[l_6_1] = l_6_1
	return l_6_1
end

MusicManager.preload_songs = function(l_7_0, ...)
	local l_7_4, l_7_5 = {}, ...
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_7_4 == 0 then
		for i_0,i_1 in l_7_4 do
			if l_7_0._loadedsongs[i_1] == nil then
				l_7_0._loadedsongs[i_1] = CoreSong.Song:new(i_1, l_7_0._database)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 12 
end

MusicManager.reload_songs = function(l_8_0, ...)
	local l_8_4, l_8_5 = {}, ...
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_8_4 == 0 then
		for i_0,i_1 in l_8_4 do
			l_8_0._loadedsongs[i_1] = CoreSong.Song:new(i_1, l_8_0._database)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 12 
end

MusicManager.get_songs = function(l_9_0)
	local l_9_1 = {}
	local l_9_5, l_9_6 = ipairs, l_9_0._database:all(false, "song")
	l_9_5 = l_9_5(l_9_6)
	for i_0,i_1 in l_9_5 do
		local l_9_7 = l_9_4:name()
		table.insert(l_9_1, l_9_7)
	end
	return l_9_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MusicManager.get_modes = function(l_10_0, l_10_1)
	if l_10_0._database:has("song", l_10_1) then
		local l_10_5 = CoreSong.Song:new
		l_10_5 = l_10_5(CoreSong.Song, l_10_1, l_10_0._database)
		local l_10_2 = nil
		local l_10_3, l_10_4 = l_10_5
		return l_10_2(l_10_3)
	else
		return {}
	end
end

MusicManager.save = function(l_11_0, l_11_1)
	local l_11_2 = l_11_0._defaultplayer:get_now_playing()
	if l_11_2 ~= nil then
		local l_11_3 = {}
		l_11_3.song_name = l_11_2.song_name
		l_11_3.mode_name = l_11_2.mode_name
		l_11_1.MusicManager = l_11_3
	else
		l_11_1.MusicManager = nil
	end
end

MusicManager.load = function(l_12_0, l_12_1)
	if l_12_1.MusicManager and l_12_1.MusicManager.mode_name and l_12_1.MusicManager.song_name then
		l_12_0._defaultplayer:play_now(l_12_1.MusicManager.song_name)
		l_12_0._defaultplayer:set_mode(l_12_1.MusicManager.mode_name)
	end
end

MusicManager.override_user_music = function(l_13_0, l_13_1)
	l_13_0._override_user_music_count = math.max(0, (l_13_0._override_user_music_count or 0) + (l_13_1 and 1 or -1))
end

MusicManager.is_overriding_user_music = function(l_14_0)
	return l_14_0._override_user_music_count or 0 > 0
end

MusicManager._apply_user_music_override = function(l_15_0, l_15_1, l_15_2)
	if l_15_0:is_overriding_user_music() then
		l_15_0._user_music_override_wait_frames = nil
	else
		l_15_0._user_music_override_wait_frames = math.max((l_15_0._user_music_override_wait_frames or -1) + 1, l_15_0.USER_MUSIC_OVERRIDE_WAIT_FRAMES)
	end
	Sound:override_music(l_15_0._user_music_override_wait_frames or 0 < l_15_0.USER_MUSIC_OVERRIDE_WAIT_FRAMES)
end


