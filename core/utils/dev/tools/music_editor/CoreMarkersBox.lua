core:module("CoreMarkersBox")
core:require_module("CoreKeywordArguments")
core:require_module("CoreSmartListCtrl")
core:require_module("CoreClass")
core:require_module("CoreEvent")
MarkersBox = MarkersBox or CoreClass.class()
function MarkersBox.init(A0_0, ...)
	local L2_2
	L2_2 = CoreKeywordArguments
	L2_2 = L2_2.KeywordArguments
	L2_2 = L2_2.new
	L2_2 = L2_2(L2_2, ...)
	A0_0._ews_parent = L2_2:mandatory_object("parent")
	A0_0._marker_edit_box = L2_2:mandatory_object("marker_edit")
	A0_0._modecrossfade_box = L2_2:mandatory_object("modecrossfade")
	A0_0._main_redraw_cb = L2_2:mandatory_function("main_redraw_cb")
	L2_2:assert_all_consumed()
	A0_0._song_project = nil
	A0_0.panel = EWS:Panel(A0_0._ews_parent, "", "")
	A0_0.list = CoreSmartListCtrl.SmartListCtrl:new({
		parent = A0_0.panel,
		header = {"name"},
		on_selected_cb = CoreEvent.callback(A0_0, A0_0, "_on_marker_selected"),
		on_deselected_cb = CoreEvent.callback(A0_0, A0_0, "_on_marker_deselected"),
		on_popup_menu_cb = CoreEvent.callback(A0_0, A0_0, "_on_popup_menu")
	})
	A0_0.box_sizer = EWS:StaticBoxSizer(A0_0.panel, "HORIZONTAL", "Markers")
	A0_0.box_sizer:add(A0_0.list.listctrl, 1, 0, "EXPAND")
	A0_0.panel:set_sizer(A0_0.box_sizer)
	A0_0.list.listctrl:set_enabled(false)
	A0_0._marker_edit_box:register_on_sample_update_cb(CoreEvent.callback(A0_0, A0_0, "_redraw"))
end
function MarkersBox.global_redraw(A0_3, A1_4)
	A0_3._song_project = A1_4 or assert(A0_3._song_project)
	if A0_3._mode_name then
		if not A0_3._song_project:find_mode({
			name = A0_3._mode_name
		}) then
			A0_3._mode_name = nil
		end
	end
	if A0_3._clip_name then
		if not A0_3._song_project:find_clip({
			name = A0_3._clip_name
		}) then
			A0_3._clip_name = nil
		end
	end
	A0_3.list.listctrl:set_enabled(true)
	A0_3.list:disable_callbacks()
	A0_3:_redraw()
	A0_3.list:enable_callbacks()
end
function MarkersBox.mode_selected(A0_5, A1_6)
	A0_5._mode_name = A1_6
	A0_5._clip_name = nil
	A0_5:_redraw()
end
function MarkersBox.mode_deselected(A0_7)
	A0_7._mode_name = nil
	A0_7._clip_name = nil
	A0_7:_redraw()
end
function MarkersBox.clip_selected(A0_8, A1_9)
	A0_8._clip_name = A1_9
	A0_8:_redraw()
end
function MarkersBox.clip_deselected(A0_10)
	A0_10._clip_name = nil
	A0_10:_redraw()
end
function MarkersBox._redraw(A0_11)
	local L1_12
	A0_11.list:clear_list()
	for 