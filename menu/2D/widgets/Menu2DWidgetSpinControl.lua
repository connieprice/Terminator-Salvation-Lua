require("menu/2D/widgets/Menu2DWidgetBase.lua")
Menu2DWidgetSpinControl = Menu2DWidgetSpinControl or class(Menu2DWidgetBase)
Menu2DWidgetSpinControl._bmp_inactive_alpha = 0.3
Menu2DWidgetSpinControl._text_inactive_alpha = 0.6
function Menu2DWidgetSpinControl.init(A0_0, A1_1)
	Menu2DWidgetBase.init(A0_0, A1_1)
	A0_0._choices = {}
	A0_0._animation_time = 0.2
end
function Menu2DWidgetSpinControl.parse(A0_2, A1_3)
end
function Menu2DWidgetSpinControl.update(A0_4, A1_5)
	if A0_4._left_arrow_animation and A0_4._left_arrow_animation:update(A1_5) then
		A0_4._left_arrow_animation = nil
	end
	if A0_4._right_arrow_animation and A0_4._right_arrow_animation:update(A1_5) then
		A0_4._right_arrow_animation = nil
	end
	if A0_4._text_animation and A0_4._text_animation:update(A1_5) then
		A0_4._text_animation = nil
	end
end
function Menu2DWidgetSpinControl.selected_choice(A0_6)
	local L1_7
	L1_7 = A0_6._selected_index
	return L1_7
end
function Menu2DWidgetSpinControl.set_selected_choice(A0_8, A1_9)
	A0_8._selected_index = A1_9
end
function Menu2DWidgetSpinControl.add_choice(A0_10, A1_11)
	local L2_12
	if A1_11.ignore_localization ~= true then
		L2_12 = managers.localization:text(A1_11.text)
	else
		L2_12 = A1_11.text
	end
	table.insert(A0_10._choices, L2_12)
end
function Menu2DWidgetSpinControl.clear(A0_13)
	A0_13._choices = {}
end
function Menu2DWidgetSpinControl.create_gui(A0_14)
	local L1_15, L2_16, L3_17, L4_18, L5_19, L6_20
	L1_15 = 80
	L2_16 = A0_14._params
	L2_16 = L2_16.panel
	L3_17 = L2_16
	L2_16 = L2_16.set_width
	L4_18 = A0_14._params
	L4_18 = L4_18.panel
	L5_19 = L4_18
	L4_18 = L4_18.width
	L4_18 = L4_18(L5_19)
	L4_18 = L4_18 - L1_15
	L2_16(L3_17, L4_18)
	L2_16 = A0_14._params
	L2_16 = L2_16.panel
	L3_17 = L2_16
	L2_16 = L2_16.x
	L2_16 = L2_16(L3_17)
	L3_17 = A0_14._params
	L3_17 = L3_17.panel
	L4_18 = L3_17
	L3_17 = L3_17.x
	L3_17 = L3_17(L4_18)
	L4_18 = A0_14._params
	L4_18 = L4_18.panel
	L5_19 = L4_18
	L4_18 = L4_18.width
	L4_18 = L4_18(L5_19)
	L5_19 = A0_14._params
	L5_19 = L5_19.panel
	L6_20 = L5_19
	L5_19 = L5_19.height
	L5_19 = L5_19(L6_20)
	L6_20 = A0_14._params
	L6_20 = L6_20.panel
	L6_20 = L6_20.bitmap
	L6_20 = L6_20(L6_20, {
		x = 0,
		texture = "gui_menu_scroll_arrow",
		rotation = 270,
		layer = 3,
		color = Color.white:with_alpha(0)
	})
	A0_14._left_arrow = L6_20
	L6_20 = A0_14._params
	L6_20 = L6_20.panel
	L6_20 = L6_20.bitmap
	L6_20 = L6_20(L6_20, {
		x = L4_18 - A0_14._left_arrow:texture_width(),
		texture = "gui_menu_scroll_arrow",
		rotation = 90,
		layer = 3,
		color = Color.white:with_alpha(0)
	})
	A0_14._right_arrow = L6_20
	L6_20 = A0_14._selected_index
	L6_20 = L6_20 or 1
	A0_14._selected_index = L6_20
	L6_20 = A0_14._params
	L6_20 = L6_20.panel
	L6_20 = L6_20.text
	L6_20 = L6_20(L6_20, {
		text = A0_14._choices[A0_14._selected_index],
		color = Color.white:with_alpha(0),
		align = "center",
		valign = "center",
		font = "faith_font_22",
		font_scale = tweak_data.menu2d.controls.text_scale,
		x = 0,
		y = 0,
		layer = 3,
		wrap = true,
		word_wrap = true
	})
	A0_14._text = L6_20
	L6_20 = A0_14._text
	L6_20 = L6_20.world_center_y
	L6_20 = L6_20(L6_20)
	A0_14._left_arrow:set_world_center_y(L6_20)
	A0_14._right_arrow:set_world_center_y(L6_20)
end
function Menu2DWidgetSpinControl.set_active(A0_21, A1_22)
end
function Menu2DWidgetSpinControl.set_inactive(A0_23, A1_24)
end
function Menu2DWidgetSpinControl.destroy(A0_25)
	A0_25._params.panel:remove(A0_25._left_arrow)
	A0_25._params.panel:remove(A0_25._right_arrow)
	A0_25._params.panel:remove(A0_25._text)
end
function Menu2DWidgetSpinControl.animate(A0_26, A1_27, A2_28)
	if A1_27 == "fade_out" then
		A0_26._left_arrow_animation = Menu2DFadeOutAnimation:new(A0_26._left_arrow, 0, A0_26._animation_time, 0)
		A0_26._right_arrow_animation = Menu2DFadeOutAnimation:new(A0_26._right_arrow, 0, A0_26._animation_time, 0)
		A0_26._text_animation = Menu2DFadeOutAnimation:new(A0_26._text, 0, A0_26._animation_time, 0)
	elseif A1_27 == "fade_in" then
		A0_26._left_arrow_animation = Menu2DFadeInAnimation:new(A0_26._left_arrow, 0, A0_26._animation_time, 1)
		A0_26._right_arrow_animation = Menu2DFadeInAnimation:new(A0_26._right_arrow, 0, A0_26._animation_time, 1)
		A0_26._text_animation = Menu2DFadeInAnimation:new(A0_26._text, 0, A0_26._animation_time, 1)
	end
end
function Menu2DWidgetSpinControl.confirm_mode(A0_29)
	local L1_30
	L1_30 = "confirm"
	return L1_30
end
function Menu2DWidgetSpinControl._set_new_index(A0_31, A1_32)
	if A1_32 == 0 then
		A1_32 = #A0_31._choices
	elseif A1_32 == #A0_31._choices + 1 then
		A1_32 = 1
	end
	A0_31._selected_index = A1_32
	A0_31._text:set_text(A0_31._choices[A0_31._selected_index])
end
function Menu2DWidgetSpinControl.input(A0_33, A1_34)
	local L2_35
	if A1_34.x > 0 then
		L2_35 = A0_33._selected_index + 1
	elseif A1_34.x < 0 then
		L2_35 = A0_33._selected_index - 1
	end
	if L2_35 then
		A0_33:_set_new_index(L2_35)
	end
end
function Menu2DWidgetSpinControl.mouse_input(A0_36, A1_37)
	local L2_38
	L2_38 = A1_37.cursor_position
	if L2_38 then
		L2_38 = A1_37.select
		if L2_38 then
			L2_38 = nil
			if Menu2DUtilities.is_position_over_gui_object(A1_37.cursor_position, A0_36._left_arrow) then
				L2_38 = A0_36._selected_index - 1
			elseif Menu2DUtilities.is_position_over_gui_object(A1_37.cursor_position, A0_36._right_arrow) then
				L2_38 = A0_36._selected_index + 1
			end
			if L2_38 then
				A0_36:_set_new_index(L2_38)
			end
		end
	end
end
