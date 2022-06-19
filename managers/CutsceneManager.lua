CutsceneManager = CutsceneManager or class(CoreCutsceneManager)
CutsceneManager.SKIP_FADE_OUT_VIDEO_DURATION = 1
CutsceneManager.SKIP_FADE_IN_GAME_DURATION = 0.5
function CutsceneManager.init(A0_0)
	A0_0.super.init(A0_0)
	A0_0:set_timer(TimerManager:main())
	A0_0._callbacks = {}
	A0_0._playing = false
	A0_0._notify_list = {}
end
function CutsceneManager.destroy(A0_1)
	A0_1.super.destroy(A0_1)
end
function CutsceneManager.paused_update(A0_2)
	local L1_3, L2_4
	L1_3 = A0_2.super
	L1_3 = L1_3.paused_update
	L2_4 = A0_2
	L1_3(L2_4)
	L2_4 = A0_2
	L1_3 = A0_2.timer
	L1_3 = L1_3(L2_4)
	L2_4 = L1_3
	L1_3 = L1_3.delta_time
	L1_3 = L1_3(L2_4)
	L2_4 = A0_2.is_playing
	L2_4 = L2_4(A0_2)
	if L2_4 then
		L2_4 = managers
		L2_4 = L2_4.subtitle
		L2_4 = L2_4.update
		L2_4(L2_4, A0_2:timer():time(), L1_3)
	end
	L2_4 = A0_2._playing
	if L2_4 then
		L2_4 = A0_2._time_played
		L2_4 = L2_4 + L1_3
		A0_2._time_played = L2_4
		L2_4 = A0_2._time_played
		if L2_4 > 3 then
			L2_4 = A0_2._time_fading_out
			if L2_4 ~= nil then
				L2_4 = A0_2._time_fading_out
				L2_4 = L2_4 + L1_3
				A0_2._time_fading_out = L2_4
				L2_4 = A0_2._video
				L2_4 = L2_4(A0_2)
				if alive(L2_4) then
					L2_4:set_volume_gain(math.clamp(1 - A0_2._time_fading_out / A0_2.SKIP_FADE_OUT_VIDEO_DURATION, 0, 1))
				end
				if A0_2._time_fading_out > A0_2.SKIP_FADE_OUT_VIDEO_DURATION then
					A0_2:skip()
				end
			else
				L2_4 = A0_2._user_wants_to_skip
				L2_4 = L2_4(A0_2)
				if L2_4 then
					A0_2._time_fading_out = 0
					L2_4 = A0_2.play_overlay_effect
					L2_4(A0_2, {
						blend_mode = "normal",
						color = Color.black,
						fade_in = A0_2.SKIP_FADE_OUT_VIDEO_DURATION,
						sustain = 0.033333335,
						fade_out = A0_2.SKIP_FADE_IN_GAME_DURATION
					})
				end
			end
		end
	end
end
function CutsceneManager._on_playback_started(A0_5, A1_6)
	A0_5._playing = true
	A0_5._time_played = 0
	A0_5._time_fading_out = nil
end
function CutsceneManager.on_cutscene_exit(A0_7)
	for 