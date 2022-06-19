require("menu/2D/Menu2DScreen")
if not Menu2DGameOverScreen then
	Menu2DGameOverScreen = class(Menu2DScreen)
end
Menu2DGameOverScreen.create = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._transition_time = l_1_0._page:transition_time()
	l_1_0._root_panel = l_1_1
	l_1_0._full_screen_panel_root = l_1_2
	local l_1_4, l_1_5 = l_1_2:panel, l_1_2
	local l_1_6 = {}
	l_1_6.layer = tweak_data.menu2d.layer_normal
	l_1_4 = l_1_4(l_1_5, l_1_6)
	l_1_0._full_screen_panel = l_1_4
	l_1_0._next_start_y = 0
	l_1_0._visible_slots = 0
	l_1_0._current_slot = nil
	l_1_0._widget_border = 0
	l_1_4 = l_1_0._full_screen_panel
	l_1_4, l_1_5 = l_1_4:height, l_1_4
	l_1_4 = l_1_4(l_1_5)
	l_1_4 = l_1_4 * 0.35
	l_1_0._page_y = l_1_4
	l_1_4 = l_1_0._root_panel
	l_1_4, l_1_5 = l_1_4:panel, l_1_4
	l_1_4, l_1_6 = l_1_4(l_1_5, l_1_6), {y = tweak_data.menu2d.choice_panel_y, height = l_1_0._root_panel:h() - tweak_data.menu2d.choice_panel_y}
	l_1_0._dummy_panel = l_1_4
	l_1_4 = l_1_0._root_panel
	l_1_4, l_1_5 = l_1_4:panel, l_1_4
	l_1_4, l_1_6 = l_1_4(l_1_5, l_1_6), {width = l_1_0._full_screen_panel:width(), layer = 1, halign = "right", x = 0, y = l_1_0._page_y}
	l_1_0._choice_panel = l_1_4
	l_1_4 = l_1_0._root_panel
	l_1_4, l_1_5 = l_1_4:text, l_1_4
	l_1_4, l_1_6 = l_1_4(l_1_5, l_1_6), {text = l_1_0._page:text(), font = "credits_merged", color = tweak_data.menu2d.normal_menu.page_name_color:with_alpha(0), halign = "top", valign = "top", align = "center", height = 60, x = 0, y = l_1_0._page_y, layer = l_1_0._layer_text}
	l_1_0._page_name = l_1_4
	l_1_4 = l_1_0._page_name
	l_1_4, l_1_5 = l_1_4:text_rect, l_1_4
	l_1_4 = l_1_4(l_1_5)
	local l_1_7 = nil
	l_1_0._page_center_x = l_1_0._root_panel:width() * 0.5 - l_1_6 * 0.5
	l_1_0._page_name:set_x(l_1_0._page_center_x)
	l_1_0._page_name:set_width(R10_PC98)
	l_1_0._slots = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_1_11, l_1_12 = ipairs, l_1_0._page:choices()
	l_1_11 = l_1_11(l_1_12, R10_PC98)
	for i_0,i_1 in l_1_11 do
		l_1_0:_set_choice(l_1_9, l_1_10)
	end
	do
		if #l_1_0._page:choices() > 0 then
			local l_1_13, l_1_18, l_1_19 = l_1_0._slots[1]
			l_1_0._choice_panel:set_h(l_1_0._slots[#l_1_0._slots]:bottom_y() - l_1_0._slots[1]:y())
			if l_1_0._dummy_panel:h() < l_1_0._slots[#l_1_0._slots]:bottom_y() then
				do return end
			end
			l_1_0:set_selection(1, true)
			for i_0,l_1_13 in pairs(l_1_0._slots) do
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				do
					local l_1_14, l_1_15, l_1_16, l_1_17 = nil
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					l_1_16(l_1_17, "center")
			end
			if 0 < l_1_14 then
				end
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		for i_0,i_1 in pairs(l_1_0._slots) do
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_1_20:text():set_w(l_1_14)
			l_1_20:text():set_x(l_1_18:width() * 0.5 - l_1_14 * 0.5)
		end
		if l_1_0._slots[1] then
			l_1_0._next_start_y = l_1_0._page_name:y() - l_1_0._page_name:height() + l_1_0._slots[1]:height()
		end
		l_1_0._choice_panel:set_y(l_1_0._page_y + l_1_0._page_name:height())
		if l_1_3 then
			l_1_0:start_transition_forward_in()
		elseif l_1_3 ~= "reset" then
			l_1_0:start_transition_backward_in()
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 188 
end


