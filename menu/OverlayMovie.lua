OverlayMovie = OverlayMovie or class()
function OverlayMovie.init(A0_0, A1_1, A2_2)
	local L3_3, L4_4, L5_5
	L3_3 = managers
	L3_3 = L3_3.menu
	L4_4 = L3_3
	L3_3 = L3_3.ingame_gui
	L3_3 = L3_3(L4_4)
	L4_4 = L3_3
	L3_3 = L3_3.root_panel
	L3_3 = L3_3(L4_4)
	L4_4 = L3_3
	L3_3 = L3_3.panel
	L3_3 = L3_3(L4_4)
	A0_0._root_panel = L3_3
	L3_3 = A0_0._root_panel
	L4_4 = L3_3
	L3_3 = L3_3.video
	L5_5 = {}
	L5_5.video = A1_1
	L5_5.loop = A2_2
	L5_5.layer = 2
	L3_3 = L3_3(L4_4, L5_5)
	A0_0._video = L3_3
	L3_3 = managers
	L3_3 = L3_3.menu
	L4_4 = L3_3
	L3_3 = L3_3.ingame_gui
	L3_3 = L3_3(L4_4)
	L4_4 = L3_3
	L3_3 = L3_3.full_rect
	L3_3 = L3_3(L4_4)
	L4_4 = A0_0._root_panel
	L5_5 = L4_4
	L4_4 = L4_4.rect
	L4_4(L5_5, {
		color = Color.black,
		layer = 1
	})
	L4_4 = get_fit_size
	L5_5 = A0_0._video
	L5_5 = L5_5.video_width
	L5_5 = L5_5(L5_5)
	L5_5 = L4_4(L5_5, A0_0._video:video_height(), L3_3.w, L3_3.h)
	A0_0._video:set_size(L4_4, L5_5)
	A0_0._video:set_center(L3_3.w / 2, L3_3.h / 2)
	A0_0._video:play()
	A0_0._is_done = false
	A0_0._is_looping = A2_2
end
function OverlayMovie.destroy(A0_6)
	A0_6._video:stop()
	managers.menu:ingame_gui():root_panel():remove(A0_6._root_panel)
end
function OverlayMovie.update(A0_7, A1_8)
	if not A0_7._looping and (A0_7._video:loop_count() > 0 or managers.menu:ingame_gui():is_faded_down()) then
		A0_7._is_done = true
	elseif managers.menu:ingame_gui():is_fading() then
		A0_7._video:set_volume_gain(1 - managers.menu:ingame_gui():fade_value())
	end
end
function OverlayMovie.is_done(A0_9)
	local L1_10
	L1_10 = A0_9._is_done
	return L1_10
end
