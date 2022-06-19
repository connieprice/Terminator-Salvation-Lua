local L0_0
L0_0 = core
L0_0 = L0_0.module
L0_0(L0_0, "CoreLuaProfilerViewer")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreLuaProfilerTreeBox")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreLuaProfilerGridBox")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreClass")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreEvent")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreDebug")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreKeywordArguments")
L0_0 = "Lua Profiler II"
TOOLHUB_NAME = L0_0
L0_0 = 0
LuaProfilerViewer = LuaProfilerViewer or CoreClass.class()
function LuaProfilerViewer.init(A0_1)
	A0_1._lpd = EWS:LuaProfilerDataStore()
	A0_1:_create_main_frame()
end
function LuaProfilerViewer._create_main_frame(A0_2)
	local L1_3, L2_4
	L1_3 = EWS
	L2_4 = L1_3
	L1_3 = L1_3.Frame
	L1_3 = L1_3(L2_4, TOOLHUB_NAME, Vector3(100, 400, 0), Vector3(1500, 800, 0), "FRAME_FLOAT_ON_PARENT,DEFAULT_FRAME_STYLE", Global.frame)
	A0_2._frame = L1_3
	L1_3 = EWS
	L2_4 = L1_3
	L1_3 = L1_3.BoxSizer
	L1_3 = L1_3(L2_4, "VERTICAL")
	L2_4 = EWS
	L2_4 = L2_4.SplitterWindow
	L2_4 = L2_4(L2_4, A0_2._frame, "", "")
	A0_2:_create_menu(A0_2._frame)
	A0_2._treeview = CoreLuaProfilerTreeBox.LuaProfilerTreeBox:new({parent = L2_4})
	A0_2._gridview = CoreLuaProfilerGridBox.LuaProfilerGridBox:new({parent = L2_4})
	A0_2._treeview:set_gridview({
		gridview = A0_2._gridview
	})
	A0_2._gridview:set_treeview({
		treeview = A0_2._treeview
	})
	A0_2._displayformat = _UPVALUE0_
	A0_2._capturecounter = 0
	A0_2._on_percent_cb = CoreEvent.callback(A0_2, A0_2, "_on_percent")
	A0_2._on_seconds_cb = CoreEvent.callback(A0_2, A0_2, "_on_seconds")
	A0_2._on_custom_cb = CoreEvent.callback(A0_2, A0_2, "_on_custom")
	A0_2._on_acc_calls_cb = CoreEvent.callback(A0_2, A0_2, "_on_acc_calls")
	A0_2._on_no_acc_calls_cb = CoreEvent.callback(A0_2, A0_2, "_on_no_acc_calls")
	L2_4:split_vertically(A0_2._treeview.panel, A0_2._gridview.panel, "")
	L2_4:set_minimum_pane_size(50)
	L2_4:set_sash_gravity(1)
	L2_4:set_sash_position(500, true)
	L1_3:add(L2_4, 1, 0, "EXPAND")
	A0_2._frame:set_sizer(L1_3)
	A0_2._frame:set_visible(true)
	A0_2:_redraw_menu()
end
function LuaProfilerViewer._create_menu(A0_5)
	local L1_6, L2_7, L3_8, L4_9
	L1_6 = EWS
	L2_7 = L1_6
	L1_6 = L1_6.Menu
	L3_8 = ""
	L1_6 = L1_6(L2_7, L3_8)
	L3_8 = L1_6
	L2_7 = L1_6.append_item
	L4_9 = "OPEN"
	L2_7(L3_8, L4_9, "Open\tCtrl+O", "")
	L3_8 = L1_6
	L2_7 = L1_6.append_item
	L4_9 = "EXIT"
	L2_7(L3_8, L4_9, "Exit", "")
	L2_7 = EWS
	L3_8 = L2_7
	L2_7 = L2_7.Menu
	L4_9 = ""
	L2_7 = L2_7(L3_8, L4_9)
	A0_5._view_menu = L2_7
	A0_5._view_menu_filled = false
	L3_8 = {}
	A0_5._view_menu_connects = L3_8
	L3_8 = EWS
	L4_9 = L3_8
	L3_8 = L3_8.Menu
	L3_8 = L3_8(L4_9, "")
	L4_9 = L3_8.append_item
	L4_9(L3_8, "CAPTURE", "Capture Frame\tCtrl+F", "")
	L4_9 = EWS
	L4_9 = L4_9.MenuBar
	L4_9 = L4_9(L4_9)
	L4_9:append(L1_6, "File")
	L4_9:append(L2_7, "View")
	L4_9:append(L3_8, "Capture")
	A0_5._frame:set_menu_bar(L4_9)
	A0_5._frame:connect("OPEN", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(A0_5, A0_5, "_on_open"), "")
	A0_5._frame:connect("EXIT", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(A0_5, A0_5, "_on_close"), "")
	A0_5._frame:connect("", "EVT_CLOSE_WINDOW", CoreEvent.callback(A0_5, A0_5, "_on_close"), "")
	A0_5._frame:connect("CAPTURE", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(A0_5, A0_5, "_on_capture"), "")
end
function LuaProfilerViewer._redraw_menu(A0_10)
	local L1_11, L2_12, L3_13, L4_14, L5_15, L6_16, L7_17, L8_18
	L1_11 = A0_10._lpd
	A0_10._displayformat = L2_12
	if L2_12 then
		L5_15 = "EVT_COMMAND_MENU_SELECTED"
		L6_16 = A0_10._on_percent_cb
		L2_12(L3_13, L4_14, L5_15, L6_16)
		L5_15 = "EVT_COMMAND_MENU_SELECTED"
		L6_16 = A0_10._on_seconds_cb
		L2_12(L3_13, L4_14, L5_15, L6_16)
		L5_15 = "EVT_COMMAND_MENU_SELECTED"
		L6_16 = A0_10._on_acc_calls_cb
		L2_12(L3_13, L4_14, L5_15, L6_16)
		L5_15 = "EVT_COMMAND_MENU_SELECTED"
		L6_16 = A0_10._on_no_acc_calls_cb
		L2_12(L3_13, L4_14, L5_15, L6_16)
		for L5_15, L6_16 in L2_12(L3_13) do
			L7_17 = A0_10._frame
			L8_18 = L7_17
			L7_17 = L7_17.disconnect
			L7_17(L8_18, L6_16, "EVT_COMMAND_MENU_SELECTED", A0_10._on_custom_cb)
		end
		A0_10._view_menu_filled = false
		A0_10._view_menu_connects = L2_12
		L2_12(L3_13)
	end
	L2_12(L3_13)
	L5_15 = "Time in %\tCtrl+P"
	L6_16 = ""
	L2_12(L3_13, L4_14, L5_15, L6_16)
	L5_15 = "EVT_COMMAND_MENU_SELECTED"
	L6_16 = A0_10._on_percent_cb
	L7_17 = ""
	L2_12(L3_13, L4_14, L5_15, L6_16, L7_17)
	L5_15 = "Time in ms\tCtrl+M"
	L6_16 = ""
	L2_12(L3_13, L4_14, L5_15, L6_16)
	L5_15 = "EVT_COMMAND_MENU_SELECTED"
	L6_16 = A0_10._on_seconds_cb
	L7_17 = ""
	L2_12(L3_13, L4_14, L5_15, L6_16, L7_17)
	for L5_15 = 0, L3_13 - 1 do
		L6_16 = string
		L6_16 = L6_16.capitalize
		L8_18 = L1_11
		L7_17 = L1_11.headername
		L8_18 = L7_17(L8_18, L5_15)
		L6_16 = L6_16(L7_17, L8_18, L7_17(L8_18, L5_15))
		L7_17 = string
		L7_17 = L7_17.format
		L8_18 = "%s:-1"
		L7_17 = L7_17(L8_18, L5_15)
		L8_18 = A0_10._view_menu
		L8_18 = L8_18.append_radio_item
		L8_18(L8_18, L7_17, "Diff " .. L6_16, "")
		L8_18 = A0_10._frame
		L8_18 = L8_18.connect
		L8_18(L8_18, L7_17, "EVT_COMMAND_MENU_SELECTED", A0_10._on_custom_cb, L7_17)
		L8_18 = table
		L8_18 = L8_18.insert
		L8_18(A0_10._view_menu_connects, L7_17)
		L8_18 = string
		L8_18 = L8_18.format
		L8_18 = L8_18("-1:%s", L5_15)
		A0_10._view_menu:append_radio_item(L8_18, "Peak " .. L6_16, "")
		A0_10._frame:connect(L8_18, "EVT_COMMAND_MENU_SELECTED", A0_10._on_custom_cb, L8_18)
		table.insert(A0_10._view_menu_connects, L8_18)
	end
	L2_12(L3_13)
	L5_15 = "Acc. and sort Calls"
	L6_16 = ""
	L2_12(L3_13, L4_14, L5_15, L6_16)
	L5_15 = "EVT_COMMAND_MENU_SELECTED"
	L6_16 = A0_10._on_acc_calls_cb
	L7_17 = ""
	L2_12(L3_13, L4_14, L5_15, L6_16, L7_17)
	L5_15 = "Keep Call order"
	L6_16 = ""
	L2_12(L3_13, L4_14, L5_15, L6_16)
	L5_15 = "EVT_COMMAND_MENU_SELECTED"
	L6_16 = A0_10._on_no_acc_calls_cb
	L7_17 = ""
	L2_12(L3_13, L4_14, L5_15, L6_16, L7_17)
	A0_10._view_menu_filled = true
end
function LuaProfilerViewer.close(A0_19)
	if A0_19._frame then
		A0_19._frame:destroy()
	end
	A0_19._treeview:destroy()
	A0_19._gridview:destroy()
	A0_19._treeview = nil
	A0_19._gridview = nil
	A0_19._lpd = nil
end
function LuaProfilerViewer.set_position(A0_20, A1_21)
	if A0_20._frame then
		A0_20._frame:set_position(A1_21)
	end
end
function LuaProfilerViewer.update(A0_22, A1_23, A2_24)
	if A0_22._capturecounter == 4 then
		Application:console_command("luaprofiler dump")
	end
	if A0_22._capturecounter == 1 then
		A0_22:_on_open()
	end
	if A0_22._capturecounter > 0 then
		A0_22._capturecounter = A0_22._capturecounter - 1
	end
end
function LuaProfilerViewer._on_close(A0_25)
	managers.toolhub:close(TOOLHUB_NAME)
end
function LuaProfilerViewer._on_open(A0_26)
	local L1_27, L2_28, L3_29, L4_30, L5_31, L6_32
	L1_27 = EWS
	L2_28 = L1_27
	L1_27 = L1_27.FileDialog
	L3_29 = A0_26._frame
	L4_30 = "Open 'luaprofiler dump_stat' File"
	L5_31 = Application
	L6_32 = L5_31
	L5_31 = L5_31.base_path
	L5_31 = L5_31(L6_32)
	L6_32 = ""
	L1_27 = L1_27(L2_28, L3_29, L4_30, L5_31, L6_32, "*.pf", "")
	L3_29 = L1_27
	L2_28 = L1_27.show_modal
	L2_28(L3_29)
	L3_29 = L1_27
	L2_28 = L1_27.get_filename
	L2_28 = L2_28(L3_29)
	L4_30 = L1_27
	L3_29 = L1_27.get_directory
	L3_29 = L3_29(L4_30)
	L4_30 = string
	L4_30 = L4_30.format
	L5_31 = "%s\\%s"
	L6_32 = L3_29
	L4_30 = L4_30(L5_31, L6_32, L2_28)
	if L2_28 ~= "" then
		L5_31 = EWS
		L6_32 = L5_31
		L5_31 = L5_31.LuaProfilerDataStore
		L5_31 = L5_31(L6_32)
		L6_32 = L5_31.parsefile
		L6_32 = L6_32(L5_31, L4_30)
		if L6_32 == "" then
			A0_26._lpd = L5_31
			A0_26:_redraw_menu()
			A0_26._lpd:buildstructure(true)
			A0_26._treeview:set_profilerdata({
				lpd = A0_26._lpd,
				displayformat = A0_26._displayformat
			})
			A0_26._gridview:set_profilerdata({
				lpd = A0_26._lpd,
				displayformat = A0_26._displayformat
			})
		else
			EWS:MessageDialog(A0_26._frame, L6_32, "Loading Error", ""):show_modal()
		end
	end
end
function LuaProfilerViewer._on_percent(A0_33)
	A0_33._displayformat = _UPVALUE0_
	if A0_33._lpd then
		if A0_33._lpd:set_cn_key(-1, -1) then
			A0_33._treeview:set_profilerdata({
				lpd = A0_33._lpd,
				displayformat = A0_33._displayformat
			})
			A0_33._gridview:set_displayformat({
				displayformat = A0_33._displayformat
			})
		else
			A0_33._treeview:set_displayformat({
				displayformat = A0_33._displayformat
			})
			A0_33._gridview:set_displayformat({
				displayformat = A0_33._displayformat
			})
		end
	end
end
function LuaProfilerViewer._on_seconds(A0_34)
	A0_34._displayformat = _UPVALUE0_
	if A0_34._lpd then
		if A0_34._lpd:set_cn_key(-1, -1) then
			A0_34._treeview:set_profilerdata({
				lpd = A0_34._lpd,
				displayformat = A0_34._displayformat
			})
			A0_34._gridview:set_displayformat({
				displayformat = A0_34._displayformat
			})
		else
			A0_34._treeview:set_displayformat({
				displayformat = A0_34._displayformat
			})
			A0_34._gridview:set_displayformat({
				displayformat = A0_34._displayformat
			})
		end
	end
end
function LuaProfilerViewer._on_custom(A0_35, A1_36)
	local L2_37, L3_38
	L2_37 = _UPVALUE0_
	A0_35._displayformat = L2_37
	L2_37 = tonumber
	L3_38 = string
	L3_38 = L3_38.split
	L3_38 = L3_38(A1_36, ":")
	L3_38 = L3_38[1]
	L2_37 = L2_37(L3_38)
	L3_38 = tonumber
	L3_38 = L3_38(string.split(A1_36, ":")[2])
	if A0_35._lpd then
		if A0_35._lpd:set_cn_key(L2_37, L3_38) then
			A0_35._treeview:set_profilerdata({
				lpd = A0_35._lpd,
				displayformat = A0_35._displayformat
			})
		else
			A0_35._treeview:set_displayformat({
				displayformat = A0_35._displayformat
			})
		end
	end
end
function LuaProfilerViewer._on_acc_calls(A0_39)
	if A0_39._lpd then
		A0_39._lpd:buildstructure(true)
		A0_39._treeview:set_profilerdata({
			lpd = A0_39._lpd,
			displayformat = A0_39._displayformat
		})
		A0_39._gridview:set_profilerdata({
			lpd = A0_39._lpd,
			displayformat = A0_39._displayformat
		})
	end
end
function LuaProfilerViewer._on_no_acc_calls(A0_40)
	if A0_40._lpd then
		A0_40._lpd:buildstructure(false)
		A0_40._treeview:set_profilerdata({
			lpd = A0_40._lpd,
			displayformat = A0_40._displayformat
		})
		A0_40._gridview:set_profilerdata({
			lpd = A0_40._lpd,
			displayformat = A0_40._displayformat
		})
	end
end
function LuaProfilerViewer._on_capture(A0_41)
	local L1_42
	A0_41._capturecounter = 6
end
