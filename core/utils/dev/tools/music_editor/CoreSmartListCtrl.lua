core:module("CoreSmartListCtrl")
core:require_module("CoreKeywordArguments")
core:require_module("CoreClass")
core:require_module("CoreEvent")
if not SmartListCtrl then
	SmartListCtrl = CoreClass.class()
end
SmartListCtrl.init = function(l_1_0, ...)
	l_1_0.parent = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("parent")
	l_1_0.header = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("header")
	l_1_0._static_item = CoreKeywordArguments.KeywordArguments:new(...):optional_table("static_item")
	l_1_0._on_selected_cb = CoreKeywordArguments.KeywordArguments:new(...):optional_function("on_selected_cb")
	l_1_0._on_deselected_cb = CoreKeywordArguments.KeywordArguments:new(...):optional_function("on_deselected_cb")
	l_1_0._on_static_selected_cb = CoreKeywordArguments.KeywordArguments:new(...):optional_function("on_static_selected_cb")
	l_1_0._on_popup_menu_cb = CoreKeywordArguments.KeywordArguments:new(...):optional_function("on_popup_menu_cb")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_1_0._first_dynamic_index = 0
	if l_1_0._static_item then
		l_1_0._first_dynamic_index = 1
	end
	if #l_1_0.header == 1 then
		l_1_0.listctrl = EWS:ListCtrl(l_1_0.parent, "", "LC_REPORT,LC_SINGLE_SEL,LC_NO_HEADER")
	else
		local l_1_5, l_1_7 = , EWS:ListCtrl
		local l_1_6, l_1_8 = EWS, l_1_0.parent
		l_1_7 = l_1_7(l_1_6, l_1_8, "", "LC_REPORT,LC_SINGLE_SEL")
		l_1_0.listctrl = l_1_7
	end
	for i_0,i_1 in ipairs(l_1_0.header) do
		local l_1_2 = nil
		l_1_0.listctrl:append_column(i_1, "")
	end
	l_1_0.listctrl:connect("EVT_COMMAND_LIST_ITEM_SELECTED", CoreEvent.callback(l_1_0, l_1_0, "_on_select"))
	l_1_0.listctrl:connect("EVT_COMMAND_LIST_ITEM_DESELECTED", CoreEvent.callback(l_1_0, l_1_0, "_on_deselect"))
	l_1_0.listctrl:connect("EVT_RIGHT_UP", CoreEvent.callback(l_1_0, l_1_0, "_on_right_click"))
	l_1_0._supress_callbacks = false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SmartListCtrl.compare_items = function(l_2_0, l_2_1, l_2_2, l_2_3)
	local l_2_7, l_2_8, l_2_9, l_2_10 = nil
	if l_2_3 == nil then
		l_2_3 = l_2_0.header
	end
	for i_0,i_1 in ipairs(l_2_3) do
		if l_2_1[i_1] ~= l_2_2[i_1] then
			return false
		end
	end
	return true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SmartListCtrl.get_item = function(l_3_0, l_3_1)
	local l_3_7, l_3_8, l_3_9 = nil
	local l_3_2 = {}
	local l_3_3 = l_3_1 + l_3_0._first_dynamic_index
	for i_0,i_1 in ipairs(l_3_0.header) do
		l_3_2[i_1] = l_3_0.listctrl:get_item(l_3_3, i_0 - 1)
	end
	return l_3_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SmartListCtrl.get_selected_item = function(l_4_0)
	local l_4_1 = l_4_0.listctrl:selected_item()
	if l_4_1 >= 0 then
		local l_4_2 = l_4_1 - l_4_0._first_dynamic_index
		local l_4_3, l_4_4 = l_4_0:get_item, l_4_0
		local l_4_5 = l_4_2
		return l_4_3(l_4_4, l_4_5)
	end
end

SmartListCtrl.get_selected_index = function(l_5_0)
	local l_5_1 = l_5_0.listctrl:selected_item()
	if l_5_1 >= 0 then
		return l_5_1 - l_5_0._first_dynamic_index
	end
end

SmartListCtrl.get_number_dynamic_items = function(l_6_0)
	return l_6_0.listctrl:item_count() - l_6_0._first_dynamic_index
end

SmartListCtrl.has_item = function(l_7_0, l_7_1, l_7_2)
	for l_7_6 = 0, l_7_0.listctrl:item_count() - 1 do
		local l_7_7 = l_7_6 - l_7_0._first_dynamic_index
		if l_7_0:compare_items(l_7_1, l_7_0:get_item(l_7_7), l_7_2) then
			return true
		end
	end
	return false
end

SmartListCtrl.set_selected = function(l_8_0, l_8_1)
	local l_8_2 = l_8_1 + l_8_0._first_dynamic_index
	l_8_0.listctrl:set_item_selected(l_8_2, true)
end

SmartListCtrl.modify_item = function(l_9_0, l_9_1, l_9_2)
	local l_9_6, l_9_7, l_9_8, l_9_9 = nil
	for i_0,i_1 in ipairs(l_9_0.header) do
		if l_9_1[i_1] ~= nil then
			l_9_0.listctrl:set_item(l_9_2 + l_9_0._first_dynamic_index, l_9_10 - 1, l_9_1[i_1])
		end
	end
end

SmartListCtrl.append_item = function(l_10_0, l_10_1)
	local l_10_2 = l_10_0.listctrl:append_item(l_10_1[l_10_0.header[1]])
	for l_10_6 = 2, #l_10_0.header do
		l_10_0.listctrl:set_item(l_10_2, l_10_6 - 1, l_10_1[l_10_0.header[l_10_6]])
	end
	return l_10_2 - l_10_0._first_dynamic_index
end

SmartListCtrl.insert_item = function(l_11_0, l_11_1, l_11_2)
	local l_11_3 = l_11_2 + l_11_0._first_dynamic_index
	l_11_0.listctrl:insert_item(l_11_3, l_11_1[l_11_0.header[1]])
	for l_11_7 = 2, #l_11_0.header do
		l_11_0.listctrl:set_item(l_11_3, l_11_7 - 1, l_11_1[l_11_0.header[l_11_7]])
	end
end

SmartListCtrl.move_item = function(l_12_0, l_12_1, l_12_2)
	local l_12_3 = l_12_0:get_item(l_12_1)
	l_12_0:delete_item(l_12_1)
	l_12_0:insert_item(l_12_3, l_12_2)
end

SmartListCtrl.delete_item = function(l_13_0, l_13_1)
	local l_13_2 = l_13_1 + l_13_0._first_dynamic_index
	l_13_0.listctrl:delete_item(l_13_2)
end

SmartListCtrl.clear_list = function(l_14_0)
	l_14_0.listctrl:delete_all_items()
	if l_14_0._static_item then
		l_14_0:append_item(l_14_0._static_item)
	end
end

SmartListCtrl.enable_callbacks = function(l_15_0)
	l_15_0._supress_callbacks = false
end

SmartListCtrl.disable_callbacks = function(l_16_0)
	l_16_0._supress_callbacks = true
end

SmartListCtrl.autosize = function(l_17_0)
	for l_17_4 = 1, #l_17_0.header do
		l_17_0.listctrl:autosize_column(l_17_4 - 1)
	end
end

SmartListCtrl._on_right_click = function(l_18_0)
	if l_18_0._supress_callbacks then
		return 
	end
	if l_18_0._on_popup_menu_cb then
		local l_18_7, l_18_8 = l_18_0._on_popup_menu_cb, l_18_0:get_selected_item()
		l_18_7 = l_18_7(l_18_8, l_18_0:get_selected_index())
		local l_18_1 = nil
		l_18_8 = EWS
		l_18_8, l_18_1 = l_18_8:Menu, l_18_8
		l_18_8 = l_18_8(l_18_1, "")
		local l_18_2 = nil
		local l_18_3 = nil
		l_18_2 = pairs
		l_18_3 = l_18_7
		l_18_2 = l_18_2(l_18_3)
		for i_0,i_1 in l_18_2 do
			table.insert(l_18_1, l_18_5)
		end
		table.sort(l_18_1)
		for i_0,i_1 in ipairs(l_18_1) do
			l_18_8:append_item(i_1, i_1, "")
			l_18_8:connect(i_1, "EVT_COMMAND_MENU_SELECTED", l_18_7[i_1], "")
		end
		l_18_0.listctrl:popup_menu(l_18_8, Vector3(-1, -1, 0))
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

SmartListCtrl._on_select = function(l_19_0)
	if l_19_0._supress_callbacks then
		return 
	end
	local l_19_1 = l_19_0.listctrl:selected_item()
	if l_19_0._static_item and l_19_1 == 0 and l_19_0._on_static_selected_cb then
		l_19_0._on_static_selected_cb()
	end
	do return end
	if l_19_0._on_selected_cb then
		local l_19_2 = l_19_1 - l_19_0._first_dynamic_index
		l_19_0._on_selected_cb(l_19_0:get_item(l_19_2), l_19_2)
	end
end

SmartListCtrl._on_deselect = function(l_20_0)
	if l_20_0._supress_callbacks then
		return 
	end
	if l_20_0._on_deselected_cb then
		l_20_0._on_deselected_cb()
	end
end


