core:module("CoreSmartListCtrl")
core:require_module("CoreKeywordArguments")
core:require_module("CoreClass")
core:require_module("CoreEvent")
SmartListCtrl = SmartListCtrl or CoreClass.class()
function SmartListCtrl.init(A0_0, ...)
	local L2_2, L3_3, L4_4, L5_5, L6_6, L7_7
	L2_2 = CoreKeywordArguments
	L2_2 = L2_2.KeywordArguments
	L2_2 = L2_2.new
	L7_7 = ...
	L2_2 = L2_2(L3_3, L4_4, L5_5, L6_6, L7_7, ...)
	A0_0.parent = L3_3
	A0_0.header = L3_3
	A0_0._static_item = L3_3
	A0_0._on_selected_cb = L3_3
	A0_0._on_deselected_cb = L3_3
	A0_0._on_static_selected_cb = L3_3
	A0_0._on_popup_menu_cb = L3_3
	L3_3(L4_4)
	A0_0._first_dynamic_index = 0
	if L3_3 then
		A0_0._first_dynamic_index = 1
	end
	if L3_3 == 1 then
		L6_6 = ""
		L7_7 = "LC_REPORT,LC_SINGLE_SEL,LC_NO_HEADER"
		A0_0.listctrl = L3_3
	else
		L6_6 = ""
		L7_7 = "LC_REPORT,LC_SINGLE_SEL"
		A0_0.listctrl = L3_3
	end
	for L6_6, L7_7 in L3_3(L4_4) do
		A0_0.listctrl:append_column(L7_7, "")
	end
	L6_6 = CoreEvent
	L6_6 = L6_6.callback
	L7_7 = A0_0
	L7_7 = L6_6(L7_7, A0_0, "_on_select")
	L3_3(L4_4, L5_5, L6_6, L7_7, L6_6(L7_7, A0_0, "_on_select"))
	L6_6 = CoreEvent
	L6_6 = L6_6.callback
	L7_7 = A0_0
	L7_7 = L6_6(L7_7, A0_0, "_on_deselect")
	L3_3(L4_4, L5_5, L6_6, L7_7, L6_6(L7_7, A0_0, "_on_deselect"))
	L6_6 = CoreEvent
	L6_6 = L6_6.callback
	L7_7 = A0_0
	L7_7 = L6_6(L7_7, A0_0, "_on_right_click")
	L3_3(L4_4, L5_5, L6_6, L7_7, L6_6(L7_7, A0_0, "_on_right_click"))
	A0_0._supress_callbacks = false
end
function SmartListCtrl.compare_items(A0_8, A1_9, A2_10, A3_11)
	if A3_11 == nil then
		A3_11 = A0_8.header
	end
	for 