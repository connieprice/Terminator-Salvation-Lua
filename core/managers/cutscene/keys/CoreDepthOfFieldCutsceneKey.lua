require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
require("core/utils/dev/ews/CoreCameraDistancePicker")
CoreDepthOfFieldCutsceneKey = CoreDepthOfFieldCutsceneKey or class(CoreCutsceneKeyBase)
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
function CoreDepthOfFieldCutsceneKey.__tostring(A0_0)
	local L1_1
	L1_1 = "Change camera focus."
	return L1_1
end
function CoreDepthOfFieldCutsceneKey.populate_from_editor(A0_2, A1_3)
	local L2_4, L3_5, L4_6
	L2_4 = A0_2.super
	L2_4 = L2_4.populate_from_editor
	L3_5 = A0_2
	L4_6 = A1_3
	L2_4(L3_5, L4_6)
	L3_5 = A1_3
	L2_4 = A1_3.camera_attributes
	L2_4 = L2_4(L3_5)
	L3_5 = L2_4.near_focus_distance_max
	L3_5 = L3_5 or A0_2.DEFAULT_NEAR_DISTANCE
	L4_6 = L2_4.far_focus_distance_min
	L4_6 = L4_6 or A0_2.DEFAULT_FAR_DISTANCE
	A0_2:set_near_distance(L3_5)
	A0_2:set_far_distance(L4_6)
	A0_2:set_target_near_distance(L3_5)
	A0_2:set_target_far_distance(L4_6)
end
function CoreDepthOfFieldCutsceneKey.play(A0_7, A1_8, A2_9, A3_10)
	if A2_9 then
		if A0_7:preceeding_key() then
			A0_7:_set_camera_depth_of_field(A1_8, A0_7:preceeding_key():_final_target_near_distance(A1_8), A0_7:preceeding_key():_final_target_far_distance(A1_8))
		else
			A0_7:_set_camera_depth_of_field(A1_8, A0_7.DEFAULT_NEAR_DISTANCE, A0_7.DEFAULT_FAR_DISTANCE)
		end
	elseif A0_7:_is_editing_target_values() then
		A0_7:_set_camera_depth_of_field(A1_8, A0_7:_final_target_near_distance(A1_8), A0_7:_final_target_far_distance(A1_8))
	else
		A0_7:_set_camera_depth_of_field(A1_8, A0_7:_final_near_distance(A1_8), A0_7:_final_far_distance(A1_8))
	end
end
function CoreDepthOfFieldCutsceneKey.update(A0_11, A1_12, A2_13)
	local L3_14, L4_15, L5_16, L6_17, L7_18, L8_19, L9_20, L10_21, L11_22
	L4_15 = A0_11
	L3_14 = A0_11.transition_time
	L3_14 = L3_14(L4_15)
	if L3_14 > 0 then
		L4_15 = math
		L4_15 = L4_15.min
		L5_16 = A2_13 / L3_14
		L6_17 = 1
		L4_15 = L4_15(L5_16, L6_17)
	else
		L4_15 = L4_15 or 1
	end
	L5_16 = nil
	L7_18 = A0_11
	L6_17 = A0_11._is_editing_initial_values
	L6_17 = L6_17(L7_18)
	if L6_17 then
		L5_16 = 0
	else
		L7_18 = A0_11
		L6_17 = A0_11._is_editing_target_values
		L6_17 = L6_17(L7_18)
		if L6_17 then
			L5_16 = 1
		else
			L7_18 = A0_11
			L6_17 = A0_11._calc_interpolation
			L8_19 = L4_15
			L6_17 = L6_17(L7_18, L8_19)
			L5_16 = L6_17
		end
	end
	L7_18 = A0_11
	L6_17 = A0_11._final_near_distance
	L8_19 = A1_12
	L6_17 = L6_17(L7_18, L8_19)
	L7_18 = L3_14 == 0 and L6_17 or L7_18(L8_19, L9_20)
	L8_19 = L7_18 - L6_17
	L8_19 = L8_19 * L5_16
	L8_19 = L6_17 + L8_19
	L10_21 = A0_11
	L9_20 = A0_11._final_far_distance
	L11_22 = A1_12
	L9_20 = L9_20(L10_21, L11_22)
	L10_21 = L3_14 == 0 and L9_20 or L10_21(L11_22, A1_12)
	L11_22 = L10_21 - L9_20
	L11_22 = L11_22 * L5_16
	L11_22 = L9_20 + L11_22
	A0_11:_set_camera_depth_of_field(A1_12, L8_19, L11_22)
end
function CoreDepthOfFieldCutsceneKey.update_gui(A0_23, A1_24, A2_25, A3_26)
	local L4_27
	L4_27 = A3_26 and L4_27(A3_26)
	if A0_23.__near_distance_control then
		A0_23.__near_distance_control:update(A1_24, A2_25)
		A0_23.__near_distance_control:set_pick_button_enabled(L4_27)
	end
	if A0_23.__far_distance_control then
		A0_23.__far_distance_control:update(A1_24, A2_25)
		A0_23.__far_distance_control:set_pick_button_enabled(L4_27)
	end
	if A0_23.__target_near_distance_control then
		A0_23.__target_near_distance_control:update(A1_24, A2_25)
		A0_23.__target_near_distance_control:set_pick_button_enabled(L4_27)
	end
	if A0_23.__target_far_distance_control then
		A0_23.__target_far_distance_control:update(A1_24, A2_25)
		A0_23.__target_far_distance_control:set_pick_button_enabled(L4_27)
	end
end
function CoreDepthOfFieldCutsceneKey.is_valid_near_distance(A0_28, A1_29)
	local L2_30
	L2_30 = A1_29 == nil or A1_29 >= 0
	return L2_30
end
function CoreDepthOfFieldCutsceneKey.is_valid_far_distance(A0_31, A1_32)
	local L2_33
	L2_33 = A1_32 == nil or A1_32 >= 0
	return L2_33
end
function CoreDepthOfFieldCutsceneKey.is_valid_tracked_unit_name(A0_34, A1_35)
	return A1_35 == nil or A1_35 == "" or CoreCutsceneKeyBase.is_valid_unit_name(A0_34, A1_35)
end
function CoreDepthOfFieldCutsceneKey.is_valid_tracked_object_name(A0_36, A1_37)
	return A1_37 == nil or A1_37 == "" or table.contains(A0_36:_unit_object_names(A0_36:tracked_unit_name()), A1_37) or false
end
function CoreDepthOfFieldCutsceneKey.is_valid_transition_time(A0_38, A1_39)
	local L2_40
	L2_40 = A1_39 and A1_39 >= 0
	return L2_40
end
function CoreDepthOfFieldCutsceneKey.is_valid_target_near_distance(A0_41, A1_42)
	local L2_43
	L2_43 = A1_42 == nil or A1_42 >= 0
	return L2_43
end
function CoreDepthOfFieldCutsceneKey.is_valid_target_far_distance(A0_44, A1_45)
	local L2_46
	L2_46 = A1_45 == nil or A1_45 >= 0
	return L2_46
end
function CoreDepthOfFieldCutsceneKey.is_valid_target_tracked_unit_name(A0_47, A1_48)
	return A1_48 == nil or A1_48 == "" or CoreCutsceneKeyBase.is_valid_unit_name(A0_47, A1_48)
end
function CoreDepthOfFieldCutsceneKey.is_valid_target_tracked_object_name(A0_49, A1_50)
	return A1_50 == nil or A1_50 == "" or table.contains(A0_49:_unit_object_names(A0_49:target_tracked_unit_name()), A1_50) or false
end
function CoreDepthOfFieldCutsceneKey.control_for_near_distance(A0_51, A1_52, A2_53)
	A0_51.__near_distance_control = CoreCameraDistancePicker:new(A1_52, A0_51:near_distance())
	A0_51.__near_distance_control:connect("EVT_COMMAND_TEXT_UPDATED", A2_53)
	return A0_51.__near_distance_control
end
function CoreDepthOfFieldCutsceneKey.control_for_far_distance(A0_54, A1_55, A2_56)
	A0_54.__far_distance_control = CoreCameraDistancePicker:new(A1_55, A0_54:far_distance())
	A0_54.__far_distance_control:connect("EVT_COMMAND_TEXT_UPDATED", A2_56)
	return A0_54.__far_distance_control
end
function CoreDepthOfFieldCutsceneKey.control_for_target_near_distance(A0_57, A1_58, A2_59)
	A0_57.__target_near_distance_control = CoreCameraDistancePicker:new(A1_58, A0_57:target_near_distance())
	A0_57.__target_near_distance_control:connect("EVT_COMMAND_TEXT_UPDATED", A2_59)
	return A0_57.__target_near_distance_control
end
function CoreDepthOfFieldCutsceneKey.control_for_target_far_distance(A0_60, A1_61, A2_62)
	A0_60.__target_far_distance_control = CoreCameraDistancePicker:new(A1_61, A0_60:target_far_distance())
	A0_60.__target_far_distance_control:connect("EVT_COMMAND_TEXT_UPDATED", A2_62)
	return A0_60.__target_far_distance_control
end
function CoreDepthOfFieldCutsceneKey.refresh_control_for_tracked_unit_name(A0_63, A1_64)
	A0_63:refresh_control_for_unit_name(A1_64, A0_63:tracked_unit_name())
	A1_64:append("")
	if A0_63:tracked_unit_name() == "" then
		A1_64:set_value("")
	end
end
function CoreDepthOfFieldCutsceneKey.refresh_control_for_tracked_object_name(A0_65, A1_66)
	A0_65:refresh_control_for_object_name(A1_66, A0_65:tracked_unit_name(), A0_65:tracked_object_name())
	A1_66:append("")
	if A0_65:tracked_object_name() == "" or not A0_65:is_valid_tracked_object_name(A0_65:tracked_object_name()) then
		A0_65:set_tracked_object_name("")
		A1_66:set_value("")
	end
end
function CoreDepthOfFieldCutsceneKey.refresh_control_for_target_tracked_unit_name(A0_67, A1_68)
	A0_67:refresh_control_for_unit_name(A1_68, A0_67:target_tracked_unit_name())
	A1_68:append("")
	if A0_67:target_tracked_unit_name() == "" then
		A1_68:set_value("")
	end
	A1_68:set_enabled(A0_67:transition_time() > 0)
end
function CoreDepthOfFieldCutsceneKey.refresh_control_for_target_tracked_object_name(A0_69, A1_70)
	A0_69:refresh_control_for_object_name(A1_70, A0_69:target_tracked_unit_name(), A0_69:target_tracked_object_name())
	A1_70:append("")
	if A0_69:target_tracked_object_name() == "" or not A0_69:is_valid_target_tracked_object_name(A0_69:target_tracked_object_name()) then
		A0_69:set_target_tracked_object_name("")
		A1_70:set_value("")
	end
	A1_70:set_enabled(A0_69:transition_time() > 0 and A0_69:target_tracked_unit_name() ~= "")
end
function CoreDepthOfFieldCutsceneKey.refresh_control_for_near_distance(A0_71, A1_72)
	A1_72:set_value(tostring(A0_71:near_distance()))
	A1_72:set_enabled(not A0_71:is_valid_object_name(A0_71:tracked_object_name(), A0_71:tracked_unit_name()))
end
function CoreDepthOfFieldCutsceneKey.refresh_control_for_far_distance(A0_73, A1_74)
	A1_74:set_value(tostring(A0_73:far_distance()))
	A1_74:set_enabled(not A0_73:is_valid_object_name(A0_73:tracked_object_name(), A0_73:tracked_unit_name()))
end
function CoreDepthOfFieldCutsceneKey.refresh_control_for_target_near_distance(A0_75, A1_76)
	A1_76:set_value(tostring(A0_75:target_near_distance()))
	A1_76:set_enabled(A0_75:transition_time() > 0 and not A0_75:is_valid_object_name(A0_75:target_tracked_object_name(), A0_75:target_tracked_unit_name()))
end
function CoreDepthOfFieldCutsceneKey.refresh_control_for_target_far_distance(A0_77, A1_78)
	A1_78:set_value(tostring(A0_77:target_far_distance()))
	A1_78:set_enabled(A0_77:transition_time() > 0 and not A0_77:is_valid_object_name(A0_77:target_tracked_object_name(), A0_77:target_tracked_unit_name()))
end
function CoreDepthOfFieldCutsceneKey._set_camera_depth_of_field(A0_79, A1_80, A2_81, A3_82)
	local L4_83, L5_84, L6_85
	L5_84 = A1_80
	L4_83 = A1_80.set_camera_depth_of_field
	L6_85 = A2_81
	L4_83(L5_84, L6_85, math.max(A3_82, A2_81))
end
function CoreDepthOfFieldCutsceneKey._is_editing_initial_values(A0_86)
	return Application:ews_enabled() and (not A0_86.__near_distance_control or not A0_86.__near_distance_control:has_focus()) and A0_86.__far_distance_control and A0_86.__far_distance_control:has_focus()
end
function CoreDepthOfFieldCutsceneKey._is_editing_target_values(A0_87)
	return Application:ews_enabled() and (not A0_87.__target_near_distance_control or not A0_87.__target_near_distance_control:has_focus()) and A0_87.__target_far_distance_control and A0_87.__target_far_distance_control:has_focus()
end
function CoreDepthOfFieldCutsceneKey._final_near_distance(A0_88, A1_89)
	local L2_90
	L2_90 = A1_89.distance_from_camera
	L2_90 = L2_90(A1_89, A0_88:tracked_unit_name(), A0_88:tracked_object_name())
	if L2_90 and A0_88:_hyperfocal_distance() then
		return L2_90 < A0_88:_hyperfocal_distance() and A0_88:_hyperfocal_distance() * L2_90 / (A0_88:_hyperfocal_distance() + L2_90) or A0_88:_hyperfocal_distance() / 2
	else
		return A0_88:near_distance()
	end
end
function CoreDepthOfFieldCutsceneKey._final_far_distance(A0_91, A1_92)
	local L2_93
	L2_93 = A1_92.distance_from_camera
	L2_93 = L2_93(A1_92, A0_91:tracked_unit_name(), A0_91:tracked_object_name())
	if L2_93 and A0_91:_hyperfocal_distance() then
		return L2_93 < A0_91:_hyperfocal_distance() and A0_91:_hyperfocal_distance() * L2_93 / (A0_91:_hyperfocal_distance() - L2_93) or L2_93
	else
		return A0_91:far_distance()
	end
end
function CoreDepthOfFieldCutsceneKey._final_target_near_distance(A0_94, A1_95)
	local L2_96
	L2_96 = A1_95.distance_from_camera
	L2_96 = L2_96(A1_95, A0_94:target_tracked_unit_name(), A0_94:target_tracked_object_name())
	if L2_96 and A0_94:_hyperfocal_distance() then
		return L2_96 < A0_94:_hyperfocal_distance() and A0_94:_hyperfocal_distance() * L2_96 / (A0_94:_hyperfocal_distance() + L2_96) or A0_94:_hyperfocal_distance() / 2
	else
		return A0_94:target_near_distance()
	end
end
function CoreDepthOfFieldCutsceneKey._final_target_far_distance(A0_97, A1_98)
	local L2_99
	L2_99 = A1_98.distance_from_camera
	L2_99 = L2_99(A1_98, A0_97:target_tracked_unit_name(), A0_97:target_tracked_object_name())
	if L2_99 and A0_97:_hyperfocal_distance() then
		return L2_99 < A0_97:_hyperfocal_distance() and A0_97:_hyperfocal_distance() * L2_99 / (A0_97:_hyperfocal_distance() - L2_99) or L2_99
	else
		return A0_97:target_far_distance()
	end
end
function CoreDepthOfFieldCutsceneKey._hyperfocal_distance(A0_100)
	local L1_101
	L1_101 = 1433
	return L1_101
end
function CoreDepthOfFieldCutsceneKey._calc_interpolation(A0_102, A1_103)
	local L2_104, L3_105
	L2_104 = A1_103 ^ 2
	L2_104 = 3 * L2_104
	L3_105 = A1_103 ^ 3
	L3_105 = 2 * L3_105
	L2_104 = L2_104 - L3_105
	return L2_104
end
