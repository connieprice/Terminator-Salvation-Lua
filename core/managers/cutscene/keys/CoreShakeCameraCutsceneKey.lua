require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreShakeCameraCutsceneKey then
	CoreShakeCameraCutsceneKey = class(CoreCutsceneKeyBase)
end
CoreShakeCameraCutsceneKey.ELEMENT_NAME = "camera_shaker"
CoreShakeCameraCutsceneKey.NAME = "Camera Shake"
CoreShakeCameraCutsceneKey:register_serialized_attribute("name", "")
CoreShakeCameraCutsceneKey:register_serialized_attribute("amplitude", 1, tonumber)
CoreShakeCameraCutsceneKey:register_serialized_attribute("frequency", 1, tonumber)
CoreShakeCameraCutsceneKey:register_serialized_attribute("offset", 0, tonumber)
CoreShakeCameraCutsceneKey.__tostring = function(l_1_0)
	return "Trigger camera shake \"" .. l_1_0:name() .. "\"."
end

CoreShakeCameraCutsceneKey.play = function(l_2_0, l_2_1, l_2_2, l_2_3)
	if l_2_2 then
		l_2_0:stop()
	elseif not l_2_3 then
		l_2_0:stop()
		l_2_0._shake_abort_func = l_2_1:play_camera_shake(l_2_0:name(), l_2_0:amplitude(), l_2_0:frequency(), l_2_0:offset())
	end
end

CoreShakeCameraCutsceneKey.stop = function(l_3_0)
	if l_3_0._shake_abort_func then
		l_3_0._shake_abort_func()
		l_3_0._shake_abort_func = nil
	end
end


