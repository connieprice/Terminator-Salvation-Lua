require("units/beings/player/new_gui/IconStates")
WeaponSelectionIcon = WeaponSelectionIcon or class()
function WeaponSelectionIcon.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._parent_panel = A1_1
	A0_0._weapon_selection_index = A3_3
	A0_0._icon_texture_name = A2_2 or "gui_inv_empty"
	A0_0._weapon_selection_index = A3_3
	A0_0._x = A0_0._parent_panel:center_x()
	A0_0._y = A0_0._parent_panel:center_y()
	A0_0._icon_panel = A0_0._parent_panel:panel({
		name = "weapon_icon_panel",
		width = 512,
		height = 128
	})
	A0_0._background_texture = A0_0._icon_panel:bitmap({
		name = "background",
		texture = "gui_weaponselection_gradient"
	})
	A0_0._pixels_to_move = tweak_data.player.new_hud.weapon_selection_panel.SELECTED_ICON_PIXELS_TO_MOVE
	if A3_3 == 1 then
		A0_0._y = A0_0._y - tweak_data.player.new_hud.weapon_selection_panel.Y_OFFSET
		A0_0._x = A0_0._x + tweak_data.player.new_hud.weapon_selection_panel.X_OFFSET
		A0_0._icon_panel:set_leftbottom(A0_0._x, A0_0._y)
		A0_0._end_position = A0_0._icon_panel:x() + A0_0._pixels_to_move
		A0_0._background_texture:set_texture_rect(512, 0, -512, 128)
	elseif A3_3 == 2 then
		A0_0._y = A0_0._y + tweak_data.player.new_hud.weapon_selection_panel.Y_OFFSET
		A0_0._x = A0_0._x + tweak_data.player.new_hud.weapon_selection_panel.X_OFFSET
		A0_0._icon_panel:set_lefttop(A0_0._x, A0_0._y)
		A0_0._end_position = A0_0._icon_panel:x() + A0_0._pixels_to_move
		A0_0._background_texture:rotate(180)
	elseif A3_3 == 3 then
		A0_0._y = A0_0._y + tweak_data.player.new_hud.weapon_selection_panel.Y_OFFSET
		A0_0._x = A0_0._x - tweak_data.player.new_hud.weapon_selection_panel.X_OFFSET
		A0_0._icon_panel:set_righttop(A0_0._x, A0_0._y)
		A0_0._end_position = A0_0._icon_panel:x() - A0_0._pixels_to_move
		A0_0._background_texture:set_texture_rect(512, 0, -512, 128)
		A0_0._background_texture:rotate(180)
	elseif A3_3 == 4 then
		A0_0._y = A0_0._y - tweak_data.player.new_hud.weapon_selection_panel.Y_OFFSET
		A0_0._x = A0_0._x - tweak_data.player.new_hud.weapon_selection_panel.X_OFFSET
		A0_0._icon_panel:set_rightbottom(A0_0._x, A0_0._y)
		A0_0._end_position = A0_0._icon_panel:x() - A0_0._pixels_to_move
	else
		assert(false)
	end
	A0_0._icon_texture = A0_0._icon_panel:bitmap({name = A2_2, texture = A2_2})
	A0_0._icon_texture:set_center_x(A0_0._icon_panel:width() / 2)
	A0_0._icon_texture:set_center_y(A0_0._icon_panel:height() / 2)
	A0_0._x = A0_0._icon_panel:x()
	A0_0._y = A0_0._icon_panel:y()
	A0_0:set_alpha(0)
	A0_0._state = FiniteStateMachine:new(A0_0, "_icon", IconIdleState)
	A0_0._state:set_debug(false)
end
function WeaponSelectionIcon.set_weapon_icon(A0_4, A1_5)
	if A1_5 ~= A0_4._icon_texture_name then
		A0_4._icon_texture:set_image(A1_5)
		A0_4._icon_texture_name = A1_5
	end
end
function WeaponSelectionIcon.reset_position(A0_6)
	local L1_7, L2_8
	L2_8 = A0_6
	L1_7 = A0_6.set_position
	L1_7(L2_8, A0_6:get_start_position())
end
function WeaponSelectionIcon.get_end_position(A0_9)
	local L1_10
	L1_10 = A0_9._end_position
	return L1_10
end
function WeaponSelectionIcon.get_current_position(A0_11)
	return A0_11._icon_panel:x()
end
function WeaponSelectionIcon.get_start_position(A0_12)
	local L1_13
	L1_13 = A0_12._x
	return L1_13
end
function WeaponSelectionIcon.set_position(A0_14, A1_15)
	A0_14._icon_panel:set_x(A1_15)
end
function WeaponSelectionIcon.get_alpha(A0_16)
	local L1_17
	L1_17 = A0_16._alpha
	return L1_17
end
function WeaponSelectionIcon.set_alpha(A0_18, A1_19)
	local L2_20, L3_21
	A0_18._alpha = A1_19
	L2_20 = A0_18._background_texture
	L3_21 = L2_20
	L2_20 = L2_20.set_color
	L2_20(L3_21, A0_18._background_texture:color():with_alpha(A0_18._alpha))
	L2_20 = A0_18._icon_texture
	L3_21 = L2_20
	L2_20 = L2_20.set_color
	L2_20(L3_21, A0_18._icon_texture:color():with_alpha(A0_18._alpha))
end
function WeaponSelectionIcon.wants_to_move_out(A0_22)
	local L1_23
	L1_23 = A0_22._wants_to_move_out
	return L1_23
end
function WeaponSelectionIcon.wants_to_move_in(A0_24)
	local L1_25
	L1_25 = A0_24._wants_to_move_in
	return L1_25
end
function WeaponSelectionIcon.wants_to_idle(A0_26)
	local L1_27
	L1_27 = A0_26._wants_to_idle
	return L1_27
end
function WeaponSelectionIcon.wants_to_hide(A0_28)
	local L1_29
	L1_29 = A0_28._wants_to_hide
	return L1_29
end
function WeaponSelectionIcon.wants_to_blink(A0_30)
	local L1_31
	L1_31 = A0_30._wants_to_blink
	return L1_31
end
function WeaponSelectionIcon.default_select(A0_32)
	local L1_33
	A0_32._default_selected = true
end
function WeaponSelectionIcon.clear_default_select(A0_34)
	local L1_35
	A0_34._default_selected = false
end
function WeaponSelectionIcon.is_default_selected(A0_36)
	local L1_37
	L1_37 = A0_36._default_selected
	return L1_37
end
function WeaponSelectionIcon.select(A0_38)
	A0_38:_all_states_false()
	A0_38._wants_to_move_out = true
end
function WeaponSelectionIcon.unselect(A0_39)
	A0_39:_all_states_false()
	A0_39._wants_to_move_in = true
end
function WeaponSelectionIcon.idle(A0_40)
	A0_40:_all_states_false()
	A0_40._wants_to_idle = true
end
function WeaponSelectionIcon.hide(A0_41)
	A0_41:_all_states_false()
	A0_41._wants_to_hide = true
end
function WeaponSelectionIcon.blink(A0_42)
	A0_42:_all_states_false()
	A0_42._wants_to_blink = true
end
function WeaponSelectionIcon._all_states_false(A0_43)
	local L1_44
	A0_43._wants_to_blink = false
	A0_43._wants_to_hide = false
	A0_43._wants_to_move_in = false
	A0_43._wants_to_move_out = false
	A0_43._wants_to_idle = false
end
function WeaponSelectionIcon.get_selected_icon_fade_in_speed(A0_45)
	local L1_46
	L1_46 = tweak_data
	L1_46 = L1_46.player
	L1_46 = L1_46.new_hud
	L1_46 = L1_46.weapon_selection_panel
	L1_46 = L1_46.SELECTED_ICON_FADE_IN_SPEED
	return L1_46
end
function WeaponSelectionIcon.get_selected_icon_fade_out_speed(A0_47)
	local L1_48
	L1_48 = tweak_data
	L1_48 = L1_48.player
	L1_48 = L1_48.new_hud
	L1_48 = L1_48.weapon_selection_panel
	L1_48 = L1_48.SELECTED_ICON_FADE_OUT_SPEED
	return L1_48
end
function WeaponSelectionIcon.get_selected_icon_move_in_speed(A0_49)
	local L1_50
	L1_50 = tweak_data
	L1_50 = L1_50.player
	L1_50 = L1_50.new_hud
	L1_50 = L1_50.weapon_selection_panel
	L1_50 = L1_50.SELECTED_ICON_MOVE_SPEED
	return L1_50
end
function WeaponSelectionIcon.get_selected_icon_move_out_speed(A0_51)
	local L1_52
	L1_52 = tweak_data
	L1_52 = L1_52.player
	L1_52 = L1_52.new_hud
	L1_52 = L1_52.weapon_selection_panel
	L1_52 = L1_52.SELECTED_ICON_MOVE_SPEED
	return L1_52
end
function WeaponSelectionIcon.get_move_in_alpha_target(A0_53)
	local L1_54
	L1_54 = tweak_data
	L1_54 = L1_54.player
	L1_54 = L1_54.new_hud
	L1_54 = L1_54.weapon_selection_panel
	L1_54 = L1_54.INACTIVE_ICON_ALPHA
	return L1_54
end
function WeaponSelectionIcon.get_move_out_alpha_target(A0_55)
	local L1_56
	L1_56 = 1
	return L1_56
end
function WeaponSelectionIcon.get_selected_icon_blink_speed(A0_57)
	local L1_58
	L1_58 = tweak_data
	L1_58 = L1_58.player
	L1_58 = L1_58.new_hud
	L1_58 = L1_58.weapon_selection_panel
	L1_58 = L1_58.SELECTED_ICON_BLINK_SPEED
	return L1_58
end
function WeaponSelectionIcon.get_selected_icon_blink_times(A0_59)
	local L1_60
	L1_60 = tweak_data
	L1_60 = L1_60.player
	L1_60 = L1_60.new_hud
	L1_60 = L1_60.weapon_selection_panel
	L1_60 = L1_60.SELECTED_ICON_BLINK_TIMES
	return L1_60
end
function WeaponSelectionIcon.update(A0_61, A1_62)
	A0_61._state:update(A1_62)
end
