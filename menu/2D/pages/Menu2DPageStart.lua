require("menu/2D/Menu2DPage")
if not Menu2DPageStart then
	Menu2DPageStart = class(Menu2DPage)
end
Menu2DPageStart.init = function(l_1_0, l_1_1, l_1_2)
	Menu2DPage.init(l_1_0, l_1_1, l_1_2)
end

Menu2DPageStart.parse = function(l_2_0, l_2_1)
	l_2_0._name = l_2_1:parameter("name")
	l_2_0._goto = l_2_1:parameter("goto_page")
end

Menu2DPageStart.open = function(l_3_0, l_3_1)
	l_3_0._shows_press_start = false
	Menu2DPage.open(l_3_0, l_3_1, true, tweak_data.menu2d.layer_title)
	local l_3_2 = managers.menu:ingame_gui():safe_rect()
	local l_3_3, l_3_4 = l_3_0._root_panel:rect, l_3_0._root_panel
	local l_3_5 = {}
	l_3_5.layer = 1
	l_3_3 = l_3_3(l_3_4, l_3_5)
	l_3_0._bg = l_3_3
	l_3_3 = l_3_0._panel
	l_3_3, l_3_4 = l_3_3:text, l_3_3
	l_3_3, l_3_5 = l_3_3(l_3_4, l_3_5), {text = managers.localization:text("menu_press_any_button"), font = "faith_font_22", color = Color(1, 1, 1, 1), halign = "center", valign = "center", align = "center", width = l_3_0._panel:w(), height = tweak_data.menu2d.press_start_font_size * 2, x = 0, y = l_3_0._panel:height() * 0.5 + 150, layer = 10}
	l_3_0._press_start = l_3_3
	l_3_3, l_3_4 = l_3_0:show, l_3_0
	l_3_3(l_3_4)
	l_3_3 = l_3_0._shown
	if l_3_3 then
		l_3_3 = l_3_0._press_start
		l_3_3, l_3_4 = l_3_3:set_color, l_3_3
		l_3_5 = Color
		l_3_5 = l_3_5.white
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_3_3(l_3_4, l_3_5)
		l_3_3 = l_3_0._bg
		l_3_3, l_3_4 = l_3_3:set_color, l_3_3
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_3_3(l_3_4, l_3_5)
		l_3_3, l_3_4 = l_3_0:animate_in_reverse, l_3_0
		l_3_3(l_3_4)
	else
		l_3_0._shown = true
		l_3_3 = l_3_0._press_start
		l_3_3, l_3_4 = l_3_3:set_color, l_3_3
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_3_3(l_3_4, l_3_5)
		l_3_3 = l_3_0._bg
		l_3_3, l_3_4 = l_3_3:set_color, l_3_3
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_3_3(l_3_4, l_3_5)
		l_3_3, l_3_4 = l_3_0:animate_in_first_time, l_3_0
		l_3_3(l_3_4)
	end
	l_3_3 = tweak_data
	l_3_3 = l_3_3.menu2d
	l_3_3 = l_3_3.title_press_start_wait
	l_3_4 = tweak_data
	l_3_4 = l_3_4.menu2d
	l_3_4 = l_3_4.title_animation_speed_in
	l_3_3 = l_3_3 + l_3_4
	l_3_0._next_burst_start = l_3_3
	l_3_0._shown = true
	l_3_3 = managers
	l_3_3 = l_3_3.menu2d
	l_3_3, l_3_4 = l_3_3:logo, l_3_3
	l_3_3 = l_3_3(l_3_4)
	l_3_3, l_3_4 = l_3_3:start, l_3_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_3(l_3_4, l_3_5)
end

Menu2DPageStart.close = function(l_4_0)
	Menu2DPage.close(l_4_0)
	managers.menu2d:logo():stop()
end

Menu2DPageStart.destroy = function(l_5_0)
	Menu2DPage.destroy(l_5_0)
	l_5_0._root_panel:remove(l_5_0._bg)
end

Menu2DPageStart.update = function(l_6_0, l_6_1)
	Menu2DPage.update(l_6_0, l_6_1)
	l_6_0:animation_done()
	if l_6_0._next_burst_start < TimerManager:main():time() then
		managers.menu2d:distortion_burst(l_6_1, l_6_0._next_burst_length)
		managers.menu2d:logo_twitch(l_6_0._next_burst_length)
		l_6_0._next_burst_length = math.rand(tweak_data.menu2d.distortion.min_distortion_burst_time, tweak_data.menu2d.distortion.max_distortion_burst_time)
		l_6_0._next_burst_start = TimerManager:main():time() + l_6_0._next_burst_length + math.rand(tweak_data.menu2d.distortion.min_distortion_burst_interval, tweak_data.menu2d.distortion.max_distortion_burst_interval)
	end
	local l_6_2 = not managers.save:has_primary_user()
	if l_6_2 then
		l_6_0:_show_press_start()
	else
		l_6_0:_hide_press_start()
	end
end

Menu2DPageStart.set_transition = function(l_7_0, l_7_1)
	Menu2DPage.set_transition(l_7_0, l_7_1)
	l_7_0:animate_out()
end

Menu2DPageStart._transition = function(l_8_0)
	if l_8_0._in_transition == "out" and l_8_0._transition_timer < 0 then
		return true
	elseif l_8_0._transition_timer then
		l_8_0._transition_timer = l_8_0._transition_timer - TimerManager:main():delta_time()
	end
end

Menu2DPageStart.advance = function(l_9_0)
end

Menu2DPageStart.animate_in_first_time = function(l_10_0)
	l_10_0._animations = {}
	l_10_0._in_transition = "in"
	l_10_0:_show_press_start(tweak_data.menu2d.title_press_start_wait)
	l_10_0._bg:animate(Menu2DAnimations.fade_in, 0, tweak_data.menu2d.bg_fade_speed, tweak_data.menu2d.bg_alpha)
	l_10_0._active = false
end

Menu2DPageStart.animate_in_reverse = function(l_11_0)
	l_11_0._animations = {}
	l_11_0._in_transition = "in"
	local l_11_1 = 1 / tweak_data.menu2d.reverse_speed
	l_11_0:_show_press_start(tweak_data.menu2d.press_start_revers_wait)
	table.insert(l_11_0._animations, l_11_0._bg:animate(Menu2DAnimations.fade_in, 0, tweak_data.menu2d.bg_fade_speed * l_11_1, tweak_data.menu2d.bg_alpha))
	l_11_0._bg:animate(Menu2DAnimations.fade_in, 0, tweak_data.menu2d.bg_fade_speed * l_11_1, tweak_data.menu2d.bg_alpha)
	l_11_0._active = false
end

Menu2DPageStart.animate_out = function(l_12_0)
	l_12_0._animations = {}
	l_12_0._in_transition = "out"
	l_12_0._transition_timer = 0.1
	l_12_0:_hide_press_start()
	table.insert(l_12_0._animations, l_12_0._bg:animate(Menu2DAnimations.fade_out, tweak_data.menu2d.bg_wait_fade, tweak_data.menu2d.bg_fade_speed, 0))
end

Menu2DPageStart.animate_active = function(l_13_0)
	l_13_0._press_start:stop()
	l_13_0._press_start:animate(Menu2DAnimations.pulse, tweak_data.menu2d.press_start_pulse_speed, tweak_data.menu2d.press_start_pulse_low_alpha, tweak_data.menu2d.press_start_pulse_high_alpha, tweak_data.menu2d.press_start_pulse_wait)
	l_13_0._active = true
end

Menu2DPageStart.animation_done = function(l_14_0)
	local l_14_5, l_14_6, l_14_7, l_14_8, l_14_9, l_14_10, l_14_11 = nil
	if #l_14_0._animations > 0 then
		local l_14_1 = {}
		for i_0,i_1 in ipairs(l_14_0._animations) do
			if coroutine.status(i_1) ~= "running" and coroutine.status(i_1) ~= "suspended" then
				table.insert(l_14_1, i_0)
			end
		end
		for i = #l_14_1, 1, -1 do
			table.remove(l_14_0._animations, l_14_1[l_14_12])
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_14_1 = l_14_0._active
		if not l_14_1 then
			l_14_1(l_14_0)
		end
	 -- DECOMPILER ERROR: Overwrote pending register.

	elseif l_14_1 == "out" then
		l_14_0._animating_out = nil
	end
	l_14_0._in_transition = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	return l_14_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageStart._show_press_start = function(l_15_0, l_15_1)
	if not l_15_0._shows_press_start then
		if not l_15_1 then
			l_15_1 = 0
		end
		table.insert(l_15_0._animations, l_15_0._press_start:animate(Menu2DAnimations.fade_in, l_15_1, tweak_data.menu2d.press_start_fade_in))
		l_15_0._shows_press_start = true
	end
end

Menu2DPageStart._hide_press_start = function(l_16_0)
	if l_16_0._shows_press_start then
		l_16_0._press_start:stop()
		table.insert(l_16_0._animations, l_16_0._press_start:animate(Menu2DAnimations.fade_out, 0, tweak_data.menu2d.press_start_fade_out, 0))
		l_16_0._shows_press_start = false
	end
end


