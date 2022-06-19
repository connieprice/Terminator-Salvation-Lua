require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreShakeCameraCutsceneKey = CoreShakeCameraCutsceneKey or class(CoreCutsceneKeyBase)
CoreShakeCameraCutsceneKey.ELEMENT_NAME = "camera_shaker"
CoreShakeCameraCutsceneKey.NAME = "Camera Shake"
CoreShakeCameraCutsceneKey:register_serialized_attribute("name", "")
CoreShakeCameraCutsceneKey:register_serialized_attribute("amplitude", 1, tonumber)
CoreShakeCameraCutsceneKey:register_serialized_attribute("frequency", 1, tonumber)
CoreShakeCameraCutsceneKey:register_serialized_attribute("offset", 0, tonumber)
function CoreShakeCameraCutsceneKey.__tostring(A0_0)
	return "Trigger camera shake \"" .. A0_0:name() .. "\"."
end
function CoreShakeCameraCutsceneKey.play(A0_1, A1_2, A2_3, A3_4)
	if A2_3 then
		A0_1:stop()
	elseif not A3_4 then
		A0_1:stop()
		A0_1._shake_abort_func = A1_2:play_camera_shake(A0_1:name(), A0_1:amplitude(), A0_1:frequency(), A0_1:offset())
	end
end
function CoreShakeCameraCutsceneKey.stop(A0_5)
	if A0_5._shake_abort_func then
		A0_5._shake_abort_func()
		A0_5._shake_abort_func = nil
	end
end
