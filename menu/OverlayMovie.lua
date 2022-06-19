if not OverlayMovie then
	OverlayMovie = class()
end
OverlayMovie.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._root_panel = managers.menu:ingame_gui():root_panel():panel()
	local l_1_3, l_1_4 = l_1_0._root_panel:video, l_1_0._root_panel
	local l_1_5 = {}
	l_1_5.video = l_1_1
	l_1_5.loop = l_1_2
	l_1_5.layer = 2
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._video = l_1_3
	l_1_3 = managers
	l_1_3 = l_1_3.menu
	l_1_3, l_1_4 = l_1_3:ingame_gui, l_1_3
	l_1_3 = l_1_3(l_1_4)
	l_1_3, l_1_4 = l_1_3:full_rect, l_1_3
	l_1_3 = l_1_3(l_1_4)
	l_1_4 = l_1_0._root_panel
	l_1_4, l_1_5 = l_1_4:rect, l_1_4
	local l_1_6 = {}
	l_1_6.color = Color.black
	l_1_6.layer = 1
	l_1_4(l_1_5, l_1_6)
	l_1_4 = get_fit_size
	l_1_5 = l_1_0._video
	l_1_5, l_1_6 = l_1_5:video_width, l_1_5
	l_1_5 = l_1_5(l_1_6)
	l_1_6 = l_1_0._video
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_4 = l_1_4(l_1_5, l_1_6, l_1_3.w, l_1_3.h)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_6(l_1_6, l_1_4, R9_PC45)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_6(l_1_6, l_1_3.w / 2, R9_PC45)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_6(l_1_6)
	l_1_0._is_done = false
	l_1_0._is_looping = l_1_2
end

OverlayMovie.destroy = function(l_2_0)
	l_2_0._video:stop()
	managers.menu:ingame_gui():root_panel():remove(l_2_0._root_panel)
end

OverlayMovie.update = function(l_3_0, l_3_1)
	local l_3_2 = managers.menu:ingame_gui()
	if not l_3_0._looping and (l_3_0._video:loop_count() > 0 or l_3_2:is_faded_down()) then
		l_3_0._is_done = true
	else
		if l_3_2:is_fading() then
			local l_3_3 = l_3_2:fade_value()
			l_3_0._video:set_volume_gain(1 - l_3_3)
		end
	end
end

OverlayMovie.is_done = function(l_4_0)
	return l_4_0._is_done
end


