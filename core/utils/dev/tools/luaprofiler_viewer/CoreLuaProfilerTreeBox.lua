core:module("CoreLuaProfilerTreeBox")
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
local l_0_7 = "total_time"
if not LuaProfilerTreeBox then
	LuaProfilerTreeBox = CoreClass.class()
end
LuaProfilerTreeBox.init = function(l_1_0, ...)
	-- upvalues: l_0_6
	l_1_0._ews_parent = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("parent")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_1_0._lpd = nil
	l_1_0.panel = EWS:Panel(l_1_0._ews_parent, "", "")
	l_1_0._treectrl = EWS:TreeCtrl(l_1_0.panel, "", "TR_HAS_BUTTONS")
	l_1_0._displayformat = l_0_6
	l_1_0.__on_item_expanded_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_item_expanded")
	l_1_0._treectrl:connect("EVT_COMMAND_TREE_SEL_CHANGED", CoreEvent.callback(l_1_0, l_1_0, "_on_select"))
	l_1_0._treectrl:connect("EVT_COMMAND_TREE_ITEM_EXPANDED", l_1_0.__on_item_expanded_cb)
	l_1_0.box_sizer = EWS:BoxSizer("HORIZONTAL")
	l_1_0.box_sizer:add(l_1_0._treectrl, 1, 1, "EXPAND")
	l_1_0.panel:set_sizer(l_1_0.box_sizer)
end

LuaProfilerTreeBox.set_gridview = function(l_2_0, ...)
	-- upvalues: l_0_0
	local l_2_2 = l_0_0
	l_2_2 = l_2_2({...}, "table:gridview")
	l_2_0._gridview = l_2_2
end

LuaProfilerTreeBox.destroy = function(l_3_0)
	l_3_0._lpd = nil
	l_3_0._treectrl:clear()
	l_3_0._treectrl:destroy()
	l_3_0._treectrl = nil
	l_3_0._gridview = nil
end

LuaProfilerTreeBox.set_profilerdata = function(l_4_0, ...)
	-- upvalues: l_0_0
	local l_4_2 = l_0_0({...}, "userdata:lpd", "number:displayformat")
	l_4_0._displayformat = {...}
	l_4_0._lpd = l_4_2
	l_4_2(l_4_0)
end

LuaProfilerTreeBox.set_displayformat = function(l_5_0, ...)
	-- upvalues: l_0_0
	local l_5_2 = l_0_0
	l_5_2 = l_5_2({...}, "number:displayformat")
	l_5_0._displayformat = l_5_2
	l_5_2 = l_5_0._lpd
	if l_5_2 then
		l_5_2 = function(l_6_0)
		-- upvalues: l_5_0
		if l_5_0._lpd:cn_treenodeid(l_6_0) ~= -1 then
			local l_6_1 = l_5_0:_makelabel(l_6_0)
			local l_6_2 = l_5_0._lpd:cn_treenodeid(l_6_0)
			l_5_0._treectrl:set_item_text(l_6_2, l_6_1)
			l_5_0._treectrl:set_item_text_colour(l_6_2, Vector3(0, 0, 0))
			for l_6_6 = 0, l_5_0._lpd:cn_numchildren(l_6_0) - 1 do
				relabel(l_5_0._lpd:cn_child(l_6_0, l_6_6))
			end
			for l_6_10 = 0, l_5_0._lpd:cn_numexpensivechildren(l_6_0) - 1 do
				local l_6_11 = l_5_0._lpd:cn_expensivechild(l_6_0, l_6_10)
				local l_6_12 = l_5_0._lpd:cn_treenodeid(l_6_11)
				if l_6_12 ~= -1 then
					l_5_0._treectrl:set_item_text_colour(l_6_12, Vector3(1, 0, 0))
				end
			end
		end
  end
		relabel = l_5_2
		l_5_2 = relabel
		l_5_2(l_5_0._lpd:rootcallnode())
	end
end

LuaProfilerTreeBox._redraw = function(l_6_0)
	if l_6_0._lpd then
		l_6_0:_clear()
		l_6_0:_populate_rootnode()
		l_6_0:_populate_plus2(l_6_0, l_6_0._lpd:rootcallnode())
		local l_6_1 = l_6_0._lpd:cn_treenodeid(l_6_0._lpd:rootcallnode())
		l_6_0._treectrl:expand(l_6_1)
	end
end

LuaProfilerTreeBox._clear = function(l_7_0)
	do
		function(l_8_0)
		-- upvalues: l_7_0 , l_7_1
		if l_7_0._lpd:cn_treenodeid(l_8_0) ~= -1 then
			l_7_0._lpd:cn_settreenodeid(l_8_0, -1)
			for l_8_4 = 0, l_7_0._lpd:cn_numchildren(l_8_0) - 1 do
				l_7_1(l_7_0._lpd:cn_child(l_8_0, l_8_4))
			end
		end
  end(l_7_0._lpd:rootcallnode())
		l_7_0._treectrl:clear()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

LuaProfilerTreeBox._populate_rootnode = function(l_8_0)
	local l_8_1 = l_8_0._lpd:rootcallnode()
	local l_8_2 = l_8_0:_makelabel(l_8_1)
	local l_8_3 = l_8_0._treectrl:append_root(l_8_2)
	l_8_0._lpd:cn_settreenodeid(l_8_1, l_8_3)
end

LuaProfilerTreeBox._populate_plus2 = function(l_9_0, l_9_1, l_9_2)
	local l_9_3 = false
	for l_9_7 = 0, l_9_0._lpd:cn_numchildren(l_9_1) - 1 do
		local l_9_8 = l_9_0._lpd:cn_child(l_9_1, l_9_7)
		if l_9_0._lpd:cn_treenodeid(l_9_8) == -1 then
			l_9_3 = true
			local l_9_9 = l_9_0:_makelabel(l_9_8)
			local l_9_10 = l_9_0._treectrl:append(l_9_0._lpd:cn_treenodeid(l_9_1), l_9_9)
			l_9_0._lpd:cn_settreenodeid(l_9_8, l_9_10)
		end
		if not l_9_2 then
			l_9_0:_populate_plus2(l_9_0, l_9_8, true)
		end
	end
	if l_9_3 then
		for l_9_14 = 0, l_9_0._lpd:cn_numexpensivechildren(l_9_1) - 1 do
			local l_9_15 = l_9_0._lpd:cn_expensivechild(l_9_1, l_9_14)
			local l_9_16 = l_9_0._lpd:cn_treenodeid(l_9_15)
			l_9_0._treectrl:set_item_text_colour(l_9_16, Vector3(1, 0, 0))
		end
	end
end

LuaProfilerTreeBox._populate_path = function(l_10_0, l_10_1)
	do
		while 1 do
			local l_10_2 = {}
			while l_10_1 ~= l_10_0._lpd:rootcallnode() do
				l_10_1 = l_10_0._lpd:cn_parent(l_10_1)
				table.insert(l_10_2, l_10_1)
			end
			for l_10_6 = #l_10_2, 1, -1 do
				l_10_0:_populate_plus2(l_10_0, l_10_2[l_10_6])
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

LuaProfilerTreeBox._on_item_expanded = function(l_11_0, l_11_1, l_11_2)
	local l_11_3 = l_11_2:get_item()
	local l_11_4 = l_11_0._lpd:find_callnode(l_11_3)
	l_11_0:_populate_plus2(l_11_0, l_11_4)
end

LuaProfilerTreeBox._makelabel = function(l_12_0, l_12_1)
	-- upvalues: l_0_3 , l_0_4 , l_0_5
	local l_12_2 = l_12_0._lpd:frametime()
	do
		local l_12_3 = ""
		if l_12_1 == l_12_0._lpd:rootcallnode() then
			if l_12_0._displayformat == l_0_3 then
				l_12_3 = l_12_3 .. string.format("%6.2f%% LUA", 100 * l_12_0._lpd:cn_value(l_12_1) / l_12_2)
			else
				if l_12_0._displayformat == l_0_4 then
					l_12_3 = l_12_3 .. string.format("%6.2fms LUA", 1000 * l_12_0._lpd:cn_value(l_12_1))
				end
			else
				if l_12_0._displayformat == l_0_5 then
					l_12_3 = l_12_3 .. string.format("LUA")
				end
			else
				if l_12_0._displayformat == l_0_3 then
					l_12_3 = l_12_3 .. string.format("%6.3f%%  ", 100 * l_12_0._lpd:cn_value(l_12_1) / l_12_2)
				else
					if l_12_0._displayformat == l_0_4 then
						l_12_3 = l_12_3 .. string.format("%6.3fms  ", 1000 * l_12_0._lpd:cn_value(l_12_1))
					end
				else
					if l_12_0._displayformat == l_0_5 then
						l_12_3 = l_12_3 .. string.format("%s    ", l_12_0._lpd:cn_value(l_12_1))
					end
				end
				local l_12_4 = l_12_0._lpd:cn_funcnode(l_12_1)
				l_12_3 = l_12_3 .. string.format("%s (%s/%s)", l_12_0._lpd:fn_func(l_12_4), l_12_0._lpd:fn_file(l_12_4), l_12_0._lpd:fn_line(l_12_4))
			if l_12_0._lpd:cn_num_acc_nodes(l_12_1) > 1 then
				end
				l_12_3 = l_12_3 .. string.format(" x%d", l_12_0._lpd:cn_num_acc_nodes(l_12_1))
			end
			return l_12_3
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

LuaProfilerTreeBox.deselect_and_expand = function(l_13_0, ...)
	-- upvalues: l_0_0
	local l_13_2 = l_0_0
	l_13_2 = l_13_2({...}, "number:fnid")
	l_13_0._treectrl:disconnect("EVT_COMMAND_TREE_ITEM_EXPANDED", l_13_0.__on_item_expanded_cb)
	l_13_0:_collapse_all()
	l_13_0:_clear_highlights()
	l_13_0._treectrl:unselect_all_items()
	for i = 0, l_13_0._lpd:fn_numcallnodes(l_13_2) - 1 do
		l_13_0:_populate_path(l_13_0._lpd:fn_callnode(l_13_2, i))
	end
	for l_13_9 = 0, l_13_0._lpd:fn_numcallnodes(l_13_2) - 1 do
		l_13_0:_expand_path(l_13_0._lpd:fn_callnode(l_13_2, l_13_9))
		l_13_0:_highlight_callnode(l_13_0._lpd:fn_callnode(l_13_2, l_13_9))
	end
	l_13_0._treectrl:connect("EVT_COMMAND_TREE_ITEM_EXPANDED", l_13_0.__on_item_expanded_cb)
end

LuaProfilerTreeBox._collapse_all = function(l_14_0)
	collapse = function(l_15_0)
		-- upvalues: l_14_0
		tnid = l_14_0._lpd:cn_treenodeid(l_15_0)
		if tnid ~= -1 then
			l_14_0._treectrl:collapse(tnid)
			for l_15_4 = 0, l_14_0._lpd:cn_numchildren(l_15_0) - 1 do
				local l_15_5 = l_14_0._lpd:cn_child(l_15_0, l_15_4)
				collapse(l_15_5)
			end
		end
  end
	collapse(l_14_0._lpd:rootcallnode())
end

LuaProfilerTreeBox._expand_path = function(l_15_0, l_15_1)
	while l_15_1 ~= l_15_0._lpd:rootcallnode() do
		l_15_1 = l_15_0._lpd:cn_parent(l_15_1)
		l_15_0._treectrl:expand(l_15_0._lpd:cn_treenodeid(l_15_1))
	end
end

LuaProfilerTreeBox.deselect_and_highlight = function(l_16_0, ...)
	-- upvalues: l_0_0
	local l_16_2 = l_0_0
	l_16_2 = l_16_2({...}, "number:fnid")
	l_16_0._treectrl:unselect_all_items()
	l_16_0:_highlight_funcnode(l_16_2)
end

LuaProfilerTreeBox._clear_highlights = function(l_17_0)
	clear_highlight = function(l_18_0)
		-- upvalues: l_17_0
		local l_18_1 = l_17_0._lpd:cn_treenodeid(l_18_0)
		if l_18_1 ~= -1 then
			l_17_0._treectrl:set_item_background_colour(l_18_1, Vector3(1, 1, 1))
			for l_18_5 = 0, l_17_0._lpd:cn_numchildren(l_18_0) - 1 do
				local l_18_6 = l_17_0._lpd:cn_child(l_18_0, l_18_5)
				clear_highlight(l_18_6)
			end
		end
  end
	clear_highlight(l_17_0._lpd:rootcallnode())
end

LuaProfilerTreeBox._highlight_funcnode = function(l_18_0, l_18_1)
	l_18_0:_clear_highlights()
	for l_18_5 = 0, l_18_0._lpd:fn_numcallnodes(l_18_1) - 1 do
		local l_18_6 = l_18_0._lpd:fn_callnode(l_18_1, l_18_5)
		l_18_0:_highlight_callnode(l_18_6)
	end
end

LuaProfilerTreeBox._highlight_callnode = function(l_19_0, l_19_1)
	-- upvalues: l_0_2
	local l_19_2 = l_19_0._lpd:cn_treenodeid(l_19_1)
	if l_19_2 ~= -1 then
		l_19_0._treectrl:set_item_background_colour(l_19_2, l_0_2)
	end
end

LuaProfilerTreeBox._on_select = function(l_20_0)
	local l_20_1 = l_20_0._treectrl:selected_item()
	if l_20_1 ~= -1 then
		local l_20_2 = l_20_0._lpd:find_callnode(l_20_1)
		local l_20_3 = l_20_0._lpd:cn_funcnode(l_20_2)
		l_20_0:_highlight_funcnode(l_20_3)
		local l_20_4, l_20_5 = l_20_0._gridview:deselect_and_highlight, l_20_0._gridview
		local l_20_6 = {}
		l_20_6.fnid = l_20_3
		l_20_4(l_20_5, l_20_6)
	end
end


