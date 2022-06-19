LoadingCameraNoise = LoadingCameraNoise or class()
function LoadingCameraNoise.init(A0_0, A1_1, A2_2)
	local L3_3, L4_4
	A0_0._parent = A1_1
	L3_3 = A0_0._parent
	L4_4 = L3_3
	L3_3 = L3_3.panel
	L3_3 = L3_3(L4_4, {
		halign_s = "grow",
		valign_s = "grow",
		layer = 80
	})
	A0_0._panel = L3_3
	L3_3 = A0_0._panel
	L4_4 = L3_3
	L3_3 = L3_3.bitmap
	L3_3 = L3_3(L4_4, {
		wrap_mode = "wrap",
		layer = 80,
		texture = "security_camera_noise_1",
		blend_mode = "add"
	})
	A0_0._noise = L3_3
	L3_3 = A0_0._noise
	L4_4 = L3_3
	L3_3 = L3_3.set_render_template
	L3_3(L4_4, "OverlayVertexColorTextured")
	L3_3 = A0_0._panel
	L4_4 = L3_3
	L3_3 = L3_3.bitmap
	L3_3 = L3_3(L4_4, {
		texture = "security_camera_edgebleed",
		wrap_mode = "wrap",
		blend_mode = "mul",
		layer = 85,
		texture_rect = {
			0,
			0,
			254,
			255
		}
	})
	A0_0._edge_bleed_1 = L3_3
	L3_3 = A0_0._panel
	L4_4 = L3_3
	L3_3 = L3_3.bitmap
	L3_3 = L3_3(L4_4, {
		texture = "security_camera_edgebleed",
		wrap_mode = "wrap",
		blend_mode = "mul",
		layer = 85,
		texture_rect = {
			-1,
			0,
			-254,
			255
		}
	})
	A0_0._edge_bleed_2 = L3_3
	L3_3 = A0_0._panel
	L4_4 = L3_3
	L3_3 = L3_3.bitmap
	L3_3 = L3_3(L4_4, {
		texture = "security_camera_edgebleed",
		wrap_mode = "wrap",
		blend_mode = "mul",
		layer = 85,
		texture_rect = {
			0,
			0,
			254,
			255
		}
	})
	A0_0._edge_bleed_3 = L3_3
	L3_3 = A0_0._panel
	L4_4 = L3_3
	L3_3 = L3_3.bitmap
	L3_3 = L3_3(L4_4, {
		texture = "security_camera_edgebleed",
		wrap_mode = "wrap",
		blend_mode = "mul",
		layer = 85,
		texture_rect = {
			-1,
			0,
			-254,
			255
		}
	})
	A0_0._edge_bleed_4 = L3_3
	L3_3 = A0_0._panel
	L4_4 = L3_3
	L3_3 = L3_3.w
	L3_3 = L3_3(L4_4)
	L3_3 = L3_3 * 0.5
	L4_4 = A0_0._panel
	L4_4 = L4_4.h
	L4_4 = L4_4(L4_4)
	L4_4 = L4_4 * 0.5
	A0_0._edge_bleed_3:set_rotation(180)
	A0_0._edge_bleed_4:set_rotation(180)
	A0_0._edge_bleed_1:set_size(L3_3, L4_4)
	A0_0._edge_bleed_2:set_size(L3_3, L4_4)
	A0_0._edge_bleed_3:set_size(L3_3, L4_4)
	A0_0._edge_bleed_4:set_size(L3_3, L4_4)
	A0_0._edge_bleed_3:set_position(A0_0._edge_bleed_1:right(), A0_0._edge_bleed_1:bottom())
	A0_0._edge_bleed_4:set_center(A0_0._edge_bleed_1:center_x(), A0_0._edge_bleed_3:center_y())
	A0_0._edge_bleed_2:set_center(A0_0._edge_bleed_3:center_x(), A0_0._edge_bleed_1:center_y())
	A0_0._edge_bleed_1:set_render_template("OverlayVertexColorTextured")
	A0_0._edge_bleed_2:set_render_template("OverlayVertexColorTextured")
	A0_0._edge_bleed_3:set_render_template("OverlayVertexColorTextured")
	A0_0._edge_bleed_4:set_render_template("OverlayVertexColorTextured")
	A0_0._frame_counter = 0
	A0_0._frame = 0
	A0_0._frame_fps = 15
	A0_0._noise:set_size(A0_0._panel:w(), A0_0._panel:h())
	A0_0._noise:set_texture_rect(0, 0, A0_0._panel:w() / 2, A0_0._panel:w() / 2)
	A0_0._noise:set_color(A0_0._noise:color():with_alpha(A2_2))
end
function LoadingCameraNoise.hide(A0_5)
	A0_5._panel:hide()
end
function LoadingCameraNoise.update(A0_6, A1_7)
	local L2_8, L3_9, L4_10, L5_11
	L2_8 = A0_6._panel
	L3_9 = L2_8
	L2_8 = L2_8.w
	L2_8 = L2_8(L3_9)
	L3_9 = A0_6._panel
	L4_10 = L3_9
	L3_9 = L3_9.h
	L3_9 = L3_9(L4_10)
	L4_10 = A0_6._frame_counter
	L5_11 = A0_6._frame_fps
	L5_11 = L5_11 * A1_7
	L4_10 = L4_10 + L5_11
	A0_6._frame_counter = L4_10
	L4_10 = math
	L4_10 = L4_10.floor
	L5_11 = A0_6._frame_counter
	L4_10 = L4_10(L5_11)
	L5_11 = A0_6._frame
	if L4_10 ~= L5_11 then
		L5_11 = L4_10 % 4
		A0_6._frame = L5_11
		L5_11 = A0_6._frame_counter
		L5_11 = L5_11 % 4
		A0_6._frame_counter = L5_11
		L5_11 = math
		L5_11 = L5_11.random
		L5_11 = L5_11(4)
		L5_11 = L5_11 * 90
		A0_6._noise:set_rotation(L5_11)
		A0_6._noise:set_image("security_camera_noise_" .. tostring(A0_6._frame + 1), 0, 0, L2_8 * 0.5, L2_8 * 0.5)
		if L5_11 == 90 or L5_11 == 270 then
			A0_6._noise:set_size(L3_9, L2_8)
			A0_6._noise:set_center(L2_8 / 2, L3_9 / 2)
		else
			A0_6._noise:set_size(L2_8, L3_9)
			A0_6._noise:set_center(L2_8 / 2, L3_9 / 2)
		end
	end
end
