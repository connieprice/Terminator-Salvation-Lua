if not CutsceneManager then
	CutsceneManager = class(CoreCutsceneManager)
end
CutsceneManager.SKIP_FADE_OUT_VIDEO_DURATION = 1
CutsceneManager.SKIP_FADE_IN_GAME_DURATION = 0.5
CutsceneManager.init = function(l_1_0)
	l_1_0.super.init(l_1_0)
	l_1_0:set_timer(TimerManager:main())
	l_1_0._callbacks = {}
	l_1_0._playing = false
	l_1_0._notify_list = {}
end

CutsceneManager.destroy = function(l_2_0)
	l_2_0.super.destroy(l_2_0)
end

CutsceneManager.paused_update = function(l_3_0)
	l_3_0.super.paused_update(l_3_0)
	local l_3_1 = l_3_0:timer():delta_time()
	if l_3_0:is_playing() then
		managers.subtitle:update(l_3_0:timer():time(), l_3_1)
	end
	if l_3_0._playing then
		l_3_0._time_played = l_3_0._time_played + l_3_1
	if l_3_0._time_played > 3 then
		end
		if l_3_0._time_fading_out ~= nil then
			l_3_0._time_fading_out = l_3_0._time_fading_out + l_3_1
			local l_3_2 = l_3_0:_video()
			if alive(l_3_2) then
				l_3_2:set_volume_gain(math.clamp(1 - l_3_0._time_fading_out / l_3_0.SKIP_FADE_OUT_VIDEO_DURATION, 0, 1))
			end
		if l_3_0.SKIP_FADE_OUT_VIDEO_DURATION < l_3_0._time_fading_out then
			end
			l_3_0:skip()
		end
	else
		if l_3_0:_user_wants_to_skip() then
			l_3_0._time_fading_out = 0
			local l_3_3, l_3_4 = l_3_0:play_overlay_effect, l_3_0
			local l_3_5 = {}
			l_3_5.blend_mode = "normal"
			l_3_5.color = Color.black
			l_3_5.fade_in = l_3_0.SKIP_FADE_OUT_VIDEO_DURATION
			l_3_5.sustain = 0.033333335
			l_3_5.fade_out = l_3_0.SKIP_FADE_IN_GAME_DURATION
			l_3_3(l_3_4, l_3_5)
		end
	end
end

CutsceneManager._on_playback_started = function(l_4_0, l_4_1)
	l_4_0._playing = true
	l_4_0._time_played = 0
	l_4_0._time_fading_out = nil
end

CutsceneManager.on_cutscene_exit = function(l_5_0)
	local l_5_4, l_5_5, l_5_6, l_5_7 = nil
	for i_0,i_1 in pairs(l_5_0._notify_list) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_5_0._callbacks[i_1] then
			l_5_0._callbacks[i_1]:movie_played()
		end
	end
	l_5_0._notify_list = {}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CutsceneManager._on_playback_finished = function(l_6_0, l_6_1)
	local l_6_2 = l_6_0._callbacks[l_6_1]
	if l_6_2 then
		table.insert(l_6_0._notify_list, l_6_1)
	end
	l_6_0._playing = false
	l_6_0._time_played = nil
	l_6_0._time_fading_out = nil
	l_6_0._movie_played_name = l_6_1
end

CutsceneManager._user_wants_to_skip = function(l_7_0)
	if not managers.menu_input:any_user_pressed(managers.local_user:users(), "skip_cutscene") then
		return managers.menu_input:any_user_pressed(managers.local_user:users(), "skip_cutscene2")
	end
end

CutsceneManager.add_callback_object = function(l_8_0, l_8_1)
	local l_8_2 = string.lower(l_8_1.movie_id)
	l_8_0._callbacks[l_8_2] = l_8_1
end

CutsceneManager.remove_callback_object = function(l_9_0, l_9_1)
	local l_9_2 = string.lower(l_9_1.movie_id)
	l_9_0._callbacks[l_9_2] = nil
end


