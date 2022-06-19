require("core/managers/cutscene/keys/CoreSetupCutsceneKeyBase")
CoreSpawnUnitCutsceneKey = CoreSpawnUnitCutsceneKey or class(CoreSetupCutsceneKeyBase)
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
function CoreSpawnUnitCutsceneKey.__tostring(A0_0)
	local L2_1
	L2_1 = string
	L2_1 = L2_1.format
	return L2_1("Spawn %s named \"%s\".", A0_0:unit_type(), A0_0:name())
end
function CoreSpawnUnitCutsceneKey.prime(A0_2, A1_3)
	if A0_2:is_valid() then
		World:preload_unit(A0_2:unit_type())
	end
	A0_2:_spawn_unit()
end
function CoreSpawnUnitCutsceneKey.unload(A0_4, A1_5)
	if A0_4._cast then
		A0_4:_delete_unit()
	end
end
function CoreSpawnUnitCutsceneKey.play(A0_6, A1_7, A2_8, A3_9)
	A0_6:_reparent_unit()
end
function CoreSpawnUnitCutsceneKey.is_valid_unit_category(A0_10, A1_11)
	if not Application:ews_enabled() then
		return true
	else
		return A1_11 ~= nil and table.contains(UnitDatabase:get_unit_types(), A1_11)
	end
end
function CoreSpawnUnitCutsceneKey.is_valid_unit_type(A0_12, A1_13)
	return A1_13 ~= nil and UnitDatabase:get_unit_data(A1_13) ~= nil
end
function CoreSpawnUnitCutsceneKey.is_valid_name(A0_14, A1_15)
	if A1_15 == nil or #A1_15 <= 3 or string.match(A1_15, "[a-z_0-9]+") ~= A1_15 then
		return false
	end
	return A0_14:_unit(A1_15, true) == nil or A0_14:_unit(A1_15, true) == A0_14._spawned_unit
end
function CoreSpawnUnitCutsceneKey.control_for_database_browser_button(A0_16, A1_17)
	local L2_18
	L2_18 = EWS
	L2_18 = L2_18.Button
	L2_18 = L2_18(L2_18, A1_17, "Pick From Database Browser", "", "")
	L2_18:connect("EVT_COMMAND_BUTTON_CLICKED", callback(A0_16, A0_16, "_on_database_browser_button_clicked"), L2_18)
	return L2_18
end
function CoreSpawnUnitCutsceneKey.refresh_control_for_unit_category(A0_19, A1_20)
	local L2_21, L3_22, L4_23, L5_24, L6_25, L7_26
	L2_21 = A1_20.freeze
	L2_21(L3_22)
	L2_21 = A1_20.clear
	L2_21(L3_22)
	L2_21 = A0_19.unit_category
	L2_21 = L2_21(L3_22)
	L7_26 = L4_23(L5_24)
	for L6_25, L7_26 in L3_22(L4_23, L5_24, L6_25, L7_26, L4_23(L5_24)) do
		A1_20:append(L7_26)
		if L7_26 == L2_21 then
			A1_20:set_value(L2_21)
		end
	end
	L3_22(L4_23)
end
function CoreSpawnUnitCutsceneKey.refresh_control_for_unit_type(A0_27, A1_28)
	local L2_29, L3_30, L4_31, L5_32, L6_33, L7_34, L8_35
	L3_30 = A1_28
	L2_29 = A1_28.freeze
	L2_29(L3_30)
	L3_30 = A1_28
	L2_29 = A1_28.clear
	L2_29(L3_30)
	L3_30 = A0_27
	L2_29 = A0_27.unit_type
	L2_29 = L2_29(L3_30)
	L3_30 = A0_27.unit_category
	L3_30 = L3_30(L4_31)
	if L3_30 then
		L3_30 = table
		L3_30 = L3_30.collect
		L7_34 = A0_27
		L8_35 = L6_33(L7_34)
		L3_30 = L3_30(L4_31, L5_32)
	else
		L3_30 = L3_30 or {}
	end
	for L7_34, L8_35 in L4_31(L5_32) do
		A1_28:append(L8_35)
		if L8_35 == L2_29 then
			A1_28:set_value(L2_29)
		end
	end
	L4_31(L5_32)
end
function CoreSpawnUnitCutsceneKey.refresh_control_for_parent_unit_name(A0_36, A1_37)
	local L2_38, L3_39, L4_40, L5_41, L6_42, L7_43, L8_44
	L3_39 = A1_37
	L2_38 = A1_37.freeze
	L2_38(L3_39)
	L3_39 = A1_37
	L2_38 = A1_37.clear
	L2_38(L3_39)
	L2_38 = table
	L2_38 = L2_38.exclude
	L3_39 = A0_36._unit_names
	L3_39 = L3_39(L4_40)
	L8_44 = L4_40(L5_41)
	L2_38 = L2_38(L3_39, L4_40, L5_41, L6_42, L7_43, L8_44, L4_40(L5_41))
	L3_39 = table
	L3_39 = L3_39.empty
	L3_39 = L3_39(L4_40)
	if L3_39 then
		L3_39 = A1_37.set_enabled
		L3_39(L4_40, L5_41)
	else
		L3_39 = A1_37.set_enabled
		L3_39(L4_40, L5_41)
		L3_39 = A0_36.parent_unit_name
		L3_39 = L3_39(L4_40)
		for L7_43, L8_44 in L4_40(L5_41) do
			A1_37:append(L8_44)
			if L8_44 == L3_39 then
				A1_37:set_value(L3_39)
			end
		end
	end
	L3_39 = A1_37.thaw
	L3_39(L4_40)
end
function CoreSpawnUnitCutsceneKey.refresh_control_for_parent_object_name(A0_45, A1_46)
	local L2_47, L3_48, L4_49, L5_50, L6_51, L7_52, L8_53
	L3_48 = A1_46
	L2_47 = A1_46.freeze
	L2_47(L3_48)
	L3_48 = A1_46
	L2_47 = A1_46.clear
	L2_47(L3_48)
	L3_48 = A0_45
	L2_47 = A0_45._unit_object_names
	L8_53 = L4_49(L5_50)
	L2_47 = L2_47(L3_48, L4_49, L5_50, L6_51, L7_52, L8_53, L4_49(L5_50))
	L3_48 = #L2_47
	if L3_48 == 0 then
		L3_48 = A1_46.set_enabled
		L3_48(L4_49, L5_50)
	else
		L3_48 = A1_46.set_enabled
		L3_48(L4_49, L5_50)
		L3_48 = A0_45.parent_object_name
		L3_48 = L3_48(L4_49)
		for L7_52, L8_53 in L4_49(L5_50) do
			A1_46:append(L8_53)
			if L8_53 == L3_48 then
				A1_46:set_value(L3_48)
			end
		end
	end
	L3_48 = A1_46.thaw
	L3_48(L4_49)
end
function CoreSpawnUnitCutsceneKey.on_attribute_changed(A0_54, A1_55, A2_56, A3_57)
	assert(A0_54._cast)
	if A0_54._spawned_unit == nil then
		A0_54:_spawn_unit()
	elseif A1_55 == "unit_type" then
		A0_54._cast:delete_unit(A0_54:name())
		A0_54:_spawn_unit()
	elseif A1_55 == "name" then
		assert(A0_54:_unit(A2_56, true) == nil or A0_54:_unit(A2_56, true) == A0_54._spawned_unit)
		A0_54._cast:rename_unit(A3_57, A2_56)
	elseif A1_55 == "parent_object_name" or A1_55 == "offset" or A1_55 == "rotation" then
		A0_54:_reparent_unit()
	end
end
function CoreSpawnUnitCutsceneKey._spawn_unit(A0_58)
	if A0_58:is_valid() and A0_58._cast and A0_58._cast:unit(A0_58:name()) == nil then
		A0_58._spawned_unit = A0_58._cast:spawn_unit(A0_58:name(), A0_58:unit_type())
		A0_58:_reparent_unit()
	end
end
function CoreSpawnUnitCutsceneKey._delete_unit(A0_59)
	if A0_59:is_valid() and A0_59._cast then
		A0_59._cast:delete_unit(A0_59:name())
	end
end
function CoreSpawnUnitCutsceneKey._reparent_unit(A0_60)
	if A0_60._spawned_unit then
		A0_60._spawned_unit:unlink()
		if A0_60:_unit_object(A0_60:parent_unit_name(), A0_60:parent_object_name(), true) then
			A0_60:_unit(A0_60:parent_unit_name()):link(A0_60:_unit_object(A0_60:parent_unit_name(), A0_60:parent_object_name(), true):name(), A0_60._spawned_unit)
			A0_60._spawned_unit:set_local_position(A0_60:offset())
			A0_60._spawned_unit:set_local_rotation(A0_60:rotation())
			A0_60._cast:_set_unit_and_children_visible(A0_60._spawned_unit, A0_60._cast:unit_visible(A0_60:name()) and A0_60:_unit(A0_60:parent_unit_name()):visible())
		end
	end
end
function CoreSpawnUnitCutsceneKey.update_gui(A0_61, A1_62, A2_63)
	if A0_61._database_browser and A0_61._database_browser:update(A1_62, A2_63) then
		if alive(A0_61._cutscene_editor_window) then
			A0_61._cutscene_editor_window:set_enabled(true)
			A0_61._cutscene_editor_window:set_focus()
		end
		A0_61._cutscene_editor_window = nil
		A0_61._database_browser = nil
	end
end
function CoreSpawnUnitCutsceneKey._on_database_browser_button_clicked(A0_64, A1_65)
	A0_64._cutscene_editor_window = A1_65:parent()
	while A0_64._cutscene_editor_window and type_name(A0_64._cutscene_editor_window) ~= "EWSFrame" do
		A0_64._cutscene_editor_window = A0_64._cutscene_editor_window:parent()
	end
	assert(A0_64._cutscene_editor_window, "Button is not inside a top-level window.")
	A0_64._cutscene_editor_window:set_enabled(false)
	A0_64._database_browser = CoreDBDialog:new("unit", A0_64, A0_64._on_database_browser_entry_selected, ProjectDatabase)
end
function CoreSpawnUnitCutsceneKey._on_database_browser_entry_selected(A0_66)
	local L1_67
	L1_67 = A0_66._database_browser
	if L1_67 then
		L1_67 = A0_66._database_browser
		L1_67 = L1_67.get_value
		L1_67 = L1_67(L1_67)
	end
	assert(L1_67, "Callback should only be called if an entry was selected.")
	if UnitDatabase:get_unit_data(L1_67:name()) then
		A0_66:set_unit_category(UnitDatabase:get_unit_data(L1_67:name()):type())
		A0_66:set_unit_type(UnitDatabase:get_unit_data(L1_67:name()):name())
		A0_66:refresh_control_for_attribute("unit_category")
		A0_66:refresh_control_for_attribute("unit_type")
	end
end
