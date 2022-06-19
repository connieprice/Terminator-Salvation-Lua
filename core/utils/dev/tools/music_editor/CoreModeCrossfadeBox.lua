core:module("CoreModeCrossfadeBox")
core:require_module("CoreKeywordArguments")
core:require_module("CoreSmartListCtrl")
core:require_module("CoreClass")
core:require_module("CoreEvent")
if not ModeCrossfadeBox then
	ModeCrossfadeBox = CoreClass.class()
end
ModeCrossfadeBox.init = function(l_1_0, ...)
	l_1_0._ews_parent = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("parent")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_1_0._song_project = nil
	l_1_0.panel = EWS:Panel(l_1_0._ews_parent, "", "")
	l_1_0.new_section_cb = EWS:CheckBox(l_1_0.panel, "Start new section  ", "", "")
	l_1_0.section_text1 = EWS:StaticText(l_1_0.panel, "", "", "")
	l_1_0.section_text2 = EWS:StaticText(l_1_0.panel, "", "", "")
	l_1_0.section_text3 = EWS:StaticText(l_1_0.panel, "", "", "")
	local l_1_2, l_1_3 = , CoreSmartListCtrl.SmartListCtrl:new
	local l_1_4 = CoreSmartListCtrl.SmartListCtrl
	local l_1_5 = {parent = l_1_0.panel}
	l_1_5.header = {"mode", "marker", "add_time", "weight", "fade_in", "fade_out"}
	l_1_5.on_popup_menu_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_popup_menu")
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0.list = l_1_3
	l_1_3 = CoreEvent
	l_1_3 = l_1_3.callback
	l_1_4 = l_1_0
	l_1_5 = l_1_0
	l_1_3 = l_1_3(l_1_4, l_1_5, "_on_new_section")
	l_1_0._on_new_section_cb = l_1_3
	l_1_3, l_1_4 = l_1_0:_enable_callbacks, l_1_0
	l_1_3(l_1_4)
	l_1_3 = EWS
	l_1_3, l_1_4 = l_1_3:FlexGridSizer, l_1_3
	l_1_5 = 3
	l_1_3 = l_1_3(l_1_4, l_1_5, 1, 5, 5)
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, l_1_0.section_text1, 0, 0, "ALIGN_LEFT")
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, l_1_0.section_text2, 0, 0, "ALIGN_CENTER")
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, l_1_0.section_text3, 0, 0, "ALIGN_CENTER")
	l_1_4 = EWS
	l_1_4, l_1_5 = l_1_4:FlexGridSizer, l_1_4
	l_1_4 = l_1_4(l_1_5, 2, 1, 5, 5)
	l_1_5(l_1_4, l_1_3, 0, 0, "ALIGN_RIGHT")
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_5(l_1_4, l_1_0.new_section_cb, 0, 0, "")
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0.box_sizer = l_1_5
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_5(l_1_5, l_1_4, 0, 0, "")
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_5(l_1_5, l_1_0.list.listctrl, 1, 0, "EXPAND")
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_5(l_1_5, l_1_0.box_sizer)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_5(l_1_0, false)
end

ModeCrossfadeBox.global_redraw = function(l_2_0, l_2_1)
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

ModeCrossfadeBox.set_song = function(l_3_0, l_3_1)
	l_3_0._marker_name = nil
	l_3_0._song_project = l_3_1
	l_3_0:_redraw()
end

ModeCrossfadeBox.marker_selected = function(l_4_0, l_4_1)
	l_4_0._marker_name = l_4_1
	l_4_0:_redraw()
end

ModeCrossfadeBox.marker_deselected = function(l_5_0)
	l_5_0._marker_name = nil
	l_5_0:_redraw()
end

ModeCrossfadeBox._redraw = function(l_6_0)
	l_6_0:_disable_callbacks()
	if l_6_0._marker_name then
		local l_6_1, l_6_2 = l_6_0._song_project:find_first_marker_in_section, l_6_0._song_project
		local l_6_3 = {}
		l_6_3.marker_name = l_6_0._marker_name
		l_6_1 = l_6_1(l_6_2, l_6_3)
		l_6_2 = l_6_0._song_project
		l_6_2, l_6_3 = l_6_2:find_end_marker_for_section, l_6_2
		local l_6_4 = {}
		l_6_4.marker_name = l_6_0._marker_name
		l_6_2 = l_6_2(l_6_3, l_6_4)
		l_6_3 = l_6_0._song_project
		l_6_3, l_6_4 = l_6_3:is_last_marker_in_mode, l_6_3
		local l_6_5 = {}
		l_6_5.marker_name = l_6_0._marker_name
		l_6_3 = l_6_3(l_6_4, l_6_5)
		if l_6_3 then
			l_6_3 = l_6_0.section_text1
			l_6_3, l_6_4 = l_6_3:set_value, l_6_3
			l_6_5 = "This is the last marker for the mode,   "
			l_6_3(l_6_4, l_6_5)
			l_6_3 = l_6_0.section_text2
			l_6_3, l_6_4 = l_6_3:set_value, l_6_3
			l_6_5 = "there should be no crossfades..."
			l_6_3(l_6_4, l_6_5)
			l_6_3 = l_6_0.section_text3
			l_6_3, l_6_4 = l_6_3:set_value, l_6_3
			l_6_5 = ""
			l_6_3(l_6_4, l_6_5)
			l_6_3 = l_6_0.list
			l_6_3, l_6_4 = l_6_3:clear_list, l_6_3
			l_6_3(l_6_4)
			l_6_3 = l_6_0.list
			l_6_3 = l_6_3.listctrl
			l_6_3, l_6_4 = l_6_3:set_enabled, l_6_3
			l_6_5 = false
			l_6_3(l_6_4, l_6_5)
			l_6_3 = l_6_0.new_section_cb
			l_6_3, l_6_4 = l_6_3:set_enabled, l_6_3
			l_6_5 = false
			l_6_3(l_6_4, l_6_5)
			l_6_3 = l_6_0.new_section_cb
			l_6_3, l_6_4 = l_6_3:set_value, l_6_3
			l_6_5 = false
			l_6_3(l_6_4, l_6_5)
		elseif l_6_1 and l_6_2 then
			l_6_3 = l_6_0.section_text1
			l_6_3, l_6_4 = l_6_3:set_value, l_6_3
			l_6_5 = "Between A and B, use crossfade to -->"
			l_6_3(l_6_4, l_6_5)
			l_6_3 = l_6_0.section_text2
			l_6_3, l_6_4 = l_6_3:set_value, l_6_3
			l_6_5 = string
			l_6_5 = l_6_5.format
			l_6_3(l_6_4, l_6_5)
			l_6_3 = l_6_0.section_text3
			l_6_3, l_6_4 = l_6_3:set_value, l_6_3
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_6_3(l_6_4, l_6_5)
			l_6_3 = l_6_0.list
			l_6_3, l_6_4 = l_6_3:clear_list, l_6_3
			l_6_3(l_6_4)
			l_6_3 = l_6_0._song_project
			l_6_3, l_6_4 = l_6_3:get_allowed_crossfades, l_6_3
			local l_6_6 = l_6_0._marker_name
			l_6_3, l_6_5 = l_6_3(l_6_4, l_6_5), {marker_name = l_6_6}
			for l_6_6 in l_6_3 do
				local l_6_7, l_6_8 = l_6_0._song_project:find_marker, l_6_0._song_project
				local l_6_9 = {}
				l_6_9.name = l_6_6.marker
				l_6_7 = l_6_7(l_6_8, l_6_9)
				l_6_8 = l_6_7.mode
				l_6_6.mode = l_6_8
				l_6_8 = l_6_0.list
				l_6_8, l_6_9 = l_6_8:append_item, l_6_8
				l_6_8(l_6_9, l_6_6)
			end
			l_6_0.list.listctrl:set_enabled(true)
			l_6_0.new_section_cb:set_enabled(true)
			if l_6_0._song_project:is_start_marker_for_section({marker_name = l_6_0._marker_name}) then
				l_6_0.new_section_cb:set_value(true)
			else
				l_6_0.new_section_cb:set_value(false)
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		else
			l_6_0.section_text1:set_value("Marker is not within crossfade section! ")
			l_6_0.section_text2:set_value("(check below to start new section")
			l_6_0.section_text3:set_value(string.format("for '%s')", l_6_0._marker_name))
			l_6_0.list:clear_list()
			l_6_0.list.listctrl:set_enabled(false)
			l_6_0.new_section_cb:set_enabled(true)
			if l_6_0._song_project:is_start_marker_for_section({marker_name = l_6_0._marker_name}) then
				l_6_0.new_section_cb:set_value(true)
			end
		else
			l_6_0.new_section_cb:set_value(false)
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	else
		l_6_1 = l_6_0.section_text1
		l_6_1, l_6_2 = l_6_1:set_value, l_6_1
		l_6_1(l_6_2, "  Select MARKER to see crossfades -->")
		l_6_1 = l_6_0.section_text2
		l_6_1, l_6_2 = l_6_1:set_value, l_6_1
		l_6_1(l_6_2, "")
		l_6_1 = l_6_0.section_text3
		l_6_1, l_6_2 = l_6_1:set_value, l_6_1
		l_6_1(l_6_2, "")
		l_6_1 = l_6_0.list
		l_6_1, l_6_2 = l_6_1:clear_list, l_6_1
		l_6_1(l_6_2)
		l_6_1 = l_6_0.list
		l_6_1 = l_6_1.listctrl
		l_6_1, l_6_2 = l_6_1:set_enabled, l_6_1
		l_6_1(l_6_2, false)
		l_6_1 = l_6_0.new_section_cb
		l_6_1, l_6_2 = l_6_1:set_enabled, l_6_1
		l_6_1(l_6_2, false)
		l_6_1 = l_6_0.new_section_cb
		l_6_1, l_6_2 = l_6_1:set_value, l_6_1
		l_6_1(l_6_2, false)
	end
	l_6_1 = l_6_0.panel
	l_6_1, l_6_2 = l_6_1:layout, l_6_1
	l_6_1(l_6_2)
	l_6_1, l_6_2 = l_6_0:_enable_callbacks, l_6_0
	l_6_1(l_6_2)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ModeCrossfadeBox._enable_callbacks = function(l_7_0)
	l_7_0.list:enable_callbacks()
	l_7_0.new_section_cb:connect("EVT_COMMAND_CHECKBOX_CLICKED", l_7_0._on_new_section_cb)
end

ModeCrossfadeBox._disable_callbacks = function(l_8_0)
	l_8_0.list:disable_callbacks()
	l_8_0.new_section_cb:disconnect("EVT_COMMAND_CHECKBOX_CLICKED", l_8_0._on_new_section_cb)
end

ModeCrossfadeBox._set_enabled = function(l_9_0, l_9_1)
	l_9_0.list.listctrl:set_enabled(l_9_1)
	l_9_0.new_section_cb:set_enabled(l_9_1)
end

ModeCrossfadeBox._on_popup_menu = function(l_10_0, l_10_1, l_10_2)
	local l_10_3 = {}
	l_10_3.Add = CoreEvent.callback(l_10_0, l_10_0, "_on_add")
	if l_10_2 ~= nil then
		l_10_3.Modify = CoreEvent.callback(l_10_0, l_10_0, "_on_modify")
		l_10_3.Remove = CoreEvent.callback(l_10_0, l_10_0, "_on_remove")
	end
	return l_10_3
end

ModeCrossfadeBox._on_add = function(l_11_0)
	local l_11_1 = l_11_0:_edit_mode_crossfade({}, "Add New Mode Change Crossfade Path")
	if l_11_1 then
		local l_11_2, l_11_3 = l_11_0._song_project:add_allowed_crossfade, l_11_0._song_project
		local l_11_4 = {}
		l_11_4.from_marker = l_11_0._marker_name
		l_11_4.to_marker = l_11_1.marker
		l_11_4.add_time = l_11_1.add_time
		l_11_4.weight = l_11_1.weight
		l_11_4.fade_in = l_11_1.fade_in
		l_11_4.fade_out = l_11_1.fade_out
		l_11_2(l_11_3, l_11_4)
		l_11_2, l_11_3 = l_11_0:_redraw, l_11_0
		l_11_2(l_11_3)
	end
end

ModeCrossfadeBox._on_modify = function(l_12_0)
	local l_12_1 = l_12_0.list:get_selected_item()
	local l_12_2 = l_12_0:_edit_mode_crossfade(l_12_1, "Modify Mode Change Crossfade Path")
	if l_12_2 then
		local l_12_3, l_12_4 = l_12_0._song_project:modify_allowed_crossfade, l_12_0._song_project
		local l_12_5 = {}
		l_12_5.from_marker = l_12_0._marker_name
		l_12_5.old_to_marker = l_12_1.marker
		l_12_5.new_to_marker = l_12_2.marker
		l_12_5.weight = l_12_2.weight
		l_12_5.add_time = l_12_2.add_time
		l_12_5.fade_in = l_12_2.fade_in
		l_12_5.fade_out = l_12_2.fade_out
		l_12_3(l_12_4, l_12_5)
		l_12_3, l_12_4 = l_12_0:_redraw, l_12_0
		l_12_3(l_12_4)
	end
end

ModeCrossfadeBox._on_remove = function(l_13_0)
	local l_13_1 = l_13_0.list:get_selected_item()
	local l_13_2, l_13_3 = l_13_0._song_project:remove_allowed_crossfade, l_13_0._song_project
	local l_13_4 = {}
	l_13_4.from_marker = l_13_0._marker_name
	l_13_4.to_marker = l_13_1.marker
	l_13_2(l_13_3, l_13_4)
	l_13_2, l_13_3 = l_13_0:_redraw, l_13_0
	l_13_2(l_13_3)
end

ModeCrossfadeBox._on_new_section = function(l_14_0)
	if l_14_0.new_section_cb:get_value() then
		local l_14_1, l_14_2 = l_14_0._song_project:add_section, l_14_0._song_project
		local l_14_3 = {}
		l_14_3.start_marker_name = l_14_0._marker_name
		l_14_1(l_14_2, l_14_3)
	else
		local l_14_4, l_14_5 = l_14_0._song_project:remove_section, l_14_0._song_project
		local l_14_6 = {}
		l_14_6.start_marker_name = l_14_0._marker_name
		l_14_4(l_14_5, l_14_6)
	end
	l_14_0:_redraw()
end

ModeCrossfadeBox._edit_mode_crossfade = function(l_15_0, l_15_1, l_15_2)
	do
		local l_15_3 = l_15_1.weight or 1
	do
		end
		local l_15_4 = nil
	do
		end
		local l_15_5 = nil
	do
		end
		local l_15_6 = nil
	do
		end
		local l_15_7 = nil
	end
	local l_15_8, l_15_9, l_15_10 = , l_15_1.marker or "", l_15_1.add_time or "since_jump"
	local l_15_11 = l_15_1.fade_in or "0.0"
	local l_15_12 = l_15_1.fade_out or "0.0"
	local l_15_13 = nil
	local l_15_14 = nil
	local l_15_15 = nil
	local l_15_16 = nil
	local l_15_17 = EWS:SpinCtrl(EWS:Dialog(l_15_0._ews_parent, l_15_2, "", Vector3(-1, -1, 0), Vector3(360, 250, 0), ""), tonumber(l_15_8), "", "")
	local l_15_23 = EWS:ComboBox(EWS:Dialog(l_15_0._ews_parent, l_15_2, "", Vector3(-1, -1, 0), Vector3(360, 250, 0), ""), "", "", "CB_READONLY")
	local l_15_18 = EWS:ComboBox(EWS:Dialog(l_15_0._ews_parent, l_15_2, "", Vector3(-1, -1, 0), Vector3(360, 250, 0), ""), "", "", "CB_READONLY")
	local l_15_19, l_15_20 = EWS:TextCtrl(EWS:Dialog(l_15_0._ews_parent, l_15_2, "", Vector3(-1, -1, 0), Vector3(360, 250, 0), ""), l_15_11, "", ""), EWS:TextCtrl(EWS:Dialog(l_15_0._ews_parent, l_15_2, "", Vector3(-1, -1, 0), Vector3(360, 250, 0), ""), l_15_12, "", "")
	local l_15_21 = EWS:Button(l_15_16, "Apply", "", "")
	for i_0 in l_15_0._song_project:get_markers() do
		local l_15_22 = EWS:Button(l_15_16, "Cancel", "", "")
		if i_0.mode ~= l_15_0._song_project:find_marker({name = l_15_0._marker_name}).mode then
			l_15_23:append(i_0.name)
		end
	end
	l_15_18:append("since_jump")
	l_15_18:append("barsync_only")
	l_15_17:set_value(l_15_8)
	l_15_23:set_value(l_15_9)
	l_15_18:set_value(l_15_10)
	l_15_16:set_sizer(EWS:BoxSizer("VERTICAL"))
	EWS:FlexGridSizer(5, 2, 10, 10):add(EWS:StaticText(l_15_16, string.format("From Mode '%s', crossfade to:", l_15_0._song_project:find_marker({name = l_15_0._marker_name}).mode), "", ""), 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(l_15_23, 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(EWS:StaticText(l_15_16, "Add Time:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(l_15_18, 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(EWS:StaticText(l_15_16, "Weight:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(l_15_17, 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(EWS:StaticText(l_15_16, "Fade-in:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(l_15_19, 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(EWS:StaticText(l_15_16, "Fade-out:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(l_15_20, 0, 0, "")
	EWS:FlexGridSizer(1, 2, 40, 10):add(l_15_21, 0, 0, "ALIGN_CENTER")
	EWS:FlexGridSizer(1, 2, 40, 10):add(l_15_22, 0, 0, "ALIGN_CENTER")
	EWS:BoxSizer("VERTICAL"):add(EWS:StaticText(l_15_16, "", "", ""), 0, 0, "")
	EWS:BoxSizer("VERTICAL"):add(EWS:FlexGridSizer(5, 2, 10, 10), 1, 0, "ALIGN_CENTER")
	EWS:BoxSizer("VERTICAL"):add(EWS:FlexGridSizer(1, 2, 40, 10), 0, 0, "ALIGN_CENTER")
	local l_15_24 = nil
	l_15_21:connect("", "EVT_COMMAND_BUTTON_CLICKED", function()
		-- upvalues: l_15_24 , l_15_11
		l_15_24 = "APPLY"
		l_15_11:end_modal()
  end, "")
	l_15_22:connect("", "EVT_COMMAND_BUTTON_CLICKED", function()
		-- upvalues: l_15_24 , l_15_11
		l_15_24 = "CANCEL"
		l_15_11:end_modal()
  end, "")
	while 1 do
		local l_15_27 = nil
		while 1 do
			while 1 do
				while 1 do
					while not false do
						l_15_16:show_modal()
						if "CANCEL" == "CANCEL" then
							return nil
						end
						new_marker = l_15_23:get_value()
						new_weight = l_15_17:get_value()
						new_addtime = l_15_18:get_value()
						l_15_14 = l_15_19:get_value()
						l_15_15 = l_15_20:get_value()
						if new_marker == "" then
							EWS:MessageDialog(l_15_0._ews_parent, "Marker to crossfade to must be specified.", "Wrong Input", ""):show_modal()
						end
						if not tonumber(l_15_14) then
							EWS:MessageDialog(l_15_0._ews_parent, "Fade-in must be a number.", "Wrong Input", ""):show_modal()
						end
						if not tonumber(l_15_15) then
							EWS:MessageDialog(l_15_0._ews_parent, "Fade-out must be a number.", "Wrong Input", ""):show_modal()
						end
					end
					do
						local l_15_28 = nil
						return {weight = new_weight, marker = new_marker, add_time = new_addtime, fade_in = l_15_14, fade_out = l_15_15}
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


