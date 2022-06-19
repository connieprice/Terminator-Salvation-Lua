require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreLocatorConstraintCutsceneKey = CoreLocatorConstraintCutsceneKey or class(CoreCutsceneKeyBase)
CoreLocatorConstraintCutsceneKey.ELEMENT_NAME = "locator_constraint"
CoreLocatorConstraintCutsceneKey.NAME = "Locator Constraint"
CoreLocatorConstraintCutsceneKey:register_serialized_attribute("locator_name", "")
CoreLocatorConstraintCutsceneKey:register_serialized_attribute("parent_unit_name", "")
CoreLocatorConstraintCutsceneKey:register_serialized_attribute("parent_object_name", "")
CoreLocatorConstraintCutsceneKey.control_for_locator_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreLocatorConstraintCutsceneKey.control_for_parent_unit_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreLocatorConstraintCutsceneKey.control_for_parent_object_name = CoreCutsceneKeyBase.standard_combo_box_control
function CoreLocatorConstraintCutsceneKey.__tostring(A0_0)
	local L1_1
	L1_1 = "disabled"
	if A0_0:parent_unit_name() ~= "" and A0_0:parent_object_name() ~= "" then
		L1_1 = string.format("\"%s/%s\"", A0_0:parent_unit_name(), A0_0:parent_object_name())
	end
	return string.format("Set constaint of locator \"%s\" to %s.", A0_0:locator_name(), L1_1)
end
function CoreLocatorConstraintCutsceneKey.can_evaluate_with_player(A0_2, A1_3)
	return A0_2._cast ~= nil
end
function CoreLocatorConstraintCutsceneKey.evaluate(A0_4, A1_5, A2_6)
	local L3_7
	L3_7 = A0_4._unit_object
	L3_7 = L3_7(A0_4, A0_4:parent_unit_name(), A0_4:parent_object_name(), true)
	A0_4:_constrain_locator_to_object(L3_7)
end
function CoreLocatorConstraintCutsceneKey.revert(A0_8, A1_9)
	if A0_8:preceeding_key({
		locator_name = A0_8:locator_name()
	}) then
		A0_8:preceeding_key({
			locator_name = A0_8:locator_name()
		}):evaluate(A1_9, false)
	else
		A0_8:_constrain_locator_to_object(nil)
	end
end
function CoreLocatorConstraintCutsceneKey.update_gui(A0_10, A1_11, A2_12, A3_13)
	if A0_10:_unit_object(A0_10:locator_name(), "locator", true) then
		Draw:pen():set("no_z")
		Draw:pen():set(Color(1, 0.5, 0))
		Draw:pen():sphere(A0_10:_unit_object(A0_10:locator_name(), "locator", true):position(), 1, 5, 1)
		if A0_10:_unit_object(A0_10:parent_unit_name(), A0_10:parent_object_name(), true) then
			Draw:pen():set(Color(1, 0, 1))
			Draw:pen():line(A0_10:_unit_object(A0_10:locator_name(), "locator", true):position(), A0_10:_unit_object(A0_10:parent_unit_name(), A0_10:parent_object_name(), true):position())
			Draw:pen():rotation(A0_10:_unit_object(A0_10:parent_unit_name(), A0_10:parent_object_name(), true):position(), A0_10:_unit_object(A0_10:parent_unit_name(), A0_10:parent_object_name(), true):rotation(), 10)
			Draw:pen():set(Color(0, 1, 1))
			Draw:pen():sphere(A0_10:_unit_object(A0_10:parent_unit_name(), A0_10:parent_object_name(), true):position(), 1, 10, 1)
		end
	end
end
function CoreLocatorConstraintCutsceneKey.is_valid_locator_name(A0_14, A1_15)
	return string.begins(A1_15, "locator") and A0_14:_unit_type(A1_15) == "locator"
end
function CoreLocatorConstraintCutsceneKey.is_valid_parent_unit_name(A0_16, A1_17)
	return A1_17 == nil or A1_17 == "" or CoreCutsceneKeyBase.is_valid_unit_name(A0_16, A1_17)
end
function CoreLocatorConstraintCutsceneKey.is_valid_parent_object_name(A0_18, A1_19)
	local L3_20, L4_21
	L3_20 = A1_19 == nil or A1_19 == "" or L3_20(L4_21, A1_19, A0_18:parent_unit_name())
	return L3_20
end
function CoreLocatorConstraintCutsceneKey.refresh_control_for_locator_name(A0_22, A1_23)
	local L2_24, L3_25, L4_26, L5_27, L6_28, L7_29
	L2_24 = A1_23.freeze
	L2_24(L3_25)
	L2_24 = A1_23.clear
	L2_24(L3_25)
	L2_24 = table
	L2_24 = L2_24.find_all_values
	L2_24 = L2_24(L3_25, L4_26)
	for L6_28, L7_29 in L3_25(L4_26) do
		A1_23:append(L7_29)
	end
	L6_28 = L2_24
	L3_25(L4_26, L5_27)
	L3_25(L4_26, L5_27)
	L6_28 = A0_22
	L7_29 = L5_27(L6_28)
	L3_25(L4_26, L5_27, L6_28, L7_29, L5_27(L6_28))
	L3_25(L4_26)
end
function CoreLocatorConstraintCutsceneKey.refresh_control_for_parent_unit_name(A0_30, A1_31)
	CoreCutsceneKeyBase.refresh_control_for_unit_name(A0_30, A1_31, A0_30:parent_unit_name())
	A1_31:append("")
	if A0_30:parent_unit_name() == "" then
		A1_31:set_value("")
	end
end
function CoreLocatorConstraintCutsceneKey.refresh_control_for_parent_object_name(A0_32, A1_33)
	CoreCutsceneKeyBase.refresh_control_for_object_name(A0_32, A1_33, A0_32:parent_unit_name(), A0_32:parent_object_name())
	A1_33:append("")
	if A0_32:parent_object_name() == "" then
		A1_33:set_value("")
	end
end
function CoreLocatorConstraintCutsceneKey.on_attribute_before_changed(A0_34, A1_35, A2_36, A3_37)
	A0_34:revert(nil)
end
function CoreLocatorConstraintCutsceneKey.on_attribute_changed(A0_38, A1_39, A2_40, A3_41)
	A0_38:evaluate(nil)
end
function CoreLocatorConstraintCutsceneKey._constrain_locator_to_object(A0_42, A1_43)
	local L2_44, L3_45, L4_46, L5_47
	L3_45 = A0_42
	L2_44 = A0_42._unit
	L5_47 = A0_42
	L4_46 = A0_42.locator_name
	L4_46 = L4_46(L5_47)
	L5_47 = true
	L2_44 = L2_44(L3_45, L4_46, L5_47)
	if L2_44 == nil then
		return
	end
	if A1_43 then
		L4_46 = L2_44
		L3_45 = L2_44.set_animations_enabled
		L5_47 = false
		L3_45(L4_46, L5_47)
		L4_46 = L2_44
		L3_45 = L2_44.get_object
		L5_47 = "locator"
		L3_45 = L3_45(L4_46, L5_47)
		L5_47 = L3_45
		L4_46 = L3_45.position
		L4_46 = L4_46(L5_47)
		L5_47 = L3_45.rotation
		L5_47 = L5_47(L3_45)
		L3_45:set_local_position(Vector3(0, 0, 0))
		L3_45:set_local_rotation(Rotation())
		L3_45:link(A1_43)
		L3_45:set_position(L4_46)
		L3_45:set_rotation(L5_47)
		A0_42:_unit(A0_42:parent_unit_name()):link(L2_44)
	else
		L4_46 = L2_44
		L3_45 = L2_44.get_object
		L5_47 = "locator"
		L3_45 = L3_45(L4_46, L5_47)
		L5_47 = L3_45
		L4_46 = L3_45.unlink
		L4_46(L5_47)
		L5_47 = L2_44
		L4_46 = L2_44.unlink
		L4_46(L5_47)
		L5_47 = L2_44
		L4_46 = L2_44.set_animations_enabled
		L4_46(L5_47, true)
	end
end
