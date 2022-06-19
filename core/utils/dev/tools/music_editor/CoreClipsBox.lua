core:module("CoreClipsBox")
core:require_module("CoreKeywordArguments")
core:require_module("CoreSmartListCtrl")
core:require_module("CoreClass")
core:require_module("CoreEvent")
ClipsBox = ClipsBox or CoreClass.class()
function ClipsBox.init(A0_0, ...)
	local L2_2
	L2_2 = CoreKeywordArguments
	L2_2 = L2_2.KeywordArguments
	L2_2 = L2_2.new
	L2_2 = L2_2(L2_2, ...)
	A0_0._ews_parent = L2_2:mandatory_object("parent")
	A0_0._markers_box = L2_2:mandatory_object("markers")
	A0_0._marker_edit_box = L2_2:mandatory_object("marker_edit")
	L2_2:assert_all_consumed()
	A0_0._song_project = nil
	A0_0._mode_name = nil
	A0_0.panel = EWS:Panel(A0_0._ews_parent, "", "")
	A0_0.list = CoreSmartListCtrl.SmartListCtrl:new({
		parent = A0_0.panel,
		header = {
			"name",
			"soundbank",
			"sound",
			"start",
			"stop"
		},
		static_item = {
			name = "(no filter -->)"
		},
		on_selected_cb = CoreEvent.callback(A0_0, A0_0, "_on_clip_selected"),
		on_static_selected_cb = CoreEvent.callback(A0_0, A0_0, "_on_static_selected"),
		on_popup_menu_cb = CoreEvent.callback(A0_0, A0_0, "_on_popup_menu")
	})
	A0_0.box_sizer = EWS:StaticBoxSizer(A0_0.panel, "HORIZONTAL", "Clips")
	A0_0.box_sizer:add(A0_0.list.listctrl, 1, 0, "EXPAND")
	A0_0.panel:set_sizer(A0_0.box_sizer)
	A0_0.list.listctrl:set_enabled(false)
end
function ClipsBox.global_redraw(A0_3, A1_4)
	A0_3._song_project = A1_4 or assert(A0_3._song_project)
	if A0_3._mode_name then
		if not A0_3._song_project:find_mode({
			name = A0_3._mode_name
		}) then
			A0_3._mode_name = nil
		end
	end
	A0_3.list.listctrl:set_enabled(true)
	A0_3.list:disable_callbacks()
	A0_3:_redraw()
	A0_3.list:enable_callbacks()
end
function ClipsBox.mode_selected(A0_5, A1_6)
	A0_5._mode_name = A1_6
	A0_5:_redraw()
end
function ClipsBox.mode_deselected(A0_7)
	A0_7._mode_name = nil
	A0_7:_redraw()
end
function ClipsBox._redraw(A0_8)
	local L1_9, L2_10, L3_11, L4_12, L5_13
	L1_9(L2_10)
	if L1_9 then
		L4_12 = A0_8._mode_name
		L3_11.mode_name = L4_12
		for L4_12 in L1_9(L2_10, L3_11) do
			L5_13 = A0_8._song_project
			L5_13 = L5_13.find_clip
			L5_13 = L5_13(L5_13, {
				name = L4_12.clip
			})
			A0_8.list:append_item(L5_13)
		end
	else
		for L4_12 in L1_9(L2_10) do
			L5_13 = A0_8.list
			L5_13 = L5_13.append_item
			L5_13(L5_13, L4_12)
		end
	end
end
function ClipsBox._on_clip_selected(A0_14, A1_15, A2_16)
	A0_14._markers_box:clip_selected(A1_15.name)
end
function ClipsBox._on_static_selected(A0_17)
	A0_17._markers_box:clip_deselected()
end
function ClipsBox._on_popup_menu(A0_18, A1_19, A2_20)
	local L3_21
	L3_21 = {}
	L3_21["Create new clip"] = CoreEvent.callback(A0_18, A0_18, "_on_create")
	if A0_18._mode_name then
		L3_21[string.format("Create and add new clip to mode '%s'", A0_18._mode_name)] = CoreEvent.callback(A0_18, A0_18, "_on_create_and_add")
		if A0_18._song_project:get_number_clips() > 0 then
			L3_21[string.format("Find and add existing clip to mode '%s'", A0_18._mode_name)] = CoreEvent.callback(A0_18, A0_18, "_on_find_and_add")
		end
	end
	if A2_20 == nil or A2_20 == -1 then
		return L3_21
	end
	if A0_18._mode_name then
		if not A0_18._song_project:mode_clip_is_referenced({
			mode_name = A0_18._mode_name,
			clip_name = A1_19.name
		}) then
			L3_21["Remove Clip From Mode"] = CoreEvent.callback(A0_18, A0_18, "_on_remove_from_mode")
		end
	elseif not A0_18._song_project:clip_is_referenced({
		name = A1_19.name
	}) then
		L3_21.Remove = CoreEvent.callback(A0_18, A0_18, "_on_remove")
	end
	L3_21.Modify = CoreEvent.callback(A0_18, A0_18, "_on_modify")
	if A0_18._mode_name then
		if A2_20 > 0 then
			L3_21["Move Up"] = CoreEvent.callback(A0_18, A0_18, "_on_move_up")
		end
		if A2_20 < A0_18.list:get_number_dynamic_items() - 1 then
			L3_21["Move Down"] = CoreEvent.callback(A0_18, A0_18, "_on_move_down")
		end
	end
	return L3_21
end
function ClipsBox._on_create_and_add(A0_22)
	if A0_22:_on_create() then
		A0_22._song_project:add_clip_to_mode({
			mode_name = A0_22._mode_name,
			clip_name = A0_22:_on_create().name
		})
	end
	A0_22:_redraw()
end
function ClipsBox._on_find_and_add(A0_23)
	local L1_24
	L1_24 = {}
	for 