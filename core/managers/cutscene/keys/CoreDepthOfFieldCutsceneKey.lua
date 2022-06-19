require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
require("core/utils/dev/ews/CoreCameraDistancePicker")
if not CoreDepthOfFieldCutsceneKey then
	CoreDepthOfFieldCutsceneKey = class(CoreCutsceneKeyBase)
end
CoreDepthOfFieldCutsceneKey.ELEMENT_NAME = "camera_focus"
CoreDepthOfFieldCutsceneKey.NAME = "Camera Focus"
CoreDepthOfFieldCutsceneKey.DEFAULT_NEAR_DISTANCE = 15
CoreDepthOfFieldCutsceneKey.DEFAULT_FAR_DISTANCE = 10000
CoreDepthOfFieldCutsceneKey:register_serialized_attribute("near_distance", CoreDepthOfFieldCutsceneKey.DEFAULT_NEAR_DISTANCE, tonumber)
CoreDepthOfFieldCutsceneKey:register_serialized_attribute("far_distance", CoreDepthOfFieldCutsceneKey.DEFAULT_FAR_DISTANCE, tonumber)
CoreDepthOfFieldCutsceneKey:register_serialized_attribute("tracked_unit_name", "")
CoreDepthOfFieldCutsceneKey:register_serialized_attribute("tracked_object_name", "")
CoreDepthOfFieldCutsceneKey:register_control("divider1")
CoreDepthOfFieldCutsceneKey:register_serialized_attribute("transition_time", 0, tonumber)
CoreDepthOfFieldCutsceneKey:register_control("divider2")
CoreDepthOfFieldCutsceneKey:register_serialized_attribute("target_near_distance", CoreDepthOfFieldCutsceneKey.DEFAULT_NEAR_DISTANCE, tonumber)
CoreDepthOfFieldCutsceneKey:register_serialized_attribute("target_far_distance", CoreDepthOfFieldCutsceneKey.DEFAULT_FAR_DISTANCE, tonumber)
CoreDepthOfFieldCutsceneKey:register_serialized_attribute("target_tracked_unit_name", "")
CoreDepthOfFieldCutsceneKey:register_serialized_attribute("target_tracked_object_name", "")
CoreDepthOfFieldCutsceneKey:attribute_affects("tracked_unit_name", "near_distance")
CoreDepthOfFieldCutsceneKey:attribute_affects("tracked_unit_name", "far_distance")
CoreDepthOfFieldCutsceneKey:attribute_affects("tracked_unit_name", "tracked_object_name")
CoreDepthOfFieldCutsceneKey:attribute_affects("tracked_object_name", "near_distance")
CoreDepthOfFieldCutsceneKey:attribute_affects("tracked_object_name", "far_distance")
CoreDepthOfFieldCutsceneKey:attribute_affects("transition_time", "target_near_distance")
CoreDepthOfFieldCutsceneKey:attribute_affects("transition_time", "target_far_distance")
CoreDepthOfFieldCutsceneKey:attribute_affects("transition_time", "target_tracked_unit_name")
CoreDepthOfFieldCutsceneKey:attribute_affects("transition_time", "target_tracked_object_name")
CoreDepthOfFieldCutsceneKey:attribute_affects("target_tracked_unit_name", "target_near_distance")
CoreDepthOfFieldCutsceneKey:attribute_affects("target_tracked_unit_name", "target_far_distance")
CoreDepthOfFieldCutsceneKey:attribute_affects("target_tracked_unit_name", "target_tracked_object_name")
CoreDepthOfFieldCutsceneKey:attribute_affects("target_tracked_object_name", "target_near_distance")
CoreDepthOfFieldCutsceneKey:attribute_affects("target_tracked_object_name", "target_far_distance")
CoreDepthOfFieldCutsceneKey.control_for_tracked_unit_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreDepthOfFieldCutsceneKey.control_for_tracked_object_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreDepthOfFieldCutsceneKey.control_for_divider1 = CoreCutsceneKeyBase.standard_divider_control
CoreDepthOfFieldCutsceneKey.control_for_divider2 = CoreCutsceneKeyBase.standard_divider_control
CoreDepthOfFieldCutsceneKey.control_for_target_tracked_unit_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreDepthOfFieldCutsceneKey.control_for_target_tracked_object_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreDepthOfFieldCutsceneKey.__tostring = function(l_1_0)
	return "Change camera focus."
end

CoreDepthOfFieldCutsceneKey.populate_from_editor = function(l_2_0, l_2_1)
	l_2_0.super.populate_from_editor(l_2_0, l_2_1)
	local l_2_2 = l_2_1:camera_attributes()
	if not l_2_2.near_focus_distance_max then
		local l_2_3, l_2_4, l_2_6, l_2_8, l_2_10, l_2_11, l_2_13, l_2_15 = l_2_0.DEFAULT_NEAR_DISTANCE
	end
	if not l_2_2.far_focus_distance_min then
		local l_2_5, l_2_7, l_2_9, l_2_12, l_2_14, l_2_16 = , l_2_0.DEFAULT_FAR_DISTANCE
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_2_0:set_near_distance(l_2_5)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_2_0:set_far_distance(l_2_7)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_2_0:set_target_near_distance(l_2_5)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_2_0:set_target_far_distance(l_2_7)
end

CoreDepthOfFieldCutsceneKey.play = function(l_3_0, l_3_1, l_3_2, l_3_3)
	if l_3_2 then
		local l_3_4 = l_3_0:preceeding_key()
		if l_3_4 then
			l_3_0:_set_camera_depth_of_field(l_3_1, l_3_4:_final_target_near_distance(l_3_1), l_3_4:_final_target_far_distance(l_3_1))
		else
			l_3_0:_set_camera_depth_of_field(l_3_1, l_3_0.DEFAULT_NEAR_DISTANCE, l_3_0.DEFAULT_FAR_DISTANCE)
		end
	else
		if l_3_0:_is_editing_target_values() then
			l_3_0:_set_camera_depth_of_field(l_3_1, l_3_0:_final_target_near_distance(l_3_1), l_3_0:_final_target_far_distance(l_3_1))
		end
	else
		l_3_0:_set_camera_depth_of_field(l_3_1, l_3_0:_final_near_distance(l_3_1), l_3_0:_final_far_distance(l_3_1))
	end
end

CoreDepthOfFieldCutsceneKey.update = function(l_4_0, l_4_1, l_4_2)
	local l_4_3 = l_4_0:transition_time()
	do
		local l_4_4 = l_4_3 > 0 and math.min(l_4_2 / l_4_3, 1) or 1
	end
	local l_4_5 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_4_0:_is_editing_initial_values() then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_4_0:_is_editing_target_values() then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_4_6 = nil
	if l_4_3 ~= 0 or not l_4_0:_final_near_distance(l_4_1) then
		local l_4_8, l_4_9 = , l_4_0:_final_target_near_distance(l_4_1)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_4_10 = nil
	local l_4_11 = nil
	if l_4_3 ~= 0 or not l_4_0:_final_far_distance(l_4_1) then
		local l_4_13, l_4_14 = l_4_8 + (l_4_9 - l_4_8) * l_4_6
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_4_15 = nil
	l_4_0:_set_camera_depth_of_field(l_4_1, l_4_15, l_4_14 + (l_4_0:_final_target_far_distance(l_4_1) - l_4_14) * l_4_6)
end

CoreDepthOfFieldCutsceneKey.update_gui = function(l_5_0, l_5_1, l_5_2, l_5_3)
	do
		if not l_5_3 or l_5_0.__near_distance_control then
			l_5_0.__near_distance_control:update(l_5_1, l_5_2)
			l_5_0.__near_distance_control:set_pick_button_enabled(l_5_3:is_viewport_enabled())
		end
		if l_5_0.__far_distance_control then
			l_5_0.__far_distance_control:update(l_5_1, l_5_2)
			l_5_0.__far_distance_control:set_pick_button_enabled(l_5_3:is_viewport_enabled())
		end
		if l_5_0.__target_near_distance_control then
			l_5_0.__target_near_distance_control:update(l_5_1, l_5_2)
			l_5_0.__target_near_distance_control:set_pick_button_enabled(l_5_3:is_viewport_enabled())
		end
		if l_5_0.__target_far_distance_control then
			l_5_0.__target_far_distance_control:update(l_5_1, l_5_2)
			l_5_0.__target_far_distance_control:set_pick_button_enabled(l_5_3:is_viewport_enabled())
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreDepthOfFieldCutsceneKey.is_valid_near_distance = function(l_6_0, l_6_1)
	return l_6_1 == nil or l_6_1 >= 0
end

CoreDepthOfFieldCutsceneKey.is_valid_far_distance = function(l_7_0, l_7_1)
	return l_7_1 == nil or l_7_1 >= 0
end

CoreDepthOfFieldCutsceneKey.is_valid_tracked_unit_name = function(l_8_0, l_8_1)
	if l_8_1 ~= nil and l_8_1 ~= "" then
		local l_8_2 = CoreCutsceneKeyBase.is_valid_unit_name(l_8_0, l_8_1)
		l_8_2 = l_8_2
		return l_8_2
	end
end

CoreDepthOfFieldCutsceneKey.is_valid_tracked_object_name = function(l_9_0, l_9_1)
	if l_9_1 ~= nil and l_9_1 ~= "" and not table.contains(l_9_0:_unit_object_names(l_9_0:tracked_unit_name()), l_9_1) then
		local l_9_2 = false
	end
	l_9_2 = l_9_2
	return l_9_2
end

CoreDepthOfFieldCutsceneKey.is_valid_transition_time = function(l_10_0, l_10_1)
	do
		return not l_10_1 or l_10_1 >= 0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreDepthOfFieldCutsceneKey.is_valid_target_near_distance = function(l_11_0, l_11_1)
	return l_11_1 == nil or l_11_1 >= 0
end

CoreDepthOfFieldCutsceneKey.is_valid_target_far_distance = function(l_12_0, l_12_1)
	return l_12_1 == nil or l_12_1 >= 0
end

CoreDepthOfFieldCutsceneKey.is_valid_target_tracked_unit_name = function(l_13_0, l_13_1)
	if l_13_1 ~= nil and l_13_1 ~= "" then
		local l_13_2 = CoreCutsceneKeyBase.is_valid_unit_name(l_13_0, l_13_1)
		l_13_2 = l_13_2
		return l_13_2
	end
end

CoreDepthOfFieldCutsceneKey.is_valid_target_tracked_object_name = function(l_14_0, l_14_1)
	if l_14_1 ~= nil and l_14_1 ~= "" and not table.contains(l_14_0:_unit_object_names(l_14_0:target_tracked_unit_name()), l_14_1) then
		local l_14_2 = false
	end
	l_14_2 = l_14_2
	return l_14_2
end

CoreDepthOfFieldCutsceneKey.control_for_near_distance = function(l_15_0, l_15_1, l_15_2)
	l_15_0.__near_distance_control = CoreCameraDistancePicker:new(l_15_1, l_15_0:near_distance())
	l_15_0.__near_distance_control:connect("EVT_COMMAND_TEXT_UPDATED", l_15_2)
	return l_15_0.__near_distance_control
end

CoreDepthOfFieldCutsceneKey.control_for_far_distance = function(l_16_0, l_16_1, l_16_2)
	l_16_0.__far_distance_control = CoreCameraDistancePicker:new(l_16_1, l_16_0:far_distance())
	l_16_0.__far_distance_control:connect("EVT_COMMAND_TEXT_UPDATED", l_16_2)
	return l_16_0.__far_distance_control
end

CoreDepthOfFieldCutsceneKey.control_for_target_near_distance = function(l_17_0, l_17_1, l_17_2)
	l_17_0.__target_near_distance_control = CoreCameraDistancePicker:new(l_17_1, l_17_0:target_near_distance())
	l_17_0.__target_near_distance_control:connect("EVT_COMMAND_TEXT_UPDATED", l_17_2)
	return l_17_0.__target_near_distance_control
end

CoreDepthOfFieldCutsceneKey.control_for_target_far_distance = function(l_18_0, l_18_1, l_18_2)
	l_18_0.__target_far_distance_control = CoreCameraDistancePicker:new(l_18_1, l_18_0:target_far_distance())
	l_18_0.__target_far_distance_control:connect("EVT_COMMAND_TEXT_UPDATED", l_18_2)
	return l_18_0.__target_far_distance_control
end

CoreDepthOfFieldCutsceneKey.refresh_control_for_tracked_unit_name = function(l_19_0, l_19_1)
	l_19_0:refresh_control_for_unit_name(l_19_1, l_19_0:tracked_unit_name())
	l_19_1:append("")
	if l_19_0:tracked_unit_name() == "" then
		l_19_1:set_value("")
	end
end

CoreDepthOfFieldCutsceneKey.refresh_control_for_tracked_object_name = function(l_20_0, l_20_1)
	l_20_0:refresh_control_for_object_name(l_20_1, l_20_0:tracked_unit_name(), l_20_0:tracked_object_name())
	l_20_1:append("")
	if l_20_0:tracked_object_name() == "" or not l_20_0:is_valid_tracked_object_name(l_20_0:tracked_object_name()) then
		l_20_0:set_tracked_object_name("")
		l_20_1:set_value("")
	end
end

CoreDepthOfFieldCutsceneKey.refresh_control_for_target_tracked_unit_name = function(l_21_0, l_21_1)
	l_21_0:refresh_control_for_unit_name(l_21_1, l_21_0:target_tracked_unit_name())
	l_21_1:append("")
	if l_21_0:target_tracked_unit_name() == "" then
		l_21_1:set_value("")
	end
	local l_21_2, l_21_3 = l_21_1:set_enabled, l_21_1
	l_21_2(l_21_3, l_21_0:transition_time() > 0)
end

CoreDepthOfFieldCutsceneKey.refresh_control_for_target_tracked_object_name = function(l_22_0, l_22_1)
	l_22_0:refresh_control_for_object_name(l_22_1, l_22_0:target_tracked_unit_name(), l_22_0:target_tracked_object_name())
	l_22_1:append("")
	if l_22_0:target_tracked_object_name() == "" or not l_22_0:is_valid_target_tracked_object_name(l_22_0:target_tracked_object_name()) then
		l_22_0:set_target_tracked_object_name("")
		l_22_1:set_value("")
	end
	local l_22_2, l_22_3 = l_22_1:set_enabled, l_22_1
	l_22_2(l_22_3, l_22_0:transition_time() > 0 and l_22_0:target_tracked_unit_name() ~= "")
end

CoreDepthOfFieldCutsceneKey.refresh_control_for_near_distance = function(l_23_0, l_23_1)
	l_23_1:set_value(tostring(l_23_0:near_distance()))
	l_23_1:set_enabled(not l_23_0:is_valid_object_name(l_23_0:tracked_object_name(), l_23_0:tracked_unit_name()))
end

CoreDepthOfFieldCutsceneKey.refresh_control_for_far_distance = function(l_24_0, l_24_1)
	l_24_1:set_value(tostring(l_24_0:far_distance()))
	l_24_1:set_enabled(not l_24_0:is_valid_object_name(l_24_0:tracked_object_name(), l_24_0:tracked_unit_name()))
end

CoreDepthOfFieldCutsceneKey.refresh_control_for_target_near_distance = function(l_25_0, l_25_1)
	l_25_1:set_value(tostring(l_25_0:target_near_distance()))
	local l_25_2, l_25_3 = l_25_1:set_enabled, l_25_1
	if l_25_0:transition_time() > 0 then
		local l_25_4 = not l_25_0:is_valid_object_name(l_25_0:target_tracked_object_name(), l_25_0:target_tracked_unit_name())
	else
		l_25_2(l_25_3, false)
	end
end

CoreDepthOfFieldCutsceneKey.refresh_control_for_target_far_distance = function(l_26_0, l_26_1)
	l_26_1:set_value(tostring(l_26_0:target_far_distance()))
	local l_26_2, l_26_3 = l_26_1:set_enabled, l_26_1
	if l_26_0:transition_time() > 0 then
		local l_26_4 = not l_26_0:is_valid_object_name(l_26_0:target_tracked_object_name(), l_26_0:target_tracked_unit_name())
	else
		l_26_2(l_26_3, false)
	end
end

CoreDepthOfFieldCutsceneKey._set_camera_depth_of_field = function(l_27_0, l_27_1, l_27_2, l_27_3)
	l_27_1:set_camera_depth_of_field(l_27_2, math.max(l_27_3, l_27_2))
end

CoreDepthOfFieldCutsceneKey._is_editing_initial_values = function(l_28_0)
	if Application:ews_enabled() and (not l_28_0.__near_distance_control or not l_28_0.__near_distance_control:has_focus()) and l_28_0.__far_distance_control then
		return l_28_0.__far_distance_control:has_focus()
	end
end

CoreDepthOfFieldCutsceneKey._is_editing_target_values = function(l_29_0)
	if Application:ews_enabled() and (not l_29_0.__target_near_distance_control or not l_29_0.__target_near_distance_control:has_focus()) and l_29_0.__target_far_distance_control then
		return l_29_0.__target_far_distance_control:has_focus()
	end
end

CoreDepthOfFieldCutsceneKey._final_near_distance = function(l_30_0, l_30_1)
	local l_30_6 = l_30_1:distance_from_camera
	l_30_6 = l_30_6(l_30_1, l_30_0:tracked_unit_name(), l_30_0:tracked_object_name())
	local l_30_2 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_30_3 = nil
	if l_30_6 and l_30_2 then
		if l_30_6 < l_30_2 then
			l_30_3 = l_30_2 * l_30_6
			l_30_3 = l_30_3 / (l_30_2 + l_30_6)
		if not l_30_3 then
			end
		end
		l_30_3 = l_30_2 / 2
		return l_30_3
	else
		local l_30_4, l_30_5 = l_30_0
		return l_30_3(l_30_4)
	end
end

CoreDepthOfFieldCutsceneKey._final_far_distance = function(l_31_0, l_31_1)
	local l_31_6 = l_31_1:distance_from_camera
	l_31_6 = l_31_6(l_31_1, l_31_0:tracked_unit_name(), l_31_0:tracked_object_name())
	local l_31_2 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_31_3 = nil
	if l_31_6 and l_31_2 then
		if l_31_6 < l_31_2 then
			l_31_3 = l_31_2 * l_31_6
			l_31_3 = l_31_3 / (l_31_2 - l_31_6)
		if not l_31_3 then
			end
		end
		l_31_3 = l_31_6
		return l_31_3
	else
		local l_31_4, l_31_5 = l_31_0
		return l_31_3(l_31_4)
	end
end

CoreDepthOfFieldCutsceneKey._final_target_near_distance = function(l_32_0, l_32_1)
	local l_32_6 = l_32_1:distance_from_camera
	l_32_6 = l_32_6(l_32_1, l_32_0:target_tracked_unit_name(), l_32_0:target_tracked_object_name())
	local l_32_2 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_32_3 = nil
	if l_32_6 and l_32_2 then
		if l_32_6 < l_32_2 then
			l_32_3 = l_32_2 * l_32_6
			l_32_3 = l_32_3 / (l_32_2 + l_32_6)
		if not l_32_3 then
			end
		end
		l_32_3 = l_32_2 / 2
		return l_32_3
	else
		local l_32_4, l_32_5 = l_32_0
		return l_32_3(l_32_4)
	end
end

CoreDepthOfFieldCutsceneKey._final_target_far_distance = function(l_33_0, l_33_1)
	local l_33_6 = l_33_1:distance_from_camera
	l_33_6 = l_33_6(l_33_1, l_33_0:target_tracked_unit_name(), l_33_0:target_tracked_object_name())
	local l_33_2 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_33_3 = nil
	if l_33_6 and l_33_2 then
		if l_33_6 < l_33_2 then
			l_33_3 = l_33_2 * l_33_6
			l_33_3 = l_33_3 / (l_33_2 - l_33_6)
		if not l_33_3 then
			end
		end
		l_33_3 = l_33_6
		return l_33_3
	else
		local l_33_4, l_33_5 = l_33_0
		return l_33_3(l_33_4)
	end
end

CoreDepthOfFieldCutsceneKey._hyperfocal_distance = function(l_34_0)
	return 1433
end

CoreDepthOfFieldCutsceneKey._calc_interpolation = function(l_35_0, l_35_1)
	return 3 * l_35_1 ^ 2 - 2 * l_35_1 ^ 3
end


