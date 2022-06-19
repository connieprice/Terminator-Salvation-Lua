core:module("CoreModesBox")
core:require_module("CoreKeywordArguments")
core:require_module("CoreSmartListCtrl")
core:require_module("CoreClass")
core:require_module("CoreEvent")
if not ModesBox then
	ModesBox = CoreClass.class()
end
local l_0_0 = "<all modes>"
ModesBox.init = function(l_1_0, ...)
	l_1_0._ews_parent = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("parent")
	l_1_0._clips_box = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("clips")
	l_1_0._markers_box = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("markers")
	l_1_0._startstop_box = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("startstop")
	l_1_0._modetiming_box = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("modetiming")
	l_1_0._songcrossfade_box = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("songcrossfade")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_1_0._song_project = nil
	l_1_0.panel = EWS:Panel(l_1_0._ews_parent, "", "")
	local l_1_2, l_1_3 = , CoreSmartListCtrl.SmartListCtrl:new
	local l_1_4 = CoreSmartListCtrl.SmartListCtrl
	local l_1_5 = {parent = l_1_0.panel}
	l_1_5.header = {"name"}
	l_1_5.static_item = {name = "(no filter -->)"}
	l_1_5.on_selected_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_mode_selected")
	l_1_5.on_static_selected_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_static_selected")
	l_1_5.on_deselected_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_mode_deselected")
	l_1_5.on_popup_menu_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_popup_menu")
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0.list = l_1_3
	l_1_3 = EWS
	l_1_3, l_1_4 = l_1_3:StaticBoxSizer, l_1_3
	l_1_5 = l_1_0.panel
	l_1_3 = l_1_3(l_1_4, l_1_5, "HORIZONTAL", "Modes")
	l_1_0.box_sizer = l_1_3
	l_1_3 = l_1_0.box_sizer
	l_1_3, l_1_4 = l_1_3:add, l_1_3
	l_1_5 = l_1_0.list
	l_1_5 = l_1_5.listctrl
	l_1_3(l_1_4, l_1_5, 1, 0, "EXPAND")
	l_1_3 = l_1_0.panel
	l_1_3, l_1_4 = l_1_3:set_sizer, l_1_3
	l_1_5 = l_1_0.box_sizer
	l_1_3(l_1_4, l_1_5)
	l_1_3 = l_1_0.list
	l_1_3 = l_1_3.listctrl
	l_1_3, l_1_4 = l_1_3:set_enabled, l_1_3
	l_1_5 = false
	l_1_3(l_1_4, l_1_5)
end

ModesBox.global_redraw = function(l_2_0, l_2_1)
	do
		if not l_2_1 then
			l_2_0._song_project = assert(l_2_0._song_project)
		end
		l_2_0.list.listctrl:set_enabled(true)
		l_2_0.list:disable_callbacks()
		l_2_0:_redraw()
		l_2_0.list:enable_callbacks()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ModesBox._redraw = function(l_3_0)
	local l_3_4, l_3_5 = nil
	l_3_0.list:clear_list()
	for i_0 in l_3_0._song_project:get_modes() do
		l_3_0.list:append_item(i_0)
	end
	l_3_0.list:autosize()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ModesBox._on_mode_selected = function(l_4_0, l_4_1, l_4_2)
	l_4_0._clips_box:mode_selected(l_4_1.name)
	l_4_0._markers_box:mode_selected(l_4_1.name)
	l_4_0._startstop_box:mode_selected(l_4_1.name)
	l_4_0._modetiming_box:mode_selected(l_4_1.name)
	l_4_0._songcrossfade_box:mode_selected(l_4_1.name)
end

ModesBox._on_static_selected = function(l_5_0)
	l_5_0._clips_box:mode_deselected()
	l_5_0._markers_box:mode_deselected()
	l_5_0._startstop_box:mode_deselected()
	l_5_0._modetiming_box:mode_deselected()
	l_5_0._songcrossfade_box:mode_deselected()
end

ModesBox._on_mode_deselected = function(l_6_0)
	l_6_0._startstop_box:mode_deselected()
	l_6_0._modetiming_box:mode_deselected()
	l_6_0._songcrossfade_box:mode_deselected()
end

ModesBox._on_popup_menu = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = {}
	l_7_3.Add = CoreEvent.callback(l_7_0, l_7_0, "_on_add")
	if l_7_2 == nil or l_7_2 == -1 then
		return l_7_3
	end
	local l_7_4, l_7_5 = l_7_0._song_project:mode_is_referenced, l_7_0._song_project
	local l_7_6 = {}
	l_7_6.name = l_7_1.name
	l_7_4 = l_7_4(l_7_5, l_7_6)
	if not l_7_4 then
		l_7_4 = CoreEvent
		l_7_4 = l_7_4.callback
		l_7_5 = l_7_0
		l_7_6 = l_7_0
		l_7_4 = l_7_4(l_7_5, l_7_6, "_on_remove")
		l_7_3.Remove = l_7_4
	end
	l_7_4 = CoreEvent
	l_7_4 = l_7_4.callback
	l_7_5 = l_7_0
	l_7_6 = l_7_0
	l_7_4 = l_7_4(l_7_5, l_7_6, "_on_rename")
	l_7_3.Rename = l_7_4
	if l_7_2 > 0 then
		l_7_4 = CoreEvent
		l_7_4 = l_7_4.callback
		l_7_5 = l_7_0
		l_7_6 = l_7_0
		l_7_4 = l_7_4(l_7_5, l_7_6, "_on_move_up")
		l_7_3["Move Up"] = l_7_4
	end
	l_7_4 = l_7_0.list
	l_7_4, l_7_5 = l_7_4:get_number_dynamic_items, l_7_4
	l_7_4 = l_7_4(l_7_5)
	l_7_4 = l_7_4 - 1
	if l_7_2 < l_7_4 then
		l_7_4 = CoreEvent
		l_7_4 = l_7_4.callback
		l_7_5 = l_7_0
		l_7_6 = l_7_0
		l_7_4 = l_7_4(l_7_5, l_7_6, "_on_move_down")
		l_7_3["Move Down"] = l_7_4
	end
	return l_7_3
end

ModesBox._on_add = function(l_8_0)
	local l_8_1 = l_8_0:_edit_mode({}, "Create New Mode")
	if l_8_1 then
		local l_8_2, l_8_3 = l_8_0._song_project:add_new_mode, l_8_0._song_project
		local l_8_4 = {}
		l_8_4.name = l_8_1.name
		l_8_2(l_8_3, l_8_4)
		l_8_2, l_8_3 = l_8_0:_redraw, l_8_0
		l_8_2(l_8_3)
	end
end

ModesBox._on_remove = function(l_9_0)
	local l_9_1 = l_9_0.list:get_selected_item()
	local l_9_2, l_9_3 = l_9_0._song_project:remove_mode, l_9_0._song_project
	local l_9_4 = {}
	l_9_4.name = l_9_1.name
	l_9_2(l_9_3, l_9_4)
	l_9_2, l_9_3 = l_9_0:_on_mode_deselected, l_9_0
	l_9_2(l_9_3)
	l_9_2, l_9_3 = l_9_0:_redraw, l_9_0
	l_9_2(l_9_3)
end

ModesBox._on_rename = function(l_10_0)
	local l_10_1 = l_10_0.list:get_selected_index()
	local l_10_2 = l_10_0.list:get_selected_item()
	local l_10_3 = l_10_0:_edit_mode(l_10_2, "Rename Mode")
	if l_10_3 then
		local l_10_4, l_10_5 = l_10_0._song_project:rename_mode, l_10_0._song_project
		local l_10_6 = {}
		l_10_6.new_name = l_10_3.name
		l_10_6.old_name = l_10_2.name
		l_10_4(l_10_5, l_10_6)
		l_10_4, l_10_5 = l_10_0:_on_mode_selected, l_10_0
		l_10_6 = l_10_3
		l_10_4(l_10_5, l_10_6)
		l_10_4, l_10_5 = l_10_0:_redraw, l_10_0
		l_10_4(l_10_5)
	end
end

ModesBox._on_move_up = function(l_11_0)
	local l_11_1 = l_11_0.list:get_selected_index()
	local l_11_2, l_11_3 = l_11_0._song_project:move_mode, l_11_0._song_project
	local l_11_4 = {}
	l_11_4.old_index = l_11_1
	l_11_4.new_index = l_11_1 - 1
	l_11_2(l_11_3, l_11_4)
	l_11_2, l_11_3 = l_11_0:_redraw, l_11_0
	l_11_2(l_11_3)
end

ModesBox._on_move_down = function(l_12_0)
	local l_12_1 = l_12_0.list:get_selected_index()
	local l_12_2, l_12_3 = l_12_0._song_project:move_mode, l_12_0._song_project
	local l_12_4 = {}
	l_12_4.old_index = l_12_1
	l_12_4.new_index = l_12_1 + 1
	l_12_2(l_12_3, l_12_4)
	l_12_2, l_12_3 = l_12_0:_redraw, l_12_0
	l_12_2(l_12_3)
end

ModesBox._edit_mode = function(l_13_0, l_13_1, l_13_2)
	do
		local l_13_3, l_13_4 = l_13_1.name or ""
	end
	local l_13_5 = nil
	while 1 do
		local l_13_6 = nil
		while 1 do
			while 1 do
				while 1 do
					while not false do
						l_13_6 = EWS:get_text_from_user(l_13_0._ews_parent, "Mode Name:", l_13_2, l_13_5, Vector3(-1, -1, 0), true)
						if l_13_6 == "" then
							return nil
						end
						if l_13_6 == "" then
							EWS:MessageDialog(l_13_0._ews_parent, "Mode must have a name.", "Wrong Input", ""):show_modal()
						end
						local l_13_7, l_13_8 = , l_13_0._song_project:find_mode
						local l_13_9 = l_13_0._song_project
						l_13_8 = l_13_8(l_13_9, {name = l_13_6})
						if l_13_8 then
							l_13_8 = EWS
							l_13_8, l_13_9 = l_13_8:MessageDialog, l_13_8
							l_13_8 = l_13_8(l_13_9, l_13_0._ews_parent, "Mode name '" .. l_13_6 .. "' already exist!", "Wrong Input", "")
							l_13_8, l_13_9 = l_13_8:show_modal, l_13_8
							l_13_8(l_13_9)
						end
						if l_13_6 == "stop" or l_13_6 == "default" then
							l_13_8 = EWS
							l_13_8, l_13_9 = l_13_8:MessageDialog, l_13_8
							l_13_8 = l_13_8(l_13_9, l_13_0._ews_parent, "Mode name can not be 'stop' or 'default'.", "Wrong Input", "")
							l_13_8, l_13_9 = l_13_8:show_modal, l_13_8
							l_13_8(l_13_9)
						end
						l_13_7 = true
					end
					do
						local l_13_10 = nil
						return {name = l_13_6}
					end
					 -- WARNING: missing end command somewhere! Added here
				end
				 -- WARNING: missing end command somewhere! Added here
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end


