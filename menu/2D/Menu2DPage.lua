if not Menu2DPage then
	Menu2DPage = class()
end
Menu2DPage.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._transition_active = false
	l_1_0._root_panel = l_1_2
	l_1_0:parse(l_1_1)
end

Menu2DPage.post_init = function(l_2_0)
end

Menu2DPage.parse = function(l_3_0, l_3_1)
	l_3_0._no_page_title_gradient = toboolean(l_3_1:parameter("no_page_title"))
	l_3_0._name = l_3_1:parameter("name")
end

Menu2DPage.can_go_back = function(l_4_0)
	local l_4_1 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_4_1
end

Menu2DPage.confirm_mode = function(l_5_0)
	return "confirm"
end

Menu2DPage.no_page_title_gradient = function(l_6_0)
	return l_6_0._no_page_title_gradient
end

Menu2DPage.continue_back = function(l_7_0)
	return l_7_0._continue_back
end

Menu2DPage.update = function(l_8_0, l_8_1)
	if l_8_0:_transition() then
		l_8_0:_transition_end()
	end
end

Menu2DPage.input = function(l_9_0, l_9_1, l_9_2)
end

Menu2DPage.show = function(l_10_0)
	l_10_0._root_panel:show()
	l_10_0._menu_active = true
end

Menu2DPage.hide = function(l_11_0)
	l_11_0._root_panel:hide()
	l_11_0._menu_active = false
end

Menu2DPage.open = function(l_12_0, l_12_1, l_12_2, l_12_3)
	l_12_0._panel = l_12_0._root_panel:panel(l_12_1)
	local l_12_4, l_12_5 = l_12_0._panel:set_layer, l_12_0._panel
	do
		l_12_4(l_12_5, l_12_3 or 0)
		l_12_0._layer = l_12_3
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPage.set_root_panel = function(l_13_0, l_13_1)
	l_13_0._root_panel = l_13_1
end

Menu2DPage.reopen = function(l_14_0, l_14_1, l_14_2)
	l_14_0._panel = l_14_1:panel({})
	l_14_0:open(l_14_2, true, l_14_0._layer)
end

Menu2DPage.close = function(l_15_0)
	l_15_0:destroy()
end

Menu2DPage.destroy = function(l_16_0)
	l_16_0._root_panel:remove(l_16_0._panel)
end

Menu2DPage.set_transition = function(l_17_0, l_17_1)
	l_17_0._transition_active = true
	l_17_0._frames = 0
	l_17_0._transition_forward = l_17_1
end

Menu2DPage._transition = function(l_18_0)
	return l_18_0._transition_active
end

Menu2DPage._transition_end = function(l_19_0)
	l_19_0._transition_active = false
end

Menu2DPage.transition_active = function(l_20_0)
	return l_20_0._transition_active
end

Menu2DPage.advance = function(l_21_0)
end

Menu2DPage.set_text = function(l_22_0, l_22_1)
	l_22_0._text = ""
end

Menu2DPage.name = function(l_23_0)
	return l_23_0._name or ""
end


