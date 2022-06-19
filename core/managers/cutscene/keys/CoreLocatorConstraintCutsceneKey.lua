require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreLocatorConstraintCutsceneKey then
	CoreLocatorConstraintCutsceneKey = class(CoreCutsceneKeyBase)
end
CoreLocatorConstraintCutsceneKey.ELEMENT_NAME = "locator_constraint"
CoreLocatorConstraintCutsceneKey.NAME = "Locator Constraint"
CoreLocatorConstraintCutsceneKey:register_serialized_attribute("locator_name", "")
CoreLocatorConstraintCutsceneKey:register_serialized_attribute("parent_unit_name", "")
CoreLocatorConstraintCutsceneKey:register_serialized_attribute("parent_object_name", "")
CoreLocatorConstraintCutsceneKey.control_for_locator_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreLocatorConstraintCutsceneKey.control_for_parent_unit_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreLocatorConstraintCutsceneKey.control_for_parent_object_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreLocatorConstraintCutsceneKey.__tostring = function(l_1_0)
	local l_1_1 = "disabled"
	if l_1_0:parent_unit_name() ~= "" and l_1_0:parent_object_name() ~= "" then
		local l_1_6 = string.format
		l_1_6 = l_1_6("\"%s/%s\"", l_1_0:parent_unit_name(), l_1_0:parent_object_name())
		l_1_1 = l_1_6
	end
	local l_1_2 = string.format
	local l_1_3 = "Set constaint of locator \"%s\" to %s."
	local l_1_4 = l_1_0:locator_name()
	local l_1_5 = l_1_1
	return l_1_2(l_1_3, l_1_4, l_1_5)
end

CoreLocatorConstraintCutsceneKey.can_evaluate_with_player = function(l_2_0, l_2_1)
	return l_2_0._cast ~= nil
end

CoreLocatorConstraintCutsceneKey.evaluate = function(l_3_0, l_3_1, l_3_2)
	local l_3_3 = l_3_0:_unit_object(l_3_0:parent_unit_name(), l_3_0:parent_object_name(), true)
	l_3_0:_constrain_locator_to_object(l_3_3)
end

CoreLocatorConstraintCutsceneKey.revert = function(l_4_0, l_4_1)
	local l_4_2, l_4_3 = l_4_0:preceeding_key, l_4_0
	local l_4_4 = {}
	l_4_4.locator_name = l_4_0:locator_name()
	l_4_2 = l_4_2(l_4_3, l_4_4)
	if l_4_2 then
		l_4_3, l_4_4 = l_4_2:evaluate, l_4_2
		l_4_3(l_4_4, l_4_1, false)
	else
		l_4_3, l_4_4 = l_4_0:_constrain_locator_to_object, l_4_0
		l_4_3(l_4_4, nil)
	end
end

CoreLocatorConstraintCutsceneKey.update_gui = function(l_5_0, l_5_1, l_5_2, l_5_3)
	local l_5_4 = l_5_0:_unit_object(l_5_0:locator_name(), "locator", true)
	if l_5_4 then
		local l_5_5 = Draw:pen()
		l_5_5:set("no_z")
		l_5_5:set(Color(1, 0.5, 0))
		l_5_5:sphere(l_5_4:position(), 1, 5, 1)
		local l_5_6 = l_5_0:_unit_object(l_5_0:parent_unit_name(), l_5_0:parent_object_name(), true)
	if l_5_6 then
		end
		l_5_5:set(Color(1, 0, 1))
		l_5_5:line(l_5_4:position(), l_5_6:position())
		l_5_5:rotation(l_5_6:position(), l_5_6:rotation(), 10)
		l_5_5:set(Color(0, 1, 1))
		l_5_5:sphere(l_5_6:position(), 1, 10, 1)
	end
end

CoreLocatorConstraintCutsceneKey.is_valid_locator_name = function(l_6_0, l_6_1)
	return not string.begins(l_6_1, "locator") or l_6_0:_unit_type(l_6_1) == "locator"
end

CoreLocatorConstraintCutsceneKey.is_valid_parent_unit_name = function(l_7_0, l_7_1)
	if l_7_1 ~= nil and l_7_1 ~= "" then
		local l_7_2 = CoreCutsceneKeyBase.is_valid_unit_name(l_7_0, l_7_1)
		l_7_2 = l_7_2
		return l_7_2
	end
end

CoreLocatorConstraintCutsceneKey.is_valid_parent_object_name = function(l_8_0, l_8_1)
	if l_8_1 ~= nil and l_8_1 ~= "" then
		local l_8_2 = CoreCutsceneKeyBase.is_valid_object_name(l_8_0, l_8_1, l_8_0:parent_unit_name())
		l_8_2 = l_8_2
		return l_8_2
	end
end

CoreLocatorConstraintCutsceneKey.refresh_control_for_locator_name = function(l_9_0, l_9_1)
	local l_9_6, l_9_7, l_9_8, l_9_9 = nil
	l_9_1:freeze()
	l_9_1:clear()
	local l_9_2 = table.find_all_values(l_9_0:_unit_names(), function(l_10_0)
		-- upvalues: l_9_0
		local l_10_1, l_10_2 = l_9_0:is_valid_locator_name, l_9_0
		local l_10_3 = l_10_0
		return l_10_1(l_10_2, l_10_3)
  end)
	for i_0,i_1 in ipairs(l_9_2) do
		l_9_1:append(i_1)
	end
	l_9_1:set_enabled(not table.empty(l_9_2))
	l_9_1:append("")
	l_9_1:set_value(l_9_0:locator_name())
	l_9_1:thaw()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreLocatorConstraintCutsceneKey.refresh_control_for_parent_unit_name = function(l_10_0, l_10_1)
	CoreCutsceneKeyBase.refresh_control_for_unit_name(l_10_0, l_10_1, l_10_0:parent_unit_name())
	l_10_1:append("")
	if l_10_0:parent_unit_name() == "" then
		l_10_1:set_value("")
	end
end

CoreLocatorConstraintCutsceneKey.refresh_control_for_parent_object_name = function(l_11_0, l_11_1)
	CoreCutsceneKeyBase.refresh_control_for_object_name(l_11_0, l_11_1, l_11_0:parent_unit_name(), l_11_0:parent_object_name())
	l_11_1:append("")
	if l_11_0:parent_object_name() == "" then
		l_11_1:set_value("")
	end
end

CoreLocatorConstraintCutsceneKey.on_attribute_before_changed = function(l_12_0, l_12_1, l_12_2, l_12_3)
	l_12_0:revert(nil)
end

CoreLocatorConstraintCutsceneKey.on_attribute_changed = function(l_13_0, l_13_1, l_13_2, l_13_3)
	l_13_0:evaluate(nil)
end

CoreLocatorConstraintCutsceneKey._constrain_locator_to_object = function(l_14_0, l_14_1)
	local l_14_2 = l_14_0:_unit(l_14_0:locator_name(), true)
	if l_14_2 == nil then
		return 
	end
	if l_14_1 then
		l_14_2:set_animations_enabled(false)
		local l_14_3 = l_14_2:get_object("locator")
		local l_14_4 = l_14_3:position()
		local l_14_5 = l_14_3:rotation()
		local l_14_6 = l_14_0:_unit(l_14_0:parent_unit_name())
		l_14_3:set_local_position(Vector3(0, 0, 0))
		l_14_3:set_local_rotation(Rotation())
		l_14_3:link(l_14_1)
		l_14_3:set_position(l_14_4)
		l_14_3:set_rotation(l_14_5)
		l_14_6:link(l_14_2)
	else
		local l_14_7 = l_14_2:get_object("locator")
		l_14_7:unlink()
		l_14_2:unlink()
		l_14_2:set_animations_enabled(true)
	end
end


