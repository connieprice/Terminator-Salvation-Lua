require("menu/2D/Menu2DScreen")
Menu2DGameOverScreen = Menu2DGameOverScreen or class(Menu2DScreen)
function Menu2DGameOverScreen.create(A0_0, A1_1, A2_2, A3_3)
	local L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11, L12_12, L13_13, L14_14
	L4_4 = A0_0._page
	L5_5 = L4_4
	L4_4 = L4_4.transition_time
	L4_4 = L4_4(L5_5)
	A0_0._transition_time = L4_4
	A0_0._root_panel = A1_1
	A0_0._full_screen_panel_root = A2_2
	L5_5 = A2_2
	L4_4 = A2_2.panel
	L6_6 = {}
	L7_7 = tweak_data
	L7_7 = L7_7.menu2d
	L7_7 = L7_7.layer_normal
	L6_6.layer = L7_7
	L4_4 = L4_4(L5_5, L6_6)
	A0_0._full_screen_panel = L4_4
	A0_0._next_start_y = 0
	A0_0._visible_slots = 0
	A0_0._current_slot = nil
	A0_0._widget_border = 0
	L4_4 = A0_0._full_screen_panel
	L5_5 = L4_4
	L4_4 = L4_4.height
	L4_4 = L4_4(L5_5)
	L4_4 = L4_4 * 0.35
	A0_0._page_y = L4_4
	L4_4 = A0_0._root_panel
	L5_5 = L4_4
	L4_4 = L4_4.panel
	L6_6 = {}
	L7_7 = tweak_data
	L7_7 = L7_7.menu2d
	L7_7 = L7_7.choice_panel_y
	L6_6.y = L7_7
	L7_7 = A0_0._root_panel
	L7_7 = L7_7.h
	L7_7 = L7_7(L8_8)
	L7_7 = L7_7 - L8_8
	L6_6.height = L7_7
	L4_4 = L4_4(L5_5, L6_6)
	A0_0._dummy_panel = L4_4
	L4_4 = A0_0._root_panel
	L5_5 = L4_4
	L4_4 = L4_4.panel
	L6_6 = {}
	L7_7 = A0_0._full_screen_panel
	L7_7 = L7_7.width
	L7_7 = L7_7(L8_8)
	L6_6.width = L7_7
	L6_6.layer = 1
	L6_6.halign = "right"
	L6_6.x = 0
	L7_7 = A0_0._page_y
	L6_6.y = L7_7
	L4_4 = L4_4(L5_5, L6_6)
	A0_0._choice_panel = L4_4
	L4_4 = A0_0._root_panel
	L5_5 = L4_4
	L4_4 = L4_4.text
	L6_6 = {}
	L7_7 = A0_0._page
	L7_7 = L7_7.text
	L7_7 = L7_7(L8_8)
	L6_6.text = L7_7
	L6_6.font = "credits_merged"
	L7_7 = tweak_data
	L7_7 = L7_7.menu2d
	L7_7 = L7_7.normal_menu
	L7_7 = L7_7.page_name_color
	L7_7 = L7_7.with_alpha
	L7_7 = L7_7(L8_8, L9_9)
	L6_6.color = L7_7
	L6_6.halign = "top"
	L6_6.valign = "top"
	L6_6.align = "center"
	L6_6.height = 60
	L6_6.x = 0
	L7_7 = A0_0._page_y
	L6_6.y = L7_7
	L7_7 = A0_0._layer_text
	L6_6.layer = L7_7
	L4_4 = L4_4(L5_5, L6_6)
	A0_0._page_name = L4_4
	L4_4 = A0_0._page_name
	L5_5 = L4_4
	L4_4 = L4_4.text_rect
	L7_7 = L4_4(L5_5)
	A0_0._page_center_x = L8_8
	L8_8(L9_9, L10_10)
	L8_8(L9_9, L10_10)
	A0_0._slots = L8_8
	L14_14 = L9_9(L10_10)
	for L11_11, L12_12 in L8_8(L9_9, L10_10, L11_11, L12_12, L13_13, L14_14, L9_9(L10_10)) do
		L14_14 = A0_0
		L13_13 = A0_0._set_choice
		L13_13(L14_14, L11_11, L12_12)
	end
	if L9_9 > 0 then
		L12_12 = A0_0._slots
		L12_12 = #L12_12
		L12_12 = L11_11
		L12_12 = A0_0._slots
		L12_12 = L12_12[1]
		L13_13 = L12_12
		L12_12 = L12_12.y
		L12_12 = L12_12(L13_13)
		L9_9(L10_10, L11_11)
		A0_0._current_slot = 1
		if L9_9 > L10_10 then
			A0_0._scroll = true
			A0_0._choice_wanted_y = 0
			A0_0._current_top = 1
			A0_0._current_end = L9_9
			L12_12 = A0_0._current_slot
			L12_12 = L11_11
			A0_0._max_visible_slots = L9_9
		else
			A0_0._choice_wanted_y = 0
			A0_0._scroll = false
		end
		L12_12 = true
		L9_9(L10_10, L11_11, L12_12)
		for L12_12, L13_13 in L9_9(L10_10) do
			L14_14 = L13_13.text
			L14_14 = L14_14(L13_13)
			L14_14 = L14_14.text_rect
			L14_14 = L14_14(L14_14)
			L13_13:text():set_align("center")
		end
	end
	for L12_12, L13_13 in L9_9(L10_10) do
		L14_14 = A0_0._root_panel
		L14_14 = L14_14.width
		L14_14 = L14_14(L14_14)
		L14_14 = L14_14 * 0.5
		L14_14 = L14_14 - L8_8 * 0.5
		L13_13:text():set_w(L8_8)
		L13_13:text():set_x(L14_14)
	end
	A0_0._next_start_y = L9_9
	L12_12 = A0_0._page_y
	L13_13 = A0_0._page_name
	L14_14 = L13_13
	L13_13 = L13_13.height
	L13_13 = L13_13(L14_14)
	L12_12 = L12_12 + L13_13
	L10_10(L11_11, L12_12)
	if A3_3 then
		L10_10(L11_11)
	elseif A3_3 ~= "reset" then
		L10_10(L11_11)
	end
end
