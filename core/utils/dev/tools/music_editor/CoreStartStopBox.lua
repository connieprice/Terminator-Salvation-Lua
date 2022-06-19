core:module("CoreStartStopBox")
core:require_module("CoreKeywordArguments")
core:require_module("CoreSmartListCtrl")
core:require_module("CoreClass")
core:require_module("CoreEvent")
if not StartStopBox then
	StartStopBox = CoreClass.class()
end
StartStopBox.init = function(l_1_0, ...)
	l_1_0._ews_parent = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("parent")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_1_0._song_project = nil
	l_1_0.panel = EWS:Panel(l_1_0._ews_parent, "", "")
	l_1_0.fadeout_to_stop_cb = EWS:CheckBox(l_1_0.panel, "", "", "")
	l_1_0.stop_fadeout_ctrl = EWS:TextCtrl(l_1_0.panel, "0.00", "", "")
	local l_1_2, l_1_3 = , CoreSmartListCtrl.SmartListCtrl:new
	local l_1_4 = CoreSmartListCtrl.SmartListCtrl
	local l_1_5 = {parent = l_1_0.panel}
	l_1_5.header = {"marker", "weight", "fade_in"}
	l_1_5.on_popup_menu_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_popup_menu")
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0.list = l_1_3
	l_1_3 = CoreEvent
	l_1_3 = l_1_3.callback
	l_1_4 = l_1_0
	l_1_5 = l_1_0
	l_1_3 = l_1_3(l_1_4, l_1_5, "_on_fadeout_to_stop")
	l_1_0._on_fadeout_to_stop_cb = l_1_3
	l_1_3 = CoreEvent
	l_1_3 = l_1_3.callback
	l_1_4 = l_1_0
	l_1_5 = l_1_0
	l_1_3 = l_1_3(l_1_4, l_1_5, "_on_stop_fadeout")
	l_1_0._on_stop_fadeout_cb = l_1_3
	l_1_3, l_1_4 = l_1_0:_connect_events, l_1_0
	l_1_3(l_1_4)
	l_1_3 = EWS
	l_1_3, l_1_4 = l_1_3:FlexGridSizer, l_1_3
	l_1_5 = 2
	l_1_3 = l_1_3(l_1_4, l_1_5, 2, 5, 5)
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, EWS:StaticText(l_1_0.panel, "               Use Fadeout to Stop:", "", ""), 0, 10, "ALIGN_RIGHT")
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, l_1_0.fadeout_to_stop_cb, 0, 0, "")
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, EWS:StaticText(l_1_0.panel, "Mode Stop Fadeout:", "", ""), 0, 10, "ALIGN_RIGHT")
	l_1_4, l_1_5 = l_1_3:add, l_1_3
	l_1_4(l_1_5, l_1_0.stop_fadeout_ctrl, 0, 0, "")
	l_1_4 = EWS
	l_1_4, l_1_5 = l_1_4:FlexGridSizer, l_1_4
	l_1_4 = l_1_4(l_1_5, 2, 1, 15, 15)
	l_1_5(l_1_4, EWS:StaticText(l_1_0.panel, "    For selected Mode, start Song at one of these markers -->", "", ""), 0, 0, "")
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_5(l_1_4, l_1_3, 0, 0, "")
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

StartStopBox.global_redraw = function(l_2_0, l_2_1)
	do
		if not l_2_1 then
			l_2_0._song_project = assert(l_2_0._song_project)
		end
		if l_2_0._mode_name then
			local l_2_3 = l_2_0._song_project:find_mode
			local l_2_4 = l_2_0._song_project
			l_2_3 = l_2_3(l_2_4, {name = l_2_0._mode_name})
		if not l_2_3 then
			end
			l_2_0._mode_name = nil
		end
		l_2_0:_redraw()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

StartStopBox.mode_selected = function(l_3_0, l_3_1)
	l_3_0._mode_name = l_3_1
	l_3_0:_redraw()
end

StartStopBox.mode_deselected = function(l_4_0)
	l_4_0._mode_name = nil
	l_4_0:_redraw()
end

StartStopBox._redraw = function(l_5_0)
	l_5_0:_disconnect_events()
	if l_5_0._mode_name then
		l_5_0.list:clear_list()
		local l_5_1, l_5_2 = l_5_0._song_project:get_start_markers, l_5_0._song_project
		local l_5_4 = {}
		l_5_4.mode_name = l_5_0._mode_name
		l_5_1 = l_5_1(l_5_2, l_5_4)
		for i_0 in l_5_1 do
			l_5_0.list:append_item(l_5_3)
		end
		l_5_0.fadeout_to_stop_cb:set_value(l_5_0._song_project:find_mode({name = l_5_0._mode_name}).use_fadeout_to_stop == "yes")
		l_5_0:_set_enabled(true)
		if l_5_0._song_project:find_mode({name = l_5_0._mode_name}).use_fadeout_to_stop == "yes" then
			l_5_0.stop_fadeout_ctrl:set_value(l_5_0._song_project:find_mode({name = l_5_0._mode_name}).mode_stop_fadeout)
		else
			l_5_0.stop_fadeout_ctrl:set_value("0.00")
			l_5_0.stop_fadeout_ctrl:set_enabled(false)
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	else
		l_5_0.list:clear_list()
		l_5_0.fadeout_to_stop_cb:set_value(false)
		l_5_0.stop_fadeout_ctrl:set_value("0.00")
		l_5_0:_set_enabled(false)
	end
	l_5_0:_connect_events()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

StartStopBox._set_enabled = function(l_6_0, l_6_1)
	l_6_0.fadeout_to_stop_cb:set_enabled(l_6_1)
	l_6_0.stop_fadeout_ctrl:set_enabled(l_6_1)
	l_6_0.list.listctrl:set_enabled(l_6_1)
end

StartStopBox._connect_events = function(l_7_0)
	l_7_0.list:enable_callbacks()
	l_7_0.fadeout_to_stop_cb:connect("EVT_COMMAND_CHECKBOX_CLICKED", l_7_0._on_fadeout_to_stop_cb)
	l_7_0.stop_fadeout_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", l_7_0._on_stop_fadeout_cb)
end

StartStopBox._disconnect_events = function(l_8_0)
	l_8_0.list:disable_callbacks()
	l_8_0.fadeout_to_stop_cb:disconnect("EVT_COMMAND_CHECKBOX_CLICKED", l_8_0._on_fadeout_to_stop_cb)
	l_8_0.stop_fadeout_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", l_8_0._on_stop_fadeout_cb)
end

StartStopBox._on_popup_menu = function(l_9_0, l_9_1, l_9_2)
	local l_9_3 = {}
	l_9_3.Add = CoreEvent.callback(l_9_0, l_9_0, "_on_add")
	if l_9_2 ~= nil then
		l_9_3.Modify = CoreEvent.callback(l_9_0, l_9_0, "_on_modify")
		l_9_3.Remove = CoreEvent.callback(l_9_0, l_9_0, "_on_remove")
	end
	return l_9_3
end

StartStopBox._on_add = function(l_10_0)
	local l_10_1 = l_10_0:_edit_start_marker({}, "Add New Start Marker")
	if l_10_1 then
		local l_10_2, l_10_3 = l_10_0._song_project:add_start_marker, l_10_0._song_project
		local l_10_4 = {}
		l_10_4.mode_name = l_10_0._mode_name
		l_10_4.marker_name = l_10_1.marker
		l_10_4.weight = l_10_1.weight
		l_10_4.fade_in = l_10_1.fade_in
		l_10_2(l_10_3, l_10_4)
		l_10_2, l_10_3 = l_10_0:_redraw, l_10_0
		l_10_2(l_10_3)
	end
end

StartStopBox._on_modify = function(l_11_0)
	local l_11_1 = l_11_0.list:get_selected_item()
	local l_11_2 = l_11_0:_edit_start_marker(l_11_1, "Modify Start Marker")
	if l_11_2 then
		local l_11_3, l_11_4 = l_11_0._song_project:modify_start_marker, l_11_0._song_project
		local l_11_5 = {}
		l_11_5.mode_name = l_11_0._mode_name
		l_11_5.old_marker_name = l_11_1.marker
		l_11_5.new_marker_name = l_11_2.marker
		l_11_5.weight = l_11_2.weight
		l_11_5.fade_in = l_11_2.fade_in
		l_11_3(l_11_4, l_11_5)
		l_11_3, l_11_4 = l_11_0:_redraw, l_11_0
		l_11_3(l_11_4)
	end
end

StartStopBox._on_remove = function(l_12_0)
	local l_12_1 = l_12_0.list:get_selected_item()
	local l_12_2, l_12_3 = l_12_0._song_project:remove_start_marker, l_12_0._song_project
	local l_12_4 = {}
	l_12_4.mode_name = l_12_0._mode_name
	l_12_4.marker_name = l_12_1.marker
	l_12_2(l_12_3, l_12_4)
	l_12_2, l_12_3 = l_12_0:_redraw, l_12_0
	l_12_2(l_12_3)
end

StartStopBox._on_fadeout_to_stop = function(l_13_0)
	if l_13_0._mode_name then
		local l_13_1 = "no"
		if l_13_0.fadeout_to_stop_cb:get_value() then
			l_13_1 = "yes"
		end
		local l_13_2, l_13_3 = l_13_0._song_project:set_mode_parameter, l_13_0._song_project
		local l_13_4 = {}
		l_13_4.mode_name = l_13_0._mode_name
		l_13_4.parameter = "use_fadeout_to_stop"
		l_13_4.value = l_13_1
		l_13_2(l_13_3, l_13_4)
	end
	l_13_0:_redraw()
end

StartStopBox._on_stop_fadeout = function(l_14_0)
	if l_14_0._mode_name and tonumber(l_14_0.stop_fadeout_ctrl:get_value()) then
		local l_14_1, l_14_2 = l_14_0._song_project:set_mode_parameter, l_14_0._song_project
		local l_14_3 = {}
		l_14_3.mode_name = l_14_0._mode_name
		l_14_3.parameter = "mode_stop_fadeout"
		l_14_3.value = l_14_0.stop_fadeout_ctrl:get_value()
		l_14_1(l_14_2, l_14_3)
	end
end

StartStopBox._edit_start_marker = function(l_15_0, l_15_1, l_15_2)
	do
		local l_15_3 = l_15_1.marker or ""
	do
		end
		local l_15_4 = nil
	do
		end
		local l_15_5 = nil
	end
	local l_15_6, l_15_7, l_15_8 = , l_15_1.weight or "1", l_15_1.fade_in or "0.0"
	local l_15_9 = nil
	local l_15_10 = nil
	local l_15_11 = nil
	local l_15_12 = nil
	local l_15_13 = EWS:ComboBox(EWS:Dialog(l_15_0._ews_parent, l_15_2, "", Vector3(-1, -1, 0), Vector3(330, 200, 0), ""), "", "", "CB_READONLY")
	local l_15_18 = EWS:SpinCtrl(EWS:Dialog(l_15_0._ews_parent, l_15_2, "", Vector3(-1, -1, 0), Vector3(330, 200, 0), ""), tonumber(l_15_7), "", "")
	local l_15_14 = EWS:TextCtrl(EWS:Dialog(l_15_0._ews_parent, l_15_2, "", Vector3(-1, -1, 0), Vector3(330, 200, 0), ""), l_15_8, "", "")
	for i_0 in l_15_0._song_project:get_markers() do
		local l_15_15, l_15_16 = EWS:Button(l_15_12, "Apply", "", ""), EWS:Button(l_15_12, "Cancel", "", "")
		if i_0.mode == l_15_0._mode_name and not l_15_0._song_project:mode_has_start_marker({mode_name = l_15_0._mode_name, marker_name = l_15_21.name}) then
			l_15_13:append(l_15_21.name)
		end
	end
	if l_15_6 ~= "" then
		l_15_13:append(l_15_6)
		l_15_13:set_value(l_15_6)
	end
	l_15_18:set_range(0, 100000)
	l_15_12:set_sizer(EWS:BoxSizer("VERTICAL"))
	EWS:FlexGridSizer(3, 2, 10, 10):add(EWS:StaticText(l_15_12, "Start at Marker:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(3, 2, 10, 10):add(l_15_13, 0, 0, "")
	EWS:FlexGridSizer(3, 2, 10, 10):add(EWS:StaticText(l_15_12, "Weight:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(3, 2, 10, 10):add(l_15_18, 0, 0, "")
	EWS:FlexGridSizer(3, 2, 10, 10):add(EWS:StaticText(l_15_12, "Fade-in:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(3, 2, 10, 10):add(l_15_14, 0, 0, "")
	EWS:FlexGridSizer(1, 2, 40, 10):add(l_15_15, 0, 0, "ALIGN_CENTER")
	EWS:FlexGridSizer(1, 2, 40, 10):add(l_15_16, 0, 0, "ALIGN_CENTER")
	EWS:BoxSizer("VERTICAL"):add(EWS:StaticText(l_15_12, "", "", ""), 0, 0, "")
	EWS:BoxSizer("VERTICAL"):add(EWS:FlexGridSizer(3, 2, 10, 10), 1, 0, "ALIGN_CENTER")
	EWS:BoxSizer("VERTICAL"):add(EWS:FlexGridSizer(1, 2, 40, 10), 0, 0, "ALIGN_CENTER")
	l_15_15:connect("", "EVT_COMMAND_BUTTON_CLICKED", function()
		-- upvalues: l_15_18 , l_15_9
		l_15_18 = "APPLY"
		l_15_9:end_modal()
  end, "")
	l_15_16:connect("", "EVT_COMMAND_BUTTON_CLICKED", function()
		-- upvalues: l_15_18 , l_15_9
		l_15_18 = "CANCEL"
		l_15_9:end_modal()
  end, "")
	while 1 do
		local l_15_24 = nil
		while 1 do
			while 1 do
				while not false do
					l_15_12:show_modal()
					if "CANCEL" == "CANCEL" then
						return nil
					end
					l_15_9 = l_15_13:get_value()
					l_15_10 = l_15_18:get_value()
					l_15_11 = l_15_14:get_value()
					if l_15_9 == "" then
						EWS:MessageDialog(l_15_0._ews_parent, "Start Marker must be specified.", "Wrong Input", ""):show_modal()
					end
					if not tonumber(l_15_11) then
						EWS:MessageDialog(l_15_0._ews_parent, "Fade-in must be a number.", "Wrong Input", ""):show_modal()
					end
				end
				do
					local l_15_25 = nil
					return {marker = l_15_9, weight = l_15_10, fade_in = l_15_11}
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

				 -- WARNING: undefined locals caused missing assignments!
				 -- WARNING: missing end command somewhere! Added here
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end


