local L0_0, L1_1, L2_2, L3_3
L0_0 = core
L1_1 = L0_0
L0_0 = L0_0.module
L2_2 = "CoreLuaProfilerGridBox"
L0_0(L1_1, L2_2)
L0_0 = core
L1_1 = L0_0
L0_0 = L0_0.require_module
L2_2 = "CoreClass"
L0_0(L1_1, L2_2)
L0_0 = core
L1_1 = L0_0
L0_0 = L0_0.require_module
L2_2 = "CoreEvent"
L0_0(L1_1, L2_2)
L0_0 = core
L1_1 = L0_0
L0_0 = L0_0.require_module
L2_2 = "CoreKeywordArguments"
L0_0(L1_1, L2_2)
L0_0 = CoreKeywordArguments
L0_0 = L0_0.parse_kwargs
L1_1 = Vector3
L2_2 = 1
L3_3 = 1
L1_1 = L1_1(L2_2, L3_3, 1)
L2_2 = Vector3
L3_3 = 0.8
L2_2 = L2_2(L3_3, 0.8, 1)
L3_3 = 0
LuaProfilerGridBox = LuaProfilerGridBox or CoreClass.class()
function LuaProfilerGridBox.init(A0_4, ...)
	local L2_6
	L2_6 = CoreKeywordArguments
	L2_6 = L2_6.KeywordArguments
	L2_6 = L2_6.new
	L2_6 = L2_6(L2_6, ...)
	A0_4._ews_parent = L2_6:mandatory_object("parent")
	L2_6:assert_all_consumed()
	A0_4._lpd = nil
	A0_4.panel = EWS:Panel(A0_4._ews_parent, "", "")
	A0_4._listctrl = EWS:ListCtrl(A0_4.panel, "", "LC_REPORT,LC_SINGLE_SEL")
	A0_4._item2fnid = {}
	A0_4._baseheader = {
		"Func",
		"File",
		"Line",
		"Total time",
		"Local time",
		"Children time",
		"No. Calls",
		"No. Sub Calls"
	}
	A0_4._sortcolumn = 1
	A0_4._sortreverse = false
	A0_4._displayformat = _UPVALUE0_
	A0_4._listctrl:connect("EVT_COMMAND_LIST_ITEM_SELECTED", CoreEvent.callback(A0_4, A0_4, "_on_select"))
	A0_4._listctrl:connect("EVT_COMMAND_LIST_ITEM_ACTIVATED", CoreEvent.callback(A0_4, A0_4, "_on_activate"))
	A0_4._listctrl:connect("EVT_COMMAND_LIST_COL_CLICK", CoreEvent.callback(A0_4, A0_4, "_on_column"))
	A0_4.box_sizer = EWS:BoxSizer("HORIZONTAL")
	A0_4.box_sizer:add(A0_4._listctrl, 1, 0, "EXPAND")
	A0_4.panel:set_sizer(A0_4.box_sizer)
end
function LuaProfilerGridBox.set_treeview(A0_7, ...)
	A0_7._treeview = _UPVALUE0_({
		...
	}, "table:treeview")
end
function LuaProfilerGridBox.destroy(A0_9)
	A0_9._lpd = nil
	A0_9._item2fnid = {}
	A0_9._listctrl:clear_all()
	A0_9._listctrl:destroy()
	A0_9._listctrl = nil
	A0_9._treeview = nil
end
function LuaProfilerGridBox.set_profilerdata(A0_10, ...)
	local L2_12, L3_13, L4_14, L5_15, L6_16
	L6_16 = ...
	;({
		[4] = ...
	})[1] = L4_14
	;({
		[4] = ...
	})[2] = L5_15
	;({
		[4] = ...
	})[3] = L6_16
	L5_15 = "number:displayformat"
	A0_10._displayformat = L3_13
	A0_10._lpd = L2_12
	A0_10._highlightedfuncnode = nil
	A0_10._item2fnid = L2_12
	for L5_15 = 0, L3_13 - 1 do
		L6_16 = table
		L6_16 = L6_16.insert
		L6_16(A0_10._item2fnid, L5_15)
	end
	L2_12(L3_13)
	for L5_15, L6_16 in L2_12(L3_13) do
		A0_10._listctrl:append_column(L6_16, "")
	end
	for L5_15 = 0, L3_13 - 1 do
		L6_16 = A0_10._lpd
		L6_16 = L6_16.headername
		L6_16 = L6_16(L6_16, L5_15)
		A0_10._listctrl:append_column("Diff " .. string.capitalize(L6_16), "")
		A0_10._listctrl:append_column("Peak " .. string.capitalize(L6_16), "")
	end
	L2_12(L3_13)
end
function LuaProfilerGridBox.set_displayformat(A0_17, ...)
	local L2_19, L3_20, L4_21, L5_22, L6_23, L7_24
	L2_19 = _UPVALUE0_
	L7_24 = ...
	;({
		[5] = ...
	})[1] = L4_21
	;({
		[5] = ...
	})[2] = L5_22
	;({
		[5] = ...
	})[3] = L6_23
	;({
		[5] = ...
	})[4] = L7_24
	L2_19 = L2_19(L3_20, L4_21)
	A0_17._displayformat = L2_19
	L2_19 = A0_17._lpd
	if L2_19 ~= nil then
		L2_19 = A0_17._lpd
		L2_19 = L2_19.frametime
		L2_19 = L2_19(L3_20)
		for L6_23, L7_24 in L3_20(L4_21) do
			if A0_17._displayformat ~= _UPVALUE1_ then
				A0_17._listctrl:set_item(L6_23 - 1, 3, string.format("%6.3f %%", 100 * A0_17._lpd:fn_total_time(L7_24) / L2_19))
				A0_17._listctrl:set_item(L6_23 - 1, 4, string.format("%6.3f %%", 100 * A0_17._lpd:fn_local_time(L7_24) / L2_19))
				A0_17._listctrl:set_item(L6_23 - 1, 5, string.format("%6.3f %%", 100 * A0_17._lpd:fn_children_time(L7_24) / L2_19))
			else
				A0_17._listctrl:set_item(L6_23 - 1, 3, string.format("%8.3f ms", 1000 * A0_17._lpd:fn_total_time(L7_24)))
				A0_17._listctrl:set_item(L6_23 - 1, 4, string.format("%8.3f ms", 1000 * A0_17._lpd:fn_local_time(L7_24)))
				A0_17._listctrl:set_item(L6_23 - 1, 5, string.format("%8.3f ms", 1000 * A0_17._lpd:fn_children_time(L7_24)))
			end
		end
	end
end
function LuaProfilerGridBox._redraw(A0_25)
	local L1_26, L2_27, L3_28, L4_29, L5_30, L6_31, L7_32, L8_33, L9_34, L10_35, L11_36
	L1_26 = A0_25._lpd
	if L1_26 ~= nil then
		L1_26 = A0_25._sort_funcnodes
		L1_26(L2_27)
		L1_26 = A0_25._listctrl
		L1_26 = L1_26.delete_all_items
		L1_26(L2_27)
		L1_26 = A0_25._lpd
		L1_26 = L1_26.frametime
		L1_26 = L1_26(L2_27)
		for L5_30, L6_31 in L2_27(L3_28) do
			L7_32 = A0_25._listctrl
			L7_32 = L7_32.insert_item
			L11_36 = L10_35
			L11_36 = L10_35(L11_36, L6_31)
			L7_32(L8_33, L9_34, L10_35, L11_36, L10_35(L11_36, L6_31))
			L7_32 = A0_25._listctrl
			L7_32 = L7_32.set_item
			L11_36 = A0_25._lpd
			L11_36 = L11_36.fn_file
			L11_36 = L11_36(L11_36, L6_31)
			L7_32(L8_33, L9_34, L10_35, L11_36, L11_36(L11_36, L6_31))
			L7_32 = A0_25._listctrl
			L7_32 = L7_32.set_item
			L11_36 = A0_25._lpd
			L11_36 = L11_36.fn_line
			L11_36 = L11_36(L11_36, L6_31)
			L7_32(L8_33, L9_34, L10_35, L11_36, L11_36(L11_36, L6_31))
			L7_32 = A0_25._displayformat
			if L7_32 ~= L8_33 then
				L7_32 = A0_25._listctrl
				L7_32 = L7_32.set_item
				L11_36 = string
				L11_36 = L11_36.format
				L11_36 = L11_36("%6.3f %%", 100 * A0_25._lpd:fn_total_time(L6_31) / L1_26)
				L7_32(L8_33, L9_34, L10_35, L11_36, L11_36("%6.3f %%", 100 * A0_25._lpd:fn_total_time(L6_31) / L1_26))
				L7_32 = A0_25._listctrl
				L7_32 = L7_32.set_item
				L11_36 = string
				L11_36 = L11_36.format
				L11_36 = L11_36("%6.3f %%", 100 * A0_25._lpd:fn_local_time(L6_31) / L1_26)
				L7_32(L8_33, L9_34, L10_35, L11_36, L11_36("%6.3f %%", 100 * A0_25._lpd:fn_local_time(L6_31) / L1_26))
				L7_32 = A0_25._listctrl
				L7_32 = L7_32.set_item
				L11_36 = string
				L11_36 = L11_36.format
				L11_36 = L11_36("%6.3f %%", 100 * A0_25._lpd:fn_children_time(L6_31) / L1_26)
				L7_32(L8_33, L9_34, L10_35, L11_36, L11_36("%6.3f %%", 100 * A0_25._lpd:fn_children_time(L6_31) / L1_26))
			else
				L7_32 = A0_25._listctrl
				L7_32 = L7_32.set_item
				L11_36 = string
				L11_36 = L11_36.format
				L11_36 = L11_36("%8.3f ms", 1000 * A0_25._lpd:fn_total_time(L6_31))
				L7_32(L8_33, L9_34, L10_35, L11_36, L11_36("%8.3f ms", 1000 * A0_25._lpd:fn_total_time(L6_31)))
				L7_32 = A0_25._listctrl
				L7_32 = L7_32.set_item
				L11_36 = string
				L11_36 = L11_36.format
				L11_36 = L11_36("%8.3f ms", 1000 * A0_25._lpd:fn_local_time(L6_31))
				L7_32(L8_33, L9_34, L10_35, L11_36, L11_36("%8.3f ms", 1000 * A0_25._lpd:fn_local_time(L6_31)))
				L7_32 = A0_25._listctrl
				L7_32 = L7_32.set_item
				L11_36 = string
				L11_36 = L11_36.format
				L11_36 = L11_36("%8.3f ms", 1000 * A0_25._lpd:fn_children_time(L6_31))
				L7_32(L8_33, L9_34, L10_35, L11_36, L11_36("%8.3f ms", 1000 * A0_25._lpd:fn_children_time(L6_31)))
			end
			L7_32 = A0_25._listctrl
			L7_32 = L7_32.set_item
			L11_36 = A0_25._lpd
			L11_36 = L11_36.fn_num_calls
			L11_36 = L11_36(L11_36, L6_31)
			L7_32(L8_33, L9_34, L10_35, L11_36, L11_36(L11_36, L6_31))
			L7_32 = A0_25._listctrl
			L7_32 = L7_32.set_item
			L11_36 = A0_25._lpd
			L11_36 = L11_36.fn_num_sub_calls
			L11_36 = L11_36(L11_36, L6_31)
			L7_32(L8_33, L9_34, L10_35, L11_36, L11_36(L11_36, L6_31))
			L7_32 = 8
			for L11_36 = 0, L9_34 - 1 do
				A0_25._listctrl:set_item(L5_30 - 1, L7_32, string.format("%s", A0_25._lpd:fn_diff(L6_31, L11_36)))
				A0_25._listctrl:set_item(L5_30 - 1, L7_32 + 1, string.format("%s", A0_25._lpd:fn_peak(L6_31, L11_36)))
				L7_32 = L7_32 + 2
			end
		end
		if L2_27 then
			L2_27(L3_28, L4_29)
		end
	end
end
function LuaProfilerGridBox._sort_funcnodes(A0_37)
	if A0_37._sortcolumn == 1 then
	elseif A0_37._sortcolumn == 2 then
	elseif A0_37._sortcolumn == 3 then
	elseif A0_37._sortcolumn == 4 then
	elseif A0_37._sortcolumn == 5 then
	elseif A0_37._sortcolumn == 6 then
	elseif A0_37._sortcolumn == 7 then
	elseif A0_37._sortcolumn == 8 then
	elseif (A0_37._sortcolumn - 9) % 2 == 0 then
	else
	end
	function sort(A0_38, A1_39)
		if _UPVALUE0_._sortreverse then
			return _UPVALUE1_(A0_38) > _UPVALUE1_(A1_39)
		else
			return _UPVALUE1_(A0_38) < _UPVALUE1_(A1_39)
		end
	end
	table.sort(A0_37._item2fnid, sort)
end
function LuaProfilerGridBox.deselect_and_highlight(A0_40, ...)
	local L2_42
	L2_42 = _UPVALUE0_
	L2_42 = L2_42({
		...
	}, "number:fnid")
	A0_40._listctrl:set_item_selected(A0_40._listctrl:selected_item(), false)
	A0_40:_highlight(L2_42)
end
function LuaProfilerGridBox._highlight(A0_43, A1_44)
	A0_43._highlightedfuncnode = A1_44
	for 