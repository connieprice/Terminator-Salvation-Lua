require("shared/Angle")
require("units/beings/player/new_gui/HudPanel")
HurtDirectionIndicatorPanel = HurtDirectionIndicatorPanel or class(HudPanel)
function HurtDirectionIndicatorPanel.init(A0_0, A1_1, A2_2)
	HudPanel.init(A0_0, false)
	A0_0._parent_panel = A1_1
	A0_0._player_unit = A2_2
	A0_0._player_data = A2_2:player_data()
	A0_0._width = A0_0._parent_panel:width()
	A0_0._height = A0_0._parent_panel:height()
	A0_0._centre_x = A0_0._width / 2
	A0_0._centre_y = A0_0._height / 2
	A0_0._radius = tweak_data.player.new_hud.hurt_direction_indicator_panel.RADIUS
	A0_0._panel = A0_0._parent_panel:panel({
		name = "hurt_direction_indicator_panel",
		width = A0_0._width,
		height = A0_0._height,
		valign = "center",
		halign = "center"
	})
	A0_0._hurt_direction_indicator_texture = A0_0._panel:bitmap({
		name = "gui_damage_indicator",
		texture = "gui_damage_indicator"
	})
	A0_0._hurt_direction_indicator_texture:set_center(A0_0._centre_x, A0_0._centre_y)
	A0_0._alpha = 0
	A0_0._alpha_interpolator = Interpolator:new(0, tweak_data.player.new_hud.hurt_direction_indicator_panel.FADE_OUT_SPEED)
	A0_0._alpha_interpolator:set_target(0)
	A0_0._hurt_direction_indicator_texture:set_color(A0_0._hurt_direction_indicator_texture:color():with_alpha(A0_0._alpha))
	A0_0:set_alpha(0)
end
function HurtDirectionIndicatorPanel.panel(A0_3)
	local L1_4
	L1_4 = A0_3._panel
	return L1_4
end
function HurtDirectionIndicatorPanel.visible(A0_5)
	return A0_5._alpha > 0
end
function HurtDirectionIndicatorPanel.set_angle(A0_6, A1_7)
	local L2_8, L3_9, L4_10
	L2_8 = A0_6._centre_x
	L3_9 = A0_6._radius
	L4_10 = math
	L4_10 = L4_10.cos
	L4_10 = L4_10(A1_7 - 90)
	L3_9 = L3_9 * L4_10
	L2_8 = L2_8 + L3_9
	L3_9 = A0_6._centre_y
	L4_10 = A0_6._radius
	L4_10 = L4_10 * math.sin(A1_7 - 90)
	L3_9 = L3_9 + L4_10
	L4_10 = 0
	if A0_6._current_angle then
		L4_10 = angle_diff(A0_6._current_angle, A1_7)
	end
	if L4_10 > 5 or not A0_6._current_angle then
		A0_6._current_angle = A1_7
		A0_6._hurt_direction_indicator_texture:set_rotation(A1_7)
		A0_6._hurt_direction_indicator_texture:set_center(L2_8, L3_9)
	end
end
function HurtDirectionIndicatorPanel.update_hurt_direction(A0_11, A1_12)
	local L2_13, L3_14, L4_15, L5_16
	if A1_12 then
		L2_13 = A0_11._player_unit
		L3_14 = L2_13
		L2_13 = L2_13.camera_data
		L2_13 = L2_13(L3_14)
		L2_13 = L2_13.camera_rotation
		L3_14 = L2_13
		L2_13 = L2_13.y
		L2_13 = L2_13(L3_14)
		L3_14 = Rotation
		L4_15 = A1_12
		L5_16 = Vector3
		L5_16 = L5_16(0, 0, 1)
		L3_14 = L3_14(L4_15, L5_16, L5_16(0, 0, 1))
		L4_15 = L3_14
		L3_14 = L3_14.roll
		L3_14 = L3_14(L4_15)
		L4_15 = Rotation
		L5_16 = L2_13
		L4_15 = L4_15(L5_16, Vector3(0, 0, 1))
		L5_16 = L4_15
		L4_15 = L4_15.roll
		L4_15 = L4_15(L5_16)
		L5_16 = L4_15 - L3_14
		L5_16 = L5_16 + 180
		A0_11:set_angle(L5_16)
	end
end
function HurtDirectionIndicatorPanel.update_alpha(A0_17, A1_18, A2_19)
	local L3_20
	if A2_19 then
		L3_20 = tweak_data
		L3_20 = L3_20.player
		L3_20 = L3_20.hud
		L3_20 = L3_20.DAMAGE_INDICATOR_STAY_TIME
		if A2_19 < L3_20 then
			L3_20 = A0_17._alpha_interpolator
			L3_20 = L3_20.set_value
			L3_20(L3_20, 1)
			L3_20 = A0_17._alpha_interpolator
			L3_20 = L3_20.set_target
			L3_20(L3_20, 0)
			L3_20 = A0_17.use_low_frequency_update
			L3_20(A0_17)
		end
	else
		L3_20 = A0_17._alpha_interpolator
		L3_20 = L3_20.update
		L3_20(L3_20, A1_18)
		L3_20 = A0_17.use_high_frequency_update
		L3_20(A0_17)
	end
	L3_20 = A0_17._alpha_interpolator
	L3_20 = L3_20.value
	L3_20 = L3_20(L3_20)
	A0_17:set_alpha(L3_20)
end
function HurtDirectionIndicatorPanel.instant_hide(A0_21)
	A0_21._alpha_interpolator:set_value(0)
	A0_21._alpha_interpolator:set_target(0)
	A0_21._hurt_direction_indicator_texture:set_color(A0_21._hurt_direction_indicator_texture:color():with_alpha(0))
end
function HurtDirectionIndicatorPanel.update(A0_22, A1_23, A2_24, A3_25)
	A0_22:update_hurt_direction(A3_25)
	A0_22:update_alpha(A1_23, A2_24)
	if A3_25 then
	end
end
function HurtDirectionIndicatorPanel.set_alpha(A0_26, A1_27)
	HudPanel.set_alpha(A0_26, A1_27)
	A0_26._hurt_direction_indicator_texture:set_color(A0_26._hurt_direction_indicator_texture:color():with_alpha(A0_26._alpha))
end
