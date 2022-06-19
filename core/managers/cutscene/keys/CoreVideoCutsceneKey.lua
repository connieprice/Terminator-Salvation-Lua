require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreVideoCutsceneKey = CoreVideoCutsceneKey or class(CoreCutsceneKeyBase)
CoreVideoCutsceneKey.ELEMENT_NAME = "video"
CoreVideoCutsceneKey.NAME = "Video Playback"
CoreVideoCutsceneKey:register_serialized_attribute("video", "")
CoreVideoCutsceneKey:register_serialized_attribute("gui_layer", 2, tonumber)
CoreVideoCutsceneKey:register_serialized_attribute("loop", 0, tonumber)
CoreVideoCutsceneKey:register_serialized_attribute("speed", 1, tonumber)
function CoreVideoCutsceneKey.__tostring(A0_0)
	local L2_1
	L2_1 = string
	L2_1 = L2_1.format
	return L2_1("Play video \"%s\".", A0_0:video())
end
function CoreVideoCutsceneKey.can_evaluate_with_player(A0_2, A1_3)
	local L2_4
	L2_4 = true
	return L2_4
end
function CoreVideoCutsceneKey.play(A0_5, A1_6, A2_7, A3_8)
	local L4_9
	L4_9 = managers
	L4_9 = L4_9.cutscene
	L4_9 = L4_9.video_workspace
	L4_9 = L4_9(L4_9)
	A0_5._paused = false
	if A2_7 then
		A0_5:_stop()
	else
		if alive(A0_5._video_object) then
			if A0_5._paused then
				A0_5:_play_video(L4_9)
			end
			if A0_5._video_object:loop_count() > A0_5:loop() then
				A0_5:_stop()
				managers.cutscene:_cleanup(true)
				managers.overlay_effect:play_effect(tweak_data.player.overlay.cutscene_fade_out)
			end
		elseif A0_5:video() ~= "" then
			A0_5:_play_video(L4_9)
		end
		return true
	end
end
function CoreVideoCutsceneKey.unload(A0_10, A1_11)
	A0_10:_stop()
end
function CoreVideoCutsceneKey.update(A0_12, A1_13, A2_14)
	if A0_12.is_in_cutscene_editor then
		A0_12:_handle_cutscene_editor_scrubbing(A2_14)
	end
end
function CoreVideoCutsceneKey.is_valid_video(A0_15, A1_16)
	if A0_15.is_in_cutscene_editor then
		return A1_16 ~= nil and A1_16 ~= "" and File:exists(A1_16) and not File:is_dir(A1_16)
	else
		return A1_16 ~= nil and A1_16 ~= ""
	end
end
function CoreVideoCutsceneKey.on_attribute_changed(A0_17, A1_18, A2_19, A3_20)
	A0_17:_stop()
end
function CoreVideoCutsceneKey._handle_cutscene_editor_scrubbing(A0_21, A1_22)
	if A0_21._last_evaluated_time then
		if A1_22 == A0_21._last_evaluated_time then
			A0_21._stopped_frame_count = (A0_21._stopped_frame_count or 0) + 1
			if A0_21._stopped_frame_count > 5 then
				A0_21._stopped_frame_count = nil
				A0_21:_pause()
			end
		else
			A0_21._stopped_frame_count = nil
			if alive(A0_21._video_object) and (A1_22 < A0_21._last_evaluated_time or A1_22 - A0_21._last_evaluated_time > 1) then
				A0_21._video_object:goto_time(A1_22)
			end
			A0_21:_resume()
		end
	end
	A0_21._last_evaluated_time = A1_22
end
function CoreVideoCutsceneKey._play_video(A0_23, A1_24)
	local L2_25, L3_26
	L2_25 = alive
	L3_26 = A0_23._video_object
	L2_25 = L2_25(L3_26)
	if L2_25 then
		L3_26 = A0_23
		L2_25 = A0_23.video
		L2_25 = L2_25(L3_26)
		L3_26 = A0_23._video_played
		if L2_25 == L3_26 then
			L3_26 = A0_23
			L2_25 = A0_23.loop
			L2_25 = L2_25(L3_26)
			L3_26 = A0_23._loop_played
			if L2_25 == L3_26 then
				L3_26 = A0_23
				L2_25 = A0_23.speed
				L2_25 = L2_25(L3_26)
				L3_26 = A0_23._speed_played
			end
		end
	elseif L2_25 ~= L3_26 then
		L3_26 = A1_24
		L2_25 = A1_24.panel
		L2_25 = L2_25(L3_26)
		L3_26 = L2_25
		L2_25 = L2_25.clear
		L2_25(L3_26)
		L3_26 = A1_24
		L2_25 = A1_24.show
		L2_25(L3_26)
		L3_26 = A1_24
		L2_25 = A1_24.panel
		L2_25 = L2_25(L3_26)
		L3_26 = L2_25
		L2_25 = L2_25.rect
		L2_25(L3_26, {
			width = A1_24:width(),
			height = A1_24:height(),
			color = Color.black
		})
		L3_26 = A1_24
		L2_25 = A1_24.panel
		L2_25 = L2_25(L3_26)
		L3_26 = L2_25
		L2_25 = L2_25.video
		L2_25 = L2_25(L3_26, {
			video = A0_23:video(),
			loop = A0_23:loop() > 0,
			speed = A0_23:speed(),
			layer = A0_23:gui_layer()
		})
		A0_23._video_object = L2_25
		L3_26 = A0_23
		L2_25 = A0_23.video
		L2_25 = L2_25(L3_26)
		A0_23._video_played = L2_25
		L3_26 = A0_23
		L2_25 = A0_23.loop
		L2_25 = L2_25(L3_26)
		A0_23._loop_played = L2_25
		L3_26 = A0_23
		L2_25 = A0_23.speed
		L2_25 = L2_25(L3_26)
		A0_23._speed_played = L2_25
		L2_25 = get_fit_size
		L3_26 = A0_23._video_object
		L3_26 = L3_26.video_width
		L3_26 = L3_26(L3_26)
		L3_26 = L2_25(L3_26, A0_23._video_object:video_height(), A1_24:width(), A1_24:height())
		A0_23._video_object:set_size(L2_25, L3_26)
		A0_23._video_object:set_center(A1_24:width() / 2, A1_24:height() / 2)
		A0_23._video_object:set_volume_gain(Global.video_sound_volume or 1)
	end
	L2_25 = A0_23._video_object
	L3_26 = L2_25
	L2_25 = L2_25.play
	L2_25(L3_26)
end
function CoreVideoCutsceneKey._stop(A0_27)
	if alive(A0_27._video_object) then
		managers.cutscene:video_workspace():panel():clear()
		managers.cutscene:video_workspace():hide()
		A0_27._video_object = nil
	end
	A0_27._last_evaluated_time = nil
end
function CoreVideoCutsceneKey._pause(A0_28)
	if not A0_28._paused and alive(A0_28._video_object) then
		A0_28._video_object:pause()
		A0_28._paused = true
	end
end
function CoreVideoCutsceneKey._resume(A0_29)
	if A0_29._paused and alive(A0_29._video_object) then
		A0_29._video_object:play()
		A0_29._paused = false
	end
end
