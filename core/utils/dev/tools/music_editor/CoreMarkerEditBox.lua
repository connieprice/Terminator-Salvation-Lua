core:module("CoreMarkerEditBox")
core:require_module("CoreKeywordArguments")
core:require_module("CoreSmartListCtrl")
core:require_module("CoreClass")
core:require_module("CoreEvent")
MarkerEditBox = MarkerEditBox or CoreClass.class()
function MarkerEditBox.init(A0_0, ...)
	local L2_2, L3_3
	L2_2 = CoreKeywordArguments
	L2_2 = L2_2.KeywordArguments
	L3_3 = L2_2
	L2_2 = L2_2.new
	L2_2 = L2_2(L3_3, ...)
	L3_3 = L2_2.mandatory_object
	L3_3 = L3_3(L2_2, "parent")
	A0_0._ews_parent = L3_3
	L3_3 = L2_2.assert_all_consumed
	L3_3(L2_2)
	A0_0._song_project = nil
	L3_3 = EWS
	L3_3 = L3_3.Panel
	L3_3 = L3_3(L3_3, A0_0._ews_parent, "", "")
	A0_0.panel = L3_3
	L3_3 = EWS
	L3_3 = L3_3.SpinCtrl
	L3_3 = L3_3(L3_3, A0_0.panel, "0", "", "")
	A0_0.sample_clip_ctrl = L3_3
	L3_3 = EWS
	L3_3 = L3_3.SpinCtrl
	L3_3 = L3_3(L3_3, A0_0.panel, "0", "", "")
	A0_0.sample_raw_ctrl = L3_3
	L3_3 = EWS
	L3_3 = L3_3.TextCtrl
	L3_3 = L3_3(L3_3, A0_0.panel, "0.00", "", "")
	A0_0.time_clip_ctrl = L3_3
	L3_3 = EWS
	L3_3 = L3_3.TextCtrl
	L3_3 = L3_3(L3_3, A0_0.panel, "0.00", "", "")
	A0_0.time_raw_ctrl = L3_3
	L3_3 = EWS
	L3_3 = L3_3.CheckBox
	L3_3 = L3_3(L3_3, A0_0.panel, "Align Bars", "", "")
	A0_0.align_bar_cb = L3_3
	L3_3 = EWS
	L3_3 = L3_3.StaticText
	L3_3 = L3_3(L3_3, A0_0.panel, "(bar# 0.00)", "", "")
	A0_0.bar_cnt_text = L3_3
	L3_3 = EWS
	L3_3 = L3_3.Button
	L3_3 = L3_3(L3_3, A0_0.panel, "<<", "MOVEBEATLEFT", "")
	A0_0.move_beat_left = L3_3
	L3_3 = EWS
	L3_3 = L3_3.Button
	L3_3 = L3_3(L3_3, A0_0.panel, ">>", "MOVEBEATRIGHT", "")
	A0_0.move_beat_right = L3_3
	L3_3 = CoreSmartListCtrl
	L3_3 = L3_3.SmartListCtrl
	L3_3 = L3_3.new
	L3_3 = L3_3(L3_3, {
		parent = A0_0.panel,
		header = {
			"rule",
			"weight",
			"jump_to",
			"fade_in",
			"fade_out"
		},
		on_popup_menu_cb = CoreEvent.callback(A0_0, A0_0, "_on_popup_menu")
	})
	A0_0.list = L3_3
	L3_3 = CoreEvent
	L3_3 = L3_3.callback
	L3_3 = L3_3(A0_0, A0_0, "_on_sample_clip")
	A0_0._on_sample_clip_cb = L3_3
	L3_3 = CoreEvent
	L3_3 = L3_3.callback
	L3_3 = L3_3(A0_0, A0_0, "_on_sample_raw")
	A0_0._on_sample_raw_cb = L3_3
	L3_3 = CoreEvent
	L3_3 = L3_3.callback
	L3_3 = L3_3(A0_0, A0_0, "_on_sample_clip")
	A0_0._on_sample_clip_cb = L3_3
	L3_3 = CoreEvent
	L3_3 = L3_3.callback
	L3_3 = L3_3(A0_0, A0_0, "_on_sample_raw")
	A0_0._on_sample_raw_cb = L3_3
	L3_3 = CoreEvent
	L3_3 = L3_3.callback
	L3_3 = L3_3(A0_0, A0_0, "_on_time_clip")
	A0_0._on_time_clip_cb = L3_3
	L3_3 = CoreEvent
	L3_3 = L3_3.callback
	L3_3 = L3_3(A0_0, A0_0, "_on_time_raw")
	A0_0._on_time_raw_cb = L3_3
	L3_3 = CoreEvent
	L3_3 = L3_3.callback
	L3_3 = L3_3(A0_0, A0_0, "_on_move_beat_left")
	A0_0._on_move_beat_left_cb = L3_3
	L3_3 = CoreEvent
	L3_3 = L3_3.callback
	L3_3 = L3_3(A0_0, A0_0, "_on_move_beat_right")
	A0_0._on_move_beat_right_cb = L3_3
	L3_3 = CoreEvent
	L3_3 = L3_3.callback
	L3_3 = L3_3(A0_0, A0_0, "_on_align_bars")
	A0_0._on_align_bars_cb = L3_3
	L3_3 = A0_0._enable_callbacks
	L3_3(A0_0)
	L3_3 = EWS
	L3_3 = L3_3.FlexGridSizer
	L3_3 = L3_3(L3_3, 2, 6, 5, 5)
	L3_3:add(EWS:StaticText(A0_0.panel, "sample/clip:", "", ""), 0, 0, "")
	L3_3:add(A0_0.sample_clip_ctrl, 0, 0, "EXPAND")
	L3_3:add(EWS:StaticText(A0_0.panel, "time/clip:", "", ""), 0, 0, "")
	L3_3:add(A0_0.time_clip_ctrl, 0, 0, "EXPAND")
	L3_3:add(A0_0.move_beat_left, 0, 0, "")
	L3_3:add(A0_0.move_beat_right, 0, 0, "")
	L3_3:add(EWS:StaticText(A0_0.panel, "sample/sound:", "", ""), 0, 0, "")
	L3_3:add(A0_0.sample_raw_ctrl, 0, 0, "EXPAND")
	L3_3:add(EWS:StaticText(A0_0.panel, "time/sound:", "", ""), 0, 0, "")
	L3_3:add(A0_0.time_raw_ctrl, 0, 0, "")
	L3_3:add(A0_0.bar_cnt_text, 0, 0, "")
	L3_3:add(A0_0.align_bar_cb, 0, 0, "")
	A0_0.box_sizer = EWS:StaticBoxSizer(A0_0.panel, "VERTICAL", "Marker")
	A0_0.box_sizer:add(L3_3, 0, 0, "")
	A0_0.box_sizer:add(A0_0.list.listctrl, 1, 0, "EXPAND")
	A0_0.panel:set_sizer(A0_0.box_sizer)
	A0_0:_set_enabled(false)
end
function MarkerEditBox.global_redraw(A0_4, A1_5)
	A0_4._song_project = A1_5 or assert(A0_4._song_project)
	if A0_4._marker_name then
		if not A0_4._song_project:find_marker({
			name = A0_4._marker_name
		}) then
			A0_4._marker_name = nil
		end
	end
	A0_4:_redraw()
end
function MarkerEditBox.marker_selected(A0_6, A1_7)
	A0_6._marker_name = A1_7
	A0_6:_redraw()
end
function MarkerEditBox.marker_deselected(A0_8)
	A0_8._marker_name = nil
	A0_8:_redraw()
end
function MarkerEditBox.clip_modified(A0_9)
	A0_9:_redraw()
end
function MarkerEditBox.register_on_sample_update_cb(A0_10, A1_11)
	A0_10._on_sample_update_cb = A1_11
end
function MarkerEditBox._redraw(A0_12)
	local L1_13, L2_14, L3_15, L4_16, L5_17, L6_18, L7_19, L8_20, L9_21, L10_22, L11_23, L12_24
	L2_14 = A0_12
	L1_13 = A0_12._disable_callbacks
	L1_13(L2_14)
	L1_13 = A0_12.list
	L2_14 = L1_13
	L1_13 = L1_13.clear_list
	L1_13(L2_14)
	L1_13 = A0_12._marker_name
	if L1_13 then
		L1_13 = A0_12._song_project
		L2_14 = L1_13
		L1_13 = L1_13.find_marker
		L3_15 = {}
		L4_16 = A0_12._marker_name
		L3_15.name = L4_16
		L1_13 = L1_13(L2_14, L3_15)
		L2_14 = A0_12._song_project
		L3_15 = L2_14
		L2_14 = L2_14.find_clip
		L4_16 = {}
		L5_17 = L1_13.clip
		L4_16.name = L5_17
		L2_14 = L2_14(L3_15, L4_16)
		L3_15 = tonumber
		L4_16 = L2_14.start
		L3_15 = L3_15(L4_16)
		L4_16 = tonumber
		L5_17 = L2_14.stop
		L4_16 = L4_16(L5_17)
		L5_17 = A0_12.sample_clip_ctrl
		L6_18 = L5_17
		L5_17 = L5_17.set_range
		L7_19 = 0
		L8_20 = L4_16 - L3_15
		L5_17(L6_18, L7_19, L8_20)
		L5_17 = A0_12.sample_raw_ctrl
		L6_18 = L5_17
		L5_17 = L5_17.set_range
		L7_19 = L3_15
		L8_20 = L4_16
		L5_17(L6_18, L7_19, L8_20)
		L5_17 = tonumber
		L6_18 = L1_13.sample
		L5_17 = L5_17(L6_18)
		L6_18 = L5_17 + L3_15
		L7_19 = L5_17 / 44100
		L8_20 = L6_18 / 44100
		L9_21(L10_22, L11_23)
		L9_21(L10_22, L11_23)
		L12_24 = "%.5f"
		L12_24 = L11_23(L12_24, L7_19)
		L9_21(L10_22, L11_23, L12_24, L11_23(L12_24, L7_19))
		L12_24 = "%.5f"
		L12_24 = L11_23(L12_24, L8_20)
		L9_21(L10_22, L11_23, L12_24, L11_23(L12_24, L8_20))
		L11_23 = L11_23 == "yes"
		L9_21(L10_22, L11_23)
		L12_24 = A0_12._marker_name
		L11_23.marker_name = L12_24
		for L12_24 in L9_21(L10_22, L11_23) do
			A0_12.list:append_item(L12_24)
		end
		L9_21(L10_22, L11_23)
	else
		L1_13 = A0_12.sample_clip_ctrl
		L2_14 = L1_13
		L1_13 = L1_13.set_range
		L3_15 = 0
		L4_16 = 1
		L1_13(L2_14, L3_15, L4_16)
		L1_13 = A0_12.sample_raw_ctrl
		L2_14 = L1_13
		L1_13 = L1_13.set_range
		L3_15 = 0
		L4_16 = 1
		L1_13(L2_14, L3_15, L4_16)
		L1_13 = A0_12.sample_clip_ctrl
		L2_14 = L1_13
		L1_13 = L1_13.set_value
		L3_15 = 0
		L1_13(L2_14, L3_15)
		L1_13 = A0_12.sample_raw_ctrl
		L2_14 = L1_13
		L1_13 = L1_13.set_value
		L3_15 = 0
		L1_13(L2_14, L3_15)
		L1_13 = A0_12.time_clip_ctrl
		L2_14 = L1_13
		L1_13 = L1_13.set_value
		L3_15 = "0.00000"
		L1_13(L2_14, L3_15)
		L1_13 = A0_12.time_raw_ctrl
		L2_14 = L1_13
		L1_13 = L1_13.set_value
		L3_15 = "0.00000"
		L1_13(L2_14, L3_15)
		L1_13 = A0_12.align_bar_cb
		L2_14 = L1_13
		L1_13 = L1_13.set_value
		L3_15 = false
		L1_13(L2_14, L3_15)
		L2_14 = A0_12
		L1_13 = A0_12._set_enabled
		L3_15 = false
		L1_13(L2_14, L3_15)
	end
	L2_14 = A0_12
	L1_13 = A0_12._redraw_bar_cnt_text
	L1_13(L2_14)
	L2_14 = A0_12
	L1_13 = A0_12._enable_callbacks
	L1_13(L2_14)
end
function MarkerEditBox._set_enabled(A0_25, A1_26)
	A0_25.list.listctrl:set_enabled(A1_26)
	A0_25.sample_clip_ctrl:set_enabled(A1_26)
	A0_25.sample_raw_ctrl:set_enabled(A1_26)
	A0_25.time_clip_ctrl:set_enabled(A1_26)
	A0_25.time_raw_ctrl:set_enabled(A1_26)
	A0_25.move_beat_left:set_enabled(A1_26)
	A0_25.move_beat_right:set_enabled(A1_26)
	A0_25.align_bar_cb:set_enabled(A1_26)
	A0_25.bar_cnt_text:set_enabled(A1_26)
end
function MarkerEditBox._enable_callbacks(A0_27, A1_28)
	A0_27.list:enable_callbacks()
	A0_27.sample_clip_ctrl:connect("EVT_COMMAND_SPINCTRL_UPDATED", A0_27._on_sample_clip_cb)
	A0_27.sample_raw_ctrl:connect("EVT_COMMAND_SPINCTRL_UPDATED", A0_27._on_sample_raw_cb)
	A0_27.sample_clip_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", A0_27._on_sample_clip_cb)
	A0_27.sample_raw_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", A0_27._on_sample_raw_cb)
	A0_27.time_clip_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", A0_27._on_time_clip_cb)
	A0_27.time_raw_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", A0_27._on_time_raw_cb)
	A0_27.move_beat_left:connect("EVT_COMMAND_BUTTON_CLICKED", A0_27._on_move_beat_left_cb)
	A0_27.move_beat_right:connect("EVT_COMMAND_BUTTON_CLICKED", A0_27._on_move_beat_right_cb)
	A0_27.align_bar_cb:connect("EVT_COMMAND_CHECKBOX_CLICKED", A0_27._on_align_bars_cb)
end
function MarkerEditBox._disable_callbacks(A0_29, A1_30)
	A0_29.list:disable_callbacks()
	A0_29.sample_clip_ctrl:disconnect("EVT_COMMAND_SPINCTRL_UPDATED", A0_29._on_sample_clip_cb)
	A0_29.sample_raw_ctrl:disconnect("EVT_COMMAND_SPINCTRL_UPDATED", A0_29._on_sample_raw_cb)
	A0_29.sample_clip_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", A0_29._on_sample_clip_cb)
	A0_29.sample_raw_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", A0_29._on_sample_raw_cb)
	A0_29.time_clip_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", A0_29._on_time_clip_cb)
	A0_29.time_raw_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", A0_29._on_time_raw_cb)
	A0_29.move_beat_left:disconnect("EVT_COMMAND_BUTTON_CLICKED", A0_29._on_move_beat_left_cb)
	A0_29.move_beat_right:disconnect("EVT_COMMAND_BUTTON_CLICKED", A0_29._on_move_beat_right_cb)
	A0_29.align_bar_cb:disconnect("EVT_COMMAND_CHECKBOX_CLICKED", A0_29._on_align_bars_cb)
end
function MarkerEditBox._on_popup_menu(A0_31, A1_32, A2_33)
	local L3_34
	L3_34 = {}
	L3_34.Add = CoreEvent.callback(A0_31, A0_31, "_on_add")
	if A2_33 == nil then
		return L3_34
	end
	L3_34.Modify = CoreEvent.callback(A0_31, A0_31, "_on_modify")
	L3_34.Remove = CoreEvent.callback(A0_31, A0_31, "_on_remove")
	if A2_33 > 0 then
		L3_34["Move Up"] = CoreEvent.callback(A0_31, A0_31, "_on_move_up")
	end
	if A2_33 < A0_31.list:get_number_dynamic_items() - 1 then
		L3_34["Move Down"] = CoreEvent.callback(A0_31, A0_31, "_on_move_down")
	end
	return L3_34
end
function MarkerEditBox._on_add(A0_35)
	if A0_35:_edit_rule({}, "Add New Rule") then
		A0_35._song_project:add_new_rule({
			rule = A0_35:_edit_rule({}, "Add New Rule").rule,
			weight = A0_35:_edit_rule({}, "Add New Rule").weight,
			jump_to = A0_35:_edit_rule({}, "Add New Rule").jump_to,
			fade_in = A0_35:_edit_rule({}, "Add New Rule").fade_in,
			fade_out = A0_35:_edit_rule({}, "Add New Rule").fade_out,
			marker_name = A0_35._marker_name
		})
		A0_35:_redraw()
	end
end
function MarkerEditBox._on_modify(A0_36)
	local L1_37, L2_38
	L1_37 = A0_36.list
	L2_38 = L1_37
	L1_37 = L1_37.get_selected_index
	L1_37 = L1_37(L2_38)
	L2_38 = A0_36.list
	L2_38 = L2_38.get_selected_item
	L2_38 = L2_38(L2_38)
	if A0_36:_edit_rule(L2_38, "Modify Rule") then
		A0_36._song_project:modify_rule({
			rule = A0_36:_edit_rule(L2_38, "Modify Rule").rule,
			weight = A0_36:_edit_rule(L2_38, "Modify Rule").weight,
			jump_to = A0_36:_edit_rule(L2_38, "Modify Rule").jump_to,
			fade_in = A0_36:_edit_rule(L2_38, "Modify Rule").fade_in,
			fade_out = A0_36:_edit_rule(L2_38, "Modify Rule").fade_out,
			marker_name = A0_36._marker_name,
			index = L1_37
		})
		A0_36:_redraw()
	end
end
function MarkerEditBox._on_remove(A0_39)
	A0_39._song_project:remove_rule({
		marker_name = A0_39._marker_name,
		index = A0_39.list:get_selected_index()
	})
	A0_39:_redraw()
end
function MarkerEditBox._on_move_up(A0_40)
	A0_40._song_project:move_rule({
		marker_name = A0_40._marker_name,
		old_index = A0_40.list:get_selected_index(),
		new_index = A0_40.list:get_selected_index() - 1
	})
	A0_40:_redraw()
end
function MarkerEditBox._on_move_down(A0_41)
	A0_41._song_project:move_rule({
		marker_name = A0_41._marker_name,
		old_index = A0_41.list:get_selected_index(),
		new_index = A0_41.list:get_selected_index() + 1
	})
	A0_41:_redraw()
end
function MarkerEditBox._edit_rule(A0_42, A1_43, A2_44)
	local L3_45, L4_46, L5_47, L6_48, L7_49, L8_50, L9_51, L10_52, L11_53, L12_54, L13_55, L14_56, L15_57, L16_58, L17_59, L18_60, L19_61, L20_62, L21_63, L22_64, L23_65, L24_66, L25_67, L26_68
	L3_45 = A1_43.rule
	L3_45 = L3_45 or "default"
	L4_46 = A1_43.weight
	L4_46 = L4_46 or "1"
	L5_47 = A1_43.jump_to
	L5_47 = L5_47 or ""
	L6_48 = A1_43.fade_in
	L6_48 = L6_48 or "0.5"
	L7_49 = A1_43.fade_out
	L7_49 = L7_49 or "0.5"
	L8_50, L9_51, L10_52, L11_53, L12_54 = nil, nil, nil, nil, nil
	L13_55 = EWS
	L14_56 = L13_55
	L13_55 = L13_55.Dialog
	L15_57 = A0_42._ews_parent
	L16_58 = A2_44
	L17_59 = ""
	L18_60 = Vector3
	L19_61 = -1
	L20_62 = -1
	L18_60 = L18_60(L19_61, L20_62, L21_63)
	L19_61 = Vector3
	L20_62 = 260
	L19_61 = L19_61(L20_62, L21_63, L22_64)
	L20_62 = ""
	L13_55 = L13_55(L14_56, L15_57, L16_58, L17_59, L18_60, L19_61, L20_62)
	L14_56 = EWS
	L15_57 = L14_56
	L14_56 = L14_56.ComboBox
	L16_58 = L13_55
	L17_59 = ""
	L18_60 = ""
	L19_61 = "CB_READONLY"
	L14_56 = L14_56(L15_57, L16_58, L17_59, L18_60, L19_61)
	L15_57 = EWS
	L16_58 = L15_57
	L15_57 = L15_57.SpinCtrl
	L17_59 = L13_55
	L18_60 = tonumber
	L19_61 = L4_46
	L18_60 = L18_60(L19_61)
	L19_61 = ""
	L20_62 = ""
	L15_57 = L15_57(L16_58, L17_59, L18_60, L19_61, L20_62)
	L16_58 = EWS
	L17_59 = L16_58
	L16_58 = L16_58.ComboBox
	L18_60 = L13_55
	L19_61 = ""
	L20_62 = ""
	L16_58 = L16_58(L17_59, L18_60, L19_61, L20_62, L21_63)
	L17_59 = EWS
	L18_60 = L17_59
	L17_59 = L17_59.TextCtrl
	L19_61 = L13_55
	L20_62 = L6_48
	L17_59 = L17_59(L18_60, L19_61, L20_62, L21_63, L22_64)
	L18_60 = EWS
	L19_61 = L18_60
	L18_60 = L18_60.TextCtrl
	L20_62 = L13_55
	L18_60 = L18_60(L19_61, L20_62, L21_63, L22_64, L23_65)
	L19_61 = EWS
	L20_62 = L19_61
	L19_61 = L19_61.Button
	L24_66 = ""
	L19_61 = L19_61(L20_62, L21_63, L22_64, L23_65, L24_66)
	L20_62 = EWS
	L20_62 = L20_62.Button
	L24_66 = ""
	L25_67 = ""
	L20_62 = L20_62(L21_63, L22_64, L23_65, L24_66, L25_67)
	L21_63(L22_64, L23_65)
	L21_63(L22_64, L23_65)
	for L24_66 in L21_63(L22_64) do
		L26_68 = L14_56
		L25_67 = L14_56.append
		L25_67(L26_68, L24_66.name)
	end
	L21_63(L22_64, L23_65)
	L24_66 = 100000
	L21_63(L22_64, L23_65, L24_66)
	L21_63(L22_64, L23_65)
	for L24_66 in L21_63(L22_64) do
		L26_68 = L16_58
		L25_67 = L16_58.append
		L25_67(L26_68, L24_66.name)
	end
	L21_63(L22_64, L23_65)
	L24_66 = 5
	L25_67 = 2
	L26_68 = 10
	L24_66 = L23_65
	L25_67 = 1
	L26_68 = 2
	L25_67 = L13_55
	L24_66 = L13_55.set_sizer
	L26_68 = L21_63
	L24_66(L25_67, L26_68)
	L25_67 = L22_64
	L24_66 = L22_64.add
	L26_68 = EWS
	L26_68 = L26_68.StaticText
	L26_68 = L26_68(L26_68, L13_55, "Rule:", "", "")
	L24_66(L25_67, L26_68, 0, 0, "")
	L25_67 = L22_64
	L24_66 = L22_64.add
	L26_68 = L14_56
	L24_66(L25_67, L26_68, 0, 0, "")
	L25_67 = L22_64
	L24_66 = L22_64.add
	L26_68 = EWS
	L26_68 = L26_68.StaticText
	L26_68 = L26_68(L26_68, L13_55, "Weight:", "", "")
	L24_66(L25_67, L26_68, 0, 0, "")
	L25_67 = L22_64
	L24_66 = L22_64.add
	L26_68 = L15_57
	L24_66(L25_67, L26_68, 0, 0, "")
	L25_67 = L22_64
	L24_66 = L22_64.add
	L26_68 = EWS
	L26_68 = L26_68.StaticText
	L26_68 = L26_68(L26_68, L13_55, "Jump To:", "", "")
	L24_66(L25_67, L26_68, 0, 0, "")
	L25_67 = L22_64
	L24_66 = L22_64.add
	L26_68 = L16_58
	L24_66(L25_67, L26_68, 0, 0, "")
	L25_67 = L22_64
	L24_66 = L22_64.add
	L26_68 = EWS
	L26_68 = L26_68.StaticText
	L26_68 = L26_68(L26_68, L13_55, "Fade-in:", "", "")
	L24_66(L25_67, L26_68, 0, 0, "")
	L25_67 = L22_64
	L24_66 = L22_64.add
	L26_68 = L17_59
	L24_66(L25_67, L26_68, 0, 0, "")
	L25_67 = L22_64
	L24_66 = L22_64.add
	L26_68 = EWS
	L26_68 = L26_68.StaticText
	L26_68 = L26_68(L26_68, L13_55, "Fade-out:", "", "")
	L24_66(L25_67, L26_68, 0, 0, "")
	L25_67 = L22_64
	L24_66 = L22_64.add
	L26_68 = L18_60
	L24_66(L25_67, L26_68, 0, 0, "")
	L25_67 = L23_65
	L24_66 = L23_65.add
	L26_68 = L19_61
	L24_66(L25_67, L26_68, 0, 0, "ALIGN_CENTER")
	L25_67 = L23_65
	L24_66 = L23_65.add
	L26_68 = L20_62
	L24_66(L25_67, L26_68, 0, 0, "ALIGN_CENTER")
	L25_67 = L21_63
	L24_66 = L21_63.add
	L26_68 = EWS
	L26_68 = L26_68.StaticText
	L26_68 = L26_68(L26_68, L13_55, "", "", "")
	L24_66(L25_67, L26_68, 0, 0, "")
	L25_67 = L21_63
	L24_66 = L21_63.add
	L26_68 = L22_64
	L24_66(L25_67, L26_68, 1, 0, "ALIGN_CENTER")
	L25_67 = L21_63
	L24_66 = L21_63.add
	L26_68 = L23_65
	L24_66(L25_67, L26_68, 0, 0, "ALIGN_CENTER")
	L24_66 = "CANCEL"
	function L25_67()
		_UPVALUE0_ = "APPLY"
		_UPVALUE1_:end_modal()
	end
	function L26_68()
		_UPVALUE0_ = "CANCEL"
		_UPVALUE1_:end_modal()
	end
	L19_61:connect("", "EVT_COMMAND_BUTTON_CLICKED", L25_67, "")
	L20_62:connect("", "EVT_COMMAND_BUTTON_CLICKED", L26_68, "")
	while not false do
		L13_55:show_modal()
		if L24_66 == "CANCEL" then
			return nil
		end
		L8_50 = L14_56:get_value()
		L9_51 = L15_57:get_value()
		L10_52 = L16_58:get_value()
		L11_53 = L17_59:get_value()
		L12_54 = L18_60:get_value()
		if L10_52 == "" then
			EWS:MessageDialog(A0_42._ews_parent, "Rule must have a Jump-to Marker.", "Wrong Input", ""):show_modal()
		elseif not tonumber(L11_53) then
			EWS:MessageDialog(A0_42._ews_parent, "Fade-in must be a float number (e.g. 1.234).", "Wrong Input", ""):show_modal()
		elseif not tonumber(L12_54) then
			EWS:MessageDialog(A0_42._ews_parent, "Fade-out must be a float number (e.g. 1.234).", "Wrong Input", ""):show_modal()
		else
		end
	end
	return {
		rule = L8_50,
		weight = L9_51,
		jump_to = L10_52,
		fade_in = L11_53,
		fade_out = L12_54
	}
end
function MarkerEditBox._on_sample_clip(A0_69)
	local L1_70, L2_71, L3_72, L4_73, L5_74, L6_75, L7_76
	L1_70 = A0_69._marker_name
	if L1_70 then
		L1_70 = A0_69._song_project
		L2_71 = L1_70
		L1_70 = L1_70.find_marker
		L3_72 = {}
		L4_73 = A0_69._marker_name
		L3_72.name = L4_73
		L1_70 = L1_70(L2_71, L3_72)
		L2_71 = A0_69._song_project
		L3_72 = L2_71
		L2_71 = L2_71.find_clip
		L4_73 = {}
		L5_74 = L1_70.clip
		L4_73.name = L5_74
		L2_71 = L2_71(L3_72, L4_73)
		L3_72 = tonumber
		L4_73 = L2_71.start
		L3_72 = L3_72(L4_73)
		L4_73 = A0_69.sample_clip_ctrl
		L5_74 = L4_73
		L4_73 = L4_73.get_value
		L4_73 = L4_73(L5_74)
		L5_74 = L4_73 + L3_72
		L6_75 = L4_73 / 44100
		L7_76 = L5_74 / 44100
		A0_69:_disable_callbacks()
		A0_69.sample_raw_ctrl:set_value(L5_74)
		A0_69.time_clip_ctrl:set_value(string.format("%.5f", L6_75))
		A0_69.time_raw_ctrl:set_value(string.format("%.5f", L7_76))
		A0_69._song_project:set_marker_sample({
			name = A0_69._marker_name,
			sample = L4_73
		})
		A0_69:_enable_callbacks()
		A0_69:_redraw_bar_cnt_text()
		if A0_69._on_sample_update_cb then
			A0_69._on_sample_update_cb()
		end
	end
end
function MarkerEditBox._on_sample_raw(A0_77)
	local L1_78, L2_79, L3_80, L4_81, L5_82, L6_83, L7_84
	L1_78 = A0_77._marker_name
	if L1_78 then
		L1_78 = A0_77._song_project
		L2_79 = L1_78
		L1_78 = L1_78.find_marker
		L3_80 = {}
		L4_81 = A0_77._marker_name
		L3_80.name = L4_81
		L1_78 = L1_78(L2_79, L3_80)
		L2_79 = A0_77._song_project
		L3_80 = L2_79
		L2_79 = L2_79.find_clip
		L4_81 = {}
		L5_82 = L1_78.clip
		L4_81.name = L5_82
		L2_79 = L2_79(L3_80, L4_81)
		L3_80 = tonumber
		L4_81 = L2_79.start
		L3_80 = L3_80(L4_81)
		L4_81 = A0_77.sample_raw_ctrl
		L5_82 = L4_81
		L4_81 = L4_81.get_value
		L4_81 = L4_81(L5_82)
		L5_82 = L4_81 - L3_80
		L6_83 = L5_82 / 44100
		L7_84 = L4_81 / 44100
		A0_77:_disable_callbacks()
		A0_77.sample_clip_ctrl:set_value(L5_82)
		A0_77.time_clip_ctrl:set_value(string.format("%.5f", L6_83))
		A0_77.time_raw_ctrl:set_value(string.format("%.5f", L7_84))
		A0_77._song_project:set_marker_sample({
			name = A0_77._marker_name,
			sample = L5_82
		})
		A0_77:_enable_callbacks()
		A0_77:_redraw_bar_cnt_text()
		if A0_77._on_sample_update_cb then
			A0_77._on_sample_update_cb()
		end
	end
end
function MarkerEditBox._on_time_clip(A0_85)
	local L1_86, L2_87, L3_88, L4_89, L5_90, L6_91, L7_92, L8_93
	L1_86 = A0_85._marker_name
	if L1_86 then
		L1_86 = A0_85.time_clip_ctrl
		L2_87 = L1_86
		L1_86 = L1_86.in_focus
		L1_86 = L1_86(L2_87)
		if L1_86 then
			L1_86 = A0_85._song_project
			L2_87 = L1_86
			L1_86 = L1_86.find_marker
			L3_88 = {}
			L4_89 = A0_85._marker_name
			L3_88.name = L4_89
			L1_86 = L1_86(L2_87, L3_88)
			L2_87 = A0_85._song_project
			L3_88 = L2_87
			L2_87 = L2_87.find_clip
			L4_89 = {}
			L5_90 = L1_86.clip
			L4_89.name = L5_90
			L2_87 = L2_87(L3_88, L4_89)
			L3_88 = tonumber
			L4_89 = L2_87.start
			L3_88 = L3_88(L4_89)
			L4_89 = tonumber
			L5_90 = L2_87.stop
			L4_89 = L4_89(L5_90)
			L5_90 = tonumber
			L6_91 = A0_85.time_clip_ctrl
			L7_92 = L6_91
			L6_91 = L6_91.get_value
			L8_93 = L6_91(L7_92)
			L5_90 = L5_90(L6_91, L7_92, L8_93, L6_91(L7_92))
			if L5_90 == nil then
				return
			end
			L6_91 = math
			L6_91 = L6_91.floor
			L7_92 = math
			L7_92 = L7_92.min
			L8_93 = L4_89 - L3_88
			L8_93 = L7_92(L8_93, math.max(0, math.floor(L5_90 * 44100)))
			L6_91 = L6_91(L7_92, L8_93, L7_92(L8_93, math.max(0, math.floor(L5_90 * 44100))))
			L7_92 = L6_91 + L3_88
			L8_93 = L7_92 / 44100
			A0_85:_disable_callbacks()
			A0_85.sample_clip_ctrl:set_value(L6_91)
			A0_85.sample_raw_ctrl:set_value(L7_92)
			A0_85.time_raw_ctrl:set_value(string.format("%.5f", L8_93))
			A0_85._song_project:set_marker_sample({
				name = A0_85._marker_name,
				sample = L6_91
			})
			A0_85:_enable_callbacks()
			A0_85:_redraw_bar_cnt_text()
			if A0_85._on_sample_update_cb then
				A0_85._on_sample_update_cb()
			end
		end
	end
end
function MarkerEditBox._on_time_raw(A0_94)
	local L1_95, L2_96, L3_97, L4_98, L5_99, L6_100, L7_101, L8_102
	L1_95 = A0_94._marker_name
	if L1_95 then
		L1_95 = A0_94.time_raw_ctrl
		L2_96 = L1_95
		L1_95 = L1_95.in_focus
		L1_95 = L1_95(L2_96)
		if L1_95 then
			L1_95 = A0_94._song_project
			L2_96 = L1_95
			L1_95 = L1_95.find_marker
			L3_97 = {}
			L4_98 = A0_94._marker_name
			L3_97.name = L4_98
			L1_95 = L1_95(L2_96, L3_97)
			L2_96 = A0_94._song_project
			L3_97 = L2_96
			L2_96 = L2_96.find_clip
			L4_98 = {}
			L5_99 = L1_95.clip
			L4_98.name = L5_99
			L2_96 = L2_96(L3_97, L4_98)
			L3_97 = tonumber
			L4_98 = L2_96.start
			L3_97 = L3_97(L4_98)
			L4_98 = tonumber
			L5_99 = L2_96.stop
			L4_98 = L4_98(L5_99)
			L5_99 = tonumber
			L6_100 = A0_94.time_raw_ctrl
			L7_101 = L6_100
			L6_100 = L6_100.get_value
			L8_102 = L6_100(L7_101)
			L5_99 = L5_99(L6_100, L7_101, L8_102, L6_100(L7_101))
			if L5_99 == nil then
				return
			end
			L6_100 = math
			L6_100 = L6_100.floor
			L7_101 = math
			L7_101 = L7_101.min
			L8_102 = L4_98
			L8_102 = L7_101(L8_102, math.max(L3_97, math.floor(L5_99 * 44100)))
			L6_100 = L6_100(L7_101, L8_102, L7_101(L8_102, math.max(L3_97, math.floor(L5_99 * 44100))))
			L7_101 = L6_100 - L3_97
			L8_102 = L7_101 / 44100
			A0_94:_disable_callbacks()
			A0_94.sample_clip_ctrl:set_value(L7_101)
			A0_94.sample_raw_ctrl:set_value(L6_100)
			A0_94.time_clip_ctrl:set_value(string.format("%.5f", L8_102))
			A0_94._song_project:set_marker_sample({
				name = A0_94._marker_name,
				sample = L7_101
			})
			A0_94:_enable_callbacks()
			A0_94:_redraw_bar_cnt_text()
			if A0_94._on_sample_update_cb then
				A0_94._on_sample_update_cb()
			end
		end
	end
end
function MarkerEditBox._on_move_beat_left(A0_103)
	local L1_104, L2_105, L3_106, L4_107, L5_108, L6_109, L7_110, L8_111, L9_112, L10_113
	L1_104 = A0_103._marker_name
	if L1_104 then
		L1_104 = A0_103._song_project
		L2_105 = L1_104
		L1_104 = L1_104.find_marker
		L3_106 = {}
		L4_107 = A0_103._marker_name
		L3_106.name = L4_107
		L1_104 = L1_104(L2_105, L3_106)
		L2_105 = A0_103._song_project
		L3_106 = L2_105
		L2_105 = L2_105.find_mode
		L4_107 = {}
		L5_108 = L1_104.mode
		L4_107.name = L5_108
		L2_105 = L2_105(L3_106, L4_107)
		L3_106 = L2_105.mode_time_signature
		L3_106 = L3_106 * 60
		L4_107 = L2_105.mode_bpm
		L3_106 = L3_106 / L4_107
		L4_107 = A0_103._song_project
		L5_108 = L4_107
		L4_107 = L4_107.find_clip
		L6_109 = {}
		L7_110 = L1_104.clip
		L6_109.name = L7_110
		L4_107 = L4_107(L5_108, L6_109)
		L5_108 = tonumber
		L6_109 = L4_107.start
		L5_108 = L5_108(L6_109)
		L6_109 = tonumber
		L7_110 = L4_107.stop
		L6_109 = L6_109(L7_110)
		L7_110 = math
		L7_110 = L7_110.floor
		L8_111 = tonumber
		L9_112 = L1_104.sample
		L8_111 = L8_111(L9_112)
		L9_112 = L3_106 * 44100
		L8_111 = L8_111 - L9_112
		L7_110 = L7_110(L8_111)
		if L7_110 >= 0 then
			L8_111 = L7_110 + L5_108
			L9_112 = L7_110 / 44100
			L10_113 = L8_111 / 44100
			A0_103:_disable_callbacks()
			A0_103.sample_clip_ctrl:set_value(L7_110)
			A0_103.sample_raw_ctrl:set_value(L8_111)
			A0_103.time_clip_ctrl:set_value(string.format("%.5f", L9_112))
			A0_103.time_raw_ctrl:set_value(string.format("%.5f", L10_113))
			A0_103._song_project:set_marker_sample({
				name = A0_103._marker_name,
				sample = L7_110
			})
			A0_103:_enable_callbacks()
			A0_103:_redraw_bar_cnt_text()
			if A0_103._on_sample_update_cb then
				A0_103._on_sample_update_cb()
			end
		end
	end
end
function MarkerEditBox._on_move_beat_right(A0_114)
	local L1_115, L2_116, L3_117, L4_118, L5_119, L6_120, L7_121, L8_122, L9_123, L10_124
	L1_115 = A0_114._marker_name
	if L1_115 then
		L1_115 = A0_114._song_project
		L2_116 = L1_115
		L1_115 = L1_115.find_marker
		L3_117 = {}
		L4_118 = A0_114._marker_name
		L3_117.name = L4_118
		L1_115 = L1_115(L2_116, L3_117)
		L2_116 = A0_114._song_project
		L3_117 = L2_116
		L2_116 = L2_116.find_mode
		L4_118 = {}
		L5_119 = L1_115.mode
		L4_118.name = L5_119
		L2_116 = L2_116(L3_117, L4_118)
		L3_117 = L2_116.mode_time_signature
		L3_117 = L3_117 * 60
		L4_118 = L2_116.mode_bpm
		L3_117 = L3_117 / L4_118
		L4_118 = A0_114._song_project
		L5_119 = L4_118
		L4_118 = L4_118.find_clip
		L6_120 = {}
		L7_121 = L1_115.clip
		L6_120.name = L7_121
		L4_118 = L4_118(L5_119, L6_120)
		L5_119 = tonumber
		L6_120 = L4_118.start
		L5_119 = L5_119(L6_120)
		L6_120 = tonumber
		L7_121 = L4_118.stop
		L6_120 = L6_120(L7_121)
		L7_121 = math
		L7_121 = L7_121.floor
		L8_122 = tonumber
		L9_123 = L1_115.sample
		L8_122 = L8_122(L9_123)
		L9_123 = L3_117 * 44100
		L8_122 = L8_122 + L9_123
		L7_121 = L7_121(L8_122)
		L8_122 = L7_121 + L5_119
		L9_123 = L7_121 / 44100
		L10_124 = L8_122 / 44100
		A0_114:_disable_callbacks()
		A0_114.sample_clip_ctrl:set_value(L7_121)
		A0_114.sample_raw_ctrl:set_value(L8_122)
		A0_114.time_clip_ctrl:set_value(string.format("%.5f", L9_123))
		A0_114.time_raw_ctrl:set_value(string.format("%.5f", L10_124))
		A0_114._song_project:set_marker_sample({
			name = A0_114._marker_name,
			sample = L7_121
		})
		A0_114:_enable_callbacks()
		A0_114:_redraw_bar_cnt_text()
		if A0_114._on_sample_update_cb then
			A0_114._on_sample_update_cb()
		end
	end
end
function MarkerEditBox._on_align_bars(A0_125)
	if A0_125._marker_name then
		A0_125._song_project:set_marker_align_bars({
			name = A0_125._marker_name,
			align_bars = A0_125.align_bar_cb:get_value()
		})
	end
	A0_125:_redraw_bar_cnt_text()
end
function MarkerEditBox._redraw_bar_cnt_text(A0_126)
	local L1_127, L2_128, L3_129, L4_130, L5_131, L6_132, L7_133
	L1_127 = A0_126._marker_name
	if L1_127 then
		L1_127 = A0_126._song_project
		L2_128 = L1_127
		L1_127 = L1_127.find_marker
		L3_129 = {}
		L4_130 = A0_126._marker_name
		L3_129.name = L4_130
		L1_127 = L1_127(L2_128, L3_129)
		L2_128 = A0_126._song_project
		L3_129 = L2_128
		L2_128 = L2_128.find_mode
		L4_130 = {}
		L5_131 = L1_127.mode
		L4_130.name = L5_131
		L2_128 = L2_128(L3_129, L4_130)
		L3_129 = L2_128.mode_time_signature
		L3_129 = L3_129 * 60
		L4_130 = L2_128.mode_bpm
		L3_129 = L3_129 / L4_130
		L4_130 = A0_126._song_project
		L5_131 = L4_130
		L4_130 = L4_130.find_clip_calc_baroffset
		L6_132 = {}
		L7_133 = L1_127.mode
		L6_132.mode_name = L7_133
		L7_133 = L1_127.clip
		L6_132.clip_name = L7_133
		L5_131 = L4_130(L5_131, L6_132)
		if not L4_130 then
			L6_132 = tonumber
			L7_133 = L1_127.sample
			L6_132 = L6_132(L7_133)
			L7_133 = L6_132 / 44100
			L7_133 = L7_133 - L5_131.bar_offset
			L7_133 = L7_133 / L3_129
			L7_133 = L7_133 + 1
			A0_126.bar_cnt_text:set_value(string.format("(bar# %4.2f)", L7_133))
			return
		end
	end
	L1_127 = A0_126.bar_cnt_text
	L2_128 = L1_127
	L1_127 = L1_127.set_value
	L3_129 = "(bar# 0.00)"
	L1_127(L2_128, L3_129)
end
