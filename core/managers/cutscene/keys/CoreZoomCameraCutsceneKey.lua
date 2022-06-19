require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreZoomCameraCutsceneKey = CoreZoomCameraCutsceneKey or class(CoreCutsceneKeyBase)
CoreZoomCameraCutsceneKey.ELEMENT_NAME = "camera_zoom"
CoreZoomCameraCutsceneKey.NAME = "Camera Zoom"
CoreZoomCameraCutsceneKey.DEFAULT_CAMERA_FOV = 55
CoreZoomCameraCutsceneKey.INTERPOLATION_FUNCTIONS = {
	["Linear"] = function(A0_0, A1_1)
		return A0_0
	end,
	["J curve"] = function(A0_2, A1_3)
		local L2_4, L3_5, L4_6, L5_7
		L2_4 = 1 - A1_3
		L2_4 = 2 * L2_4
		L3_5 = 1 - L2_4
		L4_6 = A0_2 ^ 2
		L4_6 = L3_5 * L4_6
		L5_7 = L2_4 * A0_2
		L4_6 = L4_6 + L5_7
		return L4_6
	end,
	["S curve"] = function(A0_8, A1_9)
		local L2_10, L3_11, L4_12, L5_13
		L2_10 = A1_9 * 2
		L2_10 = 1 + L2_10
		L3_11 = L2_10 + 1
		L4_12 = A0_8 ^ L2_10
		L4_12 = L3_11 * L4_12
		L5_13 = A0_8 ^ L3_11
		L5_13 = L2_10 * L5_13
		L4_12 = L4_12 - L5_13
		return L4_12
	end
}
CoreZoomCameraCutsceneKey:register_serialized_attribute("start_fov", CoreZoomCameraCutsceneKey.DEFAULT_CAMERA_FOV, tonumber)
CoreZoomCameraCutsceneKey:register_serialized_attribute("end_fov", CoreZoomCameraCutsceneKey.DEFAULT_CAMERA_FOV, tonumber)
CoreZoomCameraCutsceneKey:register_serialized_attribute("transition_time", 0, tonumber)
CoreZoomCameraCutsceneKey:register_serialized_attribute("interpolation", "Linear")
CoreZoomCameraCutsceneKey:register_serialized_attribute("interpolation_bias", 0.5, function(A0_14)
	return (tonumber(A0_14) or 0) / 100
end)
function CoreZoomCameraCutsceneKey.__tostring(A0_15)
	local L1_16
	L1_16 = "Change camera zoom."
	return L1_16
end
function CoreZoomCameraCutsceneKey.populate_from_editor(A0_17, A1_18)
	A0_17.super.populate_from_editor(A0_17, A1_18)
	A0_17:set_start_fov(A1_18:camera_attributes().fov)
	A0_17:set_end_fov(A1_18:camera_attributes().fov)
end
function CoreZoomCameraCutsceneKey.play(A0_19, A1_20, A2_21, A3_22)
	if A2_21 then
		if A0_19:preceeding_key() then
			A1_20:set_camera_attribute("fov", A0_19:preceeding_key():end_fov())
		else
			A1_20:set_camera_attribute("fov", CoreZoomCameraCutsceneKey.DEFAULT_CAMERA_FOV)
		end
	else
		A1_20:set_camera_attribute("fov", A0_19:start_fov())
	end
end
function CoreZoomCameraCutsceneKey.update(A0_23, A1_24, A2_25)
	local L3_26, L4_27, L5_28, L6_29
	L4_27 = A0_23
	L3_26 = A0_23.transition_time
	L3_26 = L3_26(L4_27)
	L4_27 = L3_26 + 0.033333335
	if A2_25 <= L4_27 then
		if L3_26 > 0 then
			L4_27 = math
			L4_27 = L4_27.min
			L5_28 = A2_25 / L3_26
			L6_29 = 1
			L4_27 = L4_27(L5_28, L6_29)
		else
			L4_27 = L4_27 or 1
		end
		L6_29 = A0_23
		L5_28 = A0_23._calc_interpolation
		L5_28 = L5_28(L6_29, L4_27)
		L6_29 = A0_23.start_fov
		L6_29 = L6_29(A0_23)
		L6_29 = L6_29 + (A0_23:end_fov() - A0_23:start_fov()) * L5_28
		A1_24:set_camera_attribute("fov", L6_29)
	end
end
function CoreZoomCameraCutsceneKey.is_valid_start_fov(A0_30, A1_31)
	local L2_32
	L2_32 = A1_31 and A1_31 > 0 and A1_31 < 180
	return L2_32
end
function CoreZoomCameraCutsceneKey.is_valid_transition_time(A0_33, A1_34)
	local L2_35
	L2_35 = A1_34 and A1_34 >= 0
	return L2_35
end
function CoreZoomCameraCutsceneKey.is_valid_interpolation(A0_36, A1_37)
	local L2_38
	L2_38 = A0_36.INTERPOLATION_FUNCTIONS
	L2_38 = L2_38[A1_37]
	L2_38 = L2_38 ~= nil
	return L2_38
end
function CoreZoomCameraCutsceneKey.is_valid_interpolation_bias(A0_39, A1_40)
	local L2_41
	L2_41 = A1_40 and A1_40 >= 0 and A1_40 <= 1
	return L2_41
end
CoreZoomCameraCutsceneKey.is_valid_end_fov = CoreZoomCameraCutsceneKey.is_valid_start_fov
CoreZoomCameraCutsceneKey.control_for_interpolation = CoreCutsceneKeyBase.standard_combo_box_control
CoreZoomCameraCutsceneKey.control_for_interpolation_bias = CoreCutsceneKeyBase.standard_percentage_slider_control
CoreZoomCameraCutsceneKey.refresh_control_for_interpolation = CoreCutsceneKeyBase:standard_combo_box_control_refresh("interpolation", table.map_keys(CoreZoomCameraCutsceneKey.INTERPOLATION_FUNCTIONS, function(A0_42, A1_43)
	local L2_44
	L2_44 = A0_42 == "Linear" or A0_42 < A1_43
	return L2_44
end))
CoreZoomCameraCutsceneKey.refresh_control_for_interpolation_bias = CoreCutsceneKeyBase:standard_percentage_slider_control_refresh("interpolation_bias")
function CoreZoomCameraCutsceneKey._calc_interpolation(A0_45, A1_46)
	local L2_47
	L2_47 = A0_45.INTERPOLATION_FUNCTIONS
	L2_47 = L2_47[A0_45:interpolation()]
	return L2_47(A1_46, math.clamp(A0_45:interpolation_bias(), 0, 1))
end
