core:module("CoreLuaProfilerGridBox")
core:require_module("CoreClass")
core:require_module("CoreEvent")
core:require_module("CoreKeywordArguments")
local l_0_0 = CoreKeywordArguments.parse_kwargs
local l_0_1 = Vector3(1, 1, 1)
local l_0_2 = Vector3(0.8, 0.8, 1)
local l_0_3 = 0
local l_0_4 = 1
local l_0_5 = 2
local l_0_6 = l_0_3
if not LuaProfilerGridBox then
	LuaProfilerGridBox = CoreClass.class()
end
LuaProfilerGridBox.init = function(l_1_0, ...)
	-- upvalues: l_0_6
	l_1_0._ews_parent = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("parent")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_1_0._lpd = nil
	l_1_0.panel = EWS:Panel(l_1_0._ews_parent, "", "")
	l_1_0._listctrl = EWS:ListCtrl(l_1_0.panel, "", "LC_REPORT,LC_SINGLE_SEL")
	l_1_0._item2fnid = {}
	local l_1_2 = nil
	l_1_0._baseheader = {"Func", "File", "Line", "Total time", "Local time", "Children time", "No. Calls", "No. Sub Calls"}
	l_1_0._sortcolumn = 1
	l_1_0._sortreverse = false
	l_1_0._displayformat = l_0_6
	l_1_0._listctrl:connect("EVT_COMMAND_LIST_ITEM_SELECTED", CoreEvent.callback(l_1_0, l_1_0, "_on_select"))
	l_1_0._listctrl:connect("EVT_COMMAND_LIST_ITEM_ACTIVATED", CoreEvent.callback(l_1_0, l_1_0, "_on_activate"))
	l_1_0._listctrl:connect("EVT_COMMAND_LIST_COL_CLICK", CoreEvent.callback(l_1_0, l_1_0, "_on_column"))
	l_1_0.box_sizer = EWS:BoxSizer("HORIZONTAL")
	l_1_0.box_sizer:add(l_1_0._listctrl, 1, 0, "EXPAND")
	l_1_0.panel:set_sizer(l_1_0.box_sizer)
end

LuaProfilerGridBox.set_treeview = function(l_2_0, ...)
	-- upvalues: l_0_0
	local l_2_2 = l_0_0
	l_2_2 = l_2_2({...}, "table:treeview")
	l_2_0._treeview = l_2_2
end

LuaProfilerGridBox.destroy = function(l_3_0)
	l_3_0._lpd = nil
	l_3_0._item2fnid = {}
	l_3_0._listctrl:clear_all()
	l_3_0._listctrl:destroy()
	l_3_0._listctrl = nil
	l_3_0._treeview = nil
end

LuaProfilerGridBox.set_profilerdata = function(l_4_0, ...)
	-- upvalues: l_0_0
	local l_4_5, l_4_6, l_4_16 = nil
	local l_4_2 = l_0_0({...}, "userdata:lpd", "number:displayformat")
	l_4_0._displayformat = {...}
	l_4_0._lpd = l_4_2
	l_4_0._highlightedfuncnode = nil
	l_4_0._item2fnid, l_4_2 = l_4_2, {}
	l_4_2 = 0
	for l_4_12 = l_4_2, l_4_0._lpd:numfuncnodes() - 1 do
		local l_4_12 = nil
		l_4_12 = table
		l_4_12 = l_4_12.insert
		local l_4_11, l_4_13 = nil
		l_4_11 = l_4_0._item2fnid
		l_4_13 = l_4_10
		l_4_12(l_4_11, l_4_13)
	end
	l_4_0._listctrl:clear_all()
	for i_0,i_1 in ipairs(l_4_0._baseheader) do
		l_4_0._listctrl:append_column(i_1, "")
	end
	for i = 0, l_4_0._lpd:numheaders() - 1 do
		local l_4_14 = nil
		l_4_14 = l_4_0._lpd
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_4_15 = nil
		l_4_15 = l_4_0._listctrl
		l_4_15(l_4_15, "Diff " .. string.capitalize(l_4_14), "")
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_4_15(l_4_15, "Peak " .. string.capitalize(l_4_14), "")
	end
	l_4_0:_redraw()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

LuaProfilerGridBox.set_displayformat = function(l_5_0, ...)
	-- upvalues: l_0_0 , l_0_4
	local l_5_2 = l_0_0
	local l_5_5, l_5_6 = {}, ...
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_5_2 ~= nil then
		for i_0,i_1 in l_5_5 do
			if l_5_0._displayformat ~= l_0_4 then
				l_5_0._listctrl:set_item(l_5_4 - 1, 3, string.format("%6.3f %%", 100 * l_5_0._lpd:fn_total_time(i_1) / l_5_2))
				l_5_0._listctrl:set_item(l_5_4 - 1, 4, string.format("%6.3f %%", 100 * l_5_0._lpd:fn_local_time(i_1) / l_5_2))
				l_5_0._listctrl:set_item(l_5_4 - 1, 5, string.format("%6.3f %%", 100 * l_5_0._lpd:fn_children_time(i_1) / l_5_2))
			else
				l_5_0._listctrl:set_item(l_5_4 - 1, 3, string.format("%8.3f ms", 1000 * l_5_0._lpd:fn_total_time(i_1)))
				l_5_0._listctrl:set_item(l_5_4 - 1, 4, string.format("%8.3f ms", 1000 * l_5_0._lpd:fn_local_time(i_1)))
				l_5_0._listctrl:set_item(l_5_4 - 1, 5, string.format("%8.3f ms", 1000 * l_5_0._lpd:fn_children_time(i_1)))
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

LuaProfilerGridBox._redraw = function(l_6_0)
	-- upvalues: l_0_4
	local l_6_5, l_6_6, l_6_7, l_6_8, l_6_9, l_6_10, l_6_11, l_6_12, l_6_13, l_6_14, l_6_15, l_6_16, l_6_17, l_6_18, l_6_19, l_6_20, l_6_21, l_6_22, l_6_23, l_6_24, l_6_25, l_6_26, l_6_27, l_6_28, l_6_29, l_6_30, l_6_31, l_6_32, l_6_33, l_6_34, l_6_35, l_6_36, l_6_37, l_6_38, l_6_39, l_6_40, l_6_41, l_6_42, l_6_43, l_6_44, l_6_45, l_6_46, l_6_47, l_6_48, l_6_49, l_6_50, l_6_51, l_6_52, l_6_53, l_6_54, l_6_55, l_6_56, l_6_57, l_6_58, l_6_59, l_6_60, l_6_61 = nil
	if l_6_0._lpd ~= nil then
		l_6_0:_sort_funcnodes()
		l_6_0._listctrl:delete_all_items()
		local l_6_1 = l_6_0._lpd:frametime()
		for i_0,i_1 in ipairs(l_6_0._item2fnid) do
			l_6_0._listctrl:insert_item(i_0 - 1, l_6_0._lpd:fn_func(i_1))
			l_6_0._listctrl:set_item(i_0 - 1, 1, l_6_0._lpd:fn_file(i_1))
			l_6_0._listctrl:set_item(i_0 - 1, 2, l_6_0._lpd:fn_line(i_1))
			if l_6_0._displayformat ~= l_0_4 then
				l_6_0._listctrl:set_item(i_0 - 1, 3, string.format("%6.3f %%", 100 * l_6_0._lpd:fn_total_time(i_1) / l_6_1))
				l_6_0._listctrl:set_item(i_0 - 1, 4, string.format("%6.3f %%", 100 * l_6_0._lpd:fn_local_time(i_1) / l_6_1))
				l_6_0._listctrl:set_item(i_0 - 1, 5, string.format("%6.3f %%", 100 * l_6_0._lpd:fn_children_time(i_1) / l_6_1))
			else
				l_6_0._listctrl:set_item(i_0 - 1, 3, string.format("%8.3f ms", 1000 * l_6_0._lpd:fn_total_time(i_1)))
				l_6_0._listctrl:set_item(i_0 - 1, 4, string.format("%8.3f ms", 1000 * l_6_0._lpd:fn_local_time(i_1)))
				l_6_0._listctrl:set_item(i_0 - 1, 5, string.format("%8.3f ms", 1000 * l_6_0._lpd:fn_children_time(i_1)))
			end
			l_6_0._listctrl:set_item(i_0 - 1, 6, l_6_0._lpd:fn_num_calls(i_1))
			l_6_0._listctrl:set_item(i_0 - 1, 7, l_6_0._lpd:fn_num_sub_calls(i_1))
			for l_6_66 = 0, l_6_0._lpd:numheaders() - 1 do
				local l_6_64 = 8
				 -- DECOMPILER ERROR: Confused about usage of registers!

				l_6_0._listctrl:set_item(l_6_62 - 1, l_6_64, string.format("%s", l_6_0._lpd:fn_diff(l_6_63, l_6_0._lpd:fn_num_sub_calls(i_1))))
				 -- DECOMPILER ERROR: Confused about usage of registers!

				l_6_0._listctrl:set_item(l_6_62 - 1, l_6_64 + 1, string.format("%s", l_6_0._lpd:fn_peak(l_6_63, l_6_0._lpd:fn_num_sub_calls(i_1))))
				l_6_64 = l_6_64 + 2
			end
		end
	if l_6_0._highlightedfuncnode then
		end
		l_6_0:_highlight(l_6_0._highlightedfuncnode)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

LuaProfilerGridBox._sort_funcnodes = function(l_7_0)
	local l_7_1 = nil
	if l_7_0._sortcolumn == 1 then
		l_7_1 = function(l_8_0)
		-- upvalues: l_7_0
		local l_8_1 = string.lower
		local l_8_2, l_8_3, l_8_4 = l_7_0._lpd:fn_func(l_8_0), .end
		return l_8_1(l_8_2, l_8_3, l_8_4)
  end
	elseif l_7_0._sortcolumn == 2 then
		l_7_1 = function(l_9_0)
		-- upvalues: l_7_0
		local l_9_1 = string.lower
		local l_9_2, l_9_3, l_9_4 = l_7_0._lpd:fn_file(l_9_0), .end
		return l_9_1(l_9_2, l_9_3, l_9_4)
  end
	elseif l_7_0._sortcolumn == 3 then
		l_7_1 = function(l_10_0)
		-- upvalues: l_7_0
		local l_10_1 = tonumber
		local l_10_2, l_10_3, l_10_4 = l_7_0._lpd:fn_line(l_10_0), .end
		return l_10_1(l_10_2, l_10_3, l_10_4)
  end
	elseif l_7_0._sortcolumn == 4 then
		l_7_1 = function(l_11_0)
		-- upvalues: l_7_0
		local l_11_1, l_11_2 = l_7_0._lpd:fn_total_time, l_7_0._lpd
		local l_11_3 = l_11_0
		return l_11_1(l_11_2, l_11_3)
  end
	elseif l_7_0._sortcolumn == 5 then
		l_7_1 = function(l_12_0)
		-- upvalues: l_7_0
		local l_12_1, l_12_2 = l_7_0._lpd:fn_local_time, l_7_0._lpd
		local l_12_3 = l_12_0
		return l_12_1(l_12_2, l_12_3)
  end
	elseif l_7_0._sortcolumn == 6 then
		l_7_1 = function(l_13_0)
		-- upvalues: l_7_0
		local l_13_1, l_13_2 = l_7_0._lpd:fn_children_time, l_7_0._lpd
		local l_13_3 = l_13_0
		return l_13_1(l_13_2, l_13_3)
  end
	elseif l_7_0._sortcolumn == 7 then
		l_7_1 = function(l_14_0)
		-- upvalues: l_7_0
		local l_14_1, l_14_2 = l_7_0._lpd:fn_num_calls, l_7_0._lpd
		local l_14_3 = l_14_0
		return l_14_1(l_14_2, l_14_3)
  end
	elseif l_7_0._sortcolumn == 8 then
		l_7_1 = function(l_15_0)
		-- upvalues: l_7_0
		local l_15_1, l_15_2 = l_7_0._lpd:fn_num_sub_calls, l_7_0._lpd
		local l_15_3 = l_15_0
		return l_15_1(l_15_2, l_15_3)
  end
	else
		local l_7_2 = nil
		do
			if l_7_2 % 2 == 0 then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

		end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	table.sort(math.floor((l_7_0._sortcolumn - 9) / 2), sort)
end

LuaProfilerGridBox.deselect_and_highlight = function(l_8_0, ...)
	-- upvalues: l_0_0
	local l_8_2 = l_0_0
	l_8_2 = l_8_2({...}, "number:fnid")
	l_8_0._listctrl:set_item_selected(l_8_0._listctrl:selected_item(), false)
	l_8_0:_highlight(l_8_2)
end

LuaProfilerGridBox._highlight = function(l_9_0, l_9_1)
	-- upvalues: l_0_2 , l_0_1
	local l_9_5, l_9_6, l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_12 = nil
	l_9_0._highlightedfuncnode = l_9_1
	for i_0,i_1 in ipairs(l_9_0._item2fnid) do
		if i_1 == l_9_1 then
			l_9_0._listctrl:set_item_background_colour(i_0 - 1, l_0_2)
		else
			l_9_0._listctrl:set_item_background_colour(i_0 - 1, l_0_1)
		end
	end
end

LuaProfilerGridBox._on_select = function(l_10_0)
	local l_10_1 = l_10_0._listctrl:selected_item()
	local l_10_2, l_10_3 = l_10_0._treeview:deselect_and_highlight, l_10_0._treeview
	local l_10_4 = {}
	l_10_4.fnid = l_10_0._item2fnid[l_10_1 + 1]
	l_10_2(l_10_3, l_10_4)
	l_10_2, l_10_3 = l_10_0:_highlight, l_10_0
	l_10_4 = l_10_0._item2fnid
	l_10_4 = l_10_4[l_10_1 + 1]
	l_10_2(l_10_3, l_10_4)
end

LuaProfilerGridBox._on_activate = function(l_11_0)
	local l_11_1 = l_11_0._listctrl:selected_item()
	local l_11_2, l_11_3 = l_11_0._treeview:deselect_and_expand, l_11_0._treeview
	local l_11_4 = {}
	l_11_4.fnid = l_11_0._item2fnid[l_11_1 + 1]
	l_11_2(l_11_3, l_11_4)
end

LuaProfilerGridBox._on_column = function(l_12_0, l_12_1, l_12_2)
	local l_12_3 = l_12_2:get_column() + 1
	if l_12_3 == l_12_0._sortcolumn then
		l_12_0._sortreverse = not l_12_0._sortreverse
	else
		l_12_0._sortcolumn = l_12_3
		l_12_0._sortreverse = false
	end
	l_12_0:_redraw()
end


