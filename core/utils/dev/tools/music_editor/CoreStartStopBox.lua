core:module("CoreStartStopBox")
core:require_module("CoreKeywordArguments")
core:require_module("CoreSmartListCtrl")
core:require_module("CoreClass")
core:require_module("CoreEvent")
StartStopBox = StartStopBox or CoreClass.class()
function StartStopBox.init(A0_0, ...)
	local L2_2, L3_3, L4_4
	L2_2 = CoreKeywordArguments
	L2_2 = L2_2.KeywordArguments
	L3_3 = L2_2
	L2_2 = L2_2.new
	L4_4 = ...
	L2_2 = L2_2(L3_3, L4_4, ...)
	L4_4 = L2_2
	L3_3 = L2_2.mandatory_object
	L3_3 = L3_3(L4_4, "parent")
	A0_0._ews_parent = L3_3
	L4_4 = L2_2
	L3_3 = L2_2.assert_all_consumed
	L3_3(L4_4)
	A0_0._song_project = nil
	L3_3 = EWS
	L4_4 = L3_3
	L3_3 = L3_3.Panel
	L3_3 = L3_3(L4_4, A0_0._ews_parent, "", "")
	A0_0.panel = L3_3
	L3_3 = EWS
	L4_4 = L3_3
	L3_3 = L3_3.CheckBox
	L3_3 = L3_3(L4_4, A0_0.panel, "", "", "")
	A0_0.fadeout_to_stop_cb = L3_3
	L3_3 = EWS
	L4_4 = L3_3
	L3_3 = L3_3.TextCtrl
	L3_3 = L3_3(L4_4, A0_0.panel, "0.00", "", "")
	A0_0.stop_fadeout_ctrl = L3_3
	L3_3 = CoreSmartListCtrl
	L3_3 = L3_3.SmartListCtrl
	L4_4 = L3_3
	L3_3 = L3_3.new
	L3_3 = L3_3(L4_4, {
		parent = A0_0.panel,
		header = {
			"marker",
			"weight",
			"fade_in"
		},
		on_popup_menu_cb = CoreEvent.callback(A0_0, A0_0, "_on_popup_menu")
	})
	A0_0.list = L3_3
	L3_3 = CoreEvent
	L3_3 = L3_3.callback
	L4_4 = A0_0
	L3_3 = L3_3(L4_4, A0_0, "_on_fadeout_to_stop")
	A0_0._on_fadeout_to_stop_cb = L3_3
	L3_3 = CoreEvent
	L3_3 = L3_3.callback
	L4_4 = A0_0
	L3_3 = L3_3(L4_4, A0_0, "_on_stop_fadeout")
	A0_0._on_stop_fadeout_cb = L3_3
	L4_4 = A0_0
	L3_3 = A0_0._connect_events
	L3_3(L4_4)
	L3_3 = EWS
	L4_4 = L3_3
	L3_3 = L3_3.FlexGridSizer
	L3_3 = L3_3(L4_4, 2, 2, 5, 5)
	L4_4 = L3_3.add
	L4_4(L3_3, EWS:StaticText(A0_0.panel, "               Use Fadeout to Stop:", "", ""), 0, 10, "ALIGN_RIGHT")
	L4_4 = L3_3.add
	L4_4(L3_3, A0_0.fadeout_to_stop_cb, 0, 0, "")
	L4_4 = L3_3.add
	L4_4(L3_3, EWS:StaticText(A0_0.panel, "Mode Stop Fadeout:", "", ""), 0, 10, "ALIGN_RIGHT")
	L4_4 = L3_3.add
	L4_4(L3_3, A0_0.stop_fadeout_ctrl, 0, 0, "")
	L4_4 = EWS
	L4_4 = L4_4.FlexGridSizer
	L4_4 = L4_4(L4_4, 2, 1, 15, 15)
	L4_4:add(EWS:StaticText(A0_0.panel, "    For selected Mode, start Song at one of these markers -->", "", ""), 0, 0, "")
	L4_4:add(L3_3, 0, 0, "")
	A0_0.box_sizer = EWS:BoxSizer("HORIZONTAL")
	A0_0.box_sizer:add(L4_4, 0, 0, "")
	A0_0.box_sizer:add(A0_0.list.listctrl, 1, 0, "EXPAND")
	A0_0.panel:set_sizer(A0_0.box_sizer)
	A0_0:_set_enabled(false)
end
function StartStopBox.global_redraw(A0_5, A1_6)
	A0_5._song_project = A1_6 or assert(A0_5._song_project)
	if A0_5._mode_name then
		if not A0_5._song_project:find_mode({
			name = A0_5._mode_name
		}) then
			A0_5._mode_name = nil
		end
	end
	A0_5:_redraw()
end
function StartStopBox.mode_selected(A0_7, A1_8)
	A0_7._mode_name = A1_8
	A0_7:_redraw()
end
function StartStopBox.mode_deselected(A0_9)
	A0_9._mode_name = nil
	A0_9:_redraw()
end
function StartStopBox._redraw(A0_10)
	local L1_11, L2_12, L3_13, L4_14
	L1_11(L2_12)
	if L1_11 then
		L1_11(L2_12)
		L4_14 = A0_10._mode_name
		L3_13.mode_name = L4_14
		for L4_14 in L1_11(L2_12, L3_13) do
			A0_10.list:append_item(L4_14)
		end
		L4_14 = A0_10._mode_name
		L3_13.name = L4_14
		L4_14 = L1_11.use_fadeout_to_stop
		L4_14 = L4_14 == "yes"
		L2_12(L3_13, L4_14)
		L4_14 = true
		L2_12(L3_13, L4_14)
		if L2_12 == "yes" then
			L4_14 = L1_11.mode_stop_fadeout
			L2_12(L3_13, L4_14)
		else
			L4_14 = "0.00"
			L2_12(L3_13, L4_14)
			L4_14 = false
			L2_12(L3_13, L4_14)
		end
	else
		L1_11(L2_12)
		L1_11(L2_12, L3_13)
		L1_11(L2_12, L3_13)
		L1_11(L2_12, L3_13)
	end
	L1_11(L2_12)
end
function StartStopBox._set_enabled(A0_15, A1_16)
	A0_15.fadeout_to_stop_cb:set_enabled(A1_16)
	A0_15.stop_fadeout_ctrl:set_enabled(A1_16)
	A0_15.list.listctrl:set_enabled(A1_16)
end
function StartStopBox._connect_events(A0_17)
	A0_17.list:enable_callbacks()
	A0_17.fadeout_to_stop_cb:connect("EVT_COMMAND_CHECKBOX_CLICKED", A0_17._on_fadeout_to_stop_cb)
	A0_17.stop_fadeout_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", A0_17._on_stop_fadeout_cb)
end
function StartStopBox._disconnect_events(A0_18)
	A0_18.list:disable_callbacks()
	A0_18.fadeout_to_stop_cb:disconnect("EVT_COMMAND_CHECKBOX_CLICKED", A0_18._on_fadeout_to_stop_cb)
	A0_18.stop_fadeout_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", A0_18._on_stop_fadeout_cb)
end
function StartStopBox._on_popup_menu(A0_19, A1_20, A2_21)
	local L3_22
	L3_22 = {}
	L3_22.Add = CoreEvent.callback(A0_19, A0_19, "_on_add")
	if A2_21 ~= nil then
		L3_22.Modify = CoreEvent.callback(A0_19, A0_19, "_on_modify")
		L3_22.Remove = CoreEvent.callback(A0_19, A0_19, "_on_remove")
	end
	return L3_22
end
function StartStopBox._on_add(A0_23)
	if A0_23:_edit_start_marker({}, "Add New Start Marker") then
		A0_23._song_project:add_start_marker({
			mode_name = A0_23._mode_name,
			marker_name = A0_23:_edit_start_marker({}, "Add New Start Marker").marker,
			weight = A0_23:_edit_start_marker({}, "Add New Start Marker").weight,
			fade_in = A0_23:_edit_start_marker({}, "Add New Start Marker").fade_in
		})
		A0_23:_redraw()
	end
end
function StartStopBox._on_modify(A0_24)
	local L1_25
	L1_25 = A0_24.list
	L1_25 = L1_25.get_selected_item
	L1_25 = L1_25(L1_25)
	if A0_24:_edit_start_marker(L1_25, "Modify Start Marker") then
		A0_24._song_project:modify_start_marker({
			mode_name = A0_24._mode_name,
			old_marker_name = L1_25.marker,
			new_marker_name = A0_24:_edit_start_marker(L1_25, "Modify Start Marker").marker,
			weight = A0_24:_edit_start_marker(L1_25, "Modify Start Marker").weight,
			fade_in = A0_24:_edit_start_marker(L1_25, "Modify Start Marker").fade_in
		})
		A0_24:_redraw()
	end
end
function StartStopBox._on_remove(A0_26)
	A0_26._song_project:remove_start_marker({
		mode_name = A0_26._mode_name,
		marker_name = A0_26.list:get_selected_item().marker
	})
	A0_26:_redraw()
end
function StartStopBox._on_fadeout_to_stop(A0_27)
	if A0_27._mode_name then
		if A0_27.fadeout_to_stop_cb:get_value() then
		end
		A0_27._song_project:set_mode_parameter({
			mode_name = A0_27._mode_name,
			parameter = "use_fadeout_to_stop",
			value = "yes"
		})
	end
	A0_27:_redraw()
end
function StartStopBox._on_stop_fadeout(A0_28)
	if A0_28._mode_name and tonumber(A0_28.stop_fadeout_ctrl:get_value()) then
		A0_28._song_project:set_mode_parameter({
			mode_name = A0_28._mode_name,
			parameter = "mode_stop_fadeout",
			value = A0_28.stop_fadeout_ctrl:get_value()
		})
	end
end
function StartStopBox._edit_start_marker(A0_29, A1_30, A2_31)
	local L3_32, L4_33, L5_34, L6_35, L7_36, L8_37, L9_38, L10_39, L11_40, L12_41, L13_42, L14_43, L15_44, L16_45, L17_46, L18_47, L19_48, L20_49
	L3_32 = A1_30.marker
	L3_32 = L3_32 or ""
	L4_33 = A1_30.weight
	L4_33 = L4_33 or "1"
	L5_34 = A1_30.fade_in
	L5_34 = L5_34 or "0.0"
	L6_35, L7_36, L8_37 = nil, nil, nil
	L9_38 = EWS
	L10_39 = L9_38
	L9_38 = L9_38.Dialog
	L11_40 = A0_29._ews_parent
	L12_41 = A2_31
	L13_42 = ""
	L14_43 = Vector3
	L14_43 = L14_43(L15_44, L16_45, L17_46)
	L18_47 = 0
	L9_38 = L9_38(L10_39, L11_40, L12_41, L13_42, L14_43, L15_44, L16_45)
	L10_39 = EWS
	L11_40 = L10_39
	L10_39 = L10_39.ComboBox
	L12_41 = L9_38
	L13_42 = ""
	L14_43 = ""
	L10_39 = L10_39(L11_40, L12_41, L13_42, L14_43, L15_44)
	L11_40 = EWS
	L12_41 = L11_40
	L11_40 = L11_40.SpinCtrl
	L13_42 = L9_38
	L14_43 = tonumber
	L14_43 = L14_43(L15_44)
	L11_40 = L11_40(L12_41, L13_42, L14_43, L15_44, L16_45)
	L12_41 = EWS
	L13_42 = L12_41
	L12_41 = L12_41.TextCtrl
	L14_43 = L9_38
	L12_41 = L12_41(L13_42, L14_43, L15_44, L16_45, L17_46)
	L13_42 = EWS
	L14_43 = L13_42
	L13_42 = L13_42.Button
	L18_47 = ""
	L13_42 = L13_42(L14_43, L15_44, L16_45, L17_46, L18_47)
	L14_43 = EWS
	L14_43 = L14_43.Button
	L18_47 = ""
	L19_48 = ""
	L14_43 = L14_43(L15_44, L16_45, L17_46, L18_47, L19_48)
	for L18_47 in L15_44(L16_45) do
		L19_48 = L18_47.mode
		L20_49 = A0_29._mode_name
		if L19_48 == L20_49 then
			L19_48 = A0_29._song_project
			L20_49 = L19_48
			L19_48 = L19_48.mode_has_start_marker
			L19_48 = L19_48(L20_49, {
				mode_name = A0_29._mode_name,
				marker_name = L18_47.name
			})
			if not L19_48 then
				L20_49 = L10_39
				L19_48 = L10_39.append
				L19_48(L20_49, L18_47.name)
			end
		end
	end
	if L3_32 ~= "" then
		L15_44(L16_45, L17_46)
		L15_44(L16_45, L17_46)
	end
	L18_47 = 100000
	L15_44(L16_45, L17_46, L18_47)
	L18_47 = 3
	L19_48 = 2
	L20_49 = 10
	L18_47 = L17_46
	L19_48 = 1
	L20_49 = 2
	L19_48 = L9_38
	L18_47 = L9_38.set_sizer
	L20_49 = L15_44
	L18_47(L19_48, L20_49)
	L19_48 = L16_45
	L18_47 = L16_45.add
	L20_49 = EWS
	L20_49 = L20_49.StaticText
	L20_49 = L20_49(L20_49, L9_38, "Start at Marker:", "", "")
	L18_47(L19_48, L20_49, 0, 0, "")
	L19_48 = L16_45
	L18_47 = L16_45.add
	L20_49 = L10_39
	L18_47(L19_48, L20_49, 0, 0, "")
	L19_48 = L16_45
	L18_47 = L16_45.add
	L20_49 = EWS
	L20_49 = L20_49.StaticText
	L20_49 = L20_49(L20_49, L9_38, "Weight:", "", "")
	L18_47(L19_48, L20_49, 0, 0, "")
	L19_48 = L16_45
	L18_47 = L16_45.add
	L20_49 = L11_40
	L18_47(L19_48, L20_49, 0, 0, "")
	L19_48 = L16_45
	L18_47 = L16_45.add
	L20_49 = EWS
	L20_49 = L20_49.StaticText
	L20_49 = L20_49(L20_49, L9_38, "Fade-in:", "", "")
	L18_47(L19_48, L20_49, 0, 0, "")
	L19_48 = L16_45
	L18_47 = L16_45.add
	L20_49 = L12_41
	L18_47(L19_48, L20_49, 0, 0, "")
	L19_48 = L17_46
	L18_47 = L17_46.add
	L20_49 = L13_42
	L18_47(L19_48, L20_49, 0, 0, "ALIGN_CENTER")
	L19_48 = L17_46
	L18_47 = L17_46.add
	L20_49 = L14_43
	L18_47(L19_48, L20_49, 0, 0, "ALIGN_CENTER")
	L19_48 = L15_44
	L18_47 = L15_44.add
	L20_49 = EWS
	L20_49 = L20_49.StaticText
	L20_49 = L20_49(L20_49, L9_38, "", "", "")
	L18_47(L19_48, L20_49, 0, 0, "")
	L19_48 = L15_44
	L18_47 = L15_44.add
	L20_49 = L16_45
	L18_47(L19_48, L20_49, 1, 0, "ALIGN_CENTER")
	L19_48 = L15_44
	L18_47 = L15_44.add
	L20_49 = L17_46
	L18_47(L19_48, L20_49, 0, 0, "ALIGN_CENTER")
	L18_47 = "CANCEL"
	function L19_48()
		_UPVALUE0_ = "APPLY"
		_UPVALUE1_:end_modal()
	end
	function L20_49()
		_UPVALUE0_ = "CANCEL"
		_UPVALUE1_:end_modal()
	end
	L13_42:connect("", "EVT_COMMAND_BUTTON_CLICKED", L19_48, "")
	L14_43:connect("", "EVT_COMMAND_BUTTON_CLICKED", L20_49, "")
	while not false do
		L9_38:show_modal()
		if L18_47 == "CANCEL" then
			return nil
		end
		L6_35 = L10_39:get_value()
		L7_36 = L11_40:get_value()
		L8_37 = L12_41:get_value()
		if L6_35 == "" then
			EWS:MessageDialog(A0_29._ews_parent, "Start Marker must be specified.", "Wrong Input", ""):show_modal()
		elseif not tonumber(L8_37) then
			EWS:MessageDialog(A0_29._ews_parent, "Fade-in must be a number.", "Wrong Input", ""):show_modal()
		else
		end
	end
	return {
		marker = L6_35,
		weight = L7_36,
		fade_in = L8_37
	}
end
