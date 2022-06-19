require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreChangeCameraAttributeCutsceneKey = CoreChangeCameraAttributeCutsceneKey or class(CoreCutsceneKeyBase)
CoreChangeCameraAttributeCutsceneKey.ELEMENT_NAME = "camera_attribute"
CoreChangeCameraAttributeCutsceneKey.NAME = "Camera Attribute"
CoreChangeCameraAttributeCutsceneKey:register_serialized_attribute("near_range", nil, tonumber)
CoreChangeCameraAttributeCutsceneKey:register_serialized_attribute("far_range", nil, tonumber)
CoreChangeCameraAttributeCutsceneKey:attribute_affects("near_range", "far_range")
CoreChangeCameraAttributeCutsceneKey:attribute_affects("far_range", "near_range")
function CoreChangeCameraAttributeCutsceneKey.__tostring(A0_0)
	local L1_1
	L1_1 = "Change camera attributes."
	return L1_1
end
function CoreChangeCameraAttributeCutsceneKey.populate_from_editor(A0_2, A1_3)
	A0_2.super.populate_from_editor(A0_2, A1_3)
	A0_2:set_near_range(A1_3:camera_attributes().near_range)
	A0_2:set_far_range(A1_3:camera_attributes().far_range)
end
function CoreChangeCameraAttributeCutsceneKey.is_valid(A0_4)
	local L1_5
	L1_5 = true
	return L1_5
end
function CoreChangeCameraAttributeCutsceneKey.evaluate(A0_6, A1_7, A2_8)
	local L3_9, L4_10, L5_11, L6_12, L7_13
	function L3_9(A0_14)
		local L1_15
		L1_15 = _UPVALUE0_
		L1_15 = L1_15.attribute_value
		L1_15 = L1_15(L1_15, A0_14)
		if L1_15 and _UPVALUE0_["is_valid_" .. A0_14](_UPVALUE0_, L1_15) then
			_UPVALUE1_:set_camera_attribute(A0_14, L1_15)
		end
	end
	for L7_13, 