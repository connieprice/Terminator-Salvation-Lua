core:module("CoreMarkerEditBox")
core:require_module("CoreKeywordArguments")
core:require_module("CoreSmartListCtrl")
core:require_module("CoreClass")
core:require_module("CoreEvent")
if not MarkerEditBox then
	MarkerEditBox = CoreClass.class()
end
MarkerEditBox.init = function(l_1_0, ...)
	l_1_0._ews_parent = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("parent")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_1_0._song_project = nil
	l_1_0.panel = EWS:Panel(l_1_0._ews_parent, "", "")
	l_1_0.sample_clip_ctrl = EWS:SpinCtrl(l_1_0.panel, "0", "", "")
	l_1_0.sample_raw_ctrl = EWS:SpinCtrl(l_1_0.panel, "0", "", "")
	l_1_0.time_clip_ctrl = EWS:TextCtrl(l_1_0.panel, "0.00", "", "")
	l_1_0.time_raw_ctrl = EWS:TextCtrl(l_1_0.panel, "0.00", "", "")
	l_1_0.align_bar_cb = EWS:CheckBox(l_1_0.panel, "Align Bars", "", "")
	l_1_0.bar_cnt_text = EWS:StaticText(l_1_0.panel, "(bar# 0.00)", "", "")
	l_1_0.move_beat_left = EWS:Button(l_1_0.panel, "<<", "MOVEBEATLEFT", "")
	l_1_0.move_beat_right = EWS:Button(l_1_0.panel, ">>", "MOVEBEATRIGHT", "")
	local l_1_2, l_1_3 = , CoreSmartListCtrl.SmartListCtrl:new
	local l_1_4 = CoreSmartListCtrl.SmartListCtrl
	local l_1_5 = {parent = l_1_0.panel}
	l_1_5.header = {"rule", "weight", "jump_to", "fade_in", "fade_out"}
	l_1_5.on_popup_menu_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_popup_menu")
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0.list = l_1_3
	l_1_3 = CoreEvent
	l_1_3 = l_1_3.callback
	l_1_4 = l_1_0
	l_1_5 = l_1_0
	l_1_3 = l_1_3(l_1_4, l_1_5, "_on_sample_clip")
	l_1_0._on_sample_clip_cb = l_1_3
	l_1_3 = CoreEvent
	l_1_3 = l_1_3.callback
	l_1_4 = l_1_0
	l_1_5 = l_1_0
	l_1_3 = l_1_3(l_1_4, l_1_5, "_on_sample_raw")
	l_1_0._on_sample_raw_cb = l_1_3
	l_1_3 = CoreEvent
	l_1_3 = l_1_3.callback
	l_1_4 = l_1_0
	l_1_5 = l_1_0
	l_1_3 = l_1_3(l_1_4, l_1_5, "_on_sample_clip")
	l_1_0._on_sample_clip_cb = l_1_3
	l_1_3 = CoreEvent
	l_1_3 = l_1_3.callback
	l_1_4 = l_1_0
	l_1_5 = l_1_0
	l_1_3 = l_1_3(l_1_4, l_1_5, "_on_sample_raw")
	l_1_0._on_sample_raw_cb = l_1_3
	l_1_3 = CoreEvent
	l_1_3 = l_1_3.callback
	l_1_4 = l_1_0
	l_1_5 = l_1_0
	l_1_3 = l_1_3(l_1_4, l_1_5, "_on_time_clip")
	l_1_0._on_time_clip_cb = l_1_3
	l_1_3 = CoreEvent
	l_1_3 = l_1_3.callback
	l_1_4 = l_1_0
	l_1_5 = l_1_0
	l_1_3 = l_1_3(l_1_4, l_1_5, "_on_time_raw")
	l_1_0._on_time_raw_cb = l_1_3
	l_1_3 = CoreEvent
	l_1_3 = l_1_3.callback
	l_1_4 = l_1_0
	l_1_5 = l_1_0
	l_1_3 = l_1_3(l_1_4, l_1_5, "_on_move_beat_left")
	l_1_0._on_move_beat_left_cb = l_1_3
	l_1_3 = CoreEvent
	l_1_3 = l_1_3.callback
	l_1_4 = l_1_0
	l_1_5 = l_1_0
	l_1_3 = l_1_3(l_1_4, l_1_5, "_on_move_beat_right")
	l_1_0._on_move_beat_right_cb = l_1_3
	l_1_3 = CoreEvent
	l_1_3 = l_1_3.callback
	l_1_4 = l_1_0
	l_1_5 = l_1_0
	l_1_3 = l_1_3(l_1_4, l_1_5, "_on_align_bars")
	l_1_0._on_align_bars_cb = l_1_3
	l_1_3, l_1_4 = l_1_0:_enable_callbacks, l_1_0
	l_1_3(l_1_4)
	l_1_3 = EWS
	l_1_3, l_1_4 = l_1_3:FlexGridSizer, l_1_3
	l_1_5 = 2
	l_1_3 = l_1_3(l_1_4, l_1_5, 6, 5, 5)
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, EWS:StaticText(l_1_0.panel, "sample/clip:", "", ""), 0, 0, "")
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, l_1_0.sample_clip_ctrl, 0, 0, "EXPAND")
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, EWS:StaticText(l_1_0.panel, "time/clip:", "", ""), 0, 0, "")
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, l_1_0.time_clip_ctrl, 0, 0, "EXPAND")
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, l_1_0.move_beat_left, 0, 0, "")
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, l_1_0.move_beat_right, 0, 0, "")
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, EWS:StaticText(l_1_0.panel, "sample/sound:", "", ""), 0, 0, "")
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, l_1_0.sample_raw_ctrl, 0, 0, "EXPAND")
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, EWS:StaticText(l_1_0.panel, "time/sound:", "", ""), 0, 0, "")
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, l_1_0.time_raw_ctrl, 0, 0, "")
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, l_1_0.bar_cnt_text, 0, 0, "")
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, l_1_0.align_bar_cb, 0, 0, "")
	l_1_4 = EWS
	l_1_4, l_1_5 = l_1_4:StaticBoxSizer, l_1_4
	l_1_4 = l_1_4(l_1_5, l_1_0.panel, "VERTICAL", "Marker")
	l_1_0.box_sizer = l_1_4
	l_1_4 = l_1_0.box_sizer
	l_1_4, l_1_5 = l_1_4:add, l_1_4
	l_1_4(l_1_5, l_1_3, 0, 0, "")
	l_1_4 = l_1_0.box_sizer
	l_1_4, l_1_5 = l_1_4:add, l_1_4
	l_1_4(l_1_5, l_1_0.list.listctrl, 1, 0, "EXPAND")
	l_1_4 = l_1_0.panel
	l_1_4, l_1_5 = l_1_4:set_sizer, l_1_4
	l_1_4(l_1_5, l_1_0.box_sizer)
	l_1_4, l_1_5 = l_1_0:_set_enabled, l_1_0
	l_1_4(l_1_5, false)
end

MarkerEditBox.global_redraw = function(l_2_0, l_2_1)
	do
		if not l_2_1 then
			l_2_0._song_project = assert(l_2_0._song_project)
		end
		if l_2_0._marker_name then
			local l_2_3 = l_2_0._song_project:find_marker
			local l_2_4 = l_2_0._song_project
			l_2_3 = l_2_3(l_2_4, {name = l_2_0._marker_name})
		if not l_2_3 then
			end
			l_2_0._marker_name = nil
		end
		l_2_0:_redraw()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MarkerEditBox.marker_selected = function(l_3_0, l_3_1)
	l_3_0._marker_name = l_3_1
	l_3_0:_redraw()
end

MarkerEditBox.marker_deselected = function(l_4_0)
	l_4_0._marker_name = nil
	l_4_0:_redraw()
end

MarkerEditBox.clip_modified = function(l_5_0)
	l_5_0:_redraw()
end

MarkerEditBox.register_on_sample_update_cb = function(l_6_0, l_6_1)
	l_6_0._on_sample_update_cb = l_6_1
end

MarkerEditBox._redraw = function(l_7_0)
	l_7_0:_disable_callbacks()
	l_7_0.list:clear_list()
	if l_7_0._marker_name then
		local l_7_1, l_7_2 = l_7_0._song_project:find_marker, l_7_0._song_project
		local l_7_3 = {}
		l_7_3.name = l_7_0._marker_name
		l_7_1 = l_7_1(l_7_2, l_7_3)
		l_7_2 = l_7_0._song_project
		l_7_2, l_7_3 = l_7_2:find_clip, l_7_2
		local l_7_4 = {}
		l_7_4.name = l_7_1.clip
		l_7_2 = l_7_2(l_7_3, l_7_4)
		l_7_3 = tonumber
		l_7_4 = l_7_2.start
		l_7_3 = l_7_3(l_7_4)
		l_7_4 = tonumber
		l_7_4 = l_7_4(l_7_2.stop)
		l_7_0.sample_clip_ctrl:set_range(0, l_7_4 - l_7_3)
		l_7_0.sample_raw_ctrl:set_range(l_7_3, l_7_4)
		local l_7_5 = tonumber(l_7_1.sample)
		local l_7_6 = l_7_5 + l_7_3
		local l_7_7 = l_7_5 / 44100
		local l_7_8 = l_7_6 / 44100
		l_7_0.sample_clip_ctrl:set_value(l_7_5)
		l_7_0.sample_raw_ctrl:set_value(l_7_6)
		l_7_0.time_clip_ctrl:set_value(string.format("%.5f", l_7_7))
		l_7_0.time_raw_ctrl:set_value(string.format("%.5f", l_7_8))
		local l_7_9, l_7_10 = l_7_0.align_bar_cb:set_value, l_7_0.align_bar_cb
		l_7_9(l_7_10, l_7_1.align_bars == "yes")
		l_7_9 = l_7_0._song_project
		l_7_9, l_7_10 = l_7_9:get_rules, l_7_9
		local l_7_14 = {}
		l_7_14.marker_name = l_7_0._marker_name
		l_7_9 = l_7_9(l_7_10, l_7_14)
		for i_0 in l_7_9 do
			l_7_0.list:append_item(l_7_13)
		end
		l_7_0:_set_enabled(true)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_7_1 = l_7_0.sample_clip_ctrl
		l_7_1, l_7_2 = l_7_1:set_range, l_7_1
		l_7_3 = 0
		l_7_4 = 1
		l_7_1(l_7_2, l_7_3, l_7_4)
		l_7_1 = l_7_0.sample_raw_ctrl
		l_7_1, l_7_2 = l_7_1:set_range, l_7_1
		l_7_3 = 0
		l_7_4 = 1
		l_7_1(l_7_2, l_7_3, l_7_4)
		l_7_1 = l_7_0.sample_clip_ctrl
		l_7_1, l_7_2 = l_7_1:set_value, l_7_1
		l_7_3 = 0
		l_7_1(l_7_2, l_7_3)
		l_7_1 = l_7_0.sample_raw_ctrl
		l_7_1, l_7_2 = l_7_1:set_value, l_7_1
		l_7_3 = 0
		l_7_1(l_7_2, l_7_3)
		l_7_1 = l_7_0.time_clip_ctrl
		l_7_1, l_7_2 = l_7_1:set_value, l_7_1
		l_7_3 = "0.00000"
		l_7_1(l_7_2, l_7_3)
		l_7_1 = l_7_0.time_raw_ctrl
		l_7_1, l_7_2 = l_7_1:set_value, l_7_1
		l_7_3 = "0.00000"
		l_7_1(l_7_2, l_7_3)
		l_7_1 = l_7_0.align_bar_cb
		l_7_1, l_7_2 = l_7_1:set_value, l_7_1
		l_7_3 = false
		l_7_1(l_7_2, l_7_3)
		l_7_1, l_7_2 = l_7_0:_set_enabled, l_7_0
		l_7_3 = false
		l_7_1(l_7_2, l_7_3)
	end
	l_7_1, l_7_2 = l_7_0:_redraw_bar_cnt_text, l_7_0
	l_7_1(l_7_2)
	l_7_1, l_7_2 = l_7_0:_enable_callbacks, l_7_0
	l_7_1(l_7_2)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MarkerEditBox._set_enabled = function(l_8_0, l_8_1)
	l_8_0.list.listctrl:set_enabled(l_8_1)
	l_8_0.sample_clip_ctrl:set_enabled(l_8_1)
	l_8_0.sample_raw_ctrl:set_enabled(l_8_1)
	l_8_0.time_clip_ctrl:set_enabled(l_8_1)
	l_8_0.time_raw_ctrl:set_enabled(l_8_1)
	l_8_0.move_beat_left:set_enabled(l_8_1)
	l_8_0.move_beat_right:set_enabled(l_8_1)
	l_8_0.align_bar_cb:set_enabled(l_8_1)
	l_8_0.bar_cnt_text:set_enabled(l_8_1)
end

MarkerEditBox._enable_callbacks = function(l_9_0, l_9_1)
	l_9_0.list:enable_callbacks()
	l_9_0.sample_clip_ctrl:connect("EVT_COMMAND_SPINCTRL_UPDATED", l_9_0._on_sample_clip_cb)
	l_9_0.sample_raw_ctrl:connect("EVT_COMMAND_SPINCTRL_UPDATED", l_9_0._on_sample_raw_cb)
	l_9_0.sample_clip_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", l_9_0._on_sample_clip_cb)
	l_9_0.sample_raw_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", l_9_0._on_sample_raw_cb)
	l_9_0.time_clip_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", l_9_0._on_time_clip_cb)
	l_9_0.time_raw_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", l_9_0._on_time_raw_cb)
	l_9_0.move_beat_left:connect("EVT_COMMAND_BUTTON_CLICKED", l_9_0._on_move_beat_left_cb)
	l_9_0.move_beat_right:connect("EVT_COMMAND_BUTTON_CLICKED", l_9_0._on_move_beat_right_cb)
	l_9_0.align_bar_cb:connect("EVT_COMMAND_CHECKBOX_CLICKED", l_9_0._on_align_bars_cb)
end

MarkerEditBox._disable_callbacks = function(l_10_0, l_10_1)
	l_10_0.list:disable_callbacks()
	l_10_0.sample_clip_ctrl:disconnect("EVT_COMMAND_SPINCTRL_UPDATED", l_10_0._on_sample_clip_cb)
	l_10_0.sample_raw_ctrl:disconnect("EVT_COMMAND_SPINCTRL_UPDATED", l_10_0._on_sample_raw_cb)
	l_10_0.sample_clip_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", l_10_0._on_sample_clip_cb)
	l_10_0.sample_raw_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", l_10_0._on_sample_raw_cb)
	l_10_0.time_clip_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", l_10_0._on_time_clip_cb)
	l_10_0.time_raw_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", l_10_0._on_time_raw_cb)
	l_10_0.move_beat_left:disconnect("EVT_COMMAND_BUTTON_CLICKED", l_10_0._on_move_beat_left_cb)
	l_10_0.move_beat_right:disconnect("EVT_COMMAND_BUTTON_CLICKED", l_10_0._on_move_beat_right_cb)
	l_10_0.align_bar_cb:disconnect("EVT_COMMAND_CHECKBOX_CLICKED", l_10_0._on_align_bars_cb)
end

MarkerEditBox._on_popup_menu = function(l_11_0, l_11_1, l_11_2)
	local l_11_3 = {}
	l_11_3.Add = CoreEvent.callback(l_11_0, l_11_0, "_on_add")
	if l_11_2 == nil then
		return l_11_3
	end
	l_11_3.Modify = CoreEvent.callback(l_11_0, l_11_0, "_on_modify")
	l_11_3.Remove = CoreEvent.callback(l_11_0, l_11_0, "_on_remove")
	if l_11_2 > 0 then
		l_11_3["Move Up"] = CoreEvent.callback(l_11_0, l_11_0, "_on_move_up")
	end
	if l_11_2 < l_11_0.list:get_number_dynamic_items() - 1 then
		l_11_3["Move Down"] = CoreEvent.callback(l_11_0, l_11_0, "_on_move_down")
	end
	return l_11_3
end

MarkerEditBox._on_add = function(l_12_0)
	local l_12_1 = l_12_0:_edit_rule({}, "Add New Rule")
	if l_12_1 then
		local l_12_2, l_12_3 = l_12_0._song_project:add_new_rule, l_12_0._song_project
		local l_12_4 = {}
		l_12_4.rule = l_12_1.rule
		l_12_4.weight = l_12_1.weight
		l_12_4.jump_to = l_12_1.jump_to
		l_12_4.fade_in = l_12_1.fade_in
		l_12_4.fade_out = l_12_1.fade_out
		l_12_4.marker_name = l_12_0._marker_name
		l_12_2(l_12_3, l_12_4)
		l_12_2, l_12_3 = l_12_0:_redraw, l_12_0
		l_12_2(l_12_3)
	end
end

MarkerEditBox._on_modify = function(l_13_0)
	local l_13_1 = l_13_0.list:get_selected_index()
	local l_13_2 = l_13_0.list:get_selected_item()
	local l_13_3 = l_13_0:_edit_rule(l_13_2, "Modify Rule")
	if l_13_3 then
		local l_13_4, l_13_5 = l_13_0._song_project:modify_rule, l_13_0._song_project
		local l_13_6 = {}
		l_13_6.rule = l_13_3.rule
		l_13_6.weight = l_13_3.weight
		l_13_6.jump_to = l_13_3.jump_to
		l_13_6.fade_in = l_13_3.fade_in
		l_13_6.fade_out = l_13_3.fade_out
		l_13_6.marker_name = l_13_0._marker_name
		l_13_6.index = l_13_1
		l_13_4(l_13_5, l_13_6)
		l_13_4, l_13_5 = l_13_0:_redraw, l_13_0
		l_13_4(l_13_5)
	end
end

MarkerEditBox._on_remove = function(l_14_0)
	local l_14_1 = l_14_0.list:get_selected_index()
	local l_14_2, l_14_3 = l_14_0._song_project:remove_rule, l_14_0._song_project
	local l_14_4 = {}
	l_14_4.marker_name = l_14_0._marker_name
	l_14_4.index = l_14_1
	l_14_2(l_14_3, l_14_4)
	l_14_2, l_14_3 = l_14_0:_redraw, l_14_0
	l_14_2(l_14_3)
end

MarkerEditBox._on_move_up = function(l_15_0)
	local l_15_1 = l_15_0.list:get_selected_index()
	local l_15_2, l_15_3 = l_15_0._song_project:move_rule, l_15_0._song_project
	local l_15_4 = {}
	l_15_4.marker_name = l_15_0._marker_name
	l_15_4.old_index = l_15_1
	l_15_4.new_index = l_15_1 - 1
	l_15_2(l_15_3, l_15_4)
	l_15_2, l_15_3 = l_15_0:_redraw, l_15_0
	l_15_2(l_15_3)
end

MarkerEditBox._on_move_down = function(l_16_0)
	local l_16_1 = l_16_0.list:get_selected_index()
	local l_16_2, l_16_3 = l_16_0._song_project:move_rule, l_16_0._song_project
	local l_16_4 = {}
	l_16_4.marker_name = l_16_0._marker_name
	l_16_4.old_index = l_16_1
	l_16_4.new_index = l_16_1 + 1
	l_16_2(l_16_3, l_16_4)
	l_16_2, l_16_3 = l_16_0:_redraw, l_16_0
	l_16_2(l_16_3)
end

MarkerEditBox._edit_rule = function(l_17_0, l_17_1, l_17_2)
	do
		local l_17_3 = l_17_1.rule or "default"
	do
		end
		local l_17_4 = nil
	do
		end
		local l_17_5 = nil
	do
		end
		local l_17_6 = nil
	do
		end
		local l_17_7 = nil
	end
	local l_17_8, l_17_9, l_17_10, l_17_11, l_17_12 = , l_17_1.weight or "1", l_17_1.jump_to or "", l_17_1.fade_in or "0.5", l_17_1.fade_out or "0.5"
	local l_17_13 = nil
	local l_17_14 = nil
	local l_17_15 = nil
	local l_17_16 = nil
	local l_17_17 = nil
	local l_17_18 = nil
	local l_17_19 = EWS:ComboBox(EWS:Dialog(l_17_0._ews_parent, l_17_2, "", Vector3(-1, -1, 0), Vector3(260, 240, 0), ""), "", "", "CB_READONLY")
	local l_17_24 = EWS:SpinCtrl(EWS:Dialog(l_17_0._ews_parent, l_17_2, "", Vector3(-1, -1, 0), Vector3(260, 240, 0), ""), tonumber(l_17_9), "", "")
	local l_17_20 = EWS:ComboBox(EWS:Dialog(l_17_0._ews_parent, l_17_2, "", Vector3(-1, -1, 0), Vector3(260, 240, 0), ""), "", "", "CB_READONLY")
	l_17_19:append("default")
	l_17_19:append("stop")
	for i_0 in l_17_0._song_project:get_modes() do
		local l_17_21, l_17_22, l_17_23 = EWS:TextCtrl(EWS:Dialog(l_17_0._ews_parent, l_17_2, "", Vector3(-1, -1, 0), Vector3(260, 240, 0), ""), l_17_11, "", ""), EWS:TextCtrl(EWS:Dialog(l_17_0._ews_parent, l_17_2, "", Vector3(-1, -1, 0), Vector3(260, 240, 0), ""), l_17_12, "", ""), EWS:Button(l_17_18, "Apply", "", "")
		l_17_19:append(i_0.name)
	end
	l_17_19:set_value(l_17_8)
	l_17_24:set_range(0, 100000)
	l_17_20:append("END_SONG")
	for i_0 in l_17_0._song_project:get_markers() do
		l_17_20:append(i_0.name)
	end
	l_17_20:set_value(l_17_10)
	l_17_18:set_sizer(EWS:BoxSizer("VERTICAL"))
	EWS:FlexGridSizer(5, 2, 10, 10):add(EWS:StaticText(l_17_18, "Rule:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(l_17_19, 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(EWS:StaticText(l_17_18, "Weight:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(l_17_24, 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(EWS:StaticText(l_17_18, "Jump To:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(l_17_20, 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(EWS:StaticText(l_17_18, "Fade-in:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(l_17_21, 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(EWS:StaticText(l_17_18, "Fade-out:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(l_17_22, 0, 0, "")
	EWS:FlexGridSizer(1, 2, 40, 10):add(l_17_23, 0, 0, "ALIGN_CENTER")
	EWS:FlexGridSizer(1, 2, 40, 10):add(EWS:Button(l_17_18, "Cancel", "", ""), 0, 0, "ALIGN_CENTER")
	EWS:BoxSizer("VERTICAL"):add(EWS:StaticText(l_17_18, "", "", ""), 0, 0, "")
	EWS:BoxSizer("VERTICAL"):add(EWS:FlexGridSizer(5, 2, 10, 10), 1, 0, "ALIGN_CENTER")
	EWS:BoxSizer("VERTICAL"):add(EWS:FlexGridSizer(1, 2, 40, 10), 0, 0, "ALIGN_CENTER")
	l_17_23:connect("", "EVT_COMMAND_BUTTON_CLICKED", function()
		-- upvalues: l_17_24 , l_17_13
		l_17_24 = "APPLY"
		l_17_13:end_modal()
  end, "")
	EWS:Button(l_17_18, "Cancel", "", ""):connect("", "EVT_COMMAND_BUTTON_CLICKED", function()
		-- upvalues: l_17_24 , l_17_13
		l_17_24 = "CANCEL"
		l_17_13:end_modal()
  end, "")
	while 1 do
		local l_17_27 = nil
		while 1 do
			while 1 do
				while 1 do
					while not false do
						l_17_18:show_modal()
						if "CANCEL" == "CANCEL" then
							return nil
						end
						l_17_13 = l_17_19:get_value()
						l_17_14 = l_17_24:get_value()
						l_17_15 = l_17_20:get_value()
						l_17_16 = l_17_21:get_value()
						l_17_17 = l_17_22:get_value()
						if l_17_15 == "" then
							EWS:MessageDialog(l_17_0._ews_parent, "Rule must have a Jump-to Marker.", "Wrong Input", ""):show_modal()
						end
						if not tonumber(l_17_16) then
							EWS:MessageDialog(l_17_0._ews_parent, "Fade-in must be a float number (e.g. 1.234).", "Wrong Input", ""):show_modal()
						end
						if not tonumber(l_17_17) then
							EWS:MessageDialog(l_17_0._ews_parent, "Fade-out must be a float number (e.g. 1.234).", "Wrong Input", ""):show_modal()
						end
					end
					do
						local l_17_28 = nil
						return {rule = l_17_13, weight = l_17_14, jump_to = l_17_15, fade_in = l_17_16, fade_out = l_17_17}
					end
					 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

					 -- WARNING: undefined locals caused missing assignments!
					 -- WARNING: missing end command somewhere! Added here
				end
				 -- WARNING: missing end command somewhere! Added here
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

MarkerEditBox._on_sample_clip = function(l_18_0)
	if l_18_0._marker_name then
		local l_18_1, l_18_2 = l_18_0._song_project:find_marker, l_18_0._song_project
		local l_18_3 = {}
		l_18_3.name = l_18_0._marker_name
		l_18_1 = l_18_1(l_18_2, l_18_3)
		l_18_2 = l_18_0._song_project
		l_18_2, l_18_3 = l_18_2:find_clip, l_18_2
		local l_18_4 = {}
		l_18_4.name = l_18_1.clip
		l_18_2 = l_18_2(l_18_3, l_18_4)
		l_18_3 = tonumber
		l_18_4 = l_18_2.start
		l_18_3 = l_18_3(l_18_4)
		l_18_4 = l_18_0.sample_clip_ctrl
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_18_5 = l_18_4 + l_18_3
		local l_18_6 = l_18_4 / 44100
		local l_18_7 = l_18_5 / 44100
		l_18_0:_disable_callbacks()
		l_18_0.sample_raw_ctrl:set_value(l_18_5)
		l_18_0.time_clip_ctrl:set_value(string.format("%.5f", l_18_6))
		l_18_0.time_raw_ctrl:set_value(string.format("%.5f", l_18_7))
		local l_18_8, l_18_9 = l_18_0._song_project:set_marker_sample, l_18_0._song_project
		local l_18_10 = {}
		l_18_10.name = l_18_0._marker_name
		l_18_10.sample = l_18_4
		l_18_8(l_18_9, l_18_10)
		l_18_8, l_18_9 = l_18_0:_enable_callbacks, l_18_0
		l_18_8(l_18_9)
		l_18_8, l_18_9 = l_18_0:_redraw_bar_cnt_text, l_18_0
		l_18_8(l_18_9)
		l_18_8 = l_18_0._on_sample_update_cb
	if l_18_8 then
		end
		l_18_8 = l_18_0._on_sample_update_cb
		l_18_8()
	end
end

MarkerEditBox._on_sample_raw = function(l_19_0)
	if l_19_0._marker_name then
		local l_19_1, l_19_2 = l_19_0._song_project:find_marker, l_19_0._song_project
		local l_19_3 = {}
		l_19_3.name = l_19_0._marker_name
		l_19_1 = l_19_1(l_19_2, l_19_3)
		l_19_2 = l_19_0._song_project
		l_19_2, l_19_3 = l_19_2:find_clip, l_19_2
		local l_19_4 = {}
		l_19_4.name = l_19_1.clip
		l_19_2 = l_19_2(l_19_3, l_19_4)
		l_19_3 = tonumber
		l_19_4 = l_19_2.start
		l_19_3 = l_19_3(l_19_4)
		l_19_4 = l_19_0.sample_raw_ctrl
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_19_5 = l_19_4 - l_19_3
		local l_19_6 = l_19_5 / 44100
		local l_19_7 = l_19_4 / 44100
		l_19_0:_disable_callbacks()
		l_19_0.sample_clip_ctrl:set_value(l_19_5)
		l_19_0.time_clip_ctrl:set_value(string.format("%.5f", l_19_6))
		l_19_0.time_raw_ctrl:set_value(string.format("%.5f", l_19_7))
		local l_19_8, l_19_9 = l_19_0._song_project:set_marker_sample, l_19_0._song_project
		local l_19_10 = {}
		l_19_10.name = l_19_0._marker_name
		l_19_10.sample = l_19_5
		l_19_8(l_19_9, l_19_10)
		l_19_8, l_19_9 = l_19_0:_enable_callbacks, l_19_0
		l_19_8(l_19_9)
		l_19_8, l_19_9 = l_19_0:_redraw_bar_cnt_text, l_19_0
		l_19_8(l_19_9)
		l_19_8 = l_19_0._on_sample_update_cb
	if l_19_8 then
		end
		l_19_8 = l_19_0._on_sample_update_cb
		l_19_8()
	end
end

MarkerEditBox._on_time_clip = function(l_20_0)
	if l_20_0._marker_name and l_20_0.time_clip_ctrl:in_focus() then
		local l_20_1, l_20_2 = l_20_0._song_project:find_marker, l_20_0._song_project
		local l_20_3 = {}
		l_20_3.name = l_20_0._marker_name
		l_20_1 = l_20_1(l_20_2, l_20_3)
		l_20_2 = l_20_0._song_project
		l_20_2, l_20_3 = l_20_2:find_clip, l_20_2
		local l_20_4 = {}
		l_20_4.name = l_20_1.clip
		l_20_2 = l_20_2(l_20_3, l_20_4)
		l_20_3 = tonumber
		l_20_4 = l_20_2.start
		l_20_3 = l_20_3(l_20_4)
		l_20_4 = tonumber
		l_20_4 = l_20_4(l_20_2.stop)
		local l_20_5 = tonumber(l_20_0.time_clip_ctrl:get_value())
		if l_20_5 == nil then
			return 
		end
		local l_20_6 = math.floor(math.min(l_20_4 - l_20_3, math.max(0, math.floor(l_20_5 * 44100))))
		local l_20_7 = l_20_6 + l_20_3
		local l_20_8 = l_20_7 / 44100
		l_20_0:_disable_callbacks()
		l_20_0.sample_clip_ctrl:set_value(l_20_6)
		l_20_0.sample_raw_ctrl:set_value(l_20_7)
		l_20_0.time_raw_ctrl:set_value(string.format("%.5f", l_20_8))
		local l_20_9, l_20_10 = l_20_0._song_project:set_marker_sample, l_20_0._song_project
		local l_20_11 = {}
		l_20_11.name = l_20_0._marker_name
		l_20_11.sample = l_20_6
		l_20_9(l_20_10, l_20_11)
		l_20_9, l_20_10 = l_20_0:_enable_callbacks, l_20_0
		l_20_9(l_20_10)
		l_20_9, l_20_10 = l_20_0:_redraw_bar_cnt_text, l_20_0
		l_20_9(l_20_10)
		l_20_9 = l_20_0._on_sample_update_cb
	if l_20_9 then
		end
		l_20_9 = l_20_0._on_sample_update_cb
		l_20_9()
	end
end

MarkerEditBox._on_time_raw = function(l_21_0)
	if l_21_0._marker_name and l_21_0.time_raw_ctrl:in_focus() then
		local l_21_1, l_21_2 = l_21_0._song_project:find_marker, l_21_0._song_project
		local l_21_3 = {}
		l_21_3.name = l_21_0._marker_name
		l_21_1 = l_21_1(l_21_2, l_21_3)
		l_21_2 = l_21_0._song_project
		l_21_2, l_21_3 = l_21_2:find_clip, l_21_2
		local l_21_4 = {}
		l_21_4.name = l_21_1.clip
		l_21_2 = l_21_2(l_21_3, l_21_4)
		l_21_3 = tonumber
		l_21_4 = l_21_2.start
		l_21_3 = l_21_3(l_21_4)
		l_21_4 = tonumber
		l_21_4 = l_21_4(l_21_2.stop)
		local l_21_5 = tonumber(l_21_0.time_raw_ctrl:get_value())
		if l_21_5 == nil then
			return 
		end
		local l_21_6 = math.floor(math.min(l_21_4, math.max(l_21_3, math.floor(l_21_5 * 44100))))
		local l_21_7 = l_21_6 - l_21_3
		local l_21_8 = l_21_7 / 44100
		l_21_0:_disable_callbacks()
		l_21_0.sample_clip_ctrl:set_value(l_21_7)
		l_21_0.sample_raw_ctrl:set_value(l_21_6)
		l_21_0.time_clip_ctrl:set_value(string.format("%.5f", l_21_8))
		local l_21_9, l_21_10 = l_21_0._song_project:set_marker_sample, l_21_0._song_project
		local l_21_11 = {}
		l_21_11.name = l_21_0._marker_name
		l_21_11.sample = l_21_7
		l_21_9(l_21_10, l_21_11)
		l_21_9, l_21_10 = l_21_0:_enable_callbacks, l_21_0
		l_21_9(l_21_10)
		l_21_9, l_21_10 = l_21_0:_redraw_bar_cnt_text, l_21_0
		l_21_9(l_21_10)
		l_21_9 = l_21_0._on_sample_update_cb
	if l_21_9 then
		end
		l_21_9 = l_21_0._on_sample_update_cb
		l_21_9()
	end
end

MarkerEditBox._on_move_beat_left = function(l_22_0)
	if l_22_0._marker_name then
		local l_22_1, l_22_2 = l_22_0._song_project:find_marker, l_22_0._song_project
		local l_22_3 = {}
		l_22_3.name = l_22_0._marker_name
		l_22_1 = l_22_1(l_22_2, l_22_3)
		l_22_2 = l_22_0._song_project
		l_22_2, l_22_3 = l_22_2:find_mode, l_22_2
		local l_22_4 = {}
		l_22_4.name = l_22_1.mode
		l_22_2 = l_22_2(l_22_3, l_22_4)
		l_22_3 = l_22_2.mode_time_signature
		l_22_3 = l_22_3 * 60
		l_22_4 = l_22_2.mode_bpm
		l_22_3 = l_22_3 / l_22_4
		l_22_4 = l_22_0._song_project
		local l_22_5 = l_22_4
		local l_22_6 = {}
		l_22_6.name = l_22_1.clip
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_22_5 = tonumber
		l_22_6 = l_22_4.start
		l_22_5 = l_22_5(l_22_6)
		l_22_6 = tonumber
		l_22_6 = l_22_6(l_22_4.stop)
		local l_22_7 = math.floor(tonumber(l_22_1.sample) - l_22_3 * 44100)
	if l_22_7 >= 0 then
		end
		local l_22_8 = l_22_7 + l_22_5
		local l_22_9 = l_22_7 / 44100
		local l_22_10 = l_22_8 / 44100
		l_22_0:_disable_callbacks()
		l_22_0.sample_clip_ctrl:set_value(l_22_7)
		l_22_0.sample_raw_ctrl:set_value(l_22_8)
		l_22_0.time_clip_ctrl:set_value(string.format("%.5f", l_22_9))
		l_22_0.time_raw_ctrl:set_value(string.format("%.5f", l_22_10))
		local l_22_11, l_22_12 = l_22_0._song_project:set_marker_sample, l_22_0._song_project
		local l_22_13 = {}
		l_22_13.name = l_22_0._marker_name
		l_22_13.sample = l_22_7
		l_22_11(l_22_12, l_22_13)
		l_22_11, l_22_12 = l_22_0:_enable_callbacks, l_22_0
		l_22_11(l_22_12)
		l_22_11, l_22_12 = l_22_0:_redraw_bar_cnt_text, l_22_0
		l_22_11(l_22_12)
		l_22_11 = l_22_0._on_sample_update_cb
	if l_22_11 then
		end
		l_22_11 = l_22_0._on_sample_update_cb
		l_22_11()
	end
end

MarkerEditBox._on_move_beat_right = function(l_23_0)
	if l_23_0._marker_name then
		local l_23_1, l_23_2 = l_23_0._song_project:find_marker, l_23_0._song_project
		local l_23_3 = {}
		l_23_3.name = l_23_0._marker_name
		l_23_1 = l_23_1(l_23_2, l_23_3)
		l_23_2 = l_23_0._song_project
		l_23_2, l_23_3 = l_23_2:find_mode, l_23_2
		local l_23_4 = {}
		l_23_4.name = l_23_1.mode
		l_23_2 = l_23_2(l_23_3, l_23_4)
		l_23_3 = l_23_2.mode_time_signature
		l_23_3 = l_23_3 * 60
		l_23_4 = l_23_2.mode_bpm
		l_23_3 = l_23_3 / l_23_4
		l_23_4 = l_23_0._song_project
		local l_23_5 = l_23_4
		local l_23_6 = {}
		l_23_6.name = l_23_1.clip
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_23_5 = tonumber
		l_23_6 = l_23_4.start
		l_23_5 = l_23_5(l_23_6)
		l_23_6 = tonumber
		l_23_6 = l_23_6(l_23_4.stop)
		local l_23_7 = math.floor(tonumber(l_23_1.sample) + l_23_3 * 44100)
		local l_23_8 = l_23_7 + l_23_5
		local l_23_9 = l_23_7 / 44100
		local l_23_10 = l_23_8 / 44100
		l_23_0:_disable_callbacks()
		l_23_0.sample_clip_ctrl:set_value(l_23_7)
		l_23_0.sample_raw_ctrl:set_value(l_23_8)
		l_23_0.time_clip_ctrl:set_value(string.format("%.5f", l_23_9))
		l_23_0.time_raw_ctrl:set_value(string.format("%.5f", l_23_10))
		local l_23_11, l_23_12 = l_23_0._song_project:set_marker_sample, l_23_0._song_project
		local l_23_13 = {}
		l_23_13.name = l_23_0._marker_name
		l_23_13.sample = l_23_7
		l_23_11(l_23_12, l_23_13)
		l_23_11, l_23_12 = l_23_0:_enable_callbacks, l_23_0
		l_23_11(l_23_12)
		l_23_11, l_23_12 = l_23_0:_redraw_bar_cnt_text, l_23_0
		l_23_11(l_23_12)
		l_23_11 = l_23_0._on_sample_update_cb
	if l_23_11 then
		end
		l_23_11 = l_23_0._on_sample_update_cb
		l_23_11()
	end
end

MarkerEditBox._on_align_bars = function(l_24_0)
	if l_24_0._marker_name then
		local l_24_1, l_24_2 = l_24_0._song_project:set_marker_align_bars, l_24_0._song_project
		local l_24_3 = {}
		l_24_3.name = l_24_0._marker_name
		l_24_3.align_bars = l_24_0.align_bar_cb:get_value()
		l_24_1(l_24_2, l_24_3)
	end
	l_24_0:_redraw_bar_cnt_text()
end

MarkerEditBox._redraw_bar_cnt_text = function(l_25_0)
	if l_25_0._marker_name then
		local l_25_1, l_25_2 = l_25_0._song_project:find_marker, l_25_0._song_project
		local l_25_3 = {}
		l_25_3.name = l_25_0._marker_name
		l_25_1 = l_25_1(l_25_2, l_25_3)
		l_25_2 = l_25_0._song_project
		l_25_2, l_25_3 = l_25_2:find_mode, l_25_2
		local l_25_4 = {}
		l_25_4.name = l_25_1.mode
		l_25_2 = l_25_2(l_25_3, l_25_4)
		l_25_3 = l_25_2.mode_time_signature
		l_25_3 = l_25_3 * 60
		l_25_4 = l_25_2.mode_bpm
		l_25_3 = l_25_3 / l_25_4
		l_25_4 = l_25_0._song_project
		local l_25_5 = l_25_4
		local l_25_6 = {}
		l_25_6.mode_name = l_25_1.mode
		l_25_6.clip_name = l_25_1.clip
		 -- DECOMPILER ERROR: Overwrote pending register.

	if not l_25_4 then
		end
		l_25_6 = tonumber
		l_25_6 = l_25_6(l_25_1.sample)
		local l_25_7 = (l_25_6 / 44100 - l_25_5.bar_offset) / (l_25_3) + 1
		l_25_0.bar_cnt_text:set_value(string.format("(bar# %4.2f)", l_25_7))
		return 
	end
	l_25_0.bar_cnt_text:set_value("(bar# 0.00)")
end


