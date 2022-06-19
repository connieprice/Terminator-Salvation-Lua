require("core/managers/cutscene/keys/CoreSetupCutsceneKeyBase")
if not CoreSpawnUnitCutsceneKey then
	CoreSpawnUnitCutsceneKey = class(CoreSetupCutsceneKeyBase)
end
CoreSpawnUnitCutsceneKey.ELEMENT_NAME = "spawn_unit"
CoreSpawnUnitCutsceneKey.NAME = "Spawn Unit"
CoreSpawnUnitCutsceneKey:register_serialized_attribute("name", "")
CoreSpawnUnitCutsceneKey:register_serialized_attribute("unit_category", "")
CoreSpawnUnitCutsceneKey:register_serialized_attribute("unit_type", "")
CoreSpawnUnitCutsceneKey:register_control("database_browser_button")
CoreSpawnUnitCutsceneKey:register_control("divider")
CoreSpawnUnitCutsceneKey:register_serialized_attribute("parent_unit_name", "")
CoreSpawnUnitCutsceneKey:register_serialized_attribute("parent_object_name", "")
CoreSpawnUnitCutsceneKey:register_serialized_attribute("offset", Vector3(0, 0, 0), CoreCutsceneKeyBase.string_to_vector)
CoreSpawnUnitCutsceneKey:register_serialized_attribute("rotation", Rotation(), CoreCutsceneKeyBase.string_to_rotation)
CoreSpawnUnitCutsceneKey:attribute_affects("unit_category", "unit_type")
CoreSpawnUnitCutsceneKey:attribute_affects("parent_unit_name", "parent_object_name")
CoreSpawnUnitCutsceneKey.control_for_unit_category = CoreSetupCutsceneKeyBase.standard_combo_box_control
CoreSpawnUnitCutsceneKey.control_for_unit_type = CoreSetupCutsceneKeyBase.standard_combo_box_control
CoreSpawnUnitCutsceneKey.control_for_divider = CoreSetupCutsceneKeyBase.standard_divider_control
CoreSpawnUnitCutsceneKey.control_for_parent_unit_name = CoreSetupCutsceneKeyBase.standard_combo_box_control
CoreSpawnUnitCutsceneKey.control_for_parent_object_name = CoreSetupCutsceneKeyBase.standard_combo_box_control
CoreSpawnUnitCutsceneKey.__tostring = function(l_1_0)
	local l_1_1 = string.format
	local l_1_2 = "Spawn %s named \"%s\"."
	local l_1_3 = l_1_0:unit_type()
	local l_1_4, l_1_5 = l_1_0:name(), .end
	return l_1_1(l_1_2, l_1_3, l_1_4, l_1_5)
end

CoreSpawnUnitCutsceneKey.prime = function(l_2_0, l_2_1)
	if l_2_0:is_valid() then
		World:preload_unit(l_2_0:unit_type())
	end
	l_2_0:_spawn_unit()
end

CoreSpawnUnitCutsceneKey.unload = function(l_3_0, l_3_1)
	if l_3_0._cast then
		l_3_0:_delete_unit()
	end
end

CoreSpawnUnitCutsceneKey.play = function(l_4_0, l_4_1, l_4_2, l_4_3)
	l_4_0:_reparent_unit()
end

CoreSpawnUnitCutsceneKey.is_valid_unit_category = function(l_5_0, l_5_1)
	if not Application:ews_enabled() then
		return true
	elseif l_5_1 ~= nil then
		local l_5_2 = table.contains(UnitDatabase:get_unit_types(), l_5_1)
	else
		return false
	end
end

CoreSpawnUnitCutsceneKey.is_valid_unit_type = function(l_6_0, l_6_1)
	return l_6_1 ~= nil and UnitDatabase:get_unit_data(l_6_1) ~= nil
end

CoreSpawnUnitCutsceneKey.is_valid_name = function(l_7_0, l_7_1)
	if l_7_1 == nil or #l_7_1 <= 3 or string.match(l_7_1, "[a-z_0-9]+") ~= l_7_1 then
		return false
	end
	local l_7_2 = l_7_0:_unit(l_7_1, true)
	return l_7_2 == nil or l_7_2 == l_7_0._spawned_unit
end

CoreSpawnUnitCutsceneKey.control_for_database_browser_button = function(l_8_0, l_8_1)
	local l_8_2 = EWS:Button(l_8_1, "Pick From Database Browser", "", "")
	l_8_2:connect("EVT_COMMAND_BUTTON_CLICKED", callback(l_8_0, l_8_0, "_on_database_browser_button_clicked"), l_8_2)
	return l_8_2
end

CoreSpawnUnitCutsceneKey.refresh_control_for_unit_category = function(l_9_0, l_9_1)
	l_9_1:freeze()
	l_9_1:clear()
	local l_9_2 = l_9_0:unit_category()
	local l_9_6, l_9_7 = ipairs, UnitDatabase:get_unit_types()
	l_9_6 = l_9_6(l_9_7)
	for i_0,i_1 in l_9_6 do
		l_9_1:append(l_9_5)
		if l_9_5 == l_9_2 then
			l_9_1:set_value(l_9_2)
		end
	end
	l_9_1:thaw()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSpawnUnitCutsceneKey.refresh_control_for_unit_type = function(l_10_0, l_10_1)
	l_10_1:freeze()
	l_10_1:clear()
	local l_10_2 = l_10_0:unit_type()
	if l_10_0:unit_category() then
		local l_10_8, l_10_9, l_10_10, l_10_11, l_10_12, l_10_13, l_10_14, l_10_15 = table.collect, UnitDatabase:get_unit_data_by_type, UnitDatabase, l_10_0:unit_category(), .end
		l_10_9 = l_10_9(l_10_10, l_10_11, l_10_12, l_10_13, l_10_14, l_10_15)
		l_10_10 = function(l_11_0)
			local l_11_1, l_11_2 = l_11_0:name, l_11_0
			return l_11_1(l_11_2)
    end
		l_10_8 = l_10_8(l_10_9, l_10_10)
	if not l_10_8 then
		end
	end
	do
		local l_10_3, l_10_4 = nil
	end
	l_10_9 = ipairs
	l_10_10, l_10_8 = l_10_8, {}
	l_10_9 = l_10_9(l_10_10)
	for l_10_12,l_10_13 in l_10_9 do
		do
			local l_10_5, l_10_6, l_10_7 = nil
			l_10_14, l_10_15 = l_10_1:append, l_10_1
			l_10_5 = l_10_13
			l_10_14(l_10_15, l_10_5)
			if l_10_13 == l_10_2 then
				l_10_14, l_10_15 = l_10_1:set_value, l_10_1
				l_10_5 = l_10_2
				l_10_14(l_10_15, l_10_5)
			end
		end
		l_10_1:thaw()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSpawnUnitCutsceneKey.refresh_control_for_parent_unit_name = function(l_11_0, l_11_1)
	l_11_1:freeze()
	l_11_1:clear()
	local l_11_7, l_11_8 = table.exclude, l_11_0:_unit_names()
	l_11_7 = l_11_7(l_11_8, l_11_0:name())
	local l_11_2 = nil
	l_11_8 = table
	l_11_8 = l_11_8.empty
	l_11_2 = l_11_7
	l_11_8 = l_11_8(l_11_2)
	if l_11_8 then
		l_11_8, l_11_2 = l_11_1:set_enabled, l_11_1
		l_11_8(l_11_2, false)
	else
		l_11_8, l_11_2 = l_11_1:set_enabled, l_11_1
		l_11_8(l_11_2, true)
		l_11_8, l_11_2 = l_11_0:parent_unit_name, l_11_0
		l_11_8 = l_11_8(l_11_2)
		local l_11_3 = nil
		l_11_2 = pairs
		l_11_3 = l_11_7
		l_11_2 = l_11_2(l_11_3)
		for i_0,i_1 in l_11_2 do
			l_11_1:append(l_11_6)
			if l_11_6 == l_11_8 then
				l_11_1:set_value(l_11_8)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_11_8(l_11_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSpawnUnitCutsceneKey.refresh_control_for_parent_object_name = function(l_12_0, l_12_1)
	l_12_1:freeze()
	l_12_1:clear()
	local l_12_7, l_12_8 = l_12_0:_unit_object_names, l_12_0
	l_12_7 = l_12_7(l_12_8, l_12_0:parent_unit_name())
	local l_12_2 = nil
	l_12_8 = #l_12_7
	if l_12_8 == 0 then
		l_12_8, l_12_2 = l_12_1:set_enabled, l_12_1
		l_12_8(l_12_2, false)
	else
		l_12_8, l_12_2 = l_12_1:set_enabled, l_12_1
		l_12_8(l_12_2, true)
		l_12_8, l_12_2 = l_12_0:parent_object_name, l_12_0
		l_12_8 = l_12_8(l_12_2)
		local l_12_3 = nil
		l_12_2 = ipairs
		l_12_3 = l_12_7
		l_12_2 = l_12_2(l_12_3)
		for i_0,i_1 in l_12_2 do
			l_12_1:append(l_12_6)
			if l_12_6 == l_12_8 then
				l_12_1:set_value(l_12_8)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_12_8(l_12_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSpawnUnitCutsceneKey.on_attribute_changed = function(l_13_0, l_13_1, l_13_2, l_13_3)
	assert(l_13_0._cast)
	if l_13_0._spawned_unit == nil then
		l_13_0:_spawn_unit()
	elseif l_13_1 == "unit_type" then
		l_13_0._cast:delete_unit(l_13_0:name())
		l_13_0:_spawn_unit()
	elseif l_13_1 == "name" then
		local l_13_4 = l_13_0:_unit(l_13_2, true)
		do
			local l_13_5 = assert
			l_13_5(l_13_4 == nil or l_13_4 == l_13_0._spawned_unit)
			l_13_5 = l_13_0._cast
			l_13_5(l_13_5, l_13_3, l_13_2)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	elseif l_13_1 == "parent_object_name" or l_13_1 == "offset" or l_13_1 == "rotation" then
		l_13_0:_reparent_unit()
	end
end

CoreSpawnUnitCutsceneKey._spawn_unit = function(l_14_0)
	if l_14_0:is_valid() and l_14_0._cast and l_14_0._cast:unit(l_14_0:name()) == nil then
		l_14_0._spawned_unit = l_14_0._cast:spawn_unit(l_14_0:name(), l_14_0:unit_type())
		l_14_0:_reparent_unit()
	end
end

CoreSpawnUnitCutsceneKey._delete_unit = function(l_15_0)
	if l_15_0:is_valid() and l_15_0._cast then
		l_15_0._cast:delete_unit(l_15_0:name())
	end
end

CoreSpawnUnitCutsceneKey._reparent_unit = function(l_16_0)
	if l_16_0._spawned_unit then
		l_16_0._spawned_unit:unlink()
		local l_16_1 = l_16_0:_unit_object(l_16_0:parent_unit_name(), l_16_0:parent_object_name(), true)
	if l_16_1 then
		end
		local l_16_2 = l_16_0:_unit(l_16_0:parent_unit_name())
		l_16_2:link(l_16_1:name(), l_16_0._spawned_unit)
		l_16_0._spawned_unit:set_local_position(l_16_0:offset())
		l_16_0._spawned_unit:set_local_rotation(l_16_0:rotation())
		if l_16_0._cast:unit_visible(l_16_0:name()) then
			l_16_0._cast:_set_unit_and_children_visible(l_16_0._spawned_unit, l_16_2:visible())
		end
	end
end

CoreSpawnUnitCutsceneKey.update_gui = function(l_17_0, l_17_1, l_17_2)
	if l_17_0._database_browser and l_17_0._database_browser:update(l_17_1, l_17_2) then
		if alive(l_17_0._cutscene_editor_window) then
			l_17_0._cutscene_editor_window:set_enabled(true)
			l_17_0._cutscene_editor_window:set_focus()
		end
		l_17_0._cutscene_editor_window = nil
		l_17_0._database_browser = nil
	end
end

CoreSpawnUnitCutsceneKey._on_database_browser_button_clicked = function(l_18_0, l_18_1)
	l_18_0._cutscene_editor_window = l_18_1:parent()
	while l_18_0._cutscene_editor_window and type_name(l_18_0._cutscene_editor_window) ~= "EWSFrame" do
		l_18_0._cutscene_editor_window = l_18_0._cutscene_editor_window:parent()
	end
	assert(l_18_0._cutscene_editor_window, "Button is not inside a top-level window.")
	l_18_0._cutscene_editor_window:set_enabled(false)
	l_18_0._database_browser = CoreDBDialog:new("unit", l_18_0, l_18_0._on_database_browser_entry_selected, ProjectDatabase)
end

CoreSpawnUnitCutsceneKey._on_database_browser_entry_selected = function(l_19_0)
	if l_19_0._database_browser then
		local l_19_1, l_19_2, l_19_3, l_19_4 = l_19_0._database_browser:get_value()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	assert(l_19_1, "Callback should only be called if an entry was selected.")
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_19_5 = nil
	if UnitDatabase:get_unit_data(l_19_1:name()) then
		l_19_0:set_unit_category(UnitDatabase:get_unit_data(l_19_1:name()):type())
		l_19_0:set_unit_type(UnitDatabase:get_unit_data(l_19_1:name()):name())
		l_19_0:refresh_control_for_attribute("unit_category")
		l_19_0:refresh_control_for_attribute("unit_type")
	end
end


