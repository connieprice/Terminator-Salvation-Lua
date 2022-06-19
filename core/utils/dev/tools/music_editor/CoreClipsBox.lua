core:module("CoreClipsBox")
core:require_module("CoreKeywordArguments")
core:require_module("CoreSmartListCtrl")
core:require_module("CoreClass")
core:require_module("CoreEvent")
if not ClipsBox then
	ClipsBox = CoreClass.class()
end
local l_0_0 = "<all clips>"
ClipsBox.init = function(l_1_0, ...)
	l_1_0._ews_parent = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("parent")
	l_1_0._markers_box = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("markers")
	l_1_0._marker_edit_box = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("marker_edit")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_1_0._song_project = nil
	l_1_0._mode_name = nil
	l_1_0.panel = EWS:Panel(l_1_0._ews_parent, "", "")
	local l_1_2, l_1_3 = , CoreSmartListCtrl.SmartListCtrl:new
	local l_1_4 = CoreSmartListCtrl.SmartListCtrl
	local l_1_5 = {parent = l_1_0.panel}
	l_1_5.header = {"name", "soundbank", "sound", "start", "stop"}
	l_1_5.static_item = {name = "(no filter -->)"}
	l_1_5.on_selected_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_clip_selected")
	l_1_5.on_static_selected_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_static_selected")
	l_1_5.on_popup_menu_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_popup_menu")
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0.list = l_1_3
	l_1_3 = EWS
	l_1_3, l_1_4 = l_1_3:StaticBoxSizer, l_1_3
	l_1_5 = l_1_0.panel
	l_1_3 = l_1_3(l_1_4, l_1_5, "HORIZONTAL", "Clips")
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

ClipsBox.global_redraw = function(l_2_0, l_2_1)
	do
		if not l_2_1 then
			l_2_0._song_project = assert(l_2_0._song_project)
		end
		if l_2_0._mode_name then
			local l_2_3 = l_2_0._song_project:find_mode
			local l_2_4 = l_2_0._song_project
			l_2_3 = l_2_3(l_2_4, {name = l_2_0._mode_name})
		if not l_2_3 then
			end
			l_2_0._mode_name = nil
		end
		l_2_0.list.listctrl:set_enabled(true)
		l_2_0.list:disable_callbacks()
		l_2_0:_redraw()
		l_2_0.list:enable_callbacks()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ClipsBox.mode_selected = function(l_3_0, l_3_1)
	l_3_0._mode_name = l_3_1
	l_3_0:_redraw()
end

ClipsBox.mode_deselected = function(l_4_0)
	l_4_0._mode_name = nil
	l_4_0:_redraw()
end

ClipsBox._redraw = function(l_5_0)
	l_5_0.list:clear_list()
	if l_5_0._mode_name then
		local l_5_1, l_5_2 = l_5_0._song_project:get_clip_refs, l_5_0._song_project
		do
			local l_5_4, l_5_11, l_5_12 = {}, l_5_0._mode_name
			l_5_4.mode_name = l_5_11
			l_5_1 = l_5_1(l_5_2, l_5_4)
			for l_5_11 in l_5_1 do
				local l_5_3 = nil
				l_5_12 = l_5_0._song_project
				l_5_12, l_5_3 = l_5_12:find_clip, l_5_12
				local l_5_5, l_5_6 = nil
				local l_5_7 = nil
				l_5_6 = l_5_11.clip
				l_5_12, l_5_5 = l_5_12(l_5_3, l_5_5), {name = l_5_6}
				l_5_3 = l_5_0.list
				l_5_3, l_5_5 = l_5_3:append_item, l_5_3
				l_5_6 = l_5_12
				l_5_3(l_5_5, l_5_6)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		for i_0 in l_5_0._song_project:get_clips() do
			local l_5_9, l_5_10 = nil
			l_5_9 = l_5_0.list
			l_5_9, l_5_10 = l_5_9:append_item, l_5_9
			l_5_9(l_5_10, l_5_8)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

ClipsBox._on_clip_selected = function(l_6_0, l_6_1, l_6_2)
	l_6_0._markers_box:clip_selected(l_6_1.name)
end

ClipsBox._on_static_selected = function(l_7_0)
	l_7_0._markers_box:clip_deselected()
end

ClipsBox._on_popup_menu = function(l_8_0, l_8_1, l_8_2)
	local l_8_3 = {}
	l_8_3["Create new clip"] = CoreEvent.callback(l_8_0, l_8_0, "_on_create")
	if l_8_0._mode_name then
		local l_8_4 = string.format("Create and add new clip to mode '%s'", l_8_0._mode_name)
		l_8_3[l_8_4] = CoreEvent.callback(l_8_0, l_8_0, "_on_create_and_add")
	if l_8_0._song_project:get_number_clips() > 0 then
		end
		local l_8_5 = string.format("Find and add existing clip to mode '%s'", l_8_0._mode_name)
		l_8_3[l_8_5] = CoreEvent.callback(l_8_0, l_8_0, "_on_find_and_add")
	end
	if l_8_2 == nil or l_8_2 == -1 then
		return l_8_3
	end
	if l_8_0._mode_name then
		local l_8_6, l_8_7 = l_8_0._song_project:mode_clip_is_referenced, l_8_0._song_project
		local l_8_8 = {}
		l_8_8.mode_name = l_8_0._mode_name
		l_8_8.clip_name = l_8_1.name
		l_8_6 = l_8_6(l_8_7, l_8_8)
		if not l_8_6 then
			l_8_6 = CoreEvent
			l_8_6 = l_8_6.callback
			l_8_7 = l_8_0
			l_8_8 = l_8_0
			l_8_6 = l_8_6(l_8_7, l_8_8, "_on_remove_from_mode")
			l_8_3["Remove Clip From Mode"] = l_8_6
		end
	else
		local l_8_9, l_8_10 = l_8_0._song_project:clip_is_referenced, l_8_0._song_project
		local l_8_11 = {}
		l_8_11.name = l_8_1.name
		l_8_9 = l_8_9(l_8_10, l_8_11)
	if not l_8_9 then
		end
		l_8_9 = CoreEvent
		l_8_9 = l_8_9.callback
		l_8_10 = l_8_0
		l_8_11 = l_8_0
		l_8_9 = l_8_9(l_8_10, l_8_11, "_on_remove")
		l_8_3.Remove = l_8_9
	end
	l_8_3.Modify = CoreEvent.callback(l_8_0, l_8_0, "_on_modify")
	if l_8_0._mode_name then
		if l_8_2 > 0 then
			l_8_3["Move Up"] = CoreEvent.callback(l_8_0, l_8_0, "_on_move_up")
		end
	if l_8_2 < l_8_0.list:get_number_dynamic_items() - 1 then
		end
		l_8_3["Move Down"] = CoreEvent.callback(l_8_0, l_8_0, "_on_move_down")
	end
	return l_8_3
end

ClipsBox._on_create_and_add = function(l_9_0)
	local l_9_1 = l_9_0:_on_create()
	if l_9_1 then
		local l_9_2, l_9_3 = l_9_0._song_project:add_clip_to_mode, l_9_0._song_project
		local l_9_4 = {}
		l_9_4.mode_name = l_9_0._mode_name
		l_9_4.clip_name = l_9_1.name
		l_9_2(l_9_3, l_9_4)
	end
	l_9_0:_redraw()
end

ClipsBox._on_find_and_add = function(l_10_0)
	local l_10_5 = nil
	local l_10_1 = {}
	for i_0 in l_10_0._song_project:get_clips() do
		local l_10_7 = l_10_0._song_project:mode_has_clip
		local l_10_8 = l_10_0._song_project
		l_10_7 = l_10_7(l_10_8, {mode_name = l_10_0._mode_name, clip_name = l_10_6.name})
		if not l_10_7 then
			l_10_8 = table
			l_10_8 = l_10_8.insert
			l_10_8(l_10_1, l_10_6.name)
		end
	end
	if EWS:SingleChoiceDialog(l_10_0._ews_parent, "Add Audioclip to Mode '" .. l_10_0._mode_name .. "'", "", l_10_1, ""):show_modal() == "ID_OK" then
		local l_10_9 = l_10_0._song_project
		do
			local l_10_10 = {}
			l_10_0._song_project:add_clip_to_mode(l_10_10)
			l_10_0:_redraw()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

ClipsBox._on_create = function(l_11_0)
	local l_11_1 = l_11_0:_edit_clip({}, "Create New Clip")
	if l_11_1 then
		local l_11_2, l_11_3 = l_11_0._song_project:add_new_clip, l_11_0._song_project
		local l_11_4 = {}
		l_11_4.name = l_11_1.name
		l_11_4.soundbank = l_11_1.soundbank
		l_11_4.sound = l_11_1.sound
		l_11_4.start = l_11_1.start
		l_11_4.stop = l_11_1.stop
		l_11_2(l_11_3, l_11_4)
		l_11_2, l_11_3 = l_11_0:_redraw, l_11_0
		l_11_2(l_11_3)
	end
	return l_11_1
end

ClipsBox._on_modify = function(l_12_0)
	local l_12_1 = l_12_0.list:get_selected_index()
	local l_12_2 = l_12_0.list:get_selected_item()
	local l_12_3 = l_12_0:_edit_clip(l_12_2, "Modify Clip")
	if l_12_3 then
		local l_12_4, l_12_5 = l_12_0._song_project:modify_clip, l_12_0._song_project
		local l_12_6 = {}
		l_12_6.name = l_12_3.name
		l_12_6.soundbank = l_12_3.soundbank
		l_12_6.sound = l_12_3.sound
		l_12_6.start = l_12_3.start
		l_12_6.stop = l_12_3.stop
		l_12_6.old_name = l_12_2.name
		l_12_4(l_12_5, l_12_6)
		l_12_4, l_12_5 = l_12_0:_redraw, l_12_0
		l_12_4(l_12_5)
		l_12_4 = l_12_0._marker_edit_box
		l_12_4, l_12_5 = l_12_4:clip_modified, l_12_4
		l_12_4(l_12_5)
	end
end

ClipsBox._on_remove = function(l_13_0)
	local l_13_1 = l_13_0.list:get_selected_item()
	local l_13_2, l_13_3 = l_13_0._song_project:remove_clip, l_13_0._song_project
	local l_13_4 = {}
	l_13_4.name = l_13_1.name
	l_13_2(l_13_3, l_13_4)
	l_13_2, l_13_3 = l_13_0:_redraw, l_13_0
	l_13_2(l_13_3)
end

ClipsBox._on_remove_from_mode = function(l_14_0)
	local l_14_1 = l_14_0.list:get_selected_index()
	local l_14_2, l_14_3 = l_14_0._song_project:remove_clip_from_mode, l_14_0._song_project
	local l_14_4 = {}
	l_14_4.mode_name = l_14_0._mode_name
	l_14_4.index = l_14_1
	l_14_2(l_14_3, l_14_4)
	l_14_2, l_14_3 = l_14_0:_redraw, l_14_0
	l_14_2(l_14_3)
end

ClipsBox._on_move_up = function(l_15_0)
	local l_15_1 = l_15_0.list:get_selected_index()
	local l_15_2, l_15_3 = l_15_0._song_project:move_clip_in_mode, l_15_0._song_project
	local l_15_4 = {}
	l_15_4.mode_name = l_15_0._mode_name
	l_15_4.old_index = l_15_1
	l_15_4.new_index = l_15_1 - 1
	l_15_2(l_15_3, l_15_4)
	l_15_2, l_15_3 = l_15_0:_redraw, l_15_0
	l_15_2(l_15_3)
end

ClipsBox._on_move_down = function(l_16_0)
	local l_16_1 = l_16_0.list:get_selected_index()
	local l_16_2, l_16_3 = l_16_0._song_project:move_clip_in_mode, l_16_0._song_project
	local l_16_4 = {}
	l_16_4.mode_name = l_16_0._mode_name
	l_16_4.old_index = l_16_1
	l_16_4.new_index = l_16_1 + 1
	l_16_2(l_16_3, l_16_4)
	l_16_2, l_16_3 = l_16_0:_redraw, l_16_0
	l_16_2(l_16_3)
end

ClipsBox._edit_clip = function(l_17_0, l_17_1, l_17_2)
	do
		local l_17_3 = l_17_1.name or ""
	do
		end
		local l_17_4 = nil
	do
		end
		local l_17_5 = nil
	do
		end
		local l_17_6 = nil
	do
		end
		local l_17_7 = nil
	end
	local l_17_8, l_17_9, l_17_10, l_17_11, l_17_12 = , l_17_1.soundbank or "", l_17_1.sound or "", l_17_1.start or "0", l_17_1.stop or "0"
	local l_17_13 = nil
	local l_17_14 = nil
	local l_17_15 = nil
	local l_17_16 = nil
	local l_17_17 = nil
	local l_17_18 = nil
	local l_17_19 = EWS:TextCtrl(EWS:Dialog(l_17_0._ews_parent, l_17_2, "", Vector3(-1, -1, 0), Vector3(280, 240, 0), ""), l_17_8, "", "")
	local l_17_20 = EWS:TextCtrl(EWS:Dialog(l_17_0._ews_parent, l_17_2, "", Vector3(-1, -1, 0), Vector3(280, 240, 0), ""), l_17_9, "", "")
	EWS:SpinCtrl(EWS:Dialog(l_17_0._ews_parent, l_17_2, "", Vector3(-1, -1, 0), Vector3(280, 240, 0), ""), tonumber(l_17_11), "", ""):set_range(0, 160000000)
	EWS:SpinCtrl(EWS:Dialog(l_17_0._ews_parent, l_17_2, "", Vector3(-1, -1, 0), Vector3(280, 240, 0), ""), tonumber(l_17_12), "", ""):set_range(0, 160000000)
	local l_17_21 = EWS:TextCtrl(EWS:Dialog(l_17_0._ews_parent, l_17_2, "", Vector3(-1, -1, 0), Vector3(280, 240, 0), ""), l_17_10, "", "")
	local l_17_22 = nil
	local l_17_23 = nil
	l_17_18:set_sizer(EWS:BoxSizer("VERTICAL"))
	EWS:FlexGridSizer(5, 2, 10, 10):add(EWS:StaticText(l_17_18, "Clip Name:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(l_17_19, 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(EWS:StaticText(l_17_18, "Soundbank Name:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(l_17_20, 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(EWS:StaticText(l_17_18, "Sound Name:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(l_17_21, 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(EWS:StaticText(l_17_18, "Start Sample:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(l_17_22, 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(EWS:StaticText(l_17_18, "Stop Sample:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(5, 2, 10, 10):add(l_17_23, 0, 0, "")
	EWS:FlexGridSizer(1, 2, 40, 10):add(EWS:Button(l_17_18, "Apply", "", ""), 0, 0, "ALIGN_CENTER")
	EWS:FlexGridSizer(1, 2, 40, 10):add(EWS:Button(l_17_18, "Cancel", "", ""), 0, 0, "ALIGN_CENTER")
	EWS:BoxSizer("VERTICAL"):add(EWS:StaticText(l_17_18, "", "", ""), 0, 0, "")
	EWS:BoxSizer("VERTICAL"):add(EWS:FlexGridSizer(5, 2, 10, 10), 1, 0, "ALIGN_CENTER")
	EWS:BoxSizer("VERTICAL"):add(EWS:FlexGridSizer(1, 2, 40, 10), 0, 0, "ALIGN_CENTER")
	local l_17_24 = nil
	l_17_24:connect("", "EVT_COMMAND_BUTTON_CLICKED", function()
		-- upvalues: l_17_24 , l_17_13
		l_17_24 = "APPLY"
		l_17_13:end_modal()
  end, "")
	EWS:Button(l_17_18, "Cancel", "", ""):connect("", "EVT_COMMAND_BUTTON_CLICKED", function()
		-- upvalues: l_17_24 , l_17_13
		l_17_24 = "CANCEL"
		l_17_13:end_modal()
  end, "")
	while 1 do
		local l_17_27 = nil
		while 1 do
			while 1 do
				while 1 do
					while 1 do
						while not false do
							l_17_18:show_modal()
							if "CANCEL" == "CANCEL" then
								return nil
							end
							l_17_13 = l_17_19:get_value()
							l_17_14 = l_17_20:get_value()
							l_17_15 = l_17_21:get_value()
							l_17_16 = l_17_22:get_value()
							l_17_17 = l_17_23:get_value()
							if l_17_13 == "" then
								EWS:MessageDialog(l_17_0._ews_parent, "Clip must have a name.", "Wrong Input", ""):show_modal()
							end
							if l_17_15 == "" then
								EWS:MessageDialog(l_17_0._ews_parent, "Sound must have a name.", "Wrong Input", ""):show_modal()
							end
							if l_17_14 == "" then
								EWS:MessageDialog(l_17_0._ews_parent, "Sound Bank must have a name.", "Wrong Input", ""):show_modal()
							end
							if l_17_13 ~= l_17_8 then
								local l_17_28, l_17_29 = nil
								local l_17_30 = nil
							if l_17_0._song_project:find_clip({name = l_17_13}) then
								end
								EWS:MessageDialog(l_17_0._ews_parent, "Clip name '" .. l_17_13 .. "' is already used.", "Wrong Input", ""):show_modal()
							end
						end
						do
							local l_17_31 = nil
							return {name = l_17_13, soundbank = l_17_14, sound = l_17_15, start = l_17_16, stop = l_17_17}
						end
						 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

						 -- WARNING: undefined locals caused missing assignments!
						 -- WARNING: missing end command somewhere! Added here
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


