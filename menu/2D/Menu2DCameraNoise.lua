Menu2DCameraNoise = Menu2DCameraNoise or class()
function Menu2DCameraNoise.init(A0_0, A1_1, A2_2)
	A0_0._parent = A1_1
	A0_0._low_noise_alpha = 0.25
	A0_0._unit = A2_2
	if A0_0._unit then
		A0_0._player_data = A2_2:player_data()
	end
	A0_0._panel = A0_0._parent:panel({
		halign = "grow",
		valign = "grow",
		layer = tweak_data.menu2d.layer_noise
	})
end
function Menu2DCameraNoise.start(A0_3, A1_4, A2_5)
	local L3_6, L4_7
	L3_6 = A0_3._panel
	L4_7 = L3_6
	L3_6 = L3_6.bitmap
	L3_6 = L3_6(L4_7, {
		wrap_mode = "wrap",
		layer = tweak_data.menu2d.layer_noise,
		texture = "security_camera_noise_1",
		blend_mode = "add"
	})
	A0_3._noise = L3_6
	if A1_4 then
		L3_6 = A0_3._panel
		L4_7 = L3_6
		L3_6 = L3_6.bitmap
		L3_6 = L3_6(L4_7, {
			texture = "security_camera_edgebleed",
			wrap_mode = "wrap",
			blend_mode = "mul",
			layer = "200",
			texture_rect = {
				0,
				0,
				254,
				255
			}
		})
		A0_3._edge_bleed_1 = L3_6
		L3_6 = A0_3._panel
		L4_7 = L3_6
		L3_6 = L3_6.bitmap
		L3_6 = L3_6(L4_7, {
			texture = "security_camera_edgebleed",
			wrap_mode = "wrap",
			blend_mode = "mul",
			layer = "200",
			texture_rect = {
				-1,
				0,
				-254,
				255
			}
		})
		A0_3._edge_bleed_2 = L3_6
		L3_6 = A0_3._panel
		L4_7 = L3_6
		L3_6 = L3_6.bitmap
		L3_6 = L3_6(L4_7, {
			texture = "security_camera_edgebleed",
			wrap_mode = "wrap",
			blend_mode = "mul",
			layer = "200",
			texture_rect = {
				0,
				0,
				254,
				255
			}
		})
		A0_3._edge_bleed_3 = L3_6
		L3_6 = A0_3._panel
		L4_7 = L3_6
		L3_6 = L3_6.bitmap
		L3_6 = L3_6(L4_7, {
			texture = "security_camera_edgebleed",
			wrap_mode = "wrap",
			blend_mode = "mul",
			layer = "200",
			texture_rect = {
				-1,
				0,
				-254,
				255
			}
		})
		A0_3._edge_bleed_4 = L3_6
		L3_6 = A0_3._panel
		L4_7 = L3_6
		L3_6 = L3_6.w
		L3_6 = L3_6(L4_7)
		L3_6 = L3_6 * 0.5
		L4_7 = A0_3._panel
		L4_7 = L4_7.h
		L4_7 = L4_7(L4_7)
		L4_7 = L4_7 * 0.5
		A0_3._edge_bleed_3:set_rotation(180)
		A0_3._edge_bleed_4:set_rotation(180)
		A0_3._edge_bleed_1:set_size(L3_6, L4_7)
		A0_3._edge_bleed_2:set_size(L3_6, L4_7)
		A0_3._edge_bleed_3:set_size(L3_6, L4_7)
		A0_3._edge_bleed_4:set_size(L3_6, L4_7)
		A0_3._edge_bleed_3:set_position(A0_3._edge_bleed_1:right(), A0_3._edge_bleed_1:bottom())
		A0_3._edge_bleed_4:set_center(A0_3._edge_bleed_1:center_x(), A0_3._edge_bleed_3:center_y())
		A0_3._edge_bleed_2:set_center(A0_3._edge_bleed_3:center_x(), A0_3._edge_bleed_1:center_y())
	end
	L3_6 = A0_3._panel
	L4_7 = L3_6
	L3_6 = L3_6.animate
	L3_6(L4_7, Menu2DCameraNoise.anim_noise, A0_3._noise, A0_3._edge_bleed)
	L4_7 = A0_3
	L3_6 = A0_3.set_noise_mode
	L3_6(L4_7, A2_5)
end
function Menu2DCameraNoise.panel(A0_8)
	local L1_9
	L1_9 = A0_8._panel
	return L1_9
end
function Menu2DCameraNoise.stop(A0_10)
	if not A0_10._panel then
		return
	end
	A0_10._panel:hide()
end
function Menu2DCameraNoise.set_parent(A0_11, A1_12)
	A0_11._parent = A1_12
end
function Menu2DCameraNoise.update_ingame(A0_13, A1_14)
	if alive(A0_13._unit) and A0_13._unit:hud() and A0_13._player_data.has_left_battle_area_timer then
		if A0_13._mode == "ingame" and A0_13._player_data.has_left_battle_area_timer > 0 then
			A0_13:set_noise_mode("ingame_out_of_bounds")
		elseif A0_13._mode == "ingame_out_of_bounds" and A0_13._player_data.has_left_battle_area_timer < 0 then
			A0_13:set_noise_mode("ingame")
		end
	end
end
function Menu2DCameraNoise.anim_noise(A0_15, A1_16, A2_17)
	local L3_18, L4_19, L5_20, L6_21, L7_22, L8_23, L9_24, L10_25, L11_26, L12_27
	L4_19 = A0_15
	L3_18 = A0_15.w
	L3_18 = L3_18(L4_19)
	L5_20 = A0_15
	L4_19 = A0_15.h
	L4_19 = L4_19(L5_20)
	L5_20 = 0
	L6_21 = 0
	L7_22 = 20
	L9_24 = A0_15
	L8_23 = A0_15.h
	L8_23 = L8_23(L9_24)
	L8_23 = L8_23 / 720
	L9_24 = 0
	L10_25 = coroutine
	L10_25 = L10_25.yield
	L10_25 = L10_25()
	while true do
		L12_27 = A0_15
		L11_26 = A0_15.h
		L11_26 = L11_26(L12_27)
		if L4_19 ~= L11_26 then
			L12_27 = A0_15
			L11_26 = A0_15.h
			L11_26 = L11_26(L12_27)
			L4_19 = L11_26
			L12_27 = A0_15
			L11_26 = A0_15.h
			L11_26 = L11_26(L12_27)
			L8_23 = L11_26 / 720
			L12_27 = A1_16
			L11_26 = A1_16.set_size
			L11_26(L12_27, L3_18, L4_19)
			L12_27 = A1_16
			L11_26 = A1_16.set_texture_rect
			L11_26(L12_27, 0, 0, L3_18 / 2, L3_18 / 2)
		end
		L9_24 = L9_24 + L10_25
		L11_26 = L7_22 * L10_25
		L5_20 = L5_20 + L11_26
		L11_26 = math
		L11_26 = L11_26.floor
		L12_27 = L5_20
		L11_26 = L11_26(L12_27)
		if L11_26 ~= L6_21 then
			L6_21 = L11_26 % 4
			L5_20 = L5_20 % 4
			L12_27 = math
			L12_27 = L12_27.random
			L12_27 = L12_27(4)
			L12_27 = L12_27 * 90
			A1_16:set_rotation(L12_27)
			A1_16:set_image("security_camera_noise_" .. tostring(L6_21 + 1), 0, 0, L3_18 * 0.5, L3_18 * 0.5)
			if L12_27 == 90 or L12_27 == 270 then
				A1_16:set_size(L4_19, L3_18)
				A1_16:set_center(L3_18 / 2, L4_19 / 2)
			else
				A1_16:set_size(L3_18, L4_19)
				A1_16:set_center(L3_18 / 2, L4_19 / 2)
			end
		end
		L12_27 = coroutine
		L12_27 = L12_27.yield
		L12_27 = L12_27()
		L10_25 = L12_27
	end
end
function Menu2DCameraNoise.set_noise_mode(A0_28, A1_29)
	if A0_28._fade_animation then
		A0_28._noise:stop(A0_28._fade_animation)
	end
	if A1_29 == "menu" then
		A0_28._fade_animation = A0_28._noise:animate(Menu2DAnimations[A0_28._noise:color().a < A0_28._low_noise_alpha and "fade_in" or "fade_out"], 0, 2, A0_28._low_noise_alpha)
	elseif A1_29 == "ingame" then
		A0_28._fade_animation = A0_28._noise:animate(Menu2DAnimations[A0_28._noise:color().a < A0_28._low_noise_alpha and "fade_in" or "fade_out"], 0, 2, A0_28._low_noise_alpha)
	elseif A1_29 == "ingame_out_of_bounds" then
		A0_28._fade_animation = A0_28._noise:animate(Menu2DAnimations.fade_in, 0, 2, 1)
	elseif A1_29 == "off" then
		A0_28._noise:set_color(A0_28._noise:color():with_alpha(0))
	else
		Application:error("noise mode does not exist " .. tostring(A1_29))
	end
	A0_28._mode = A1_29
end
function Menu2DCameraNoise.enable_edgebleed(A0_30)
	A0_30._edgebleed_enabled = true
	A0_30._edge_bleed_1:show()
	A0_30._edge_bleed_2:show()
	A0_30._edge_bleed_3:show()
	A0_30._edge_bleed_4:show()
end
function Menu2DCameraNoise.disable_edgebleed(A0_31)
	A0_31._edgebleed_enabled = false
	A0_31._edge_bleed_1:hide()
	A0_31._edge_bleed_2:hide()
	A0_31._edge_bleed_3:hide()
	A0_31._edge_bleed_4:hide()
end
function Menu2DCameraNoise.edgebleed_enabled(A0_32)
	local L1_33
	L1_33 = A0_32._edgebleed_enabled
	return L1_33
end
