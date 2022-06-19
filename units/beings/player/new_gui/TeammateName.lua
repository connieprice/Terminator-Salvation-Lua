TeammateName = TeammateName or class()
function TeammateName.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	A0_0._parent_panel = A1_1
	A0_0._player_unit = A2_2
	A0_0._display_unit = A3_3
	A0_0._camera = A4_4
	A0_0._alpha_interpolator = Interpolator:new(0, tweak_data.player.new_hud.teammate_name_panel.FADE_IN_SPEED)
	A0_0._alpha_interpolator:set_target(1)
	A0_0:_show_name()
	A0_0._t = 0
	A0_0._next_scan_time = 0
end
function TeammateName.panel(A0_5)
	local L1_6
	L1_6 = A0_5._teammate_name_panel
	return L1_6
end
function TeammateName._show_name(A0_7)
	local L1_8
	if not alive(A0_7._display_unit) then
		return
	end
	if A0_7._display_unit:hud() and A0_7._display_unit:hud().teammate_name then
		if managers.localization:exists(A0_7._display_unit:hud().teammate_name) then
			L1_8 = managers.localization:text(A0_7._display_unit:hud().teammate_name)
		else
			L1_8 = A0_7._display_unit:hud().teammate_name
		end
	else
		L1_8 = A0_7._display_unit:name()
	end
	A0_7._teammate_name_text = A0_7._parent_panel:text({
		text = L1_8,
		font = tweak_data.player.new_hud.teammate_name_panel.TEXT_FONT,
		font_size = tweak_data.player.new_hud.teammate_name_panel.TEXT_FONT_SIZE,
		valign = "center",
		color = tweak_data.player.new_hud.teammate_name_panel.TEXT_FONT_COLOR
	})
	A0_7:_update_position()
end
function TeammateName._update_position(A0_9)
	local L1_10, L2_11, L3_12, L4_13
	L1_10 = alive
	L2_11 = A0_9._camera
	L1_10 = L1_10(L2_11)
	if L1_10 then
		L1_10 = Vector3
		L2_11 = 0
		L3_12 = 0
		L4_13 = tweak_data
		L4_13 = L4_13.player
		L4_13 = L4_13.new_hud
		L4_13 = L4_13.teammate_name_panel
		L4_13 = L4_13.NAME_Z_OFFSET
		L1_10 = L1_10(L2_11, L3_12, L4_13)
		L2_11 = A0_9._camera
		L3_12 = L2_11
		L2_11 = L2_11.world_to_screen
		L4_13 = A0_9._display_unit
		L4_13 = L4_13.position
		L4_13 = L4_13(L4_13)
		L4_13 = L4_13 + L1_10
		L2_11 = L2_11(L3_12, L4_13)
		L4_13 = A0_9
		L3_12 = A0_9._screen_to_resolution
		L4_13 = L3_12(L4_13, L2_11)
		A0_9._teammate_name_text:set_center(L3_12, L4_13)
		A0_9._teammate_name_text:set_vertical("center")
		A0_9._teammate_name_text:set_align("center")
		if not A0_9._wants_to_hide then
			if A0_9:_display_unit_is_infront() then
				A0_9:show()
			else
				A0_9:instant_hide()
			end
		end
	end
end
function TeammateName._display_unit_is_infront(A0_14)
	local L1_15, L2_16, L3_17
	L1_15 = A0_14._player_unit
	L2_16 = L1_15
	L1_15 = L1_15.camera_data
	L1_15 = L1_15(L2_16)
	L1_15 = L1_15.camera_rotation
	L2_16 = A0_14._display_unit
	L3_17 = L2_16
	L2_16 = L2_16.position
	L2_16 = L2_16(L3_17)
	L3_17 = A0_14._display_unit
	L3_17 = L3_17.position
	L3_17 = L3_17(L3_17)
	L3_17 = L3_17 - A0_14._player_unit:camera_data().camera_position
	return L1_15:y():dot(L3_17) > 0
end
function TeammateName.show(A0_18)
	A0_18._wants_to_hide = false
	A0_18._alpha_interpolator:set_target(1)
	A0_18._alpha_interpolator:set_speed(tweak_data.player.new_hud.teammate_name_panel.FADE_IN_SPEED)
end
function TeammateName.hide(A0_19)
	A0_19._wants_to_hide = true
	A0_19._alpha_interpolator:set_target(0)
	A0_19._alpha_interpolator:set_speed(tweak_data.player.new_hud.teammate_name_panel.FADE_OUT_SPEED)
end
function TeammateName.instant_hide(A0_20)
	A0_20._wants_to_hide = true
	A0_20._alpha_interpolator:set_target(0)
	A0_20._alpha_interpolator:set_value(0)
	A0_20._alpha_interpolator:set_speed(tweak_data.player.new_hud.teammate_name_panel.FADE_OUT_SPEED)
end
function TeammateName.remove(A0_21)
	A0_21._parent_panel:remove(A0_21._teammate_name_text)
	A0_21._teammate_name_text = nil
end
function TeammateName.visible(A0_22)
	return A0_22._alpha > 0 or 0 < A0_22._alpha_interpolator:target()
end
function TeammateName._set_alpha(A0_23, A1_24)
	local L2_25, L3_26
	A0_23._alpha = A1_24
	L2_25 = A0_23._teammate_name_text
	if L2_25 then
		L2_25 = A0_23._teammate_name_text
		L3_26 = L2_25
		L2_25 = L2_25.set_color
		L2_25(L3_26, A0_23._teammate_name_text:color():with_alpha(A0_23._alpha))
	end
end
function TeammateName.update(A0_27, A1_28)
	local L2_29
	L2_29 = A0_27._t
	L2_29 = L2_29 + A1_28
	A0_27._t = L2_29
	L2_29 = A0_27._teammate_name_text
	if L2_29 then
		L2_29 = alive
		L2_29 = L2_29(A0_27._display_unit)
		if L2_29 then
			L2_29 = A0_27._update_position
			L2_29(A0_27)
		end
	end
	L2_29 = A0_27._t
	if L2_29 > A0_27._next_scan_time then
		L2_29 = nil
		A0_27._alpha_interpolator:update(A1_28)
		if A0_27._alpha_interpolator:has_reached_target() then
			L2_29 = A0_27._alpha_interpolator:target()
		else
			L2_29 = A0_27._alpha_interpolator:value()
		end
		A0_27:_set_alpha(L2_29)
		if L2_29 > 0 and L2_29 < 1 then
			A0_27._next_scan_time = A0_27._t
		else
			A0_27._next_scan_time = A0_27._t + tweak_data.player.new_hud.teammate_name_panel.UPDATE_FREQUENCY
		end
	end
end
function TeammateName._screen_to_resolution(A0_30, A1_31)
	local L2_32, L3_33
	L2_32 = A0_30._parent_panel
	L3_33 = L2_32
	L2_32 = L2_32.width
	L2_32 = L2_32(L3_33)
	L2_32 = L2_32 / 2
	L3_33 = A0_30._parent_panel
	L3_33 = L3_33.width
	L3_33 = L3_33(L3_33)
	L3_33 = L3_33 / 2
	L3_33 = L3_33 * A1_31.x
	L2_32 = L2_32 + L3_33
	L3_33 = A0_30._parent_panel
	L3_33 = L3_33.height
	L3_33 = L3_33(L3_33)
	L3_33 = L3_33 / 2
	L3_33 = L3_33 + A0_30._parent_panel:height() / 2 * A1_31.y
	return L2_32, L3_33
end
