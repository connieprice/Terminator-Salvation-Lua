core:module("CoreSubtitlePresenter")
core:require_module("CoreClass")
core:require_module("CoreCode")
core:require_module("CoreEvent")
core:require_module("CoreDebug")
core:require_module("CoreSubtitleSequence")
if not SubtitlePresenter then
	SubtitlePresenter = CoreClass.class()
end
if not DebugPresenter then
	DebugPresenter = CoreClass.class(SubtitlePresenter)
end
if not OverlayPresenter then
	OverlayPresenter = CoreClass.class(SubtitlePresenter)
end
SubtitlePresenter.destroy = function(l_1_0)
end

SubtitlePresenter.update = function(l_2_0, l_2_1, l_2_2)
end

SubtitlePresenter.show = function(l_3_0)
end

SubtitlePresenter.hide = function(l_4_0)
end

SubtitlePresenter.show_text = function(l_5_0, l_5_1, l_5_2)
end

SubtitlePresenter.preprocess_sequence = function(l_6_0, l_6_1)
	return l_6_1
end

DebugPresenter.destroy = function(l_7_0)
	CoreDebug.cat_print("debug", string.format("SubtitlePresenter is destroyed."))
end

DebugPresenter.show = function(l_8_0)
	CoreDebug.cat_print("debug", string.format("SubtitlePresenter is shown."))
end

DebugPresenter.hide = function(l_9_0)
	CoreDebug.cat_print("debug", string.format("SubtitlePresenter hides."))
end

DebugPresenter.show_text = function(l_10_0, l_10_1, l_10_2)
	CoreDebug.cat_print("debug", string.format("SubtitlePresenter displays \"%s\" %s.", l_10_1, l_10_2 and string.format("for %g seconds", l_10_2) or "until further notice"))
end

OverlayPresenter.init = function(l_11_0, l_11_1, l_11_2)
	local l_11_3, l_11_4 = l_11_0:set_font, l_11_0
	do
		if l_11_1 or not l_11_2 then
			l_11_3(l_11_4, l_11_0:_default_font_name(), l_11_0:_default_font_size())
		end
		l_11_3, l_11_4 = l_11_0:_clear_workspace, l_11_0
		l_11_3(l_11_4)
		l_11_3 = managers
		l_11_3 = l_11_3.viewport
		l_11_3, l_11_4 = l_11_3:add_resolution_changed_func, l_11_3
		l_11_3 = l_11_3(l_11_4, CoreEvent.callback(l_11_0, l_11_0, "_on_resolution_changed"))
		l_11_0.__resolution_changed_id = l_11_3
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

OverlayPresenter.destroy = function(l_12_0)
	if l_12_0.__resolution_changed_id and managers.viewport then
		managers.viewport:remove_resolution_changed_func(l_12_0.__resolution_changed_id)
	end
	l_12_0.__resolution_changed_id = nil
	if CoreCode.alive(l_12_0.__subtitle_panel) then
		l_12_0.__subtitle_panel:stop()
		l_12_0.__subtitle_panel:clear()
	end
	l_12_0.__subtitle_panel = nil
	if CoreCode.alive(l_12_0.__ws) then
		l_12_0.__ws:gui():destroy_workspace(l_12_0.__ws)
	end
	l_12_0.__ws = nil
end

OverlayPresenter.show = function(l_13_0)
	l_13_0.__ws:show()
end

OverlayPresenter.hide = function(l_14_0)
	l_14_0.__ws:hide()
end

OverlayPresenter.set_debug = function(l_15_0, l_15_1)
	if l_15_0.__ws then
		l_15_0.__ws:panel():set_debug(l_15_1)
	end
end

OverlayPresenter.set_font = function(l_16_0, l_16_1, l_16_2)
	l_16_0.__font_name = assert(tostring(l_16_1), "Invalid font name parameter.")
	l_16_0.__font_size = assert(tonumber(l_16_2), "Invalid font size parameter.")
	Overlay:newgui():preload_font(l_16_0.__font_name)
	if l_16_0.__subtitle_panel then
		local l_16_6 = ipairs
		local l_16_7 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		for i_0,i_1 in l_16_6 do
			local l_16_8 = l_16_0.__subtitle_panel:child(l_16_5)
			if l_16_8 then
				l_16_8:set_font(l_16_0.__font_name)
				l_16_8:set_font_size(l_16_0.__font_size)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- WARNING: undefined locals caused missing assignments!
end

OverlayPresenter.set_width = function(l_17_0, l_17_1)
	local l_17_2 = managers.viewport:get_safe_rect()
	local l_17_3 = l_17_0:_gui_width() * l_17_2.width
	l_17_0.__width = math.min(l_17_1, l_17_3)
	if CoreCode.alive(l_17_0.__subtitle_panel) then
		l_17_0:_layout_text_field():set_width(l_17_0.__width)
	end
end

OverlayPresenter.show_text = function(l_18_0, l_18_1, l_18_2)
	if not l_18_0.__subtitle_panel:child("label") then
		local l_18_3, l_18_4, l_18_6, l_18_10, l_18_11, l_18_13, l_18_15 = l_18_0.__subtitle_panel:text, l_18_0.__subtitle_panel
		local l_18_5 = nil
		l_18_10 = l_18_0.__font_name
		l_18_10 = l_18_0.__font_size
		l_18_10 = Color
		l_18_10 = l_18_10.white
		l_18_3, l_18_6 = l_18_3(l_18_4, l_18_6), {name = "label", x = 1, y = 1, font = l_18_10, font_size = l_18_10, color = l_18_10, align = "center", vertical = "bottom", layer = 1, wrap = true, word_wrap = true}
	end
	if not l_18_0.__subtitle_panel:child("shadow") then
		local l_18_7, l_18_8, l_18_12, l_18_14, l_18_16 = , l_18_0.__subtitle_panel:text, l_18_0.__subtitle_panel
		local l_18_9 = nil
		l_18_16 = l_18_0.__font_name
		l_18_16 = l_18_0.__font_size
		l_18_16 = Color
		l_18_16 = l_18_16.black
		l_18_16, l_18_9 = l_18_16:with_alpha, l_18_16
		l_18_16 = l_18_16(l_18_9, 0.5)
		l_18_8, l_18_14 = l_18_8(l_18_12, l_18_14), {name = "shadow", x = 2, y = 2, font = l_18_16, font_size = l_18_16, color = l_18_16, align = "center", vertical = "bottom", layer = 0, wrap = true, word_wrap = true}
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_18_7:set_text(l_18_1)
	l_18_8:set_text(l_18_1)
end

OverlayPresenter.preprocess_sequence = function(l_19_0, l_19_1)
	local l_19_2 = CoreSubtitleSequence.SubtitleSequence:new()
	local l_19_6, l_19_7 = ipairs, l_19_1:subtitles()
	l_19_6 = l_19_6(l_19_7)
	for i_0,i_1 in l_19_6 do
		local l_19_8 = l_19_5:string()
		local l_19_9 = l_19_0:_split_string_into_lines(l_19_8, l_19_1)
		local l_19_10 = 2
		local l_19_11 = math.max(math.ceil(#l_19_9 / l_19_10), 1)
		local l_19_12 = l_19_5:duration() / l_19_11
		local l_19_13 = 0
		for l_19_17 = 1, l_19_11 * l_19_10, 2 do
			local l_19_18 = table.concat
			local l_19_19 = {}
			 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_19_19(l_19_2, l_19_9[l_19_17 + 1].Subtitle:new(l_19_18, l_19_5:start_time() + l_19_12 * l_19_13, l_19_12))
			l_19_13 = l_19_13 + 1
		end
	end
	return l_19_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

OverlayPresenter._clear_workspace = function(l_20_0)
	if CoreCode.alive(l_20_0.__ws) then
		Overlay:newgui():destroy_workspace(l_20_0.__ws)
	end
	l_20_0.__ws = Overlay:newgui():create_scaled_screen_workspace(l_20_0:_gui_width(), l_20_0:_gui_height(), 0, 0, RenderSettings.resolution.x)
	local l_20_1, l_20_2 = l_20_0.__ws:panel():panel, l_20_0.__ws:panel()
	local l_20_3 = {}
	l_20_3.layer = 1000
	l_20_1 = l_20_1(l_20_2, l_20_3)
	l_20_0.__subtitle_panel = l_20_1
	l_20_1, l_20_2 = l_20_0:_on_resolution_changed, l_20_0
	l_20_1(l_20_2)
end

OverlayPresenter._split_string_into_lines = function(l_21_0, l_21_1, l_21_2)
	local l_21_3, l_21_4 = l_21_0:_auto_word_wrap_string, l_21_0
	local l_21_5 = l_21_1
	return l_21_3(l_21_4, l_21_5)
end

OverlayPresenter._auto_word_wrap_string = function(l_22_0, l_22_1)
	local l_22_2 = l_22_0:_layout_text_field()
	l_22_2:set_text(l_22_1)
	local l_22_3 = table.collect(l_22_2:line_breaks(), function(l_23_0)
		return l_23_0 + 1
  end)
	do
		local l_22_4 = {}
		for l_22_8 = 1, #l_22_3 do
			local l_22_9 = l_22_3[l_22_8]
			local l_22_10 = l_22_3[l_22_8 + 1]
			local l_22_11 = utf8.sub
			local l_22_12 = l_22_1
			local l_22_13 = l_22_9
			l_22_11 = l_22_11(l_22_12, l_22_13, (l_22_10 or 0) - 1)
			l_22_12 = table
			l_22_12 = l_22_12.insert
			l_22_13 = l_22_4
			l_22_12(l_22_13, string.trim(l_22_11))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		return l_22_4
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

OverlayPresenter._layout_text_field = function(l_23_0)
	assert(l_23_0.__subtitle_panel)
	if not l_23_0.__subtitle_panel:child("layout") then
		local l_23_1, l_23_2, l_23_4 = l_23_0.__subtitle_panel:text, l_23_0.__subtitle_panel
		local l_23_3 = nil
		l_23_3 = l_23_0.__width
		l_23_3 = l_23_0.__font_name
		l_23_3 = l_23_0.__font_size
		l_23_1, l_23_4 = l_23_1(l_23_2, l_23_4), {name = "layout", width = l_23_3, visible = false, font = l_23_3, font_size = l_23_3, align = "center", vertical = "bottom", wrap = true, word_wrap = true}
	end
	return l_23_1
end

OverlayPresenter._string_width = function(l_24_0, l_24_1)
	if not l_24_0.__ws:panel():child("string_width") then
		local l_24_2, l_24_3, l_24_5, l_24_6, l_24_7 = l_24_0.__ws:panel():text, l_24_0.__ws:panel()
		local l_24_4 = nil
		l_24_6 = l_24_0.__font_name
		l_24_6 = l_24_0.__font_size
		l_24_2, l_24_5 = l_24_2(l_24_3, l_24_5), {name = "string_width", visible = false, font = l_24_6, font_size = l_24_6, wrap = false}
	end
	l_24_2:set_text(l_24_1)
	return l_24_1
	 -- WARNING: undefined locals caused missing assignments!
end

OverlayPresenter._on_resolution_changed = function(l_25_0)
	local l_25_1 = l_25_0:_gui_width()
	local l_25_2 = l_25_0:_gui_height()
	local l_25_3 = managers.viewport:get_safe_rect()
	l_25_0.__ws:set_screen(l_25_1, l_25_2, 0, 0, RenderSettings.resolution.x)
	l_25_0.__subtitle_panel:set_width(l_25_1 * l_25_3.width)
	l_25_0.__subtitle_panel:set_height(l_25_2 * l_25_3.height)
	l_25_0.__subtitle_panel:set_center_x(l_25_1 * 0.5)
	l_25_0.__subtitle_panel:set_center_y(l_25_2 * 0.5)
	if not l_25_0.__width then
		l_25_0:set_width(l_25_0:_string_width("The quick brown fox jumped over the lazy dog."))
	end
end

OverlayPresenter._gui_width = function(l_26_0)
	return RenderSettings.resolution.x
end

OverlayPresenter._gui_height = function(l_27_0)
	local l_27_1 = RenderSettings.resolution
	return l_27_0:_gui_width() / (l_27_1.x / l_27_1.y)
end

OverlayPresenter._default_font_name = function(l_28_0)
	return "editor_font"
end

OverlayPresenter._default_font_size = function(l_29_0)
	return 22
end


