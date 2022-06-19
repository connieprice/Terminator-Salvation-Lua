core:module("CoreMarkersBox")
core:require_module("CoreKeywordArguments")
core:require_module("CoreSmartListCtrl")
core:require_module("CoreClass")
core:require_module("CoreEvent")
if not MarkersBox then
	MarkersBox = CoreClass.class()
end
MarkersBox.init = function(l_1_0, ...)
	l_1_0._ews_parent = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("parent")
	l_1_0._marker_edit_box = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("marker_edit")
	l_1_0._modecrossfade_box = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("modecrossfade")
	l_1_0._main_redraw_cb = CoreKeywordArguments.KeywordArguments:new(...):mandatory_function("main_redraw_cb")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_1_0._song_project = nil
	l_1_0.panel = EWS:Panel(l_1_0._ews_parent, "", "")
	local l_1_2, l_1_3 = , CoreSmartListCtrl.SmartListCtrl:new
	local l_1_4 = CoreSmartListCtrl.SmartListCtrl
	local l_1_5 = {parent = l_1_0.panel}
	l_1_5.header = {"name"}
	l_1_5.on_selected_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_marker_selected")
	l_1_5.on_deselected_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_marker_deselected")
	l_1_5.on_popup_menu_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_popup_menu")
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0.list = l_1_3
	l_1_3 = EWS
	l_1_3, l_1_4 = l_1_3:StaticBoxSizer, l_1_3
	l_1_5 = l_1_0.panel
	l_1_3 = l_1_3(l_1_4, l_1_5, "HORIZONTAL", "Markers")
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
	l_1_3 = l_1_0._marker_edit_box
	l_1_3, l_1_4 = l_1_3:register_on_sample_update_cb, l_1_3
	l_1_5 = CoreEvent
	l_1_5 = l_1_5.callback
	l_1_3(l_1_4, l_1_5)
end

MarkersBox.global_redraw = function(l_2_0, l_2_1)
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
		if l_2_0._clip_name then
			local l_2_5 = l_2_0._song_project:find_clip
			local l_2_6 = l_2_0._song_project
			l_2_5 = l_2_5(l_2_6, {name = l_2_0._clip_name})
		if not l_2_5 then
			end
			l_2_0._clip_name = nil
		end
		l_2_0.list.listctrl:set_enabled(true)
		l_2_0.list:disable_callbacks()
		l_2_0:_redraw()
		l_2_0.list:enable_callbacks()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MarkersBox.mode_selected = function(l_3_0, l_3_1)
	l_3_0._mode_name = l_3_1
	l_3_0._clip_name = nil
	l_3_0:_redraw()
end

MarkersBox.mode_deselected = function(l_4_0)
	l_4_0._mode_name = nil
	l_4_0._clip_name = nil
	l_4_0:_redraw()
end

MarkersBox.clip_selected = function(l_5_0, l_5_1)
	l_5_0._clip_name = l_5_1
	l_5_0:_redraw()
end

MarkersBox.clip_deselected = function(l_6_0)
	l_6_0._clip_name = nil
	l_6_0:_redraw()
end

MarkersBox._redraw = function(l_7_0)
	local l_7_1, l_7_5, l_7_6 = nil
	l_7_0.list:clear_list()
	for i_0 in l_7_0._song_project:get_markers() do
		local l_7_2 = l_7_0.list:get_selected_item()
		if (l_7_0._mode_name and i_0.mode ~= l_7_0._mode_name and not l_7_0._clip_name) or false then
			local l_7_9 = nil
			local l_7_10 = l_7_0.list:append_item
			l_7_10(l_7_0.list, {name = l_7_8.name})
		if l_7_2 then
			end
			l_7_10 = l_7_2.name
		if l_7_10 == l_7_8.name then
			end
			l_7_10 = l_7_0.list
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_7_1 = l_7_10 - 1
		end
	end
	l_7_0.list:autosize()
	if l_7_1 then
		l_7_0.list:disable_callbacks()
		l_7_0.list:set_selected(l_7_1)
		l_7_0.list:enable_callbacks()
	else
		l_7_0._marker_edit_box:marker_deselected()
		l_7_0._modecrossfade_box:marker_deselected()
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

MarkersBox._on_marker_selected = function(l_8_0, l_8_1, l_8_2)
	l_8_0._marker_edit_box:marker_selected(l_8_1.name)
	l_8_0._modecrossfade_box:marker_selected(l_8_1.name)
end

MarkersBox._on_marker_deselected = function(l_9_0)
	l_9_0._marker_edit_box:marker_deselected()
	l_9_0._modecrossfade_box:marker_deselected()
end

MarkersBox._on_popup_menu = function(l_10_0, l_10_1, l_10_2)
	local l_10_3 = {}
	l_10_3.Add = CoreEvent.callback(l_10_0, l_10_0, "_on_add")
	if l_10_2 == nil then
		return l_10_3
	end
	l_10_3.Modify = CoreEvent.callback(l_10_0, l_10_0, "_on_modify")
	l_10_3.Duplicate = CoreEvent.callback(l_10_0, l_10_0, "_on_duplicate")
	local l_10_4, l_10_5 = l_10_0._song_project:marker_is_referenced, l_10_0._song_project
	local l_10_6 = {}
	l_10_6.name = l_10_1.name
	l_10_4 = l_10_4(l_10_5, l_10_6)
	if not l_10_4 then
		l_10_4 = CoreEvent
		l_10_4 = l_10_4.callback
		l_10_5 = l_10_0
		l_10_6 = l_10_0
		l_10_4 = l_10_4(l_10_5, l_10_6, "_on_remove")
		l_10_3.Remove = l_10_4
	end
	return l_10_3
end

MarkersBox._on_add = function(l_11_0)
	local l_11_1, l_11_2 = l_11_0:_edit_marker, l_11_0
	local l_11_3 = {}
	l_11_3.mode = l_11_0._mode_name
	l_11_3.clip = l_11_0._clip_name
	l_11_1 = l_11_1(l_11_2, l_11_3, "Add New Marker")
	if l_11_1 then
		l_11_2 = l_11_0._song_project
		l_11_2, l_11_3 = l_11_2:add_new_marker, l_11_2
		local l_11_4 = {}
		l_11_4.name = l_11_1.name
		l_11_4.mode = l_11_1.mode
		l_11_4.clip = l_11_1.clip
		l_11_2(l_11_3, l_11_4)
		l_11_2 = l_11_0._song_project
		l_11_2, l_11_3 = l_11_2:add_new_rule, l_11_2
		l_11_2(l_11_3, l_11_4)
		l_11_4 = {rule = "default", weight = 1, jump_to = l_11_1.name, fade_in = "0.5", fade_out = "0.5", marker_name = l_11_1.name}
		l_11_2, l_11_3 = l_11_0:_redraw, l_11_0
		l_11_2(l_11_3)
	end
end

MarkersBox._on_modify = function(l_12_0)
	local l_12_1 = l_12_0.list:get_selected_index()
	local l_12_2 = l_12_0.list:get_selected_item().name
	local l_12_3, l_12_4 = l_12_0._song_project:find_marker, l_12_0._song_project
	local l_12_5 = {}
	l_12_5.name = l_12_2
	l_12_3 = l_12_3(l_12_4, l_12_5)
	l_12_4 = l_12_3.mode
	l_12_5 = l_12_3.clip
	local l_12_6, l_12_7 = l_12_0:_edit_marker, l_12_0
	local l_12_8 = {}
	l_12_8.name = l_12_2
	l_12_8.mode = l_12_4
	l_12_8.clip = l_12_5
	l_12_6 = l_12_6(l_12_7, l_12_8, "Modify Marker")
	if l_12_6 then
		l_12_7 = l_12_0._song_project
		l_12_7, l_12_8 = l_12_7:modify_marker, l_12_7
		local l_12_9 = {}
		l_12_9.name = l_12_6.name
		l_12_9.mode = l_12_6.mode
		l_12_9.clip = l_12_6.clip
		l_12_9.old_name = l_12_2
		l_12_7(l_12_8, l_12_9)
		l_12_7 = l_12_0._main_redraw_cb
		l_12_7()
	end
end

MarkersBox._on_remove = function(l_13_0)
	local l_13_1 = l_13_0.list:get_selected_item()
	local l_13_2, l_13_3 = l_13_0._song_project:remove_marker, l_13_0._song_project
	local l_13_4 = {}
	l_13_4.name = l_13_1.name
	l_13_2(l_13_3, l_13_4)
	l_13_2, l_13_3 = l_13_0:_redraw, l_13_0
	l_13_2(l_13_3)
end

MarkersBox._on_duplicate = function(l_14_0)
	local l_14_1 = l_14_0.list:get_selected_item()
	local l_14_2, l_14_3 = l_14_0._song_project:find_marker, l_14_0._song_project
	local l_14_4 = {}
	l_14_4.name = l_14_1.name
	l_14_2 = l_14_2(l_14_3, l_14_4)
	l_14_3 = string
	l_14_3 = l_14_3.format
	l_14_4 = "copy_of_%s"
	l_14_3 = l_14_3(l_14_4, l_14_1.name)
	l_14_4 = 2
	while 1 do
		local l_14_5, l_14_6 = l_14_0._song_project:find_marker, l_14_0._song_project
		local l_14_7 = {}
		l_14_7.name = l_14_3
		l_14_5 = l_14_5(l_14_6, l_14_7)
		if l_14_5 then
			l_14_5 = string
			l_14_5 = l_14_5.format
			l_14_6 = "copy(%d)_of_%s"
			l_14_7 = l_14_4
			l_14_5 = l_14_5(l_14_6, l_14_7, l_14_1.name)
			l_14_3 = l_14_5
			l_14_4 = l_14_4 + 1
		end
		l_14_5 = l_14_0._song_project
		l_14_5, l_14_6 = l_14_5:add_new_marker, l_14_5
		l_14_5(l_14_6, l_14_7)
		l_14_7 = {name = l_14_3, mode = l_14_2.mode, clip = l_14_2.clip}
		l_14_5 = l_14_0._song_project
		l_14_5, l_14_6 = l_14_5:set_marker_sample, l_14_5
		local l_14_9 = tonumber
		l_14_9 = l_14_9(l_14_2.sample)
		l_14_5(l_14_6, l_14_7)
		l_14_7 = {name = l_14_3, sample = l_14_9}
		l_14_5 = l_14_0._song_project
		l_14_5, l_14_6 = l_14_5:get_rules, l_14_5
		l_14_9 = l_14_1.name
		l_14_5, l_14_7 = l_14_5(l_14_6, l_14_7), {marker_name = l_14_9}
		l_14_6 = l_14_5
		l_14_9, l_14_7 = nil
		for i_0 in l_14_6 do
			local l_14_10 = nil
			if l_14_8.jump_to == l_14_2.name then
				l_14_10 = l_14_3
			else
				l_14_10 = l_14_8.jump_to
			end
			local l_14_11, l_14_12 = l_14_0._song_project:add_new_rule, l_14_0._song_project
			local l_14_13 = {}
			l_14_13.rule = l_14_8.rule
			l_14_13.weight = tonumber(l_14_8.weight)
			l_14_13.jump_to = l_14_10
			l_14_13.fade_in = l_14_8.fade_in
			l_14_13.fade_out = l_14_8.fade_out
			l_14_13.marker_name = l_14_3
			l_14_11(l_14_12, l_14_13)
		end
		l_14_0:_redraw()
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
end

MarkersBox._edit_marker = function(l_15_0, l_15_1, l_15_2)
	do
		local l_15_3 = l_15_1.name or ""
	do
		end
		local l_15_4 = nil
	do
		end
		local l_15_5 = nil
	end
	local l_15_6, l_15_7, l_15_8 = , l_15_1.mode or "", l_15_1.clip or ""
	local l_15_9 = nil
	local l_15_10 = nil
	local l_15_11 = nil
	local l_15_12 = nil
	local l_15_13 = EWS:TextCtrl(EWS:Dialog(l_15_0._ews_parent, l_15_2, "", Vector3(-1, -1, 0), Vector3(250, 200, 0), ""), l_15_6, "", "")
	local l_15_18 = EWS:ComboBox(EWS:Dialog(l_15_0._ews_parent, l_15_2, "", Vector3(-1, -1, 0), Vector3(250, 200, 0), ""), "", "", "CB_READONLY")
	local l_15_14 = EWS:ComboBox(EWS:Dialog(l_15_0._ews_parent, l_15_2, "", Vector3(-1, -1, 0), Vector3(250, 200, 0), ""), "", "", "CB_READONLY")
	for i_0 in l_15_0._song_project:get_modes() do
		local l_15_15, l_15_16 = EWS:Button(l_15_12, "Apply", "", ""), EWS:Button(l_15_12, "Cancel", "", "")
		l_15_18:append(i_0.name)
	end
	for i_0 in l_15_0._song_project:get_clips() do
		l_15_14:append(i_0.name)
	end
	l_15_18:set_value(l_15_7)
	l_15_14:set_value(l_15_8)
	l_15_12:set_sizer(EWS:BoxSizer("VERTICAL"))
	EWS:FlexGridSizer(3, 2, 10, 10):add(EWS:StaticText(l_15_12, "Marker Name:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(3, 2, 10, 10):add(l_15_13, 0, 0, "")
	EWS:FlexGridSizer(3, 2, 10, 10):add(EWS:StaticText(l_15_12, "Mode Name:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(3, 2, 10, 10):add(l_15_18, 0, 0, "")
	EWS:FlexGridSizer(3, 2, 10, 10):add(EWS:StaticText(l_15_12, "Clip Name:", "", ""), 0, 0, "")
	EWS:FlexGridSizer(3, 2, 10, 10):add(l_15_14, 0, 0, "")
	EWS:FlexGridSizer(1, 2, 40, 10):add(l_15_15, 0, 0, "ALIGN_CENTER")
	EWS:FlexGridSizer(1, 2, 40, 10):add(l_15_16, 0, 0, "ALIGN_CENTER")
	EWS:BoxSizer("VERTICAL"):add(EWS:StaticText(l_15_12, "", "", ""), 0, 0, "")
	EWS:BoxSizer("VERTICAL"):add(EWS:FlexGridSizer(3, 2, 10, 10), 1, 0, "ALIGN_CENTER")
	EWS:BoxSizer("VERTICAL"):add(EWS:FlexGridSizer(1, 2, 40, 10), 0, 0, "ALIGN_CENTER")
	l_15_15:connect("", "EVT_COMMAND_BUTTON_CLICKED", function()
		-- upvalues: l_15_18 , l_15_9
		l_15_18 = "APPLY"
		l_15_9:end_modal()
  end, "")
	l_15_16:connect("", "EVT_COMMAND_BUTTON_CLICKED", function()
		-- upvalues: l_15_18 , l_15_9
		l_15_18 = "CANCEL"
		l_15_9:end_modal()
  end, "")
	while 1 do
		local l_15_21 = nil
		while 1 do
			while 1 do
				while 1 do
					while 1 do
						while 1 do
							while 1 do
								while not false do
									l_15_12:show_modal()
									if "CANCEL" == "CANCEL" then
										return nil
									end
									l_15_9 = l_15_13:get_value()
									l_15_10 = l_15_18:get_value()
									l_15_11 = l_15_14:get_value()
									if l_15_9 == "" then
										EWS:MessageDialog(l_15_0._ews_parent, "Marker must have a name.", "Wrong Input", ""):show_modal()
									end
									if l_15_9 == "__END_SONG__" then
										EWS:MessageDialog(l_15_0._ews_parent, "Marker name can not be 'END_SONG'.", "Wrong Input", ""):show_modal()
									end
									if l_15_9 ~= l_15_6 then
										local l_15_22, l_15_23 = nil
										local l_15_24 = nil
									if l_15_0._song_project:find_marker({name = l_15_9}) then
										end
										EWS:MessageDialog(l_15_0._ews_parent, "Marker name '" .. l_15_9 .. "' is already used.", "Wrong Input", ""):show_modal()
									end
									local l_15_25, l_15_26 = nil
									local l_15_27 = nil
									if not l_15_0._song_project:find_mode({name = l_15_10}) then
										EWS:MessageDialog(l_15_0._ews_parent, "Marker must have a Mode.", "Wrong Input", ""):show_modal()
									end
									if not l_15_0._song_project:find_clip({name = l_15_11}) then
										EWS:MessageDialog(l_15_0._ews_parent, "Marker must have a Clip.", "Wrong Input", ""):show_modal()
									end
									if not l_15_0._song_project:mode_has_clip({mode_name = l_15_10, clip_name = l_15_11}) then
										EWS:MessageDialog(l_15_0._ews_parent, "Mode '" .. l_15_10 .. "' does not have clip '" .. l_15_11 .. "'.", "Wrong Input", ""):show_modal()
									end
								end
								do
									local l_15_28 = nil
									return {name = l_15_9, mode = l_15_10, clip = l_15_11}
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
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end


