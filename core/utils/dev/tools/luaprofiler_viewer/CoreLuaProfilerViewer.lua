core:module("CoreLuaProfilerViewer")
core:require_module("CoreLuaProfilerTreeBox")
core:require_module("CoreLuaProfilerGridBox")
core:require_module("CoreClass")
core:require_module("CoreEvent")
core:require_module("CoreDebug")
core:require_module("CoreKeywordArguments")
TOOLHUB_NAME = "Lua Profiler II"
local l_0_0 = 0
local l_0_1 = 1
local l_0_2 = 2
local l_0_3 = l_0_0
local l_0_4 = "total_time"
if not LuaProfilerViewer then
	LuaProfilerViewer = CoreClass.class()
end
LuaProfilerViewer.init = function(l_1_0)
	l_1_0._lpd = EWS:LuaProfilerDataStore()
	l_1_0:_create_main_frame()
end

LuaProfilerViewer._create_main_frame = function(l_2_0)
	-- upvalues: l_0_3
	l_2_0._frame = EWS:Frame(TOOLHUB_NAME, Vector3(100, 400, 0), Vector3(1500, 800, 0), "FRAME_FLOAT_ON_PARENT,DEFAULT_FRAME_STYLE", Global.frame)
	local l_2_1 = EWS:BoxSizer("VERTICAL")
	local l_2_2 = EWS:SplitterWindow(l_2_0._frame, "", "")
	l_2_0:_create_menu(l_2_0._frame)
	local l_2_3, l_2_4 = CoreLuaProfilerTreeBox.LuaProfilerTreeBox:new, CoreLuaProfilerTreeBox.LuaProfilerTreeBox
	local l_2_5 = {}
	l_2_5.parent = l_2_2
	l_2_3 = l_2_3(l_2_4, l_2_5)
	l_2_0._treeview = l_2_3
	l_2_3 = CoreLuaProfilerGridBox
	l_2_3 = l_2_3.LuaProfilerGridBox
	l_2_3, l_2_4 = l_2_3:new, l_2_3
	l_2_3, l_2_5 = l_2_3(l_2_4, l_2_5), {parent = l_2_2}
	l_2_0._gridview = l_2_3
	l_2_3 = l_2_0._treeview
	l_2_3, l_2_4 = l_2_3:set_gridview, l_2_3
	l_2_3(l_2_4, l_2_5)
	l_2_5 = {gridview = l_2_0._gridview}
	l_2_3 = l_2_0._gridview
	l_2_3, l_2_4 = l_2_3:set_treeview, l_2_3
	l_2_3(l_2_4, l_2_5)
	l_2_5 = {treeview = l_2_0._treeview}
	l_2_3 = l_0_3
	l_2_0._displayformat = l_2_3
	l_2_0._capturecounter = 0
	l_2_3 = CoreEvent
	l_2_3 = l_2_3.callback
	l_2_4 = l_2_0
	l_2_5 = l_2_0
	l_2_3 = l_2_3(l_2_4, l_2_5, "_on_percent")
	l_2_0._on_percent_cb = l_2_3
	l_2_3 = CoreEvent
	l_2_3 = l_2_3.callback
	l_2_4 = l_2_0
	l_2_5 = l_2_0
	l_2_3 = l_2_3(l_2_4, l_2_5, "_on_seconds")
	l_2_0._on_seconds_cb = l_2_3
	l_2_3 = CoreEvent
	l_2_3 = l_2_3.callback
	l_2_4 = l_2_0
	l_2_5 = l_2_0
	l_2_3 = l_2_3(l_2_4, l_2_5, "_on_custom")
	l_2_0._on_custom_cb = l_2_3
	l_2_3 = CoreEvent
	l_2_3 = l_2_3.callback
	l_2_4 = l_2_0
	l_2_5 = l_2_0
	l_2_3 = l_2_3(l_2_4, l_2_5, "_on_acc_calls")
	l_2_0._on_acc_calls_cb = l_2_3
	l_2_3 = CoreEvent
	l_2_3 = l_2_3.callback
	l_2_4 = l_2_0
	l_2_5 = l_2_0
	l_2_3 = l_2_3(l_2_4, l_2_5, "_on_no_acc_calls")
	l_2_0._on_no_acc_calls_cb = l_2_3
	l_2_3, l_2_4 = l_2_2:split_vertically, l_2_2
	l_2_5 = l_2_0._treeview
	l_2_5 = l_2_5.panel
	l_2_3(l_2_4, l_2_5, l_2_0._gridview.panel, "")
	l_2_3, l_2_4 = l_2_2:set_minimum_pane_size, l_2_2
	l_2_5 = 50
	l_2_3(l_2_4, l_2_5)
	l_2_3, l_2_4 = l_2_2:set_sash_gravity, l_2_2
	l_2_5 = 1
	l_2_3(l_2_4, l_2_5)
	l_2_3, l_2_4 = l_2_2:set_sash_position, l_2_2
	l_2_5 = 500
	l_2_3(l_2_4, l_2_5, true)
	l_2_3, l_2_4 = l_2_1:add, l_2_1
	l_2_5 = l_2_2
	l_2_3(l_2_4, l_2_5, 1, 0, "EXPAND")
	l_2_3 = l_2_0._frame
	l_2_3, l_2_4 = l_2_3:set_sizer, l_2_3
	l_2_5 = l_2_1
	l_2_3(l_2_4, l_2_5)
	l_2_3 = l_2_0._frame
	l_2_3, l_2_4 = l_2_3:set_visible, l_2_3
	l_2_5 = true
	l_2_3(l_2_4, l_2_5)
	l_2_3, l_2_4 = l_2_0:_redraw_menu, l_2_0
	l_2_3(l_2_4)
end

LuaProfilerViewer._create_menu = function(l_3_0)
	local l_3_1 = EWS:Menu("")
	l_3_1:append_item("OPEN", "Open\tCtrl+O", "")
	l_3_1:append_item("EXIT", "Exit", "")
	local l_3_2 = EWS:Menu("")
	l_3_0._view_menu = l_3_2
	l_3_0._view_menu_filled = false
	l_3_0._view_menu_connects = {}
	local l_3_3 = EWS:Menu("")
	l_3_3:append_item("CAPTURE", "Capture Frame\tCtrl+F", "")
	local l_3_4 = EWS:MenuBar()
	l_3_4:append(l_3_1, "File")
	l_3_4:append(l_3_2, "View")
	l_3_4:append(l_3_3, "Capture")
	l_3_0._frame:set_menu_bar(l_3_4)
	l_3_0._frame:connect("OPEN", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(l_3_0, l_3_0, "_on_open"), "")
	l_3_0._frame:connect("EXIT", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(l_3_0, l_3_0, "_on_close"), "")
	l_3_0._frame:connect("", "EVT_CLOSE_WINDOW", CoreEvent.callback(l_3_0, l_3_0, "_on_close"), "")
	l_3_0._frame:connect("CAPTURE", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(l_3_0, l_3_0, "_on_capture"), "")
end

LuaProfilerViewer._redraw_menu = function(l_4_0)
	-- upvalues: l_0_0
	local l_4_1 = l_4_0._lpd
	l_4_0._displayformat = l_0_0
	if l_4_0._view_menu_filled then
		l_4_0._frame:disconnect("PERCENT", "EVT_COMMAND_MENU_SELECTED", l_4_0._on_percent_cb)
		l_4_0._frame:disconnect("SECONDS", "EVT_COMMAND_MENU_SELECTED", l_4_0._on_seconds_cb)
		l_4_0._frame:disconnect("ACC", "EVT_COMMAND_MENU_SELECTED", l_4_0._on_acc_calls_cb)
		local l_4_5 = l_4_0._frame:disconnect
		local l_4_6 = l_4_0._frame
		l_4_5(l_4_6, "NO_ACC", "EVT_COMMAND_MENU_SELECTED", l_4_0._on_no_acc_calls_cb)
		l_4_5 = ipairs
		l_4_6 = l_4_0._view_menu_connects
		l_4_5 = l_4_5(l_4_6)
		for i_0,i_1 in l_4_5 do
			l_4_0._frame:disconnect(l_4_4, "EVT_COMMAND_MENU_SELECTED", l_4_0._on_custom_cb)
		end
		l_4_0._view_menu_filled = false
		l_4_0._view_menu_connects = {}
		l_4_0._view_menu:clear()
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_4_0._view_menu:append_separator()
	l_4_0._view_menu:append_radio_item("PERCENT", "Time in %\tCtrl+P", "")
	l_4_0._frame:connect("PERCENT", "EVT_COMMAND_MENU_SELECTED", l_4_0._on_percent_cb, "")
	l_4_0._view_menu:append_radio_item("SECONDS", "Time in ms\tCtrl+M", "")
	l_4_0._frame:connect("SECONDS", "EVT_COMMAND_MENU_SELECTED", l_4_0._on_seconds_cb, "")
	for l_4_10 = 0, l_4_1:numheaders() - 1 do
		local l_4_7, l_4_8, l_4_9, l_4_10 = nil
		l_4_7 = string
		l_4_7 = l_4_7.capitalize
		l_4_8, l_4_9 = l_4_1:headername, l_4_1
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_4_10 = "EVT_COMMAND_MENU_SELECTED"
		l_4_9, l_4_8 = .end, l_4_8(l_4_9, l_4_10)
		l_4_7 = l_4_7(l_4_8, l_4_9, l_4_10)
		local l_4_11 = nil
		l_4_8 = string
		l_4_8 = l_4_8.format
		l_4_9 = "%s:-1"
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_4_10 = "EVT_COMMAND_MENU_SELECTED"
		l_4_8 = l_4_8(l_4_9, l_4_10)
		local l_4_12 = nil
		l_4_9 = l_4_0._view_menu
		l_4_9, l_4_10 = l_4_9:append_radio_item, l_4_9
		l_4_11 = l_4_8
		l_4_12 = "Diff "
		l_4_12 = l_4_12 .. l_4_7
		l_4_9(l_4_10, l_4_11, l_4_12, "")
		l_4_9 = l_4_0._frame
		l_4_9, l_4_10 = l_4_9:connect, l_4_9
		l_4_11 = l_4_8
		l_4_12 = "EVT_COMMAND_MENU_SELECTED"
		l_4_9(l_4_10, l_4_11, l_4_12, l_4_0._on_custom_cb, l_4_8)
		l_4_9 = table
		l_4_9 = l_4_9.insert
		l_4_10 = l_4_0._view_menu_connects
		l_4_11 = l_4_8
		l_4_9(l_4_10, l_4_11)
		l_4_9 = string
		l_4_9 = l_4_9.format
		l_4_10 = "-1:%s"
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_4_11 = "EVT_COMMAND_MENU_SELECTED"
		l_4_9 = l_4_9(l_4_10, l_4_11)
		local l_4_13 = nil
		l_4_10 = l_4_0._view_menu
		l_4_10, l_4_11 = l_4_10:append_radio_item, l_4_10
		l_4_12 = l_4_9
		l_4_13 = "Peak "
		l_4_13 = l_4_13 .. l_4_7
		l_4_10(l_4_11, l_4_12, l_4_13, "")
		l_4_10 = l_4_0._frame
		l_4_10, l_4_11 = l_4_10:connect, l_4_10
		l_4_12 = l_4_9
		l_4_13 = "EVT_COMMAND_MENU_SELECTED"
		l_4_10(l_4_11, l_4_12, l_4_13, l_4_0._on_custom_cb, l_4_9)
		l_4_10 = table
		l_4_10 = l_4_10.insert
		l_4_11 = l_4_0._view_menu_connects
		l_4_12 = l_4_9
		l_4_10(l_4_11, l_4_12)
	end
	l_4_0._view_menu:append_separator()
	l_4_0._view_menu:append_radio_item("ACC", "Acc. and sort Calls", "")
	l_4_0._frame:connect("ACC", "EVT_COMMAND_MENU_SELECTED", l_4_0._on_acc_calls_cb, "")
	l_4_0._view_menu:append_radio_item("NO_ACC", "Keep Call order", "")
	l_4_0._frame:connect("NO_ACC", "EVT_COMMAND_MENU_SELECTED", l_4_0._on_no_acc_calls_cb, "")
	l_4_0._view_menu_filled = true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

LuaProfilerViewer.close = function(l_5_0)
	if l_5_0._frame then
		l_5_0._frame:destroy()
	end
	l_5_0._treeview:destroy()
	l_5_0._gridview:destroy()
	l_5_0._treeview = nil
	l_5_0._gridview = nil
	l_5_0._lpd = nil
end

LuaProfilerViewer.set_position = function(l_6_0, l_6_1)
	if l_6_0._frame then
		l_6_0._frame:set_position(l_6_1)
	end
end

LuaProfilerViewer.update = function(l_7_0, l_7_1, l_7_2)
	if l_7_0._capturecounter == 4 then
		Application:console_command("luaprofiler dump")
	end
	if l_7_0._capturecounter == 1 then
		l_7_0:_on_open()
	end
	if l_7_0._capturecounter > 0 then
		l_7_0._capturecounter = l_7_0._capturecounter - 1
	end
end

LuaProfilerViewer._on_close = function(l_8_0)
	managers.toolhub:close(TOOLHUB_NAME)
end

LuaProfilerViewer._on_open = function(l_9_0)
	local l_9_1 = EWS:FileDialog(l_9_0._frame, "Open 'luaprofiler dump_stat' File", Application:base_path(), "", "*.pf", "")
	l_9_1:show_modal()
	local l_9_2 = l_9_1:get_filename()
	local l_9_3 = l_9_1:get_directory()
	local l_9_4 = string.format("%s\\%s", l_9_3, l_9_2)
	if l_9_2 ~= "" then
		local l_9_5 = EWS:LuaProfilerDataStore()
		local l_9_6 = l_9_5:parsefile(l_9_4)
		if l_9_6 == "" then
			l_9_0._lpd = l_9_5
			l_9_0:_redraw_menu()
			l_9_0._lpd:buildstructure(true)
			local l_9_7, l_9_8 = l_9_0._treeview:set_profilerdata, l_9_0._treeview
			local l_9_9 = {}
			l_9_9.lpd = l_9_0._lpd
			l_9_9.displayformat = l_9_0._displayformat
			l_9_7(l_9_8, l_9_9)
			l_9_7 = l_9_0._gridview
			l_9_7, l_9_8 = l_9_7:set_profilerdata, l_9_7
			l_9_7(l_9_8, l_9_9)
			l_9_9 = {lpd = l_9_0._lpd, displayformat = l_9_0._displayformat}
		end
	else
		EWS:MessageDialog(l_9_0._frame, l_9_6, "Loading Error", ""):show_modal()
	end
end

LuaProfilerViewer._on_percent = function(l_10_0)
	-- upvalues: l_0_0
	l_10_0._displayformat = l_0_0
	if l_10_0._lpd then
		local l_10_1 = l_10_0._lpd:set_cn_key(-1, -1)
		if l_10_1 then
			local l_10_2, l_10_3 = l_10_0._treeview:set_profilerdata, l_10_0._treeview
			local l_10_4 = {}
			l_10_4.lpd = l_10_0._lpd
			l_10_4.displayformat = l_10_0._displayformat
			l_10_2(l_10_3, l_10_4)
			l_10_2 = l_10_0._gridview
			l_10_2, l_10_3 = l_10_2:set_displayformat, l_10_2
			l_10_2(l_10_3, l_10_4)
			l_10_4 = {displayformat = l_10_0._displayformat}
		end
	else
		local l_10_5, l_10_6 = l_10_0._treeview:set_displayformat, l_10_0._treeview
		local l_10_7 = {}
		l_10_7.displayformat = l_10_0._displayformat
		l_10_5(l_10_6, l_10_7)
		l_10_5 = l_10_0._gridview
		l_10_5, l_10_6 = l_10_5:set_displayformat, l_10_5
		l_10_5(l_10_6, l_10_7)
		l_10_7 = {displayformat = l_10_0._displayformat}
	end
end

LuaProfilerViewer._on_seconds = function(l_11_0)
	-- upvalues: l_0_1
	l_11_0._displayformat = l_0_1
	if l_11_0._lpd then
		local l_11_1 = l_11_0._lpd:set_cn_key(-1, -1)
		if l_11_1 then
			local l_11_2, l_11_3 = l_11_0._treeview:set_profilerdata, l_11_0._treeview
			local l_11_4 = {}
			l_11_4.lpd = l_11_0._lpd
			l_11_4.displayformat = l_11_0._displayformat
			l_11_2(l_11_3, l_11_4)
			l_11_2 = l_11_0._gridview
			l_11_2, l_11_3 = l_11_2:set_displayformat, l_11_2
			l_11_2(l_11_3, l_11_4)
			l_11_4 = {displayformat = l_11_0._displayformat}
		end
	else
		local l_11_5, l_11_6 = l_11_0._treeview:set_displayformat, l_11_0._treeview
		local l_11_7 = {}
		l_11_7.displayformat = l_11_0._displayformat
		l_11_5(l_11_6, l_11_7)
		l_11_5 = l_11_0._gridview
		l_11_5, l_11_6 = l_11_5:set_displayformat, l_11_5
		l_11_5(l_11_6, l_11_7)
		l_11_7 = {displayformat = l_11_0._displayformat}
	end
end

LuaProfilerViewer._on_custom = function(l_12_0, l_12_1)
	-- upvalues: l_0_2
	l_12_0._displayformat = l_0_2
	local l_12_2 = tonumber(string.split(l_12_1, ":")[1])
	local l_12_3 = tonumber(string.split(l_12_1, ":")[2])
	if l_12_0._lpd then
		local l_12_4 = l_12_0._lpd:set_cn_key(l_12_2, l_12_3)
		if l_12_4 then
			local l_12_5, l_12_6 = l_12_0._treeview:set_profilerdata, l_12_0._treeview
			local l_12_7 = {}
			l_12_7.lpd = l_12_0._lpd
			l_12_7.displayformat = l_12_0._displayformat
			l_12_5(l_12_6, l_12_7)
		end
	else
		local l_12_8, l_12_9 = l_12_0._treeview:set_displayformat, l_12_0._treeview
		local l_12_10 = {}
		l_12_10.displayformat = l_12_0._displayformat
		l_12_8(l_12_9, l_12_10)
	end
end

LuaProfilerViewer._on_acc_calls = function(l_13_0)
	if l_13_0._lpd then
		l_13_0._lpd:buildstructure(true)
		local l_13_1, l_13_2 = l_13_0._treeview:set_profilerdata, l_13_0._treeview
		local l_13_3 = {}
		l_13_3.lpd = l_13_0._lpd
		l_13_3.displayformat = l_13_0._displayformat
		l_13_1(l_13_2, l_13_3)
		l_13_1 = l_13_0._gridview
		l_13_1, l_13_2 = l_13_1:set_profilerdata, l_13_1
		l_13_1(l_13_2, l_13_3)
		l_13_3 = {lpd = l_13_0._lpd, displayformat = l_13_0._displayformat}
	end
end

LuaProfilerViewer._on_no_acc_calls = function(l_14_0)
	if l_14_0._lpd then
		l_14_0._lpd:buildstructure(false)
		local l_14_1, l_14_2 = l_14_0._treeview:set_profilerdata, l_14_0._treeview
		local l_14_3 = {}
		l_14_3.lpd = l_14_0._lpd
		l_14_3.displayformat = l_14_0._displayformat
		l_14_1(l_14_2, l_14_3)
		l_14_1 = l_14_0._gridview
		l_14_1, l_14_2 = l_14_1:set_profilerdata, l_14_1
		l_14_1(l_14_2, l_14_3)
		l_14_3 = {lpd = l_14_0._lpd, displayformat = l_14_0._displayformat}
	end
end

LuaProfilerViewer._on_capture = function(l_15_0)
	l_15_0._capturecounter = 6
end


