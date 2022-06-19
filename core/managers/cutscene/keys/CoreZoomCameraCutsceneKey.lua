require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreZoomCameraCutsceneKey then
	CoreZoomCameraCutsceneKey = class(CoreCutsceneKeyBase)
end
CoreZoomCameraCutsceneKey.ELEMENT_NAME = "camera_zoom"
CoreZoomCameraCutsceneKey.NAME = "Camera Zoom"
CoreZoomCameraCutsceneKey.DEFAULT_CAMERA_FOV = 55
local l_0_0 = CoreZoomCameraCutsceneKey
local l_0_1 = {}
l_0_1.Linear = function(l_1_0, l_1_1)
	return l_1_0
end

l_0_1["J curve"] = function(l_2_0, l_2_1)
	local l_2_2 = 2 * (1 - l_2_1)
	return (1 - l_2_2) * l_2_0 ^ 2 + l_2_2 * l_2_0
end

l_0_1["S curve"] = function(l_3_0, l_3_1)
	local l_3_2 = 1 + l_3_1 * 2
	local l_3_3 = l_3_2 + 1
	return l_3_3 * l_3_0 ^ l_3_2 - l_3_2 * l_3_0 ^ l_3_3
end

l_0_0.INTERPOLATION_FUNCTIONS = l_0_1
l_0_0 = CoreZoomCameraCutsceneKey
l_0_0, l_0_1 = l_0_0:register_serialized_attribute, l_0_0
l_0_0(l_0_1, "start_fov", CoreZoomCameraCutsceneKey.DEFAULT_CAMERA_FOV, tonumber)
l_0_0 = CoreZoomCameraCutsceneKey
l_0_0, l_0_1 = l_0_0:register_serialized_attribute, l_0_0
l_0_0(l_0_1, "end_fov", CoreZoomCameraCutsceneKey.DEFAULT_CAMERA_FOV, tonumber)
l_0_0 = CoreZoomCameraCutsceneKey
l_0_0, l_0_1 = l_0_0:register_serialized_attribute, l_0_0
l_0_0(l_0_1, "transition_time", 0, tonumber)
l_0_0 = CoreZoomCameraCutsceneKey
l_0_0, l_0_1 = l_0_0:register_serialized_attribute, l_0_0
l_0_0(l_0_1, "interpolation", "Linear")
l_0_0 = CoreZoomCameraCutsceneKey
l_0_0, l_0_1 = l_0_0:register_serialized_attribute, l_0_0
l_0_0(l_0_1, "interpolation_bias", 0.5, function(l_4_0)
	return (tonumber(l_4_0) or 0) / 100
end
)
l_0_0 = CoreZoomCameraCutsceneKey
l_0_1 = function(l_5_0)
	return "Change camera zoom."
end

l_0_0.__tostring = l_0_1
l_0_0 = CoreZoomCameraCutsceneKey
l_0_1 = function(l_6_0, l_6_1)
	l_6_0.super.populate_from_editor(l_6_0, l_6_1)
	local l_6_2 = l_6_1:camera_attributes()
	l_6_0:set_start_fov(l_6_2.fov)
	l_6_0:set_end_fov(l_6_2.fov)
end

l_0_0.populate_from_editor = l_0_1
l_0_0 = CoreZoomCameraCutsceneKey
l_0_1 = function(l_7_0, l_7_1, l_7_2, l_7_3)
	if l_7_2 then
		local l_7_4 = l_7_0:preceeding_key()
		if l_7_4 then
			l_7_1:set_camera_attribute("fov", l_7_4:end_fov())
		else
			l_7_1:set_camera_attribute("fov", CoreZoomCameraCutsceneKey.DEFAULT_CAMERA_FOV)
		end
	else
		l_7_1:set_camera_attribute("fov", l_7_0:start_fov())
	end
end

l_0_0.play = l_0_1
l_0_0 = CoreZoomCameraCutsceneKey
l_0_1 = function(l_8_0, l_8_1, l_8_2)
	local l_8_3 = l_8_0:transition_time()
	if l_8_3 <= 0 or not math.min(l_8_2 / l_8_3, 1) then
		local l_8_4, l_8_5 = l_8_2 > l_8_3 + 0.033333335 or 1
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_8_6 = nil
	local l_8_7 = nil
	l_8_1:set_camera_attribute("fov", l_8_0:start_fov() + (l_8_0:end_fov() - l_8_0:start_fov()) * l_8_0:_calc_interpolation(l_8_4))
end

l_0_0.update = l_0_1
l_0_0 = CoreZoomCameraCutsceneKey
l_0_1 = function(l_9_0, l_9_1)
	do
		return not l_9_1 or (l_9_1 > 0 and l_9_1 < 180)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.is_valid_start_fov = l_0_1
l_0_0 = CoreZoomCameraCutsceneKey
l_0_1 = function(l_10_0, l_10_1)
	do
		return not l_10_1 or l_10_1 >= 0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.is_valid_transition_time = l_0_1
l_0_0 = CoreZoomCameraCutsceneKey
l_0_1 = function(l_11_0, l_11_1)
	return l_11_0.INTERPOLATION_FUNCTIONS[l_11_1] ~= nil
end

l_0_0.is_valid_interpolation = l_0_1
l_0_0 = CoreZoomCameraCutsceneKey
l_0_1 = function(l_12_0, l_12_1)
	do
		return not l_12_1 or (l_12_1 >= 0 and l_12_1 <= 1)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.is_valid_interpolation_bias = l_0_1
l_0_0 = CoreZoomCameraCutsceneKey
l_0_1 = CoreZoomCameraCutsceneKey
l_0_1 = l_0_1.is_valid_start_fov
l_0_0.is_valid_end_fov = l_0_1
l_0_0 = CoreZoomCameraCutsceneKey
l_0_1 = CoreCutsceneKeyBase
l_0_1 = l_0_1.standard_combo_box_control
l_0_0.control_for_interpolation = l_0_1
l_0_0 = CoreZoomCameraCutsceneKey
l_0_1 = CoreCutsceneKeyBase
l_0_1 = l_0_1.standard_percentage_slider_control
l_0_0.control_for_interpolation_bias = l_0_1
l_0_0 = CoreZoomCameraCutsceneKey
l_0_1 = CoreCutsceneKeyBase
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.refresh_control_for_interpolation = l_0_1
l_0_0 = CoreZoomCameraCutsceneKey
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.refresh_control_for_interpolation_bias = l_0_1
l_0_0 = CoreZoomCameraCutsceneKey
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0._calc_interpolation = l_0_1

