require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreChangeCameraCutsceneKey then
	CoreChangeCameraCutsceneKey = class(CoreCutsceneKeyBase)
end
CoreChangeCameraCutsceneKey.ELEMENT_NAME = "change_camera"
CoreChangeCameraCutsceneKey.NAME = "Camera Change"
CoreChangeCameraCutsceneKey:register_serialized_attribute("camera", nil)
CoreChangeCameraCutsceneKey.__tostring = function(l_1_0)
	return "Change camera to \"" .. l_1_0:camera() .. "\"."
end

CoreChangeCameraCutsceneKey.load = function(l_2_0, l_2_1, l_2_2)
	l_2_0.super.load(l_2_0, l_2_1, l_2_2)
	if not l_2_1:parameter("ref_obj_name") then
		l_2_0.__camera = l_2_0.__camera ~= nil or "camera"
	end
end

CoreChangeCameraCutsceneKey.evaluate = function(l_3_0, l_3_1, l_3_2)
	l_3_1:set_camera(l_3_0:camera())
end

CoreChangeCameraCutsceneKey.is_valid_camera = function(l_4_0, l_4_1)
	if l_4_0.super.is_valid_unit_name(l_4_0, l_4_1) then
		return string.begins(l_4_1, "camera")
	end
end


