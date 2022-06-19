core:module("CoreModeCrossfadeBox")
core:require_module("CoreKeywordArguments")
core:require_module("CoreSmartListCtrl")
core:require_module("CoreClass")
core:require_module("CoreEvent")
ModeCrossfadeBox = ModeCrossfadeBox or CoreClass.class()
function ModeCrossfadeBox.init(A0_0, ...)
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
	L3_3 = L3_3(L4_4, A0_0.panel, "Start new section  ", "", "")
	A0_0.new_section_cb = L3_3
	L3_3 = EWS
	L4_4 = L3_3
	L3_3 = L3_3.StaticText
	L3_3 = L3_3(L4_4, A0_0.panel, "", "", "")
	A0_0.section_text1 = L3_3
	L3_3 = EWS
	L4_4 = L3_3
	L3_3 = L3_3.StaticText
	L3_3 = L3_3(L4_4, A0_0.panel, "", "", "")
	A0_0.section_text2 = L3_3
	L3_3 = EWS
	L4_4 = L3_3
	L3_3 = L3_3.StaticText
	L3_3 = L3_3(L4_4, A0_0.panel, "", "", "")
	A0_0.section_text3 = L3_3
	L3_3 = CoreSmartListCtrl
	L3_3 = L3_3.SmartListCtrl
	L4_4 = L3_3
	L3_3 = L3_3.new
	L3_3 = L3_3(L4_4, {
		parent = A0_0.panel,
		header = {
			"mode",
			"marker",
			"add_time",
			"weight",
			"fade_in",
			"fade_out"
		},
		on_popup_menu_cb = CoreEvent.callback(A0_0, A0_0, "_on_popup_menu")
	})
	A0_0.list = L3_3
	L3_3 = CoreEvent
	L3_3 = L3_3.callback
	L4_4 = A0_0
	L3_3 = L3_3(L4_4, A0_0, "_on_new_section")
	A0_0._on_new_section_cb = L3_3
	L4_4 = A0_0
	L3_3 = A0_0._enable_callbacks
	L3_3(L4_4)
	L3_3 = EWS
	L4_4 = L3_3
	L3_3 = L3_3.FlexGridSizer
	L3_3 = L3_3(L4_4, 3, 1, 5, 5)
	L4_4 = L3_3.add
	L4_4(L3_3, A0_0.section_text1, 0, 0, "ALIGN_LEFT")
	L4_4 = L3_3.add
	L4_4(L3_3, A0_0.section_text2, 0, 0, "ALIGN_CENTER")
	L4_4 = L3_3.add
	L4_4(L3_3, A0_0.section_text3, 0, 0, "ALIGN_CENTER")
	L4_4 = EWS
	L4_4 = L4_4.FlexGridSizer
	L4_4 = L4_4(L4_4, 2, 1, 5, 5)
	L4_4:add(L3_3, 0, 0, "ALIGN_RIGHT")
	L4_4:add(A0_0.new_section_cb, 0, 0, "")
	A0_0.box_sizer = EWS:BoxSizer("HORIZONTAL")
	A0_0.box_sizer:add(L4_4, 0, 0, "")
	A0_0.box_sizer:add(A0_0.list.listctrl, 1, 0, "EXPAND")
	A0_0.panel:set_sizer(A0_0.box_sizer)
	A0_0:_set_enabled(false)
end
function ModeCrossfadeBox.global_redraw(A0_5, A1_6)
	A0_5._song_project = A1_6 or assert(A0_5._song_project)
	if A0_5._marker_name then
		if not A0_5._song_project:find_marker({
			name = A0_5._marker_name
		}) then
			A0_5._marker_name = nil
		end
	end
	A0_5:_redraw()
end
function ModeCrossfadeBox.set_song(A0_7, A1_8)
	A0_7._marker_name = nil
	A0_7._song_project = A1_8
	A0_7:_redraw()
end
function ModeCrossfadeBox.marker_selected(A0_9, A1_10)
	A0_9._marker_name = A1_10
	A0_9:_redraw()
end
function ModeCrossfadeBox.marker_deselected(A0_11)
	A0_11._marker_name = nil
	A0_11:_redraw()
end
function ModeCrossfadeBox._redraw(A0_12)
	local L1_13, L2_14, L3_15, L4_16, L5_17, L6_18
	L2_14 = A0_12
	L1_13 = A0_12._disable_callbacks
	L1_13(L2_14)
	L1_13 = A0_12._marker_name
	if L1_13 then
		L1_13 = A0_12._song_project
		L2_14 = L1_13
		L1_13 = L1_13.find_first_marker_in_section
		L3_15.marker_name = L4_16
		L1_13 = L1_13(L2_14, L3_15)
		L2_14 = A0_12._song_project
		L2_14 = L2_14.find_end_marker_for_section
		L4_16.marker_name = L5_17
		L2_14 = L2_14(L3_15, L4_16)
		L6_18 = A0_12._marker_name
		L5_17.marker_name = L6_18
		if L3_15 then
			L3_15(L4_16, L5_17)
			L3_15(L4_16, L5_17)
			L3_15(L4_16, L5_17)
			L3_15(L4_16)
			L3_15(L4_16, L5_17)
			L3_15(L4_16, L5_17)
			L3_15(L4_16, L5_17)
		elseif L1_13 and L2_14 then
			L3_15(L4_16, L5_17)
			L6_18 = "(A = %s) "
			L6_18 = L5_17(L6_18, L1_13.name)
			L3_15(L4_16, L5_17, L6_18, L5_17(L6_18, L1_13.name))
			L6_18 = "(B = %s) "
			L6_18 = L5_17(L6_18, L2_14.name)
			L3_15(L4_16, L5_17, L6_18, L5_17(L6_18, L2_14.name))
			L3_15(L4_16)
			L6_18 = A0_12._marker_name
			L5_17.marker_name = L6_18
			for L6_18 in L3_15(L4_16, L5_17) do
				L6_18.mode = A0_12._song_project:find_marker({
					name = L6_18.marker
				}).mode
				A0_12.list:append_item(L6_18)
			end
			L3_15(L4_16, L5_17)
			L3_15(L4_16, L5_17)
			L6_18 = A0_12._marker_name
			L5_17.marker_name = L6_18
			if L3_15 then
				L3_15(L4_16, L5_17)
			else
				L3_15(L4_16, L5_17)
			end
		else
			L3_15(L4_16, L5_17)
			L3_15(L4_16, L5_17)
			L6_18 = "for '%s')"
			L6_18 = L5_17(L6_18, A0_12._marker_name)
			L3_15(L4_16, L5_17, L6_18, L5_17(L6_18, A0_12._marker_name))
			L3_15(L4_16)
			L3_15(L4_16, L5_17)
			L3_15(L4_16, L5_17)
			L6_18 = A0_12._marker_name
			L5_17.marker_name = L6_18
			if L3_15 then
				L3_15(L4_16, L5_17)
			else
				L3_15(L4_16, L5_17)
			end
		end
	else
		L1_13 = A0_12.section_text1
		L2_14 = L1_13
		L1_13 = L1_13.set_value
		L1_13(L2_14, L3_15)
		L1_13 = A0_12.section_text2
		L2_14 = L1_13
		L1_13 = L1_13.set_value
		L1_13(L2_14, L3_15)
		L1_13 = A0_12.section_text3
		L2_14 = L1_13
		L1_13 = L1_13.set_value
		L1_13(L2_14, L3_15)
		L1_13 = A0_12.list
		L2_14 = L1_13
		L1_13 = L1_13.clear_list
		L1_13(L2_14)
		L1_13 = A0_12.list
		L1_13 = L1_13.listctrl
		L2_14 = L1_13
		L1_13 = L1_13.set_enabled
		L1_13(L2_14, L3_15)
		L1_13 = A0_12.new_section_cb
		L2_14 = L1_13
		L1_13 = L1_13.set_enabled
		L1_13(L2_14, L3_15)
		L1_13 = A0_12.new_section_cb
		L2_14 = L1_13
		L1_13 = L1_13.set_value
		L1_13(L2_14, L3_15)
	end
	L1_13 = A0_12.panel
	L2_14 = L1_13
	L1_13 = L1_13.layout
	L1_13(L2_14)
	L2_14 = A0_12
	L1_13 = A0_12._enable_callbacks
	L1_13(L2_14)
end
function ModeCrossfadeBox._enable_callbacks(A0_19)
	A0_19.list:enable_callbacks()
	A0_19.new_section_cb:connect("EVT_COMMAND_CHECKBOX_CLICKED", A0_19._on_new_section_cb)
end
function ModeCrossfadeBox._disable_callbacks(A0_20)
	A0_20.list:disable_callbacks()
	A0_20.new_section_cb:disconnect("EVT_COMMAND_CHECKBOX_CLICKED", A0_20._on_new_section_cb)
end
function ModeCrossfadeBox._set_enabled(A0_21, A1_22)
	A0_21.list.listctrl:set_enabled(A1_22)
	A0_21.new_section_cb:set_enabled(A1_22)
end
function ModeCrossfadeBox._on_popup_menu(A0_23, A1_24, A2_25)
	local L3_26
	L3_26 = {}
	L3_26.Add = CoreEvent.callback(A0_23, A0_23, "_on_add")
	if A2_25 ~= nil then
		L3_26.Modify = CoreEvent.callback(A0_23, A0_23, "_on_modify")
		L3_26.Remove = CoreEvent.callback(A0_23, A0_23, "_on_remove")
	end
	return L3_26
end
function ModeCrossfadeBox._on_add(A0_27)
	if A0_27:_edit_mode_crossfade({}, "Add New Mode Change Crossfade Path") then
		A0_27._song_project:add_allowed_crossfade({
			from_marker = A0_27._marker_name,
			to_marker = A0_27:_edit_mode_crossfade({}, "Add New Mode Change Crossfade Path").marker,
			add_time = A0_27:_edit_mode_crossfade({}, "Add New Mode Change Crossfade Path").add_time,
			weight = A0_27:_edit_mode_crossfade({}, "Add New Mode Change Crossfade Path").weight,
			fade_in = A0_27:_edit_mode_crossfade({}, "Add New Mode Change Crossfade Path").fade_in,
			fade_out = A0_27:_edit_mode_crossfade({}, "Add New Mode Change Crossfade Path").fade_out
		})
		A0_27:_redraw()
	end
end
function ModeCrossfadeBox._on_modify(A0_28)
	local L1_29
	L1_29 = A0_28.list
	L1_29 = L1_29.get_selected_item
	L1_29 = L1_29(L1_29)
	if A0_28:_edit_mode_crossfade(L1_29, "Modify Mode Change Crossfade Path") then
		A0_28._song_project:modify_allowed_crossfade({
			from_marker = A0_28._marker_name,
			old_to_marker = L1_29.marker,
			new_to_marker = A0_28:_edit_mode_crossfade(L1_29, "Modify Mode Change Crossfade Path").marker,
			weight = A0_28:_edit_mode_crossfade(L1_29, "Modify Mode Change Crossfade Path").weight,
			add_time = A0_28:_edit_mode_crossfade(L1_29, "Modify Mode Change Crossfade Path").add_time,
			fade_in = A0_28:_edit_mode_crossfade(L1_29, "Modify Mode Change Crossfade Path").fade_in,
			fade_out = A0_28:_edit_mode_crossfade(L1_29, "Modify Mode Change Crossfade Path").fade_out
		})
		A0_28:_redraw()
	end
end
function ModeCrossfadeBox._on_remove(A0_30)
	A0_30._song_project:remove_allowed_crossfade({
		from_marker = A0_30._marker_name,
		to_marker = A0_30.list:get_selected_item().marker
	})
	A0_30:_redraw()
end
function ModeCrossfadeBox._on_new_section(A0_31)
	if A0_31.new_section_cb:get_value() then
		A0_31._song_project:add_section({
			start_marker_name = A0_31._marker_name
		})
	else
		A0_31._song_project:remove_section({
			start_marker_name = A0_31._marker_name
		})
	end
	A0_31:_redraw()
end
function ModeCrossfadeBox._edit_mode_crossfade(A0_32, A1_33, A2_34)
	local L3_35, L4_36, L5_37, L6_38, L7_39, L8_40, L9_41, L10_42, L11_43, L12_44, L13_45, L14_46, L15_47, L16_48, L17_49, L18_50, L19_51, L20_52, L21_53, L22_54, L23_55, L24_56, L25_57, L26_58
	L3_35 = A1_33.weight
	L3_35 = L3_35 or 1
	L4_36 = A1_33.marker
	L4_36 = L4_36 or ""
	L5_37 = A1_33.add_time
	L5_37 = L5_37 or "since_jump"
	L6_38 = A1_33.fade_in
	L6_38 = L6_38 or "0.0"
	L7_39 = A1_33.fade_out
	L7_39 = L7_39 or "0.0"
	L8_40, L9_41, L10_42 = nil, nil, nil
	L11_43 = EWS
	L12_44 = L11_43
	L11_43 = L11_43.Dialog
	L13_45 = A0_32._ews_parent
	L14_46 = A2_34
	L15_47 = ""
	L16_48 = Vector3
	L17_49 = -1
	L18_50 = -1
	L19_51 = 0
	L16_48 = L16_48(L17_49, L18_50, L19_51)
	L17_49 = Vector3
	L18_50 = 360
	L19_51 = 250
	L17_49 = L17_49(L18_50, L19_51, L20_52)
	L18_50 = ""
	L11_43 = L11_43(L12_44, L13_45, L14_46, L15_47, L16_48, L17_49, L18_50)
	L12_44 = EWS
	L13_45 = L12_44
	L12_44 = L12_44.SpinCtrl
	L14_46 = L11_43
	L15_47 = tonumber
	L16_48 = L3_35
	L15_47 = L15_47(L16_48)
	L16_48 = ""
	L17_49 = ""
	L12_44 = L12_44(L13_45, L14_46, L15_47, L16_48, L17_49)
	L13_45 = EWS
	L14_46 = L13_45
	L13_45 = L13_45.ComboBox
	L15_47 = L11_43
	L16_48 = ""
	L17_49 = ""
	L18_50 = "CB_READONLY"
	L13_45 = L13_45(L14_46, L15_47, L16_48, L17_49, L18_50)
	L14_46 = EWS
	L15_47 = L14_46
	L14_46 = L14_46.ComboBox
	L16_48 = L11_43
	L17_49 = ""
	L18_50 = ""
	L19_51 = "CB_READONLY"
	L14_46 = L14_46(L15_47, L16_48, L17_49, L18_50, L19_51)
	L15_47 = EWS
	L16_48 = L15_47
	L15_47 = L15_47.TextCtrl
	L17_49 = L11_43
	L18_50 = L6_38
	L19_51 = ""
	L15_47 = L15_47(L16_48, L17_49, L18_50, L19_51, L20_52)
	L16_48 = EWS
	L17_49 = L16_48
	L16_48 = L16_48.TextCtrl
	L18_50 = L11_43
	L19_51 = L7_39
	L16_48 = L16_48(L17_49, L18_50, L19_51, L20_52, L21_53)
	L17_49 = EWS
	L18_50 = L17_49
	L17_49 = L17_49.Button
	L19_51 = L11_43
	L17_49 = L17_49(L18_50, L19_51, L20_52, L21_53, L22_54)
	L18_50 = EWS
	L19_51 = L18_50
	L18_50 = L18_50.Button
	L23_55 = ""
	L18_50 = L18_50(L19_51, L20_52, L21_53, L22_54, L23_55)
	L19_51 = A0_32._song_project
	L19_51 = L19_51.find_marker
	L21_53.name = L22_54
	L19_51 = L19_51(L20_52, L21_53)
	for L23_55 in L20_52(L21_53) do
		L24_56 = L23_55.mode
		L25_57 = L19_51.mode
		if L24_56 ~= L25_57 then
			L25_57 = L13_45
			L24_56 = L13_45.append
			L26_58 = L23_55.name
			L24_56(L25_57, L26_58)
		end
	end
	L20_52(L21_53, L22_54)
	L20_52(L21_53, L22_54)
	L20_52(L21_53, L22_54)
	L20_52(L21_53, L22_54)
	L20_52(L21_53, L22_54)
	L23_55 = 5
	L24_56 = 2
	L25_57 = 10
	L26_58 = 10
	L23_55 = L22_54
	L24_56 = 1
	L25_57 = 2
	L26_58 = 40
	L24_56 = L11_43
	L23_55 = L11_43.set_sizer
	L25_57 = L20_52
	L23_55(L24_56, L25_57)
	L23_55 = string
	L23_55 = L23_55.format
	L24_56 = "From Mode '%s', crossfade to:"
	L25_57 = L19_51.mode
	L23_55 = L23_55(L24_56, L25_57)
	L25_57 = L21_53
	L24_56 = L21_53.add
	L26_58 = EWS
	L26_58 = L26_58.StaticText
	L26_58 = L26_58(L26_58, L11_43, L23_55, "", "")
	L24_56(L25_57, L26_58, 0, 0, "")
	L25_57 = L21_53
	L24_56 = L21_53.add
	L26_58 = L13_45
	L24_56(L25_57, L26_58, 0, 0, "")
	L25_57 = L21_53
	L24_56 = L21_53.add
	L26_58 = EWS
	L26_58 = L26_58.StaticText
	L26_58 = L26_58(L26_58, L11_43, "Add Time:", "", "")
	L24_56(L25_57, L26_58, 0, 0, "")
	L25_57 = L21_53
	L24_56 = L21_53.add
	L26_58 = L14_46
	L24_56(L25_57, L26_58, 0, 0, "")
	L25_57 = L21_53
	L24_56 = L21_53.add
	L26_58 = EWS
	L26_58 = L26_58.StaticText
	L26_58 = L26_58(L26_58, L11_43, "Weight:", "", "")
	L24_56(L25_57, L26_58, 0, 0, "")
	L25_57 = L21_53
	L24_56 = L21_53.add
	L26_58 = L12_44
	L24_56(L25_57, L26_58, 0, 0, "")
	L25_57 = L21_53
	L24_56 = L21_53.add
	L26_58 = EWS
	L26_58 = L26_58.StaticText
	L26_58 = L26_58(L26_58, L11_43, "Fade-in:", "", "")
	L24_56(L25_57, L26_58, 0, 0, "")
	L25_57 = L21_53
	L24_56 = L21_53.add
	L26_58 = L15_47
	L24_56(L25_57, L26_58, 0, 0, "")
	L25_57 = L21_53
	L24_56 = L21_53.add
	L26_58 = EWS
	L26_58 = L26_58.StaticText
	L26_58 = L26_58(L26_58, L11_43, "Fade-out:", "", "")
	L24_56(L25_57, L26_58, 0, 0, "")
	L25_57 = L21_53
	L24_56 = L21_53.add
	L26_58 = L16_48
	L24_56(L25_57, L26_58, 0, 0, "")
	L25_57 = L22_54
	L24_56 = L22_54.add
	L26_58 = L17_49
	L24_56(L25_57, L26_58, 0, 0, "ALIGN_CENTER")
	L25_57 = L22_54
	L24_56 = L22_54.add
	L26_58 = L18_50
	L24_56(L25_57, L26_58, 0, 0, "ALIGN_CENTER")
	L25_57 = L20_52
	L24_56 = L20_52.add
	L26_58 = EWS
	L26_58 = L26_58.StaticText
	L26_58 = L26_58(L26_58, L11_43, "", "", "")
	L24_56(L25_57, L26_58, 0, 0, "")
	L25_57 = L20_52
	L24_56 = L20_52.add
	L26_58 = L21_53
	L24_56(L25_57, L26_58, 1, 0, "ALIGN_CENTER")
	L25_57 = L20_52
	L24_56 = L20_52.add
	L26_58 = L22_54
	L24_56(L25_57, L26_58, 0, 0, "ALIGN_CENTER")
	L24_56 = "CANCEL"
	function L25_57()
		_UPVALUE0_ = "APPLY"
		_UPVALUE1_:end_modal()
	end
	function L26_58()
		_UPVALUE0_ = "CANCEL"
		_UPVALUE1_:end_modal()
	end
	L17_49:connect("", "EVT_COMMAND_BUTTON_CLICKED", L25_57, "")
	L18_50:connect("", "EVT_COMMAND_BUTTON_CLICKED", L26_58, "")
	while not false do
		L11_43:show_modal()
		if L24_56 == "CANCEL" then
			return nil
		end
		new_marker = L13_45:get_value()
		new_weight = L12_44:get_value()
		new_addtime = L14_46:get_value()
		L9_41 = L15_47:get_value()
		L10_42 = L16_48:get_value()
		if new_marker == "" then
			EWS:MessageDialog(A0_32._ews_parent, "Marker to crossfade to must be specified.", "Wrong Input", ""):show_modal()
		elseif not tonumber(L9_41) then
			EWS:MessageDialog(A0_32._ews_parent, "Fade-in must be a number.", "Wrong Input", ""):show_modal()
		elseif not tonumber(L10_42) then
			EWS:MessageDialog(A0_32._ews_parent, "Fade-out must be a number.", "Wrong Input", ""):show_modal()
		else
		end
	end
	return {
		weight = new_weight,
		marker = new_marker,
		add_time = new_addtime,
		fade_in = L9_41,
		fade_out = L10_42
	}
end
