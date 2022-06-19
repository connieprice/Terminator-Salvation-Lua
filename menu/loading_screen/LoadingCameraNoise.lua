if not LoadingCameraNoise then
	LoadingCameraNoise = class()
end
LoadingCameraNoise.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._parent = l_1_1
	local l_1_3, l_1_4 = l_1_0._parent:panel, l_1_0._parent
	local l_1_5 = {}
	l_1_5.halign_s = "grow"
	l_1_5.valign_s = "grow"
	l_1_5.layer = 80
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._panel = l_1_3
	l_1_3 = l_1_0._panel
	l_1_3, l_1_4 = l_1_3:bitmap, l_1_3
	l_1_3, l_1_5 = l_1_3(l_1_4, l_1_5), {wrap_mode = "wrap", layer = 80, texture = "security_camera_noise_1", blend_mode = "add"}
	l_1_0._noise = l_1_3
	l_1_3 = l_1_0._noise
	l_1_3, l_1_4 = l_1_3:set_render_template, l_1_3
	l_1_5 = "OverlayVertexColorTextured"
	l_1_3(l_1_4, l_1_5)
	l_1_3 = l_1_0._panel
	l_1_3, l_1_4 = l_1_3:bitmap, l_1_3
	local l_1_6 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_6 = {0, 0, 254, 255}
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_5 = {texture = "security_camera_edgebleed", wrap_mode = "wrap", blend_mode = "mul", layer = 85, texture_rect = l_1_6}
	l_1_0._edge_bleed_2 = l_1_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_6 = {0, 0, 254, 255}
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_5 = {texture = "security_camera_edgebleed", wrap_mode = "wrap", blend_mode = "mul", layer = 85, texture_rect = l_1_6}
	l_1_0._edge_bleed_3 = l_1_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_6 = {-1, 0, -254, 255}
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_5 = {texture = "security_camera_edgebleed", wrap_mode = "wrap", blend_mode = "mul", layer = 85, texture_rect = l_1_6}
	l_1_0._edge_bleed_4 = l_1_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_5 = l_1_4
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_5 = l_1_0._edge_bleed_3
	l_1_5, l_1_6 = l_1_5:set_rotation, l_1_5
	l_1_5(l_1_6, 180)
	l_1_5 = l_1_0._edge_bleed_4
	l_1_5, l_1_6 = l_1_5:set_rotation, l_1_5
	l_1_5(l_1_6, 180)
	l_1_5 = l_1_0._edge_bleed_1
	l_1_5, l_1_6 = l_1_5:set_size, l_1_5
	l_1_5(l_1_6, l_1_3, l_1_4)
	l_1_5 = l_1_0._edge_bleed_2
	l_1_5, l_1_6 = l_1_5:set_size, l_1_5
	l_1_5(l_1_6, l_1_3, l_1_4)
	l_1_5 = l_1_0._edge_bleed_3
	l_1_5, l_1_6 = l_1_5:set_size, l_1_5
	l_1_5(l_1_6, l_1_3, l_1_4)
	l_1_5 = l_1_0._edge_bleed_4
	l_1_5, l_1_6 = l_1_5:set_size, l_1_5
	l_1_5(l_1_6, l_1_3, l_1_4)
	l_1_5 = l_1_0._edge_bleed_3
	l_1_5, l_1_6 = l_1_5:set_position, l_1_5
	l_1_5(l_1_6, l_1_0._edge_bleed_1:right(), l_1_0._edge_bleed_1:bottom())
	l_1_5 = l_1_0._edge_bleed_4
	l_1_5, l_1_6 = l_1_5:set_center, l_1_5
	l_1_5(l_1_6, l_1_0._edge_bleed_1:center_x(), l_1_0._edge_bleed_3:center_y())
	l_1_5 = l_1_0._edge_bleed_2
	l_1_5, l_1_6 = l_1_5:set_center, l_1_5
	l_1_5(l_1_6, l_1_0._edge_bleed_3:center_x(), l_1_0._edge_bleed_1:center_y())
	l_1_5 = l_1_0._edge_bleed_1
	l_1_5, l_1_6 = l_1_5:set_render_template, l_1_5
	l_1_5(l_1_6, "OverlayVertexColorTextured")
	l_1_5 = l_1_0._edge_bleed_2
	l_1_5, l_1_6 = l_1_5:set_render_template, l_1_5
	l_1_5(l_1_6, "OverlayVertexColorTextured")
	l_1_5 = l_1_0._edge_bleed_3
	l_1_5, l_1_6 = l_1_5:set_render_template, l_1_5
	l_1_5(l_1_6, "OverlayVertexColorTextured")
	l_1_5 = l_1_0._edge_bleed_4
	l_1_5, l_1_6 = l_1_5:set_render_template, l_1_5
	l_1_5(l_1_6, "OverlayVertexColorTextured")
	l_1_0._frame_counter = 0
	l_1_0._frame = 0
	l_1_0._frame_fps = 15
	l_1_5 = l_1_0._noise
	l_1_5, l_1_6 = l_1_5:set_size, l_1_5
	l_1_5(l_1_6, l_1_0._panel:w(), l_1_0._panel:h())
	l_1_5 = l_1_0._noise
	l_1_5, l_1_6 = l_1_5:set_texture_rect, l_1_5
	l_1_5(l_1_6, 0, 0, l_1_0._panel:w() / 2, l_1_0._panel:w() / 2)
	l_1_5 = l_1_0._noise
	l_1_5, l_1_6 = l_1_5:set_color, l_1_5
	l_1_5(l_1_6, l_1_0._noise:color():with_alpha(l_1_2))
end

LoadingCameraNoise.hide = function(l_2_0)
	l_2_0._panel:hide()
end

LoadingCameraNoise.update = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0._panel:w()
	local l_3_3 = l_3_0._panel:h()
	l_3_0._frame_counter = l_3_0._frame_counter + l_3_0._frame_fps * l_3_1
	local l_3_4 = math.floor(l_3_0._frame_counter)
	if l_3_4 ~= l_3_0._frame then
		l_3_0._frame = l_3_4 % 4
		l_3_0._frame_counter = l_3_0._frame_counter % 4
		local l_3_5 = math.random(4) * 90
		l_3_0._noise:set_rotation(l_3_5)
		l_3_0._noise:set_image("security_camera_noise_" .. tostring(l_3_0._frame + 1), 0, 0, l_3_2 * 0.5, l_3_2 * 0.5)
		if l_3_5 == 90 or l_3_5 == 270 then
			l_3_0._noise:set_size(l_3_3, l_3_2)
			l_3_0._noise:set_center(l_3_2 / 2, l_3_3 / 2)
		end
	else
		l_3_0._noise:set_size(l_3_2, l_3_3)
		l_3_0._noise:set_center(l_3_2 / 2, l_3_3 / 2)
	end
end


