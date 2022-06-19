require("menu/2D/Menu2DPageControllerUtil")
require("menu/2D/Menu2DScroller")
require("menu/menu_animations/Menu2DPulseAnimation")
require("controller/ControllerWrapperInputPressedChecker")
Menu2DPageControllerPC = Menu2DPageControllerPC or class(Menu2DPage)
function Menu2DPageControllerPC.init(A0_0, A1_1, A2_2)
	Menu2DPage.init(A0_0, A1_1, A2_2)
	A0_0._text_spacing = tweak_data.menu2d.controller_pc.text_spacing
	A0_0._slot_size = tweak_data.menu2d.controller_pc.box_spacing + tweak_data.menu2d.controller_pc.box_height
	A0_0._box_height = tweak_data.menu2d.controller_pc.box_height
	A0_0._title_text_id = A1_1:parameter("text")
	A0_0._icon_offset = 5
	A0_0._action_button_background_alpha = 0.2
	A0_0._input_button_background_alpha = 0.5
end
function Menu2DPageControllerPC._parse_controller_setup_xml(A0_3)
	local L1_4
	L1_4 = Menu2DPageControllerUtil
	L1_4 = L1_4.parse_xml
	A0_3._connected_connections, L1_4 = A0_3:controller_wrapper():get_type(), L1_4(A0_3:controller_wrapper():get_type(), A0_3:controller_wrapper())
	A0_3._pc_connections = L1_4
end
function Menu2DPageControllerPC._create_pc_connections_gui(A0_5)
	local L1_6, L2_7, L3_8, L4_9, L5_10, L6_11, L7_12, L8_13, L9_14, L10_15
	L1_6 = {}
	A0_5._button_backgrounds = L1_6
	L1_6 = {}
	A0_5._action_backgrounds = L1_6
	L1_6 = {}
	A0_5._texts = L1_6
	L1_6 = {}
	A0_5._input_texts = L1_6
	L1_6 = {}
	A0_5._fade_objects = L1_6
	L2_7 = A0_5
	L1_6 = A0_5._add_title_text
	L1_6(L2_7)
	L1_6 = A0_5._root_panel
	L2_7 = L1_6
	L1_6 = L1_6.width
	L1_6 = L1_6(L2_7)
	L2_7 = A0_5.controller_wrapper
	L2_7 = L2_7(L3_8)
	for L6_11, L7_12 in L3_8(L4_9) do
		L9_14 = A0_5
		L8_13 = A0_5._add_backgrounds
		L10_15 = A0_5._center_x
		L10_15 = L10_15 - A0_5._box_width
		L8_13(L9_14, L10_15, A0_5._action_button_background_alpha, A0_5._action_backgrounds)
		L9_14 = A0_5
		L8_13 = A0_5._add_backgrounds
		L10_15 = A0_5._center_x
		L8_13(L9_14, L10_15, A0_5._input_button_background_alpha, A0_5._button_backgrounds)
		L8_13 = managers
		L8_13 = L8_13.localization
		L9_14 = L8_13
		L8_13 = L8_13.text
		L10_15 = L7_12.text_id
		L8_13 = L8_13(L9_14, L10_15)
		L10_15 = A0_5
		L9_14 = A0_5._add_text
		L9_14(L10_15, A0_5._texts, L8_13, "right", -A0_5._center_x - A0_5._text_spacing)
		L10_15 = L2_7
		L9_14 = L2_7.get_connection_settings
		L9_14 = L9_14(L10_15, L7_12.name)
		L10_15 = A0_5._get_text
		L10_15 = L10_15(A0_5, L7_12.current_input, L9_14)
		A0_5:_add_text(A0_5._input_texts, L10_15, "left", A0_5._center_x + A0_5._text_spacing)
		A0_5._next_y = A0_5._next_y + A0_5._slot_size
	end
	if L3_8 > L4_9 then
		L6_11 = A0_5._slot_size
		L3_8(L4_9, L5_10)
	end
	L3_8(L4_9)
	L3_8(L4_9, L5_10)
	L3_8(L4_9)
	L3_8(L4_9)
	L6_11 = Color
	L6_11 = L6_11.black
	L7_12 = L6_11
	L6_11 = L6_11.with_alpha
	L8_13 = 0
	L6_11 = L6_11(L7_12, L8_13)
	L5_10.color = L6_11
	L5_10.layer = 2
	A0_5._background = L3_8
	L6_11 = 0
	L7_12 = 0.4
	L8_13 = 0.6
	A0_5._background_animation = L3_8
end
function Menu2DPageControllerPC._add_clickable_buttons(A0_16)
	local L1_17
	L1_17 = A0_16._panel
	L1_17 = L1_17.y
	L1_17 = L1_17(L1_17)
	L1_17 = L1_17 + A0_16._parent_controller_panel:height()
	A0_16._default_text, A0_16._default_text_rect = A0_16:_add_button_and_text("mapping_defaults", A0_16._parent_center_x, L1_17)
	L1_17 = L1_17 + A0_16._box_height * 2
	A0_16._back_text, A0_16._back_text_rect = A0_16:_add_button_and_text("mapping_back", A0_16._parent_center_x, L1_17)
end
function Menu2DPageControllerPC._add_title_text(A0_18)
	local L1_19
	L1_19 = managers
	L1_19 = L1_19.localization
	L1_19 = L1_19.text
	L1_19 = L1_19(L1_19, A0_18._title_text_id)
	A0_18._title = A0_18:_create_text_object(A0_18._panel, L1_19, A0_18._parent_center_x - A0_18._box_width, 0, "left", 3, true)
	A0_18:_fade_object(A0_18._panel, A0_18._title, 0, 1)
	A0_18._parent_controller_panel:set_y(A0_18._parent_controller_panel:y() + A0_18._title:text_rect() + 10)
end
function Menu2DPageControllerPC.update(A0_20, A1_21)
	local L2_22, L3_23
	L2_22 = Menu2DPage
	L2_22 = L2_22.update
	L2_22(L3_23, A1_21)
	L2_22 = A0_20._scroller
	if L2_22 then
		L2_22 = A0_20._scroller
		L2_22 = L2_22.update
		L2_22(L3_23, A1_21)
	end
	L2_22 = A0_20._controller_checker
	if L2_22 then
		L2_22 = A0_20._controller_checker
		L2_22 = L2_22.update
		L2_22(L3_23)
	end
	L2_22 = A0_20._scroller
	if L2_22 then
		L2_22 = A0_20._scroller
		L2_22 = L2_22.get_first_visible_index
		L2_22 = L2_22(L3_23)
		if L2_22 ~= L3_23 then
			A0_20._choice_panel:set_position(A0_20._choice_panel:x(), L3_23)
			A0_20:_set_visible_ids(L2_22, L2_22 + A0_20._max_visible_slots - 1)
		end
	end
	L2_22 = A0_20._time_since_last_change
	if L2_22 > 0 then
		L2_22 = A0_20._time_since_last_change
		L2_22 = L2_22 - A1_21
		A0_20._time_since_last_change = L2_22
	end
	L2_22 = A0_20._mouse_input_delay
	if L2_22 > 0 then
		L2_22 = A0_20._mouse_input_delay
		L2_22 = L2_22 - A1_21
		A0_20._mouse_input_delay = L2_22
	end
	L2_22 = A0_20._selected_rect_pulse
	if L2_22 then
		L2_22 = A0_20._selected_rect_pulse
		L2_22 = L2_22.update
		L2_22(L3_23, A1_21)
	end
	L2_22 = A0_20._fade_animations
	if L2_22 then
		L2_22 = true
		for 