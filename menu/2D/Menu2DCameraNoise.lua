if not Menu2DCameraNoise then
	Menu2DCameraNoise = class()
end
Menu2DCameraNoise.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._parent = l_1_1
	l_1_0._low_noise_alpha = 0.25
	l_1_0._unit = l_1_2
	if l_1_0._unit then
		l_1_0._player_data = l_1_2:player_data()
	end
	local l_1_3, l_1_4 = l_1_0._parent:panel, l_1_0._parent
	local l_1_5 = {}
	l_1_5.halign = "grow"
	l_1_5.valign = "grow"
	l_1_5.layer = tweak_data.menu2d.layer_noise
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._panel = l_1_3
end

Menu2DCameraNoise.start = function(l_2_0, l_2_1, l_2_2)
	local l_2_3, l_2_4 = l_2_0._panel:bitmap, l_2_0._panel
	local l_2_5 = {}
	l_2_5.wrap_mode = "wrap"
	l_2_5.layer = tweak_data.menu2d.layer_noise
	l_2_5.texture = "security_camera_noise_1"
	l_2_5.blend_mode = "add"
	l_2_3 = l_2_3(l_2_4, l_2_5)
	l_2_0._noise = l_2_3
	if l_2_1 then
		l_2_3 = l_2_0._panel
		l_2_3, l_2_4 = l_2_3:bitmap, l_2_3
		local l_2_6 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_6 = {0, 0, 254, 255}
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_5 = {texture = "security_camera_edgebleed", wrap_mode = "wrap", blend_mode = "mul", layer = "200", texture_rect = l_2_6}
		l_2_0._edge_bleed_2 = l_2_3
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_6 = {0, 0, 254, 255}
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_5 = {texture = "security_camera_edgebleed", wrap_mode = "wrap", blend_mode = "mul", layer = "200", texture_rect = l_2_6}
		l_2_0._edge_bleed_3 = l_2_3
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_6 = {-1, 0, -254, 255}
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_5 = {texture = "security_camera_edgebleed", wrap_mode = "wrap", blend_mode = "mul", layer = "200", texture_rect = l_2_6}
		l_2_0._edge_bleed_4 = l_2_3
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_5 = l_2_4
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_5 = l_2_0._edge_bleed_3
		l_2_5, l_2_6 = l_2_5:set_rotation, l_2_5
		l_2_5(l_2_6, 180)
		l_2_5 = l_2_0._edge_bleed_4
		l_2_5, l_2_6 = l_2_5:set_rotation, l_2_5
		l_2_5(l_2_6, 180)
		l_2_5 = l_2_0._edge_bleed_1
		l_2_5, l_2_6 = l_2_5:set_size, l_2_5
		l_2_5(l_2_6, l_2_3, l_2_4)
		l_2_5 = l_2_0._edge_bleed_2
		l_2_5, l_2_6 = l_2_5:set_size, l_2_5
		l_2_5(l_2_6, l_2_3, l_2_4)
		l_2_5 = l_2_0._edge_bleed_3
		l_2_5, l_2_6 = l_2_5:set_size, l_2_5
		l_2_5(l_2_6, l_2_3, l_2_4)
		l_2_5 = l_2_0._edge_bleed_4
		l_2_5, l_2_6 = l_2_5:set_size, l_2_5
		l_2_5(l_2_6, l_2_3, l_2_4)
		l_2_5 = l_2_0._edge_bleed_3
		l_2_5, l_2_6 = l_2_5:set_position, l_2_5
		l_2_5(l_2_6, l_2_0._edge_bleed_1:right(), l_2_0._edge_bleed_1:bottom())
		l_2_5 = l_2_0._edge_bleed_4
		l_2_5, l_2_6 = l_2_5:set_center, l_2_5
		l_2_5(l_2_6, l_2_0._edge_bleed_1:center_x(), l_2_0._edge_bleed_3:center_y())
		l_2_5 = l_2_0._edge_bleed_2
		l_2_5, l_2_6 = l_2_5:set_center, l_2_5
		l_2_5(l_2_6, l_2_0._edge_bleed_3:center_x(), l_2_0._edge_bleed_1:center_y())
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_5 = Menu2DCameraNoise
	l_2_5 = l_2_5.anim_noise
	l_2_3(l_2_4, l_2_5, l_2_0._noise, l_2_0._edge_bleed)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_5 = l_2_2
	l_2_3(l_2_4, l_2_5)
end

Menu2DCameraNoise.panel = function(l_3_0)
	return l_3_0._panel
end

Menu2DCameraNoise.stop = function(l_4_0)
	if not l_4_0._panel then
		return 
	end
	l_4_0._panel:hide()
end

Menu2DCameraNoise.set_parent = function(l_5_0, l_5_1)
	l_5_0._parent = l_5_1
end

Menu2DCameraNoise.update_ingame = function(l_6_0, l_6_1)
	if alive(l_6_0._unit) and l_6_0._unit:hud() and l_6_0._player_data.has_left_battle_area_timer then
		if l_6_0._mode == "ingame" and l_6_0._player_data.has_left_battle_area_timer > 0 then
			l_6_0:set_noise_mode("ingame_out_of_bounds")
		end
	elseif l_6_0._mode == "ingame_out_of_bounds" and l_6_0._player_data.has_left_battle_area_timer < 0 then
		l_6_0:set_noise_mode("ingame")
	end
end

Menu2DCameraNoise.anim_noise = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = l_7_0:w()
	local l_7_5 = l_7_0:h()
	local l_7_6 = 0
	local l_7_7 = 0
	local l_7_8 = 20
	local l_7_9 = l_7_0:h() / 720
	while 1 do
		local l_7_10 = 0
		while 1 do
			if l_7_5 ~= l_7_0:h() then
				local l_7_4 = coroutine.yield()
				l_7_9 = l_7_0:h() / 720
				l_7_1:set_size(l_7_3, l_7_5)
				l_7_1:set_texture_rect(0, 0, l_7_3 / 2, l_7_3 / 2)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_7_10 = l_7_10 + l_7_4
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_7_6 = l_7_6 + l_7_8 * l_7_4
			do
				local l_7_11 = nil
				if math.floor(l_7_6) ~= l_7_7 then
					l_7_7 = math.floor(l_7_6) % 4
					l_7_6 = (l_7_6) % 4
					local l_7_12 = nil
					l_7_1:set_rotation(math.random(4) * 90)
					l_7_1:set_image("security_camera_noise_" .. tostring(l_7_7 + 1), 0, 0, l_7_3 * 0.5, l_7_3 * 0.5)
					 -- DECOMPILER ERROR: Confused about usage of registers!

					 -- DECOMPILER ERROR: Confused about usage of registers!

					if math.random(4) * 90 == 90 or math.random(4) * 90 == 270 then
						l_7_1:set_size(l_7_5, l_7_3)
						l_7_1:set_center(l_7_3 / 2, l_7_5 / 2)
					end
				else
					l_7_1:set_size(l_7_3, l_7_5)
					l_7_1:set_center(l_7_3 / 2, l_7_5 / 2)
				end
				l_7_11 = coroutine.yield()
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

Menu2DCameraNoise.set_noise_mode = function(l_8_0, l_8_1)
	if l_8_0._fade_animation then
		l_8_0._noise:stop(l_8_0._fade_animation)
	end
	if l_8_0._noise:color().a >= l_8_0._low_noise_alpha or not "fade_in" then
		local l_8_2 = l_8_1 ~= "menu" or "fade_out"
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_8_0._fade_animation = l_8_0._noise:animate(Menu2DAnimations[l_8_2], 0, 2, l_8_0._low_noise_alpha)
	do return end
	if l_8_0._noise:color().a >= l_8_0._low_noise_alpha or not "fade_in" then
		local l_8_3 = l_8_1 ~= "ingame" or "fade_out"
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_8_0._fade_animation = l_8_0._noise:animate(Menu2DAnimations[l_8_3], 0, 2, l_8_0._low_noise_alpha)
	do return end
	if l_8_1 == "ingame_out_of_bounds" then
		l_8_0._fade_animation = l_8_0._noise:animate(Menu2DAnimations.fade_in, 0, 2, 1)
	elseif l_8_1 == "off" then
		l_8_0._noise:set_color(l_8_0._noise:color():with_alpha(0))
	else
		Application:error("noise mode does not exist " .. tostring(l_8_1))
	end
	l_8_0._mode = l_8_1
end

Menu2DCameraNoise.enable_edgebleed = function(l_9_0)
	l_9_0._edgebleed_enabled = true
	l_9_0._edge_bleed_1:show()
	l_9_0._edge_bleed_2:show()
	l_9_0._edge_bleed_3:show()
	l_9_0._edge_bleed_4:show()
end

Menu2DCameraNoise.disable_edgebleed = function(l_10_0)
	l_10_0._edgebleed_enabled = false
	l_10_0._edge_bleed_1:hide()
	l_10_0._edge_bleed_2:hide()
	l_10_0._edge_bleed_3:hide()
	l_10_0._edge_bleed_4:hide()
end

Menu2DCameraNoise.edgebleed_enabled = function(l_11_0)
	return l_11_0._edgebleed_enabled
end


