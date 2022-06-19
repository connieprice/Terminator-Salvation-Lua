require("menu/2D/Menu2DScreenSlot.lua")
require("menu/menu_animations/Menu2DFadeInAnimation")
require("menu/menu_animations/Menu2DFadeOutAnimation")
Menu2DScreen = Menu2DScreen or class()
function Menu2DScreen.init(A0_0, A1_1, A2_2)
	local L3_3, L4_4
	A0_0._scroll = false
	A0_0._max_visible_slots = 14
	L3_3 = tweak_data
	L3_3 = L3_3.menu2d
	L3_3 = L3_3.layer_normal
	L3_3 = L3_3 + 20
	A0_0._layer_border = L3_3
	L3_3 = tweak_data
	L3_3 = L3_3.menu2d
	L3_3 = L3_3.layer_normal
	L3_3 = L3_3 + 15
	A0_0._layer_selection = L3_3
	L3_3 = tweak_data
	L3_3 = L3_3.menu2d
	L3_3 = L3_3.layer_normal
	L3_3 = L3_3 + 10
	A0_0._layer_gradient = L3_3
	L3_3 = tweak_data
	L3_3 = L3_3.menu2d
	L3_3 = L3_3.layer_normal
	A0_0._layer_text = L3_3
	A0_0._layer_bg = 0
	L3_3 = tweak_data
	L3_3 = L3_3.menu2d
	L3_3 = L3_3.text_font_size
	A0_0._text_height = L3_3
	L3_3 = A0_0._text_height
	L4_4 = tweak_data
	L4_4 = L4_4.menu2d
	L4_4 = L4_4.spacing
	L3_3 = L3_3 + L4_4
	A0_0._text_item_height = L3_3
	A0_0._width = 1280
	A0_0._page_name_y = 40
	L3_3 = {}
	A0_0._slots = L3_3
	L3_3 = {}
	A0_0._page_animations = L3_3
	A0_0._page = A2_2
	A0_0._scroll_multiplier = 1
	A0_0._in_transition = false
end
function Menu2DScreen.destroy(A0_5)
	A0_5._root_panel:hide()
	A0_5._full_screen_panel:hide()
	A0_5:destroy_all_slots()
	A0_5._full_screen_panel_root:remove(A0_5._full_screen_panel)
	A0_5._page_animations = {}
	if A0_5._up_arrow then
		A0_5._root_panel:remove(A0_5._up_arrow)
	end
	if A0_5._down_arrow then
		A0_5._root_panel:remove(A0_5._down_arrow)
	end
	if A0_5._replay_scenario_back_text then
		A0_5._root_panel:remove(A0_5._replay_scenario_back_text)
	end
	if A0_5._replay_scenario_selection_bar then
		A0_5._root_panel:remove(A0_5._replay_scenario_selection_bar)
	end
	A0_5._up_arrow = nil
	A0_5._down_arrow = nil
end
function Menu2DScreen.show(A0_6)
	A0_6._root_panel:show()
end
function Menu2DScreen.hide(A0_7)
	A0_7._root_panel:hide()
end
function Menu2DScreen.create(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13)
	local L6_14, L7_15, L8_16, L9_17, L10_18, L11_19, L12_20
	L6_14 = A0_8._page
	L7_15 = L6_14
	L6_14 = L6_14.transition_time
	L6_14 = L6_14(L7_15)
	A0_8._transition_time = L6_14
	A0_8._root_panel = A1_9
	A0_8._full_screen_panel_root = A2_10
	L7_15 = A2_10
	L6_14 = A2_10.panel
	L8_16.layer = L9_17
	L6_14 = L6_14(L7_15, L8_16)
	A0_8._full_screen_panel = L6_14
	L6_14 = A0_8._root_panel
	L7_15 = L6_14
	L6_14 = L6_14.h
	L6_14 = L6_14(L7_15)
	A0_8._next_start_y = 0
	A0_8._visible_slots = 0
	A0_8._current_slot = 1
	L7_15 = A0_8._root_panel
	L7_15 = L7_15.w
	L7_15 = L7_15(L8_16)
	A0_8._width = L7_15
	L7_15 = tweak_data
	L7_15 = L7_15.menu2d
	L7_15 = L7_15.widget_border
	L7_15 = L7_15 * L8_16
	L7_15 = L7_15 - L8_16
	A0_8._widget_border = L8_16
	A0_8._page_y = L8_16
	L11_19 = tweak_data
	L11_19 = L11_19.menu2d
	L11_19 = L11_19.choice_panel_y
	L10_18.y = L11_19
	L11_19 = A0_8._root_panel
	L12_20 = L11_19
	L11_19 = L11_19.h
	L11_19 = L11_19(L12_20)
	L12_20 = tweak_data
	L12_20 = L12_20.menu2d
	L12_20 = L12_20.choice_panel_y
	L11_19 = L11_19 - L12_20
	L10_18.height = L11_19
	L11_19 = A0_8._layer_text
	L10_18.layer = L11_19
	A0_8._dummy_panel = L8_16
	L10_18.height = 0
	L11_19 = A0_8._dummy_panel
	L12_20 = L11_19
	L11_19 = L11_19.w
	L11_19 = L11_19(L12_20)
	L10_18.width = L11_19
	L11_19 = A0_8._layer_text
	L10_18.layer = L11_19
	L10_18.halign = "right"
	A0_8._choice_panel = L8_16
	L11_19 = tweak_data
	L11_19 = L11_19.menu2d
	L11_19 = L11_19.widget_border_color
	L12_20 = L11_19
	L11_19 = L11_19.with_alpha
	L11_19 = L11_19(L12_20, 0)
	L10_18.color = L11_19
	L10_18.x = L7_15
	L10_18.y = 0
	L10_18.width = 2
	L11_19 = A0_8._full_screen_panel
	L12_20 = L11_19
	L11_19 = L11_19.h
	L11_19 = L11_19(L12_20)
	L10_18.height = L11_19
	L11_19 = A0_8._layer_border
	L10_18.layer = L11_19
	A0_8._widget_border_rect = L8_16
	L11_19 = A0_8._page
	L12_20 = L11_19
	L11_19 = L11_19.text
	L11_19 = L11_19(L12_20)
	L10_18.text = L11_19
	L10_18.font = "credits_merged"
	L11_19 = tweak_data
	L11_19 = L11_19.menu2d
	L11_19 = L11_19.normal_menu
	L11_19 = L11_19.page_name_color
	L12_20 = L11_19
	L11_19 = L11_19.with_alpha
	L11_19 = L11_19(L12_20, 0)
	L10_18.color = L11_19
	L10_18.halign = "top"
	L10_18.valign = "top"
	L10_18.align = "right"
	L11_19 = A0_8._widget_border
	L10_18.width = L11_19
	L10_18.height = 60
	L10_18.x = 0
	L11_19 = A0_8._page_y
	L10_18.y = L11_19
	L11_19 = A0_8._layer_text
	L10_18.layer = L11_19
	A0_8._page_name = L8_16
	A0_8._slots = L8_16
	L12_20 = L9_17(L10_18)
	for L11_19, L12_20 in L8_16(L9_17, L10_18, L11_19, L12_20, L9_17(L10_18)) do
		A0_8:_set_choice(L11_19, L12_20)
	end
	if L8_16 > 0 then
		L11_19 = A0_8._slots
		L11_19 = #L11_19
		L11_19 = L10_18
		L11_19 = A0_8._slots
		L11_19 = L11_19[1]
		L12_20 = L11_19
		L11_19 = L11_19.y
		L11_19 = L11_19(L12_20)
		L8_16(L9_17, L10_18)
		if A4_12 ~= nil then
		else
			if A4_12 > L8_16 then
				A4_12 = 1
		end
		elseif L8_16 ~= A5_13 then
			A4_12 = 1
			for L11_19, L12_20 in L8_16(L9_17) do
				if L12_20:choice():text() == A5_13 then
					A4_12 = L11_19
				end
			end
		end
		if not (L8_16 > L9_17) then
		else
			if L8_16 == "replay_scenario" then
				A0_8._scroll = true
				A0_8._choice_wanted_y = 0
				A0_8._current_top = 1
				A0_8._current_end = L8_16
				A0_8._max_visible_slots = L9_17
				L11_19 = A0_8._max_visible_slots
				L11_19 = L10_18
				L12_20 = A0_8._slots
				L12_20 = L12_20[A0_8._current_slot]
				L12_20 = L12_20.height
				L12_20 = L12_20(L12_20)
				L12_20 = L12_20 * L9_17
				L10_18(L11_19, L12_20)
				L11_19 = L10_18
				L12_20 = A0_8._full_screen_panel
				L12_20 = L12_20.world_center_y
				L12_20 = L12_20(L12_20)
				L10_18(L11_19, L12_20, L12_20(L12_20))
				L11_19 = A0_8
				L10_18(L11_19)
		end
		else
			A0_8._choice_wanted_y = 0
			A0_8._scroll = false
		end
		L11_19 = true
		L8_16(L9_17, L10_18, L11_19)
	end
	if A3_11 then
		L8_16(L9_17)
	elseif A3_11 ~= "reset" then
		L8_16(L9_17)
	end
end
function Menu2DScreen._create_arrows_and_text(A0_21)
	local L1_22, L2_23, L3_24, L4_25, L5_26, L6_27, L7_28, L8_29, L9_30, L10_31
	L1_22 = A0_21._root_panel
	L2_23 = L1_22
	L1_22 = L1_22.bitmap
	L3_24 = {}
	L3_24.texture = "gui_menu_resume_arrow"
	L3_24.blend_mode = "add"
	L4_25 = Color
	L4_25 = L4_25.white
	L5_26 = L4_25
	L4_25 = L4_25.with_alpha
	L6_27 = 0
	L4_25 = L4_25(L5_26, L6_27)
	L3_24.color = L4_25
	L3_24.layer = 10
	L1_22 = L1_22(L2_23, L3_24)
	A0_21._up_arrow = L1_22
	L1_22 = A0_21._root_panel
	L2_23 = L1_22
	L1_22 = L1_22.bitmap
	L3_24 = {}
	L3_24.texture = "gui_menu_resume_arrow"
	L3_24.blend_mode = "add"
	L3_24.rotation = 180
	L4_25 = Color
	L4_25 = L4_25.white
	L5_26 = L4_25
	L4_25 = L4_25.with_alpha
	L6_27 = 0
	L4_25 = L4_25(L5_26, L6_27)
	L3_24.color = L4_25
	L3_24.layer = 10
	L1_22 = L1_22(L2_23, L3_24)
	A0_21._down_arrow = L1_22
	L1_22 = A0_21._up_arrow
	L2_23 = L1_22
	L1_22 = L1_22.texture_height
	L1_22 = L1_22(L2_23)
	L2_23 = A0_21._up_arrow
	L3_24 = L2_23
	L2_23 = L2_23.texture_width
	L2_23 = L2_23(L3_24)
	L3_24 = A0_21._slots
	L4_25 = A0_21._current_slot
	L3_24 = L3_24[L4_25]
	L4_25 = L3_24
	L3_24 = L3_24.widget_texture
	L3_24 = L3_24(L4_25)
	L5_26 = L3_24
	L4_25 = L3_24.world_x
	L4_25 = L4_25(L5_26)
	L6_27 = L3_24
	L5_26 = L3_24.width
	L5_26 = L5_26(L6_27)
	L5_26 = L5_26 * 0.5
	L4_25 = L4_25 + L5_26
	L5_26 = L2_23 * 0.5
	L4_25 = L4_25 - L5_26
	L5_26 = A0_21._up_arrow
	L6_27 = L5_26
	L5_26 = L5_26.set_world_x
	L7_28 = L4_25
	L5_26(L6_27, L7_28)
	L5_26 = A0_21._up_arrow
	L6_27 = L5_26
	L5_26 = L5_26.set_world_y
	L8_29 = L3_24
	L7_28 = L3_24.world_y
	L7_28 = L7_28(L8_29)
	L7_28 = L7_28 - L1_22
	L5_26(L6_27, L7_28)
	L5_26 = A0_21._down_arrow
	L6_27 = L5_26
	L5_26 = L5_26.set_world_x
	L7_28 = L4_25
	L5_26(L6_27, L7_28)
	L5_26 = A0_21._down_arrow
	L6_27 = L5_26
	L5_26 = L5_26.set_y
	L7_28 = A0_21._up_arrow
	L8_29 = L7_28
	L7_28 = L7_28.y
	L7_28 = L7_28(L8_29)
	L8_29 = A0_21._dummy_panel
	L9_30 = L8_29
	L8_29 = L8_29.height
	L8_29 = L8_29(L9_30)
	L7_28 = L7_28 + L8_29
	L7_28 = L7_28 + L1_22
	L5_26(L6_27, L7_28)
	L5_26 = A0_21._root_panel
	L6_27 = L5_26
	L5_26 = L5_26.text
	L7_28 = {}
	L8_29 = managers
	L8_29 = L8_29.localization
	L9_30 = L8_29
	L8_29 = L8_29.text
	L10_31 = "menu_back"
	L8_29 = L8_29(L9_30, L10_31)
	L7_28.text = L8_29
	L7_28.font = "faith_font_22"
	L8_29 = Color
	L8_29 = L8_29.white
	L9_30 = L8_29
	L8_29 = L8_29.with_alpha
	L10_31 = 0
	L8_29 = L8_29(L9_30, L10_31)
	L7_28.color = L8_29
	L7_28.align = "right"
	L8_29 = A0_21._widget_border
	L7_28.width = L8_29
	L7_28.x = 0
	L8_29 = A0_21._page_name
	L9_30 = L8_29
	L8_29 = L8_29.y
	L8_29 = L8_29(L9_30)
	L9_30 = A0_21._page_name
	L10_31 = L9_30
	L9_30 = L9_30.height
	L9_30 = L9_30(L10_31)
	L8_29 = L8_29 + L9_30
	L7_28.y = L8_29
	L8_29 = tweak_data
	L8_29 = L8_29.menu2d
	L8_29 = L8_29.layer_normal
	L7_28.layer = L8_29
	L5_26 = L5_26(L6_27, L7_28)
	A0_21._replay_scenario_back_text = L5_26
	L5_26 = A0_21._replay_scenario_back_text
	L6_27 = L5_26
	L5_26 = L5_26.text_rect
	L8_29 = L5_26(L6_27)
	L9_30 = A0_21._replay_scenario_back_text
	L10_31 = L9_30
	L9_30 = L9_30.set_height
	L9_30(L10_31, L8_29)
	L9_30 = A0_21._root_panel
	L10_31 = L9_30
	L9_30 = L9_30.bitmap
	L9_30 = L9_30(L10_31, {
		color = Color.white:with_alpha(0),
		texture = "gui_menu_bg_gradient",
		x = 0,
		w = tweak_data.menu2d.spacing_widget_border + A0_21._replay_scenario_back_text:width()
	})
	A0_21._replay_scenario_selection_bar = L9_30
	L9_30 = A0_21._replay_scenario_back_text
	L10_31 = L9_30
	L9_30 = L9_30.world_center
	L10_31 = L9_30(L10_31)
	A0_21._replay_scenario_selection_bar:set_world_center_y(L10_31)
end
function Menu2DScreen.reset(A0_32, A1_33, A2_34)
	local L3_35
	L3_35 = A0_32._slots
	L3_35 = L3_35[A0_32._current_slot]
	L3_35 = L3_35.choice
	L3_35 = L3_35(L3_35)
	L3_35 = L3_35.text
	L3_35 = L3_35(L3_35)
	A0_32:destroy()
	A0_32:create(A1_33, A2_34, "reset", A0_32._current_slot, L3_35)
	A0_32:show()
end
function Menu2DScreen.update(A0_36, A1_37)
	local L2_38, L3_39
	if L2_38 then
	elseif L2_38 < 1 then
		return
	end
	for 