require("menu/menu_animations/Menu2DPulseAnimation")
require("menu/menu_animations/Menu2DFadeInAnimation")
require("menu/menu_animations/Menu2DFadeOutAnimation")
require("menu/2D/Menu2DUtilities")
Menu2DScreenSlot = Menu2DScreenSlot or class()
function Menu2DScreenSlot.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7)
	local L8_8, L9_9
	A0_0._root_panel = A2_2
	A0_0._widget_border = A6_6
	L9_9 = A2_2
	L8_8 = A2_2.panel
	L8_8 = L8_8(L9_9, {
		x = 0,
		y = A4_4,
		width = A2_2:w(),
		height = A3_3
	})
	A0_0._panel = L8_8
	A0_0._height = A3_3
	A0_0._root_panel = A1_1
	L8_8 = A0_0._panel
	L9_9 = L8_8
	L8_8 = L8_8.text
	L8_8 = L8_8(L9_9, {
		text = "",
		font = "faith_font_22",
		color = tweak_data.menu2d.normal_menu.choice_text_color:with_alpha(0),
		h = A0_0._panel:h(),
		valign = "center",
		vertical = "center",
		align = "right",
		width = A6_6,
		x = 0,
		layer = tweak_data.menu2d.layer_normal
	})
	A0_0._text = L8_8
	L9_9 = A7_7
	L8_8 = A7_7.selection_side
	L8_8 = L8_8(L9_9)
	if L8_8 == "left" then
		L9_9 = A1_1
		L8_8 = A1_1.bitmap
		L8_8 = L8_8(L9_9, {
			texture = "gui_menu_bg_gradient",
			x = 0,
			y = A0_0._text:world_y(),
			w = A0_0._text:world_right() + tweak_data.menu2d.spacing_widget_border
		})
		A0_0._selection_bar = L8_8
		L8_8 = A0_0._text
		L9_9 = L8_8
		L8_8 = L8_8.world_center
		L9_9 = L8_8(L9_9)
		A0_0._selection_bar:set_world_center_y(L9_9)
	else
		L8_8 = A0_0._text
		L9_9 = L8_8
		L8_8 = L8_8.world_right
		L8_8 = L8_8(L9_9)
		L9_9 = tweak_data
		L9_9 = L9_9.menu2d
		L9_9 = L9_9.spacing_widget_border
		L8_8 = L8_8 + L9_9
		L9_9 = A0_0._root_panel
		L9_9 = L9_9.bitmap
		L9_9 = L9_9(L9_9, {
			texture = "gui_resumegame_gradient",
			x = L8_8,
			y = A0_0._panel:world_y(),
			w = A1_1:w() - L8_8,
			h = A0_0._panel:height()
		})
		A0_0._selection_bar = L9_9
	end
	L8_8 = A0_0._selection_bar
	L9_9 = L8_8
	L8_8 = L8_8.set_color
	L8_8(L9_9, A0_0._selection_bar:color():with_alpha(0))
	A0_0._text_animation = nil
	L8_8 = {}
	A0_0._selection_bar_animations = L8_8
end
function Menu2DScreenSlot.disable_selection_bar(A0_10)
	A0_10._selection_bar:parent():remove(A0_10._selection_bar)
	A0_10._selection_bar = nil
	A0_10._selection_bar_animations = {}
end
function Menu2DScreenSlot.destroy(A0_11)
	A0_11._selection_bar:parent():remove(A0_11._selection_bar)
	A0_11._panel:parent():remove(A0_11._panel)
	if A0_11._widget then
		A0_11._widget:destroy()
	end
	A0_11._text_animation = nil
	A0_11._selection_bar_animations = nil
end
function Menu2DScreenSlot.set(A0_12, A1_13)
	A0_12._choice = A1_13
	A0_12._text:set_text(A1_13:text())
	A0_12._panel:show()
	A0_12._widget = A1_13:widget()
	A1_13:open_code()
	if A0_12._widget then
		if A0_12._widget.height then
			A0_12._panel:set_height(A0_12._widget:height())
			if A0_12._selection_bar then
				A0_12._selection_bar:set_height(A0_12._widget:height())
			end
			A0_12._height = A0_12._widget:height()
		end
		A0_12._widget_panel = A0_12._panel:panel({
			x = A0_12._widget_border + 2 * tweak_data.menu2d.spacing_widget_border,
			width = A0_12._panel:width() - A0_12._widget_border - 20
		})
		A0_12._widget:show(A0_12._root_panel, A0_12._widget_panel)
	end
	A0_12:selection_changed(false, true)
end
function Menu2DScreenSlot.update(A0_14, A1_15)
	local L2_16, L3_17, L4_18
	L2_16 = true
	L3_17 = A0_14._text_animation
	if L3_17 then
		L3_17 = A0_14._text_animation
		L4_18 = L3_17
		L3_17 = L3_17.update
		L3_17 = L3_17(L4_18, A1_15)
		if L3_17 == false then
			L2_16 = false
		else
			A0_14._text_animation = nil
		end
	end
	L3_17 = A0_14._text_animation
	if L3_17 == nil then
		L3_17 = A0_14._activate_pulse
		if L3_17 then
			L4_18 = A0_14
			L3_17 = A0_14._start_pulse
			L3_17(L4_18)
		end
	end
	L3_17 = TableAlgorithms
	L3_17 = L3_17.is_empty
	L4_18 = A0_14._selection_bar_animations
	L3_17 = L3_17(L4_18)
	if L3_17 == false then
		L3_17 = A0_14._selection_bar_animations
		L3_17 = L3_17[1]
		L4_18 = L3_17
		L3_17 = L3_17.update
		L3_17 = L3_17(L4_18, A1_15)
		if L3_17 == true then
			L4_18 = table
			L4_18 = L4_18.remove
			L4_18(A0_14._selection_bar_animations, 1)
		else
			L2_16 = false
		end
	end
	L3_17 = A0_14._widget
	if L3_17 then
		L3_17 = A0_14._widget
		L4_18 = L3_17
		L3_17 = L3_17.update
		L3_17(L4_18, A1_15)
	end
	A0_14._transition_done = L2_16
	L3_17 = A0_14._text
	L4_18 = L3_17
	L3_17 = L3_17.world_center
	L4_18 = L3_17(L4_18)
	if A0_14._selection_bar then
		A0_14._selection_bar:set_world_center_y(L4_18)
	end
end
function Menu2DScreenSlot.stop_animation(A0_19)
	A0_19._text:stop()
end
function Menu2DScreenSlot.hide(A0_20, A1_21)
	A0_20._panel:hide()
end
function Menu2DScreenSlot.show(A0_22, A1_23)
	A0_22._panel:show()
end
function Menu2DScreenSlot.animations_fade_completed(A0_24)
	local L1_25
	L1_25 = A0_24._transition_done
	return L1_25
end
function Menu2DScreenSlot.visible(A0_26, A1_27)
	return A0_26._panel:visible()
end
function Menu2DScreenSlot.height(A0_28)
	local L1_29
	L1_29 = A0_28._height
	return L1_29
end
function Menu2DScreenSlot.y(A0_30)
	return A0_30._panel:y()
end
function Menu2DScreenSlot.widget_texture(A0_31)
	return A0_31._widget:texture()
end
function Menu2DScreenSlot.text(A0_32)
	local L1_33
	L1_33 = A0_32._text
	return L1_33
end
function Menu2DScreenSlot.world_y(A0_34)
	return A0_34._panel:world_y()
end
function Menu2DScreenSlot.bottom_y(A0_35)
	return A0_35._panel:y() + A0_35._panel:h()
end
function Menu2DScreenSlot.empty(A0_36)
	return A0_36._choice:empty()
end
function Menu2DScreenSlot.choice(A0_37)
	local L1_38
	L1_38 = A0_37._choice
	return L1_38
end
function Menu2DScreenSlot._start_pulse(A0_39)
	A0_39._text:set_color(tweak_data.menu2d.normal_menu.choice_text_color_active)
	A0_39._text_animation = Menu2DPulseAnimation:new(A0_39._text, tweak_data.menu2d.animation.choice_pulse_speed, tweak_data.menu2d.animation.choice_pulse_low_alpha, tweak_data.menu2d.animation.choice_pulse_high_alpha, tweak_data.menu2d.animation.choice_pulse_wait)
	A0_39._activate_pulse = nil
end
function Menu2DScreenSlot.fast_fade_selection_bar(A0_40)
	local L1_41
	L1_41 = Menu2DFadeOutAnimation
	L1_41 = L1_41.new
	L1_41 = L1_41(L1_41, A0_40._selection_bar, 0, 0.01, 0)
	A0_40._selection_bar_animations = {}
	table.insert(A0_40._selection_bar_animations, L1_41)
end
function Menu2DScreenSlot.selection_changed(A0_42, A1_43, A2_44, A3_45)
	local L4_46, L5_47
	A0_42._active = A1_43
	A0_42._activate_pulse = A1_43
	if A1_43 == true then
		L4_46 = A0_42._choice
		L5_47 = L4_46
		L4_46 = L4_46.set_active
		L4_46(L5_47, A2_44)
		L4_46 = A0_42._selection_bar
		if L4_46 then
			L4_46 = Menu2DFadeInAnimation
			L5_47 = L4_46
			L4_46 = L4_46.new
			L4_46 = L4_46(L5_47, A0_42._selection_bar, 0, 0.25, 1)
			L5_47 = {}
			A0_42._selection_bar_animations = L5_47
			L5_47 = table
			L5_47 = L5_47.insert
			L5_47(A0_42._selection_bar_animations, L4_46)
		end
	else
		L4_46 = A0_42._choice
		L5_47 = L4_46
		L4_46 = L4_46.set_inactive
		L4_46(L5_47, A2_44)
		L4_46 = A0_42._selection_bar
		if L4_46 then
			L4_46 = {}
			A0_42._selection_bar_animations = L4_46
			L4_46 = 0.25
			if A3_45 then
				L4_46 = 0.01
			end
			L5_47 = Menu2DFadeOutAnimation
			L5_47 = L5_47.new
			L5_47 = L5_47(L5_47, A0_42._selection_bar, 0, L4_46, 0)
			table.insert(A0_42._selection_bar_animations, L5_47)
		end
		L4_46 = A0_42._text
		L5_47 = L4_46
		L4_46 = L4_46.set_color
		L4_46(L5_47, tweak_data.menu2d.normal_menu.choice_text_color)
		L4_46 = Menu2DFadeOutAnimation
		L5_47 = L4_46
		L4_46 = L4_46.new
		L4_46 = L4_46(L5_47, A0_42._text, 0, 0.25, 1)
		A0_42._text_animation = L4_46
	end
	L4_46 = A0_42._widget
	if L4_46 then
		L4_46 = A0_42._widget
		L5_47 = L4_46
		L4_46 = L4_46.selection_changed
		L4_46(L5_47, A1_43)
	end
end
function Menu2DScreenSlot.destroy(A0_48, A1_49)
	A0_48._root_panel:remove(A0_48._panel)
end
function Menu2DScreenSlot.transition(A0_50, A1_51, A2_52)
	local L3_53
	if A1_51 == "fade_in" then
		L3_53 = A0_50._text
		L3_53 = L3_53.set_color
		L3_53(L3_53, tweak_data.menu2d.normal_menu.choice_text_color:with_alpha(0))
		L3_53 = Menu2DFadeInAnimation
		L3_53 = L3_53.new
		L3_53 = L3_53(L3_53, A0_50._text, 0, 0.25, 1)
		A0_50._text_animation = L3_53
	end
	if A1_51 == "fade_out" then
		L3_53 = A0_50._selection_bar
		if L3_53 then
			L3_53 = Menu2DFadeOutAnimation
			L3_53 = L3_53.new
			L3_53 = L3_53(L3_53, A0_50._selection_bar, 0, 0.25, 0)
			table.insert(A0_50._selection_bar_animations, L3_53)
		end
		L3_53 = Menu2DFadeOutAnimation
		L3_53 = L3_53.new
		L3_53 = L3_53(L3_53, A0_50._text, 0, 0.25, 0)
		A0_50._text_animation = L3_53
		A0_50._activate_pulse = nil
	end
	L3_53 = A0_50._widget
	if L3_53 then
		L3_53 = A0_50._widget
		L3_53 = L3_53.animate
		L3_53(L3_53, A1_51, A2_52)
	end
end
function Menu2DScreenSlot.confirm_mode(A0_54)
	if A0_54._widget then
		return A0_54._widget:confirm_mode()
	end
	if A0_54._choice then
		return "confirm"
	end
	return nil
end
function Menu2DScreenSlot.is_mouse_over_slot(A0_55, A1_56)
	return Menu2DUtilities.is_position_over_gui_object(A1_56, A0_55._panel)
end
function Menu2DScreenSlot.is_mouse_over_choice(A0_57, A1_58)
	if not A0_57._selection_bar then
		return A0_57:is_mouse_over_slot(A1_58)
	end
	return Menu2DUtilities.is_position_over_gui_object(A1_58, A0_57._selection_bar)
end
function Menu2DScreenSlot.is_mouse_over_widget(A0_59, A1_60)
	if not A0_59._widget_panel then
		return false
	end
	return Menu2DUtilities.is_position_over_gui_object(A1_60, A0_59._widget_panel)
end
function Menu2DScreenSlot.mouse_input(A0_61, A1_62)
	A0_61._widget:mouse_input(A1_62)
end
