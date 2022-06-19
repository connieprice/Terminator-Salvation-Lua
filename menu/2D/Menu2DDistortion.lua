require("menu/2D/Menu2DAnimations")
if not Menu2DDistortion then
	Menu2DDistortion = class()
end
Menu2DDistortion.init = function(l_1_0)
	l_1_0._animation_names = tweak_data.menu2d.distortion_animation_names
	l_1_0._animations = {}
	l_1_0._animations.flash = Menu2DAnimations.flash_distortion
	l_1_0._animations.idle = Menu2DAnimations.idle
	l_1_0._animations.twitch = Menu2DAnimations.twitch
	do
		local l_1_1 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

	end
	 -- WARNING: undefined locals caused missing assignments!
end

Menu2DDistortion.set_parent = function(l_2_0, l_2_1)
	l_2_0._parent = l_2_1
	local l_2_2, l_2_3 = l_2_1:panel, l_2_1
	local l_2_4 = {}
	l_2_4.layer = tweak_data.menu2d.layer_distortion
	l_2_2 = l_2_2(l_2_3, l_2_4)
	l_2_0._panel = l_2_2
	l_2_2 = l_2_0._panel
	l_2_2, l_2_3 = l_2_2:w, l_2_2
	l_2_2 = l_2_2(l_2_3)
	l_2_0._w = l_2_2
	l_2_2 = l_2_0._panel
	l_2_2, l_2_3 = l_2_2:h, l_2_2
	l_2_2 = l_2_2(l_2_3)
	l_2_0._h = l_2_2
end

Menu2DDistortion.start = function(l_3_0)
	l_3_0:create_gui()
end

Menu2DDistortion.create_gui = function(l_4_0)
	l_4_0._bitmaps = {}
	local l_4_1 = nil
	for l_4_5 = 1, l_4_0._max_nr_of_bitmaps do
		l_4_1 = l_4_0._panel:bitmap({})
		l_4_1:hide()
		table.insert(l_4_0._bitmaps, l_4_1)
	end
	local l_4_6, l_4_7 = l_4_0._panel:bitmap, l_4_0._panel
	local l_4_8 = {}
	l_4_8.name = "normal_map"
	l_4_8.texture = "gui_menu_normal_distortion"
	l_4_8.render_template = "heat_shimmer"
	l_4_8.w = l_4_0._panel:w()
	l_4_8.h = l_4_0._panel:h() * 0.9
	l_4_8.layer = 99999
	l_4_6 = l_4_6(l_4_7, l_4_8)
	l_4_0._normal_map = l_4_6
	l_4_6 = l_4_0._normal_map
	l_4_6, l_4_7 = l_4_6:hide, l_4_6
	l_4_6(l_4_7)
end

Menu2DDistortion.update = function(l_5_0, l_5_1, l_5_2)
	local l_5_7, l_5_8, l_5_9, l_5_10, l_5_11, l_5_12, l_5_13, l_5_14, l_5_15, l_5_16, l_5_17, l_5_18, l_5_19, l_5_20, l_5_21, l_5_22, l_5_23, l_5_24, l_5_25, l_5_26, l_5_27, l_5_28, l_5_29, l_5_30, l_5_31, l_5_32, l_5_33, l_5_34, l_5_35, l_5_36, l_5_37, l_5_38, l_5_39, l_5_40, l_5_41, l_5_42, l_5_43, l_5_44, l_5_45, l_5_46, l_5_47, l_5_48, l_5_49, l_5_50, l_5_51, l_5_52, l_5_53, l_5_54, l_5_55, l_5_56, l_5_57, l_5_58, l_5_59, l_5_60, l_5_61, l_5_62, l_5_63, l_5_64, l_5_65, l_5_66, l_5_67 = nil
	if l_5_0._in_burst then
		local l_5_3 = {}
		for i_0,i_1 in ipairs(l_5_0._distortions) do
			if i_1.in_animation and l_5_0:animation_dead(i_1.animations_handle) then
				i_1.in_animation = false
				i_1.obj:hide()
				table.insert(l_5_3, i_0)
			end
			for i_0,i_1 in l_5_4 do
				if i_1.next_apperance_time + l_5_0._in_burst_start < l_5_1 then
					i_1.animations_handle = i_1.obj:animate(i_1.animation, unpack(i_1.animation_params))
					i_1.obj:show()
					i_1.start_alpha = 1
					i_1.obj:set_color(i_1.obj:color():with_alpha(i_1.start_alpha))
					i_1.obj:set_size(i_1.w, i_1.h)
					i_1.obj:set_x(i_1.x)
					i_1.obj:set_y(i_1.y)
					i_1.has_next_apperance = false
					i_1.in_animation = true
				end
			end
			for i = #l_5_3, 1, -1 do
				table.remove(l_5_0._distortions, l_5_3[l_5_68])
			end
		if #l_5_0._distortions == 0 then
			end
			l_5_0._in_burst = false
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

Menu2DDistortion.create_burst = function(l_6_0, l_6_1, l_6_2, l_6_3)
	local l_6_10, l_6_11, l_6_12, l_6_13, l_6_14, l_6_15, l_6_16, l_6_17, l_6_18, l_6_19, l_6_20, l_6_21 = nil
	local l_6_4 = math.random(tweak_data.menu2d.distortion.min_distortion_objects, tweak_data.menu2d.distortion.max_distortion_objects)
	l_6_0._distortions = {}
	local l_6_5, l_6_6 = nil, nil
	for i_0,i_1 in ipairs(l_6_0._bitmaps) do
		if i_0 <= l_6_4 then
			l_6_6 = {}
			l_6_6.obj = l_6_0._bitmaps[i_0]
			l_6_0:get_next_apperance(l_6_6, l_6_1, l_6_2, l_6_3)
			table.insert(l_6_0._distortions, l_6_6)
		end
		i_1:hide()
	end
	if math.random(1, 100) < tweak_data.menu2d.distortion_normalmap_chance then
		l_6_6 = {}
		l_6_6.obj = l_6_0._normal_map
		l_6_6.animation = Menu2DAnimations.fullscreen
		l_6_6.animation_params = {tweak_data.menu2d.distortion_time_on_screen}
		l_6_6.start_alpha = 1
		l_6_6.next_apperance_time = 0
		l_6_6.w = l_6_0._panel:w()
		l_6_6.h = l_6_0._panel:h()
		l_6_6.x = 0
		l_6_6.y = 0
		table.insert(l_6_0._distortions, l_6_6)
	else
		l_6_0._normal_map:hide()
	end
	l_6_0._in_burst_start = l_6_2
	l_6_0._in_burst = true
	managers.menu2d:sound():play("menu_title_static")
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DDistortion.get_next_apperance = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4)
	local l_7_5 = l_7_1
	l_7_5.texture = l_7_0._textures[math.random(1, 4)]
	l_7_5.obj:set_image(l_7_5.texture)
	l_7_5.next_apperance_time = math.rand(0, l_7_4)
	local l_7_6 = l_7_5.obj:texture_width()
	local l_7_7 = l_7_5.obj:texture_height()
	l_7_5.w = l_7_6 * math.random(tweak_data.menu2d.distortion.texture_min, tweak_data.menu2d.distortion.texture_max)
	l_7_5.h = l_7_5.w
	l_7_5.x = math.random(l_7_0._w * 0.2, l_7_0._w * 0.8 - l_7_5.w)
	l_7_5.y = math.random(l_7_0._h * 0.2, l_7_0._h * 0.8 - l_7_5.h)
	local l_7_8, l_7_9 = l_7_0:get_next_animation()
	l_7_5.animation = l_7_8
	l_7_5.animation_params = l_7_9
	l_7_5.start_alpha = l_7_0._h * 0.8 - l_7_5.h
end

Menu2DDistortion.get_next_animation = function(l_8_0)
	local l_8_1 = math.random(1, #l_8_0._animation_names)
	local l_8_2 = l_8_0._animation_names[l_8_1]
	local l_8_3 = l_8_0._animations[l_8_2]
	local l_8_4 = {}
	local l_8_5 = 0
	if l_8_2 == "flash" then
		table.insert(l_8_4, math.rand(tweak_data.menu2d.distortion.flash_speed_min, tweak_data.menu2d.distortion.flash_speed_max))
		table.insert(l_8_4, math.random(tweak_data.menu2d.distortion_min_flash_times, tweak_data.menu2d.distortion_max_flash_times))
		table.insert(l_8_4, tweak_data.menu2d.distortion_alpha_min)
		table.insert(l_8_4, tweak_data.menu2d.distortion_alpha_max)
		if l_8_4[4] < l_8_4[3] then
			table.insert(l_8_4, true)
			l_8_5 = l_8_4[3]
		else
			l_8_5 = l_8_4[4]
		end
	elseif l_8_2 == "idle" then
		table.insert(l_8_4, math.rand(tweak_data.menu2d.distortion_idle_min_time, tweak_data.menu2d.distortion_idle_max_time))
	elseif l_8_2 == "twitch" then
		table.insert(l_8_4, math.random(tweak_data.menu2d.distortion_min_twitches, tweak_data.menu2d.distortion_max_twitches))
		table.insert(l_8_4, math.random(tweak_data.menu2d.distortion_twitch_min_step, tweak_data.menu2d.distortion_twitch_max_step))
		table.insert(l_8_4, tweak_data.menu2d.distortion_twitch_min_delta_time)
		table.insert(l_8_4, tweak_data.menu2d.distortion_twitch_max_delta_time)
	else
		Application:error("no animation called " .. tostring(l_8_2) .. " with index " .. tostring(l_8_1))
	end
	return l_8_3, l_8_4, l_8_5
end

Menu2DDistortion.animation_dead = function(l_9_0, l_9_1)
	return coroutine.status(l_9_1) ~= "running" and coroutine.status(l_9_1) ~= "suspended"
end


