local L0_0, L1_1, L2_2, L3_3
L0_0 = core
L1_1 = L0_0
L0_0 = L0_0.module
L2_2 = "CoreLuaProfilerTreeBox"
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
LuaProfilerTreeBox = LuaProfilerTreeBox or CoreClass.class()
function LuaProfilerTreeBox.init(A0_4, ...)
	local L2_6
	L2_6 = CoreKeywordArguments
	L2_6 = L2_6.KeywordArguments
	L2_6 = L2_6.new
	L2_6 = L2_6(L2_6, ...)
	A0_4._ews_parent = L2_6:mandatory_object("parent")
	L2_6:assert_all_consumed()
	A0_4._lpd = nil
	A0_4.panel = EWS:Panel(A0_4._ews_parent, "", "")
	A0_4._treectrl = EWS:TreeCtrl(A0_4.panel, "", "TR_HAS_BUTTONS")
	A0_4._displayformat = _UPVALUE0_
	A0_4.__on_item_expanded_cb = CoreEvent.callback(A0_4, A0_4, "_on_item_expanded")
	A0_4._treectrl:connect("EVT_COMMAND_TREE_SEL_CHANGED", CoreEvent.callback(A0_4, A0_4, "_on_select"))
	A0_4._treectrl:connect("EVT_COMMAND_TREE_ITEM_EXPANDED", A0_4.__on_item_expanded_cb)
	A0_4.box_sizer = EWS:BoxSizer("HORIZONTAL")
	A0_4.box_sizer:add(A0_4._treectrl, 1, 1, "EXPAND")
	A0_4.panel:set_sizer(A0_4.box_sizer)
end
function LuaProfilerTreeBox.set_gridview(A0_7, ...)
	A0_7._gridview = _UPVALUE0_({
		...
	}, "table:gridview")
end
function LuaProfilerTreeBox.destroy(A0_9)
	A0_9._lpd = nil
	A0_9._treectrl:clear()
	A0_9._treectrl:destroy()
	A0_9._treectrl = nil
	A0_9._gridview = nil
end
function LuaProfilerTreeBox.set_profilerdata(A0_10, ...)
	A0_10._lpd, A0_10._displayformat = _UPVALUE0_({
		...
	}, "userdata:lpd", "number:displayformat")
	A0_10:_redraw()
end
function LuaProfilerTreeBox.set_displayformat(A0_12, ...)
	A0_12._displayformat = _UPVALUE0_({
		...
	}, "number:displayformat")
	if A0_12._lpd then
		function relabel(A0_14)
			local L1_15, L2_16, L3_17, L4_18, L5_19, L6_20, L7_21, L8_22
			L1_15 = _UPVALUE0_
			L1_15 = L1_15._lpd
			L2_16 = L1_15
			L1_15 = L1_15.cn_treenodeid
			L1_15 = L1_15(L2_16, L3_17)
			if L1_15 ~= -1 then
				L1_15 = _UPVALUE0_
				L2_16 = L1_15
				L1_15 = L1_15._makelabel
				L1_15 = L1_15(L2_16, L3_17)
				L2_16 = _UPVALUE0_
				L2_16 = L2_16._lpd
				L2_16 = L2_16.cn_treenodeid
				L2_16 = L2_16(L3_17, L4_18)
				L6_20 = L1_15
				L3_17(L4_18, L5_19, L6_20)
				L6_20 = Vector3
				L7_21 = 0
				L8_22 = 0
				L8_22 = L6_20(L7_21, L8_22, 0)
				L3_17(L4_18, L5_19, L6_20, L7_21, L8_22, L6_20(L7_21, L8_22, 0))
				L6_20 = A0_14
				for L6_20 = 0, L4_18 - 1 do
					L7_21 = relabel
					L8_22 = _UPVALUE0_
					L8_22 = L8_22._lpd
					L8_22 = L8_22.cn_child
					L8_22 = L8_22(L8_22, A0_14, L6_20)
					L7_21(L8_22, L8_22(L8_22, A0_14, L6_20))
				end
				L6_20 = A0_14
				for L6_20 = 0, L4_18 - 1 do
					L7_21 = _UPVALUE0_
					L7_21 = L7_21._lpd
					L8_22 = L7_21
					L7_21 = L7_21.cn_expensivechild
					L7_21 = L7_21(L8_22, A0_14, L6_20)
					L8_22 = _UPVALUE0_
					L8_22 = L8_22._lpd
					L8_22 = L8_22.cn_treenodeid
					L8_22 = L8_22(L8_22, L7_21)
					if L8_22 ~= -1 then
						_UPVALUE0_._treectrl:set_item_text_colour(L8_22, Vector3(1, 0, 0))
					end
				end
			end
		end
		relabel(A0_12._lpd:rootcallnode())
	end
end
function LuaProfilerTreeBox._redraw(A0_23)
	local L1_24
	L1_24 = A0_23._lpd
	if L1_24 then
		L1_24 = A0_23._clear
		L1_24(A0_23)
		L1_24 = A0_23._populate_rootnode
		L1_24(A0_23)
		L1_24 = A0_23._populate_plus2
		L1_24(A0_23, A0_23._lpd:rootcallnode())
		L1_24 = A0_23._lpd
		L1_24 = L1_24.cn_treenodeid
		L1_24 = L1_24(L1_24, A0_23._lpd:rootcallnode())
		A0_23._treectrl:expand(L1_24)
	end
end
function LuaProfilerTreeBox._clear(A0_25)
	local L1_26
	function L1_26(A0_27)
		local L1_28, L2_29, L3_30, L4_31
		if L1_28 ~= -1 then
			L4_31 = -1
			L1_28(L2_29, L3_30, L4_31)
			L4_31 = A0_27
			for L4_31 = 0, L2_29 - 1 do
				_UPVALUE1_(_UPVALUE0_._lpd:cn_child(A0_27, L4_31))
			end
		end
	end
	L1_26(A0_25._lpd:rootcallnode())
	A0_25._treectrl:clear()
end
function LuaProfilerTreeBox._populate_rootnode(A0_32)
	local L1_33, L2_34, L3_35
	L1_33 = A0_32._lpd
	L2_34 = L1_33
	L1_33 = L1_33.rootcallnode
	L1_33 = L1_33(L2_34)
	L3_35 = A0_32
	L2_34 = A0_32._makelabel
	L2_34 = L2_34(L3_35, L1_33)
	L3_35 = A0_32._treectrl
	L3_35 = L3_35.append_root
	L3_35 = L3_35(L3_35, L2_34)
	A0_32._lpd:cn_settreenodeid(L1_33, L3_35)
end
function LuaProfilerTreeBox._populate_plus2(A0_36, A1_37, A2_38)
	local L3_39, L4_40, L5_41, L6_42, L7_43, L8_44, L9_45, L10_46
	L3_39 = false
	L7_43 = A1_37
	for L7_43 = 0, L5_41 - 1 do
		L8_44 = A0_36._lpd
		L9_45 = L8_44
		L8_44 = L8_44.cn_child
		L10_46 = A1_37
		L8_44 = L8_44(L9_45, L10_46, L7_43)
		L9_45 = A0_36._lpd
		L10_46 = L9_45
		L9_45 = L9_45.cn_treenodeid
		L9_45 = L9_45(L10_46, L8_44)
		if L9_45 == -1 then
			L3_39 = true
			L10_46 = A0_36
			L9_45 = A0_36._makelabel
			L9_45 = L9_45(L10_46, L8_44)
			L10_46 = A0_36._treectrl
			L10_46 = L10_46.append
			L10_46 = L10_46(L10_46, A0_36._lpd:cn_treenodeid(A1_37), L9_45)
			A0_36._lpd:cn_settreenodeid(L8_44, L10_46)
		end
		if not A2_38 then
			L10_46 = A0_36
			L9_45 = A0_36._populate_plus2
			L9_45(L10_46, L8_44, true)
		end
	end
	if L3_39 then
		L7_43 = A1_37
		for L7_43 = 0, L5_41 - 1 do
			L8_44 = A0_36._lpd
			L9_45 = L8_44
			L8_44 = L8_44.cn_expensivechild
			L10_46 = A1_37
			L8_44 = L8_44(L9_45, L10_46, L7_43)
			L9_45 = A0_36._lpd
			L10_46 = L9_45
			L9_45 = L9_45.cn_treenodeid
			L9_45 = L9_45(L10_46, L8_44)
			L10_46 = A0_36._treectrl
			L10_46 = L10_46.set_item_text_colour
			L10_46(L10_46, L9_45, Vector3(1, 0, 0))
		end
	end
end
function LuaProfilerTreeBox._populate_path(A0_47, A1_48)
	local L2_49
	L2_49 = {}
	while A1_48 ~= A0_47._lpd:rootcallnode() do
		A1_48 = A0_47._lpd:cn_parent(A1_48)
		table.insert(L2_49, A1_48)
	end
	for _FORV_6_ = #L2_49, 1, -1 do
		A0_47:_populate_plus2(L2_49[_FORV_6_])
	end
end
function LuaProfilerTreeBox._on_item_expanded(A0_50, A1_51, A2_52)
	local L3_53, L4_54
	L4_54 = A2_52
	L3_53 = A2_52.get_item
	L3_53 = L3_53(L4_54)
	L4_54 = A0_50._lpd
	L4_54 = L4_54.find_callnode
	L4_54 = L4_54(L4_54, L3_53)
	A0_50:_populate_plus2(L4_54)
end
function LuaProfilerTreeBox._makelabel(A0_55, A1_56)
	local L2_57, L3_58, L4_59
	L2_57 = A0_55._lpd
	L3_58 = L2_57
	L2_57 = L2_57.frametime
	L2_57 = L2_57(L3_58)
	L3_58 = ""
	L4_59 = A0_55._lpd
	L4_59 = L4_59.rootcallnode
	L4_59 = L4_59(L4_59)
	if A1_56 == L4_59 then
		L4_59 = A0_55._displayformat
		if L4_59 == _UPVALUE0_ then
			L4_59 = L3_58
			L3_58 = L4_59 .. string.format("%6.2f%% LUA", 100 * A0_55._lpd:cn_value(A1_56) / L2_57)
		else
			L4_59 = A0_55._displayformat
			if L4_59 == _UPVALUE1_ then
				L4_59 = L3_58
				L3_58 = L4_59 .. string.format("%6.2fms LUA", 1000 * A0_55._lpd:cn_value(A1_56))
			else
				L4_59 = A0_55._displayformat
				if L4_59 == _UPVALUE2_ then
					L4_59 = L3_58
					L3_58 = L4_59 .. string.format("LUA")
				end
			end
		end
	else
		L4_59 = A0_55._displayformat
		if L4_59 == _UPVALUE0_ then
			L4_59 = L3_58
			L3_58 = L4_59 .. string.format("%6.3f%%  ", 100 * A0_55._lpd:cn_value(A1_56) / L2_57)
		else
			L4_59 = A0_55._displayformat
			if L4_59 == _UPVALUE1_ then
				L4_59 = L3_58
				L3_58 = L4_59 .. string.format("%6.3fms  ", 1000 * A0_55._lpd:cn_value(A1_56))
			else
				L4_59 = A0_55._displayformat
				if L4_59 == _UPVALUE2_ then
					L4_59 = L3_58
					L3_58 = L4_59 .. string.format("%s    ", A0_55._lpd:cn_value(A1_56))
				end
			end
		end
		L4_59 = A0_55._lpd
		L4_59 = L4_59.cn_funcnode
		L4_59 = L4_59(L4_59, A1_56)
		L3_58 = L3_58 .. string.format("%s (%s/%s)", A0_55._lpd:fn_func(L4_59), A0_55._lpd:fn_file(L4_59), A0_55._lpd:fn_line(L4_59))
		if A0_55._lpd:cn_num_acc_nodes(A1_56) > 1 then
			L3_58 = L3_58 .. string.format(" x%d", A0_55._lpd:cn_num_acc_nodes(A1_56))
		end
	end
	return L3_58
end
function LuaProfilerTreeBox.deselect_and_expand(A0_60, ...)
	local L2_62, L3_63, L4_64, L5_65, L6_66
	L2_62 = _UPVALUE0_
	L6_66 = ...
	;({
		[4] = ...
	})[1] = L4_64
	;({
		[4] = ...
	})[2] = L5_65
	;({
		[4] = ...
	})[3] = L6_66
	L2_62 = L2_62(L3_63, L4_64)
	L6_66 = A0_60.__on_item_expanded_cb
	L3_63(L4_64, L5_65, L6_66)
	L3_63(L4_64)
	L3_63(L4_64)
	L3_63(L4_64)
	L6_66 = L2_62
	for L6_66 = 0, L4_64 - 1 do
		A0_60:_populate_path(A0_60._lpd:fn_callnode(L2_62, L6_66))
	end
	L6_66 = L2_62
	for L6_66 = 0, L4_64 - 1 do
		A0_60:_expand_path(A0_60._lpd:fn_callnode(L2_62, L6_66))
		A0_60:_highlight_callnode(A0_60._lpd:fn_callnode(L2_62, L6_66))
	end
	L6_66 = A0_60.__on_item_expanded_cb
	L3_63(L4_64, L5_65, L6_66)
end
function LuaProfilerTreeBox._collapse_all(A0_67)
	function collapse(A0_68)
		local L1_69, L2_70, L3_71, L4_72, L5_73
		tnid = L1_69
		if L1_69 ~= -1 then
			L1_69(L2_70, L3_71)
			L4_72 = A0_68
			for L4_72 = 0, L2_70 - 1 do
				L5_73 = _UPVALUE0_
				L5_73 = L5_73._lpd
				L5_73 = L5_73.cn_child
				L5_73 = L5_73(L5_73, A0_68, L4_72)
				collapse(L5_73)
			end
		end
	end
	collapse(A0_67._lpd:rootcallnode())
end
function LuaProfilerTreeBox._expand_path(A0_74, A1_75)
	while A1_75 ~= A0_74._lpd:rootcallnode() do
		A1_75 = A0_74._lpd:cn_parent(A1_75)
		A0_74._treectrl:expand(A0_74._lpd:cn_treenodeid(A1_75))
	end
end
function LuaProfilerTreeBox.deselect_and_highlight(A0_76, ...)
	local L2_78
	L2_78 = _UPVALUE0_
	L2_78 = L2_78({
		...
	}, "number:fnid")
	A0_76._treectrl:unselect_all_items()
	A0_76:_highlight_funcnode(L2_78)
end
function LuaProfilerTreeBox._clear_highlights(A0_79)
	function clear_highlight(A0_80)
		local L1_81, L2_82, L3_83, L4_84, L5_85, L6_86
		L1_81 = _UPVALUE0_
		L1_81 = L1_81._lpd
		L1_81 = L1_81.cn_treenodeid
		L1_81 = L1_81(L2_82, L3_83)
		if L1_81 ~= -1 then
			L5_85 = Vector3
			L6_86 = 1
			L6_86 = L5_85(L6_86, 1, 1)
			L2_82(L3_83, L4_84, L5_85, L6_86, L5_85(L6_86, 1, 1))
			L5_85 = A0_80
			for L5_85 = 0, L3_83 - 1 do
				L6_86 = _UPVALUE0_
				L6_86 = L6_86._lpd
				L6_86 = L6_86.cn_child
				L6_86 = L6_86(L6_86, A0_80, L5_85)
				clear_highlight(L6_86)
			end
		end
	end
	clear_highlight(A0_79._lpd:rootcallnode())
end
function LuaProfilerTreeBox._highlight_funcnode(A0_87, A1_88)
	local L2_89, L3_90, L4_91, L5_92, L6_93
	L2_89(L3_90)
	L5_92 = A1_88
	for L5_92 = 0, L3_90 - 1 do
		L6_93 = A0_87._lpd
		L6_93 = L6_93.fn_callnode
		L6_93 = L6_93(L6_93, A1_88, L5_92)
		A0_87:_highlight_callnode(L6_93)
	end
end
function LuaProfilerTreeBox._highlight_callnode(A0_94, A1_95)
	local L2_96
	L2_96 = A0_94._lpd
	L2_96 = L2_96.cn_treenodeid
	L2_96 = L2_96(L2_96, A1_95)
	if L2_96 ~= -1 then
		A0_94._treectrl:set_item_background_colour(L2_96, _UPVALUE0_)
	end
end
function LuaProfilerTreeBox._on_select(A0_97)
	local L1_98, L2_99, L3_100
	L1_98 = A0_97._treectrl
	L2_99 = L1_98
	L1_98 = L1_98.selected_item
	L1_98 = L1_98(L2_99)
	if L1_98 ~= -1 then
		L2_99 = A0_97._lpd
		L3_100 = L2_99
		L2_99 = L2_99.find_callnode
		L2_99 = L2_99(L3_100, L1_98)
		L3_100 = A0_97._lpd
		L3_100 = L3_100.cn_funcnode
		L3_100 = L3_100(L3_100, L2_99)
		A0_97:_highlight_funcnode(L3_100)
		A0_97._gridview:deselect_and_highlight({fnid = L3_100})
	end
end
