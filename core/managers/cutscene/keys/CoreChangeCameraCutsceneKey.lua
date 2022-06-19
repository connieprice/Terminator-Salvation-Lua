require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreChangeCameraCutsceneKey = CoreChangeCameraCutsceneKey or class(CoreCutsceneKeyBase)
CoreChangeCameraCutsceneKey.ELEMENT_NAME = "change_camera"
CoreChangeCameraCutsceneKey.NAME = "Camera Change"
CoreChangeCameraCutsceneKey:register_serialized_attribute("camera", nil)
function CoreChangeCameraCutsceneKey.__tostring(A0_0)
	return "Change camera to \"" .. A0_0:camera() .. "\"."
end
function CoreChangeCameraCutsceneKey.load(A0_1, A1_2, A2_3)
	A0_1.super.load(A0_1, A1_2, A2_3)
	if A0_1.__camera == nil then
		A0_1.__camera = A1_2:parameter("ref_obj_name") or "camera"
	end
end
function CoreChangeCameraCutsceneKey.evaluate(A0_4, A1_5, A2_6)
	local L3_7, L4_8
	L4_8 = A1_5
	L3_7 = A1_5.set_camera
	L3_7(L4_8, A0_4:camera())
end
function CoreChangeCameraCutsceneKey.is_valid_camera(A0_9, A1_10)
	return A0_9.super.is_valid_unit_name(A0_9, A1_10) and string.begins(A1_10, "camera")
end
