if not Menu2DTitleLogo then
	Menu2DTitleLogo = class()
end
Menu2DTitleLogo.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._first_time = true
	l_1_0._animations = {}
	l_1_0._twitches = {}
	l_1_0._animation_names = tweak_data.menu2d.logo.animations
	l_1_0._root_panel = l_1_1
end

Menu2DTitleLogo._create_gui = function(l_2_0, l_2_1, l_2_2)
	l_2_0._root_panel = l_2_1
	local l_2_3 = false
	if not alive(l_2_0._panel) then
		l_2_3 = true
	else
		if l_2_0._panel:parent() ~= l_2_0._root_panel then
			l_2_0._panel:parent():remove(l_2_0._panel)
			l_2_3 = true
		end
	elseif l_2_2 ~= l_2_0._mode then
		l_2_3 = true
	end
	if l_2_3 then
		local l_2_4, l_2_5 = l_2_1:panel, l_2_1
		local l_2_6 = {}
		l_2_6.layer = tweak_data.menu2d.layer_title
		l_2_4 = l_2_4(l_2_5, l_2_6)
		l_2_0._panel = l_2_4
		l_2_4 = l_2_0._panel
		l_2_4, l_2_5 = l_2_4:bitmap, l_2_4
		l_2_4, l_2_6 = l_2_4(l_2_5, l_2_6), {texture = "gui_menu_salvation_logo_big", layer = 10}
		l_2_0._logo = l_2_4
		l_2_4 = l_2_0._panel
		l_2_4, l_2_5 = l_2_4:bitmap, l_2_4
		l_2_4, l_2_6 = l_2_4(l_2_5, l_2_6), {texture = "gui_menu_salvation_logo_big", layer = 10, color = Color.white:with_alpha(tweak_data.menu2d.logo.duplicate_alpha)}
		l_2_0._logo_duplicate = l_2_4
		l_2_4 = l_2_0._logo
		l_2_4, l_2_5 = l_2_4:set_center, l_2_4
		l_2_6 = l_2_0._panel
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_4(l_2_5, l_2_6, l_2_0._panel:h() * 0.5)
		l_2_4 = l_2_0._logo_duplicate
		l_2_4, l_2_5 = l_2_4:set_center, l_2_4
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_4(l_2_5, l_2_6)
		l_2_4 = l_2_0._logo
		l_2_4, l_2_5 = l_2_4:w, l_2_4
		l_2_4 = l_2_4(l_2_5)
		l_2_0._width = l_2_4
		l_2_4 = l_2_0._logo
		l_2_4, l_2_5 = l_2_4:h, l_2_4
		l_2_4 = l_2_4(l_2_5)
		l_2_0._height = l_2_4
		if l_2_2 == "title" then
			l_2_4 = l_2_0._panel
			l_2_4, l_2_5 = l_2_4:bitmap, l_2_4
			l_2_4, l_2_6 = l_2_4(l_2_5, l_2_6), {texture = "gui_menu_salvation_logo_glow", blend_mode = "add", layer = 11}
			l_2_0._logo_bloom = l_2_4
			l_2_4, l_2_5 = l_2_0:set_logo_bloom_size, l_2_0
			l_2_4(l_2_5)
			l_2_4 = l_2_0._logo_bloom
			l_2_4, l_2_5 = l_2_4:hide, l_2_4
			l_2_4(l_2_5)
		end
	else
		l_2_0:set_logo_bloom_size()
	end
	l_2_0:set_mode(l_2_2)
end

Menu2DTitleLogo.set_logo_bloom_size = function(l_3_0)
	if l_3_0._logo_bloom then
		l_3_0._logo_bloom:set_size(l_3_0._logo:w(), l_3_0._logo:h())
		l_3_0._logo_bloom:set_center(l_3_0._logo:center())
	end
end

Menu2DTitleLogo.update = function(l_4_0, l_4_1)
	local l_4_5, l_4_6, l_4_7, l_4_8, l_4_9, l_4_10, l_4_11, l_4_12 = nil
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_4_0._mode == "title" and l_4_0._animation_playing == "idle" and #l_4_0._twitches > 0 and l_4_0:animation_done() and l_4_0._twitches[1].next_twitch < TimerManager:main():time() then
		l_4_0._logo:show()
		l_4_0._logo_duplicate:show()
		for i_0,i_1 in ipairs(l_4_0._twitches[1].guis) do
			table.insert(l_4_0._animations, i_1.obj:animate(i_1.animation, unpack(i_1.params)))
		end
		if l_4_0._twitches[1].hide_gui then
			l_4_0._twitches[1].hide_gui:hide()
		end
		table.remove(l_4_0._twitches, 1)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	do return end
	l_4_0:animation_done()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DTitleLogo.twitch = function(l_5_0)
	if not l_5_0._logo or not l_5_0._logo_duplicate then
		return 
	end
	l_5_0._animation_names = tweak_data.menu2d.logo.animations
	l_5_0._twitches = {}
	local l_5_1 = math.random(1, 5)
	l_5_1 = 1
	do
		local l_5_2, l_5_3, l_5_4, l_5_5 = nil, nil, nil, nil
		for l_5_9 = 1, l_5_1 do
			l_5_3 = math.random(1, #l_5_0._animation_names)
			l_5_3 = l_5_0._animation_names[l_5_3]
			l_5_2 = {}
			l_5_2.guis = {}
			l_5_5 = {}
			l_5_5.params = {}
			if l_5_3 == "twitch_small" then
				table.insert(l_5_5.params, tweak_data.menu2d.logo.small_twitch_count)
				local l_5_10 = {}
				for l_5_14 = 1, l_5_5.params[1] do
					table.insert(l_5_10, math.random(tweak_data.menu2d.logo.small_twitch_min_step, tweak_data.menu2d.logo.small_twitch_max_step) * l_5_0:random_sign())
				end
				table.insert(l_5_5.params, l_5_10)
				l_5_10 = {}
				for l_5_18 = 1, l_5_5.params[1] do
					table.insert(l_5_10, math.random(tweak_data.menu2d.logo.small_twitch_min_step, tweak_data.menu2d.logo.small_twitch_max_step) * l_5_0:random_sign())
				end
				table.insert(l_5_5.params, l_5_10)
				l_5_10 = {}
				for l_5_22 = 1, l_5_5.params[1] do
					table.insert(l_5_10, math.rand(tweak_data.menu2d.logo.small_twitch_min_delta_time, tweak_data.menu2d.logo.small_twitch_max_delta_time))
				end
				table.insert(l_5_5.params, l_5_10)
				l_5_5.animation = Menu2DAnimations.twitch2
			elseif l_5_3 == "twitch_big" then
				table.insert(l_5_5.params, 3)
				local l_5_23 = {}
				for l_5_27 = 1, l_5_5.params[1] do
					table.insert(l_5_23, math.random(tweak_data.menu2d.logo.big_twitch_min_step, tweak_data.menu2d.logo.big_twitch_max_step) * l_5_0:random_sign())
				end
				table.insert(l_5_5.params, l_5_23)
				l_5_23 = {}
				for l_5_31 = 1, l_5_5.params[1] do
					table.insert(l_5_23, math.random(tweak_data.menu2d.logo.big_twitch_min_step, tweak_data.menu2d.logo.big_twitch_max_step) * l_5_0:random_sign())
				end
				table.insert(l_5_5.params, l_5_23)
				l_5_23 = {}
				for l_5_35 = 1, l_5_5.params[1] do
					local l_5_41 = table.insert
					l_5_41(l_5_23, math.rand(tweak_data.menu2d.logo.big_twitch_min_delta_time, tweak_data.menu2d.logo.big_twitch_max_delta_time))
				end
				table.insert(l_5_5.params, l_5_23)
				l_5_5.animation = Menu2DAnimations.twitch2
			elseif l_5_3 == "flash" then
				table.insert(l_5_5.params, tweak_data.menu2d.logo.flash_speed)
				table.insert(l_5_5.params, tweak_data.menu2d.logo.flash_count)
				table.insert(l_5_5.params, tweak_data.menu2d.logo.flash_alpha_min)
				l_5_5.animation = Menu2DAnimations.flash_distortion
			end
			if l_5_3 ~= "flash" or not 1 then
				l_5_4 = math.random(1, 3)
			end
			if l_5_4 == 1 then
				l_5_5.obj = l_5_0._logo
				table.insert(l_5_2.guis, l_5_5)
				local l_5_36 = {}
				l_5_36.params = {}
				if l_5_3 ~= "flash" then
					local l_5_40 = l_5_0:enhance_values
					l_5_40(l_5_0, l_5_5.params, l_5_36.params)
				else
					for i_0,i_1 in ipairs(l_5_5.params) do
						l_5_36.params[i_0] = i_1
					end
					l_5_36.params[3] = 0
					 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

				end
				l_5_36.obj = l_5_0._logo_duplicate
				l_5_36.animation = l_5_5.animation
				table.insert(l_5_2.guis, l_5_36)
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			elseif l_5_4 == 2 then
				l_5_36 = l_5_0._logo
				l_5_5.obj = l_5_36
				l_5_36 = table
				l_5_36 = l_5_36.insert
				l_5_36(l_5_2.guis, l_5_5)
				l_5_36 = l_5_0._logo_duplicate
				l_5_2.hide_gui = l_5_36
			elseif l_5_4 == 3 then
				if l_5_3 ~= "flash" then
					l_5_36(l_5_0, l_5_5.params, l_5_5.params)
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_5_5.obj = l_5_36
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				l_5_36(l_5_2.guis, l_5_5)
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_5_2.next_twitch = l_5_36
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_5_36(l_5_0._twitches, l_5_2)
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DTitleLogo.random_sign = function(l_6_0)
	return math.random(0, 1) > 0 and 1 or -1
end

Menu2DTitleLogo.enhance_values = function(l_7_0, l_7_1, l_7_2)
	local l_7_6, l_7_7, l_7_8, l_7_9, l_7_10, l_7_11, l_7_12, l_7_13, l_7_14, l_7_15, l_7_16, l_7_17, l_7_18, l_7_19, l_7_20, l_7_24, l_7_25, l_7_26, l_7_27 = nil
	for i_0,i_1 in pairs(l_7_1) do
		if type(i_1) == "number" then
			l_7_2[i_0] = i_1 * 1.2
		else
			if type(i_1) == "table" then
				l_7_2[i_0] = {}
				for i_0,i_1 in pairs(i_1) do
					l_7_2[l_7_21][i_0] = i_1 * 1.2
				end
			end
		end
	end
end

Menu2DTitleLogo.start = function(l_8_0, l_8_1)
	if not l_8_1 then
		l_8_1 = l_8_0._mode
	end
	l_8_0._enabled = true
	l_8_0:_create_gui(l_8_0._root_panel, l_8_1)
end

Menu2DTitleLogo.stop = function(l_9_0)
	l_9_0._panel:stop()
	l_9_0._logo_duplicate:stop()
	l_9_0._logo:stop()
	l_9_0._logo_duplicate:hide()
	l_9_0._logo:show()
	l_9_0._enabled = false
	if l_9_0._mode == "title" then
		l_9_0:animate_out()
	elseif l_9_0._mode == "ingame" or l_9_0._mode == "main_menu" then
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 29 
end

Menu2DTitleLogo.set_mode = function(l_10_0, l_10_1)
	l_10_0._mode = l_10_1
	if l_10_1 == "title" then
		if l_10_0._first_time then
			l_10_0._first_time = false
			l_10_0._logo:set_color(l_10_0._logo:color():with_alpha(0))
			l_10_0:animate_in_first_time()
		else
			l_10_0:animate_in_reverse()
		end
	elseif l_10_1 == "ingame" or l_10_1 == "main_menu" then
		l_10_0._logo:set_color(l_10_0._logo:color():with_alpha(0))
		l_10_0._logo:hide()
		l_10_0._logo_duplicate:hide()
	if l_10_0._logo_bloom then
		end
		l_10_0._logo_bloom:hide()
	end
end

Menu2DTitleLogo.animate_in_first_time = function(l_11_0)
	l_11_0._animation_playing = "fade_in"
	l_11_0._animations = {}
	table.insert(l_11_0._animations, l_11_0._logo:animate(Menu2DAnimations.fade_in, tweak_data.menu2d.title_animation_wait, tweak_data.menu2d.title_animation_speed_in))
end

Menu2DTitleLogo.animate_in_reverse = function(l_12_0)
	l_12_0._animations = {}
	l_12_0._animation_playing = "fade_in"
	local l_12_1 = 1 / tweak_data.menu2d.reverse_speed * 3 * (1 + tweak_data.menu2d.title_growth - l_12_0._logo:w() / l_12_0._width)
	l_12_0._logo:set_color(l_12_0._logo:color():with_alpha(tweak_data.menu2d.title_end_alpha))
	l_12_0._logo_duplicate:set_color(l_12_0._logo:color():with_alpha(tweak_data.menu2d.title_end_alpha))
	table.insert(l_12_0._animations, l_12_0._logo:animate(Menu2DAnimations.grow, tweak_data.menu2d.title_animation_speed_in * l_12_1, l_12_0._width, l_12_0._height))
	table.insert(l_12_0._animations, l_12_0._logo:animate(Menu2DAnimations.fade_in, 0, tweak_data.menu2d.title_animation_speed_in * l_12_1))
	table.insert(l_12_0._animations, l_12_0._logo_duplicate:animate(Menu2DAnimations.fade_in, 0, tweak_data.menu2d.title_animation_speed_in * l_12_1, tweak_data.menu2d.logo.duplicate_alpha))
end

Menu2DTitleLogo.animate_out = function(l_13_0)
	l_13_0._animation_playing = "fade_out"
	l_13_0._animations = {}
	l_13_0:set_logo_bloom_size()
	local l_13_1 = l_13_0._logo:w() / l_13_0._width
	table.insert(l_13_0._animations, l_13_0._logo:animate(Menu2DAnimations.grow, tweak_data.menu2d.title_animation_speed_out * l_13_1, tweak_data.menu2d.title_growth * l_13_0._width, tweak_data.menu2d.title_growth * l_13_0._height))
	l_13_0._logo:set_color(Color(1, 1, 1, 1))
	l_13_0._logo_bloom:set_color(Color(1, 1, 1, 1))
	l_13_0._logo_bloom:set_color(l_13_0._logo_bloom:color():with_alpha(0))
	l_13_0._logo_bloom:show()
	table.insert(l_13_0._animations, l_13_0._logo_bloom:animate(Menu2DAnimations.grow, tweak_data.menu2d.logo_bloom_grow_speed * l_13_1, tweak_data.menu2d.logo_bloom_growth * l_13_0._width, tweak_data.menu2d.logo_bloom_growth * l_13_0._height))
	table.insert(l_13_0._animations, l_13_0._logo:animate(Menu2DAnimations.fade_out, 0, tweak_data.menu2d.title_animation_speed_out * l_13_1, tweak_data.menu2d.title_end_alpha))
	table.insert(l_13_0._animations, l_13_0._logo_bloom:animate(Menu2DAnimations.fade_out, 0, tweak_data.menu2d.logo_bloom_fade_in_speed * l_13_1, tweak_data.menu2d.logo_bloom_end_alpha))
end

Menu2DTitleLogo.animate_logo_bloom_fade_out_end = function(l_14_0)
	l_14_0._logo_bloom:animate(Menu2DAnimations.fade_out, tweak_data.menu2d.logo_bloom_fade_out_wait, tweak_data.menu2d.logo_bloom_fade_out_speed, 0)
end

Menu2DTitleLogo.init_animation = function(l_15_0)
	l_15_0._logo:stop()
	l_15_0._logo_bloom:stop()
	l_15_0._logo_duplicate:stop()
end

Menu2DTitleLogo.animation_done = function(l_16_0)
	local l_16_5, l_16_6, l_16_7, l_16_8, l_16_9 = nil
	if #l_16_0._animations > 0 then
		local l_16_1 = {}
		for i_0,i_1 in ipairs(l_16_0._animations) do
			if l_16_0:animation_dead(i_1) then
				table.insert(l_16_1, i_0)
			end
		end
		for i = #l_16_1, 1, -1 do
			table.remove(l_16_0._animations, l_16_1[l_16_10])
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_16_1 = l_16_0._animation_playing
		if l_16_1 == "fade_out" then
			l_16_1(l_16_0)
			l_16_0._animating_out = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		elseif l_16_1 == "fade_in" then
			l_16_0._animation_playing = "idle"
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_16_1(l_16_1, l_16_0._logo:w(), l_16_0._logo:h())
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_16_1(l_16_1, l_16_0._logo:center())
		end
		l_16_0._animation_playing = nil
		l_16_0._in_transition = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		return l_16_1
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Menu2DTitleLogo.animation_dead = function(l_17_0, l_17_1)
	return coroutine.status(l_17_1) ~= "running" and coroutine.status(l_17_1) ~= "suspended"
end


