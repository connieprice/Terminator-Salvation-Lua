require("units/beings/player/new_gui/ContextItemStates")
if not ContextItem then
	ContextItem = class()
end
ContextItem.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._parent_panel = l_1_1
	l_1_0._timeout_time = l_1_2
	l_1_0._width = 700
	l_1_0._height = 50
	l_1_0._x = 0
	l_1_0._y = l_1_0._parent_panel:height() + 12
	l_1_0._center_x = l_1_0._width / 2
	local l_1_3, l_1_4 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_5 = {}
	l_1_5.name = "_panel"
	l_1_5.width = l_1_0._width
	l_1_5.height = l_1_0._height
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._panel = l_1_3
	l_1_0._context_item_texts, l_1_3 = l_1_3, {}
	l_1_0._context_item_icons, l_1_3 = l_1_3, {}
	l_1_3, l_1_4 = l_1_0:set_alpha, l_1_0
	l_1_5 = 0
	l_1_3(l_1_4, l_1_5)
	l_1_3 = FiniteStateMachine
	l_1_3, l_1_4 = l_1_3:new, l_1_3
	l_1_5 = l_1_0
	l_1_3 = l_1_3(l_1_4, l_1_5, "_context_item", ContextItemIdleState)
	l_1_0._state = l_1_3
	l_1_3 = l_1_0._state
	l_1_3, l_1_4 = l_1_3:set_debug, l_1_3
	l_1_5 = false
	l_1_3(l_1_4, l_1_5)
	l_1_0._time = 0
end

ContextItem.display = function(l_2_0, l_2_1, l_2_2, ...)
	assert(l_2_1)
	if not alive(l_2_0._panel) then
		return 
	end
	if l_2_0._timed_out then
		return 
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if managers.localization:text(l_2_1, l_2_0._localizer_mapping).format(managers.localization:text(l_2_1, l_2_0._localizer_mapping), ...) ~= l_2_0._current_context_string then
		l_2_0._current_context_string = managers.localization:text(l_2_1, l_2_0._localizer_mapping).format(managers.localization:text(l_2_1, l_2_0._localizer_mapping), ...)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_2_0:_parse_context_string(managers.localization:text(l_2_1, l_2_0._localizer_mapping).format(managers.localization:text(l_2_1, l_2_0._localizer_mapping), ...))
		l_2_0._panel:set_center_x(l_2_0._parent_panel:width() / 2)
	end
	if l_2_2 then
		l_2_0:_set_position(l_2_2)
		l_2_0._move_down_interpolator = nil
	end
	l_2_0:fade_in()
end

ContextItem._set_position = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0._y - (l_3_1 - 1) * tweak_data.player.new_hud.context_panel.OFFSET_MESSAGES
	l_3_0._panel:set_bottom(l_3_2)
end

ContextItem.update_item = function(l_4_0, l_4_1, ...)
	l_4_0:display(l_4_1, nil, ...)
	return 
end

ContextItem.get_timeout = function(l_5_0)
	return l_5_0._timeout_time
end

ContextItem.set_timed_out = function(l_6_0)
	l_6_0._timed_out = true
	l_6_0._wants_to_fade_out = true
	l_6_0._wants_to_fade_in = false
end

ContextItem.timed_out = function(l_7_0)
	return l_7_0._timed_out
end

ContextItem.instant_hide = function(l_8_0)
	l_8_0.is_instant_hide = true
	l_8_0:set_alpha(0)
end

ContextItem.fade_in = function(l_9_0)
	l_9_0.is_instant_hide = false
	l_9_0._wants_to_fade_in = true
	l_9_0._wants_to_fade_out = false
	l_9_0._wants_to_idle = false
end

ContextItem.fade_out = function(l_10_0)
	if l_10_0:allowed_to_fade_out() then
		l_10_0.is_instant_hide = false
		l_10_0._wants_to_fade_out = true
		l_10_0._wants_to_fade_in = false
		l_10_0._wants_to_idle = false
		l_10_0._timed_out = false
	end
end

ContextItem.idle = function(l_11_0)
	l_11_0._wants_to_idle = true
	l_11_0._wants_to_fade_out = false
	l_11_0._wants_to_fade_in = false
end

ContextItem.wants_to_fade_in = function(l_12_0)
	return l_12_0._wants_to_fade_in
end

ContextItem.wants_to_fade_out = function(l_13_0)
	return l_13_0._wants_to_fade_out
end

ContextItem.wants_to_idle = function(l_14_0)
	return l_14_0._wants_to_idle
end

ContextItem.moving_down = function(l_15_0)
	return l_15_0._move_down_interpolator ~= nil
end

ContextItem.get_alpha = function(l_16_0)
	return l_16_0._alpha
end

ContextItem.set_alpha = function(l_17_0, l_17_1)
	local l_17_5, l_17_6, l_17_7, l_17_8, l_17_9, l_17_10, l_17_11, l_17_12, l_17_13, l_17_14, l_17_15, l_17_16 = nil
	l_17_0._alpha = l_17_1
	for i_0,i_1 in pairs(l_17_0._context_item_texts) do
		i_1:set_color(i_1:color():with_alpha(l_17_0._alpha))
	end
	for i_0,i_1 in pairs(l_17_0._context_item_icons) do
		i_1:set_color(i_1:color():with_alpha(l_17_0._alpha))
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ContextItem.visible = function(l_18_0)
	return l_18_0._alpha > 0
end

ContextItem.move_down = function(l_19_0)
	l_19_0._move_down_interpolator = Interpolator:new(l_19_0._panel:bottom(), tweak_data.player.new_hud.context_panel.SLIDE_DOWN_SPEED)
	l_19_0._move_down_interpolator:set_target(l_19_0._y)
end

ContextItem.instant_move_down = function(l_20_0)
	l_20_0._panel:set_bottom(l_20_0._y)
end

ContextItem._clear_context_item = function(l_21_0)
	local l_21_4, l_21_5, l_21_6, l_21_7, l_21_8, l_21_9, l_21_10, l_21_11, l_21_12, l_21_13, l_21_14, l_21_15 = nil
	for i_0,i_1 in pairs(l_21_0._context_item_texts) do
		i_1:set_color(i_1:color():with_alpha(0))
	end
	for i_0,i_1 in pairs(l_21_0._context_item_icons) do
		i_1:set_color(i_1:color():with_alpha(0))
	end
	l_21_0._context_item_texts = {}
	l_21_0._context_item_icons = {}
	l_21_0._current_x = 0
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ContextItem._parse_context_string = function(l_22_0, l_22_1)
	l_22_0:_clear_context_item()
	repeat
		local l_22_2 = l_22_1:find("[[]")
		if l_22_2 then
			local l_22_3 = l_22_1:sub(1, l_22_2 - 1)
			l_22_1 = l_22_1:sub(l_22_2 + 1)
			local l_22_4 = l_22_1:find("[]]")
			local l_22_5 = l_22_1:sub(1, l_22_4 - 1)
			l_22_1 = l_22_1:sub(l_22_4 + 1)
			assert(l_22_4)
			l_22_0:_add_text(l_22_3)
			l_22_0:_add_icon(l_22_5)
		end
	until l_22_2 == nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_22_2 > 0 then
		l_22_2(l_22_0, l_22_1)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_22_2(l_22_2, l_22_0._current_x)
end

ContextItem._add_text = function(l_23_0, l_23_1)
	local l_23_2, l_23_3 = l_23_0._panel:text, l_23_0._panel
	local l_23_4 = {}
	l_23_4.font = tweak_data.player.new_hud.context_panel.TEXT_FONT
	l_23_4.font_size = tweak_data.player.new_hud.context_panel.TEXT_FONT_SIZE
	l_23_4.x = l_23_0._current_x
	l_23_4.text = l_23_1
	l_23_4.valign = "center"
	l_23_4.color = tweak_data.player.new_hud.context_panel.TEXT_FONT_COLOR
	l_23_2 = l_23_2(l_23_3, l_23_4)
	l_23_3, l_23_4 = l_23_2:text_rect, l_23_2
	l_23_3 = l_23_3(l_23_4)
	local l_23_5, l_23_6 = nil
	l_23_0._current_x = l_23_0._current_x + l_23_5
	l_23_2:set_width(l_23_5)
	l_23_2:set_center_y(l_23_0._height / 2)
	l_23_2:set_vertical("center")
	table.insert(l_23_0._context_item_texts, l_23_2)
end

ContextItem._add_icon = function(l_24_0, l_24_1)
	local l_24_2, l_24_3 = l_24_0._panel:bitmap, l_24_0._panel
	local l_24_4 = {}
	l_24_4.valign = "center"
	l_24_4.texture = l_24_1
	l_24_4.x = l_24_0._current_x
	l_24_2 = l_24_2(l_24_3, l_24_4)
	l_24_3, l_24_4 = l_24_2:set_center_y, l_24_2
	l_24_3(l_24_4, l_24_0._height / 2)
	l_24_3, l_24_4 = l_24_2:texture_name, l_24_2
	l_24_3 = l_24_3(l_24_4)
	if l_24_3 ~= "" then
		l_24_3 = table
		l_24_3 = l_24_3.insert
		l_24_4 = l_24_0._context_item_icons
		l_24_3(l_24_4, l_24_2)
		l_24_3 = l_24_0._current_x
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_24_3 = l_24_3 + l_24_4
		l_24_0._current_x = l_24_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		l_24_3 = l_24_2:set_color
		l_24_3(l_24_4, l_24_2:color():with_alpha(0))
		l_24_2 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_24_3 = l_24_0:_add_text
		l_24_3(l_24_4, "[" .. l_24_1 .. "]")
	end
end

ContextItem.set_minimum_display_time = function(l_25_0, l_25_1, l_25_2)
	l_25_0._earliest_fade_out_time = l_25_2 + l_25_1
	 -- WARNING: undefined locals caused missing assignments!
end

ContextItem.allowed_to_fade_out = function(l_26_0)
	do
		local l_26_1, l_26_3 = l_26_0._earliest_fade_out_time or 0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_26_1 < l_26_0._time
end

ContextItem._update_move_down = function(l_27_0, l_27_1)
	if l_27_0._move_down_interpolator then
		l_27_0._move_down_interpolator:update(l_27_1)
		local l_27_2 = nil
		if l_27_0._move_down_interpolator:has_reached_target() then
			l_27_2 = l_27_0._y
			l_27_0._move_down_interpolator = nil
		else
			l_27_2 = l_27_0._move_down_interpolator:value()
		end
		l_27_0._panel:set_bottom(l_27_2)
	end
end

ContextItem.update = function(l_28_0, l_28_1, l_28_2)
	l_28_0._time = l_28_1
	l_28_0._state:update(l_28_2)
	l_28_0:_update_move_down(l_28_2)
end

ContextItem.set_localizer_mapping = function(l_29_0, l_29_1)
	l_29_0._localizer_mapping = l_29_1
end


