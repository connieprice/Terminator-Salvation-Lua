core:module("CoreModesBox")
core:require_module("CoreKeywordArguments")
core:require_module("CoreSmartListCtrl")
core:require_module("CoreClass")
core:require_module("CoreEvent")
ModesBox = ModesBox or CoreClass.class()
function ModesBox.init(A0_0, ...)
	local L2_2
	L2_2 = CoreKeywordArguments
	L2_2 = L2_2.KeywordArguments
	L2_2 = L2_2.new
	L2_2 = L2_2(L2_2, ...)
	A0_0._ews_parent = L2_2:mandatory_object("parent")
	A0_0._clips_box = L2_2:mandatory_object("clips")
	A0_0._markers_box = L2_2:mandatory_object("markers")
	A0_0._startstop_box = L2_2:mandatory_object("startstop")
	A0_0._modetiming_box = L2_2:mandatory_object("modetiming")
	A0_0._songcrossfade_box = L2_2:mandatory_object("songcrossfade")
	L2_2:assert_all_consumed()
	A0_0._song_project = nil
	A0_0.panel = EWS:Panel(A0_0._ews_parent, "", "")
	A0_0.list = CoreSmartListCtrl.SmartListCtrl:new({
		parent = A0_0.panel,
		header = {"name"},
		static_item = {
			name = "(no filter -->)"
		},
		on_selected_cb = CoreEvent.callback(A0_0, A0_0, "_on_mode_selected"),
		on_static_selected_cb = CoreEvent.callback(A0_0, A0_0, "_on_static_selected"),
		on_deselected_cb = CoreEvent.callback(A0_0, A0_0, "_on_mode_deselected"),
		on_popup_menu_cb = CoreEvent.callback(A0_0, A0_0, "_on_popup_menu")
	})
	A0_0.box_sizer = EWS:StaticBoxSizer(A0_0.panel, "HORIZONTAL", "Modes")
	A0_0.box_sizer:add(A0_0.list.listctrl, 1, 0, "EXPAND")
	A0_0.panel:set_sizer(A0_0.box_sizer)
	A0_0.list.listctrl:set_enabled(false)
end
function ModesBox.global_redraw(A0_3, A1_4)
	A0_3._song_project = A1_4 or assert(A0_3._song_project)
	A0_3.list.listctrl:set_enabled(true)
	A0_3.list:disable_callbacks()
	A0_3:_redraw()
	A0_3.list:enable_callbacks()
end
function ModesBox._redraw(A0_5)
	local L1_6, L2_7, L3_8, L4_9
	L1_6(L2_7)
	for L4_9 in L1_6(L2_7) do
		A0_5.list:append_item(L4_9)
	end
	L1_6(L2_7)
end
function ModesBox._on_mode_selected(A0_10, A1_11, A2_12)
	A0_10._clips_box:mode_selected(A1_11.name)
	A0_10._markers_box:mode_selected(A1_11.name)
	A0_10._startstop_box:mode_selected(A1_11.name)
	A0_10._modetiming_box:mode_selected(A1_11.name)
	A0_10._songcrossfade_box:mode_selected(A1_11.name)
end
function ModesBox._on_static_selected(A0_13)
	A0_13._clips_box:mode_deselected()
	A0_13._markers_box:mode_deselected()
	A0_13._startstop_box:mode_deselected()
	A0_13._modetiming_box:mode_deselected()
	A0_13._songcrossfade_box:mode_deselected()
end
function ModesBox._on_mode_deselected(A0_14)
	A0_14._startstop_box:mode_deselected()
	A0_14._modetiming_box:mode_deselected()
	A0_14._songcrossfade_box:mode_deselected()
end
function ModesBox._on_popup_menu(A0_15, A1_16, A2_17)
	local L3_18
	L3_18 = {}
	L3_18.Add = CoreEvent.callback(A0_15, A0_15, "_on_add")
	if A2_17 == nil or A2_17 == -1 then
		return L3_18
	end
	if not A0_15._song_project:mode_is_referenced({
		name = A1_16.name
	}) then
		L3_18.Remove = CoreEvent.callback(A0_15, A0_15, "_on_remove")
	end
	L3_18.Rename = CoreEvent.callback(A0_15, A0_15, "_on_rename")
	if A2_17 > 0 then
		L3_18["Move Up"] = CoreEvent.callback(A0_15, A0_15, "_on_move_up")
	end
	if A2_17 < A0_15.list:get_number_dynamic_items() - 1 then
		L3_18["Move Down"] = CoreEvent.callback(A0_15, A0_15, "_on_move_down")
	end
	return L3_18
end
function ModesBox._on_add(A0_19)
	if A0_19:_edit_mode({}, "Create New Mode") then
		A0_19._song_project:add_new_mode({
			name = A0_19:_edit_mode({}, "Create New Mode").name
		})
		A0_19:_redraw()
	end
end
function ModesBox._on_remove(A0_20)
	A0_20._song_project:remove_mode({
		name = A0_20.list:get_selected_item().name
	})
	A0_20:_on_mode_deselected()
	A0_20:_redraw()
end
function ModesBox._on_rename(A0_21)
	local L1_22, L2_23, L3_24
	L1_22 = A0_21.list
	L2_23 = L1_22
	L1_22 = L1_22.get_selected_index
	L1_22 = L1_22(L2_23)
	L2_23 = A0_21.list
	L3_24 = L2_23
	L2_23 = L2_23.get_selected_item
	L2_23 = L2_23(L3_24)
	L3_24 = A0_21._edit_mode
	L3_24 = L3_24(A0_21, L2_23, "Rename Mode")
	if L3_24 then
		A0_21._song_project:rename_mode({
			new_name = L3_24.name,
			old_name = L2_23.name
		})
		A0_21:_on_mode_selected(L3_24)
		A0_21:_redraw()
	end
end
function ModesBox._on_move_up(A0_25)
	A0_25._song_project:move_mode({
		old_index = A0_25.list:get_selected_index(),
		new_index = A0_25.list:get_selected_index() - 1
	})
	A0_25:_redraw()
end
function ModesBox._on_move_down(A0_26)
	A0_26._song_project:move_mode({
		old_index = A0_26.list:get_selected_index(),
		new_index = A0_26.list:get_selected_index() + 1
	})
	A0_26:_redraw()
end
function ModesBox._edit_mode(A0_27, A1_28, A2_29)
	local L3_30, L4_31
	L3_30 = A1_28.name
	L3_30 = L3_30 or ""
	L4_31 = nil
	while not false do
		L4_31 = EWS:get_text_from_user(A0_27._ews_parent, "Mode Name:", A2_29, L3_30, Vector3(-1, -1, 0), true)
		if L4_31 == "" then
			return nil
		end
		if L4_31 == "" then
			EWS:MessageDialog(A0_27._ews_parent, "Mode must have a name.", "Wrong Input", ""):show_modal()
		elseif A0_27._song_project:find_mode({name = L4_31}) then
			EWS:MessageDialog(A0_27._ews_parent, "Mode name '" .. L4_31 .. "' already exist!", "Wrong Input", ""):show_modal()
		elseif L4_31 == "stop" or L4_31 == "default" then
			EWS:MessageDialog(A0_27._ews_parent, "Mode name can not be 'stop' or 'default'.", "Wrong Input", ""):show_modal()
		else
		end
	end
	return {name = L4_31}
end
