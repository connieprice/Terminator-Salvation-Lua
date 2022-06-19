require("units/beings/player/new_gui/HudPanel")
StickDirectionPanel = StickDirectionPanel or class(HudPanel)
function StickDirectionPanel.init(A0_0, A1_1, A2_2)
	HudPanel.init(A0_0, false)
	A0_0._parent_panel = A1_1
	A0_0._player_unit = A2_2
	A0_0._player_data = A2_2:player_data()
	A0_0._width = A0_0._parent_panel:width()
	A0_0._height = A0_0._parent_panel:height()
	A0_0._center_x = A0_0._parent_panel:width() / 2
	A0_0._center_y = A0_0._parent_panel:height() / 2
	A0_0._radius = 0
	A0_0._current_angle = 0
	A0_0._panel = A0_0._parent_panel:panel({
		name = "stick_direction_panel",
		width = A0_0._width,
		height = A0_0._height,
		valign = "center",
		halign = "center"
	})
	A0_0._stick_dot_texture = A0_0._panel:bitmap({
		name = "gui_hud_selection_dot",
		texture = "gui_hud_selection_dot"
	})
	A0_0._alpha_interpolator = Interpolator:new(0, tweak_data.player.new_hud.stick_direction_panel.FADE_IN_SPEED)
	A0_0._alpha_interpolator:set_target(0)
	A0_0._angle_interpolator = Interpolator:new(0, tweak_data.player.new_hud.stick_direction_panel.ANGULAR_SPEED)
	A0_0._angle_interpolator:set_target(0)
	A0_0._radius_interpolator = Interpolator:new(0, tweak_data.player.new_hud.stick_direction_panel.RADIUS_SPEED)
	A0_0._radius_interpolator:set_target(0)
	A0_0:set_alpha(0)
end
function StickDirectionPanel.panel(A0_3)
	local L1_4
	L1_4 = A0_3._panel
	return L1_4
end
function StickDirectionPanel.set_angle(A0_5, A1_6)
	local L2_7, L3_8, L4_9
	L3_8 = tweak_data
	L3_8 = L3_8.player
	L3_8 = L3_8.new_hud
	L3_8 = L3_8.stick_direction_panel
	L3_8 = L3_8.USE_RADIUS_MOVEMENT
	if L3_8 then
		L2_7 = A0_5._radius
	else
		L3_8 = tweak_data
		L3_8 = L3_8.player
		L3_8 = L3_8.new_hud
		L3_8 = L3_8.stick_direction_panel
		L2_7 = L3_8.RADIUS
	end
	L3_8 = A0_5._center_x
	L4_9 = math
	L4_9 = L4_9.cos
	L4_9 = L4_9(A1_6 - 90)
	L4_9 = L2_7 * L4_9
	L3_8 = L3_8 + L4_9
	L4_9 = A0_5._center_y
	L4_9 = L4_9 + L2_7 * math.sin(A1_6 - 90)
	A0_5._current_angle = A1_6
	A0_5._stick_dot_texture:set_rotation(A1_6)
	A0_5._stick_dot_texture:set_center(L3_8, L4_9)
end
function StickDirectionPanel.update_angle(A0_10)
	A0_10:set_angle(A0_10._current_angle)
end
function StickDirectionPanel.set_radius(A0_11, A1_12)
	A0_11._radius = A1_12
end
function StickDirectionPanel.show(A0_13)
	A0_13._wants_to_hide = false
	A0_13._alpha_interpolator:set_target(1)
	A0_13._alpha_interpolator:set_speed(tweak_data.player.new_hud.stick_direction_panel.FADE_IN_SPEED)
	if A0_13._alpha_interpolator:value() == 0 then
		A0_13._radius = 0
	end
end
function StickDirectionPanel.hide(A0_14)
	A0_14._wants_to_hide = true
	A0_14._alpha_interpolator:set_target(0)
	A0_14._alpha_interpolator:set_speed(tweak_data.player.new_hud.stick_direction_panel.FADE_OUT_SPEED)
end
function StickDirectionPanel.visible(A0_15)
	return A0_15._alpha > 0
end
function StickDirectionPanel.get_alpha(A0_16)
	local L1_17
	L1_17 = A0_16._alpha
	return L1_17
end
function StickDirectionPanel.set_alpha(A0_18, A1_19)
	HudPanel.set_alpha(A0_18, A1_19)
	A0_18._stick_dot_texture:set_color(A0_18._stick_dot_texture:color():with_alpha(A0_18._alpha))
end
function StickDirectionPanel.update(A0_20, A1_21, A2_22, A3_23)
	local L4_24, L5_25, L6_26, L7_27
	L4_24 = A3_23
	L5_25 = A2_22
	if L5_25 and L5_25 >= 0 then
		L6_26 = A0_20._init_angle
		if not L6_26 then
			A0_20._init_angle = L5_25
			L6_26 = A0_20._angle_interpolator
			L7_27 = L6_26
			L6_26 = L6_26.set_value
			L6_26(L7_27, L5_25)
		end
		L6_26 = A0_20._angle_interpolator
		L7_27 = L6_26
		L6_26 = L6_26.value
		L6_26 = L6_26(L7_27)
		if L6_26 > 360 then
			L6_26 = L6_26 - 360
			L7_27 = A0_20._angle_interpolator
			L7_27 = L7_27.set_value
			L7_27(L7_27, L6_26)
		end
		if L6_26 < 0 then
			L6_26 = L6_26 + 360
			L7_27 = A0_20._angle_interpolator
			L7_27 = L7_27.set_value
			L7_27(L7_27, L6_26)
		end
		L7_27 = L6_26 - L5_25
		if L7_27 > 240 then
			L5_25 = L5_25 + 360
		end
		if L7_27 < -240 then
			L5_25 = L5_25 - 360
		end
		A0_20._angle_interpolator:set_target(L5_25)
	end
	L6_26 = A0_20._angle_interpolator
	L7_27 = L6_26
	L6_26 = L6_26.update
	L6_26(L7_27, A1_21)
	L6_26 = A0_20._angle_interpolator
	L7_27 = L6_26
	L6_26 = L6_26.value
	L6_26 = L6_26(L7_27)
	L5_25 = L6_26
	L7_27 = A0_20
	L6_26 = A0_20.set_angle
	L6_26(L7_27, L5_25)
	if L4_24 == 0 then
		A0_20._init_angle = nil
	end
	if L4_24 then
		L6_26 = A0_20._wants_to_hide
		if not L6_26 then
			L6_26 = A0_20._radius_interpolator
			L7_27 = L6_26
			L6_26 = L6_26.set_target
			L6_26(L7_27, L4_24 * tweak_data.player.new_hud.stick_direction_panel.RADIUS)
		end
	end
	L6_26 = A0_20._radius_interpolator
	L7_27 = L6_26
	L6_26 = L6_26.update
	L6_26(L7_27, A1_21)
	L6_26 = A0_20._radius_interpolator
	L7_27 = L6_26
	L6_26 = L6_26.value
	L6_26 = L6_26(L7_27)
	L7_27 = A0_20.set_radius
	L7_27(A0_20, L6_26)
	L7_27 = tweak_data
	L7_27 = L7_27.player
	L7_27 = L7_27.new_hud
	L7_27 = L7_27.stick_direction_panel
	L7_27 = L7_27.USE_RADIUS_MOVEMENT
	if not L7_27 then
		if L6_26 > 0.98 then
			L7_27 = A0_20._alpha_interpolator
			L7_27 = L7_27.set_target
			L7_27(L7_27, 1)
			L7_27 = A0_20._alpha_interpolator
			L7_27 = L7_27.set_speed
			L7_27(L7_27, tweak_data.player.new_hud.stick_direction_panel.FADE_IN_SPEED)
		else
			L7_27 = A0_20._alpha_interpolator
			L7_27 = L7_27.set_target
			L7_27(L7_27, 0)
			L7_27 = A0_20._alpha_interpolator
			L7_27 = L7_27.set_speed
			L7_27(L7_27, tweak_data.player.new_hud.stick_direction_panel.FADE_OUT_SPEED)
		end
	end
	L7_27 = A0_20._alpha_interpolator
	L7_27 = L7_27.update
	L7_27(L7_27, A1_21)
	L7_27 = A0_20._alpha_interpolator
	L7_27 = L7_27.value
	L7_27 = L7_27(L7_27)
	if A0_20._alpha_interpolator:target() == 0 and A0_20._alpha_interpolator:has_reached_target() then
		A0_20._radius_interpolator:set_target(0)
		A0_20._radius_interpolator:set_value(0)
		A0_20._init_angle = nil
	end
	A0_20:set_alpha(L7_27)
end
