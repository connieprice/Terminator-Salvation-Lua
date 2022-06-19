NextCoverIndicatorIcon = NextCoverIndicatorIcon or class()
function NextCoverIndicatorIcon.init(A0_0, A1_1, A2_2)
	A0_0._parent_panel = A1_1
	A0_0._width = A0_0._parent_panel:width()
	A0_0._height = A0_0._parent_panel:height()
	A0_0._centre_x = A0_0._width / 2
	A0_0._centre_y = A0_0._height / 2
	A0_0._radius = tweak_data.player.new_hud.next_cover_indicator_panel.RADIUS
	A0_0:_set_up_icon(A2_2)
end
function NextCoverIndicatorIcon._set_up_icon(A0_3, A1_4)
	A0_3._icon_texture = A0_3._parent_panel:bitmap({
		name = "gui_coverdirection_icon",
		texture = "gui_coverdirection_icon"
	})
	if A1_4 == 1 then
		A0_3:_set_angle(360 - tweak_data.player.new_hud.next_cover_indicator_panel.ANGLE_BETWEEN_ICONS * 2)
	elseif A1_4 == 2 then
		A0_3:_set_angle(360 - tweak_data.player.new_hud.next_cover_indicator_panel.ANGLE_BETWEEN_ICONS)
	elseif A1_4 == 3 then
		A0_3:_set_angle(0)
	elseif A1_4 == 4 then
		A0_3:_set_angle(0 + tweak_data.player.new_hud.next_cover_indicator_panel.ANGLE_BETWEEN_ICONS)
	elseif A1_4 == 5 then
		A0_3:_set_angle(0 + tweak_data.player.new_hud.next_cover_indicator_panel.ANGLE_BETWEEN_ICONS * 2)
	else
		assert(false)
	end
	A0_3._normal_color = A0_3._icon_texture:color()
	A0_3._desaturated_color = A0_3._icon_texture:color() / 3
end
function NextCoverIndicatorIcon._set_angle(A0_5, A1_6)
	local L2_7, L3_8
	L2_7 = A0_5._centre_x
	L3_8 = A0_5._radius
	L3_8 = L3_8 * math.cos(A1_6 - 90)
	L2_7 = L2_7 + L3_8
	L3_8 = A0_5._centre_y
	L3_8 = L3_8 + A0_5._radius * math.sin(A1_6 - 90)
	A0_5._icon_texture:set_rotation(A1_6)
	A0_5._icon_texture:set_center(L2_7, L3_8)
end
function NextCoverIndicatorIcon.set_alpha(A0_9, A1_10)
	local L2_11, L3_12
	L2_11 = A0_9._selected_icon
	if not L2_11 then
		L2_11 = tweak_data
		L2_11 = L2_11.player
		L2_11 = L2_11.new_hud
		L2_11 = L2_11.next_cover_indicator_panel
		L2_11 = L2_11.INACTIVE_ICON_ALPHA
		A1_10 = A1_10 * L2_11
	end
	A0_9._alpha = A1_10
	L2_11 = A0_9._icon_texture
	L3_12 = L2_11
	L2_11 = L2_11.set_color
	L2_11(L3_12, A0_9._icon_texture:color():with_alpha(A0_9._alpha))
end
function NextCoverIndicatorIcon.select(A0_13)
	A0_13._selected_icon = true
	A0_13._icon_texture:set_color(A0_13._normal_color)
end
function NextCoverIndicatorIcon.unselect(A0_14)
	A0_14._selected_icon = false
	A0_14._icon_texture:set_color(A0_14._normal_color)
end
function NextCoverIndicatorIcon.unavailable(A0_15)
	A0_15._selected_icon = false
	A0_15._icon_texture:set_color(A0_15._desaturated_color)
end
function NextCoverIndicatorIcon.blink(A0_16)
	local L1_17
	A0_16.blinking = true
end
function NextCoverIndicatorIcon.get_selected_icon_blink_speed(A0_18)
	local L1_19
	L1_19 = tweak_data
	L1_19 = L1_19.player
	L1_19 = L1_19.new_hud
	L1_19 = L1_19.next_cover_indicator_panel
	L1_19 = L1_19.SELECTED_ICON_BLINK_SPEED
	return L1_19
end
function NextCoverIndicatorIcon.get_selected_icon_blink_times(A0_20)
	local L1_21
	L1_21 = tweak_data
	L1_21 = L1_21.player
	L1_21 = L1_21.new_hud
	L1_21 = L1_21.next_cover_indicator_panel
	L1_21 = L1_21.SELECTED_ICON_BLINK_TIMES
	return L1_21
end
function NextCoverIndicatorIcon.update(A0_22, A1_23)
end
