require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreChangeCameraAttributeCutsceneKey then
	CoreChangeCameraAttributeCutsceneKey = class(CoreCutsceneKeyBase)
end
CoreChangeCameraAttributeCutsceneKey.ELEMENT_NAME = "camera_attribute"
CoreChangeCameraAttributeCutsceneKey.NAME = "Camera Attribute"
CoreChangeCameraAttributeCutsceneKey:register_serialized_attribute("near_range", nil, tonumber)
CoreChangeCameraAttributeCutsceneKey:register_serialized_attribute("far_range", nil, tonumber)
CoreChangeCameraAttributeCutsceneKey:attribute_affects("near_range", "far_range")
CoreChangeCameraAttributeCutsceneKey:attribute_affects("far_range", "near_range")
CoreChangeCameraAttributeCutsceneKey.__tostring = function(l_1_0)
	return "Change camera attributes."
end

CoreChangeCameraAttributeCutsceneKey.populate_from_editor = function(l_2_0, l_2_1)
	l_2_0.super.populate_from_editor(l_2_0, l_2_1)
	local l_2_2 = l_2_1:camera_attributes()
	l_2_0:set_near_range(l_2_2.near_range)
	l_2_0:set_far_range(l_2_2.far_range)
end

CoreChangeCameraAttributeCutsceneKey.is_valid = function(l_3_0)
	return true
end

CoreChangeCameraAttributeCutsceneKey.evaluate = function(l_4_0, l_4_1, l_4_2)
	local l_4_7, l_4_8, l_4_9 = nil
	do
		for i_0,i_1 in pairs(l_4_0.__serialized_attributes) do
			local l_4_4 = function(l_5_0)
		-- upvalues: l_4_0 , l_4_1
		local l_5_1 = l_4_0:attribute_value(l_5_0)
		if l_5_1 and l_4_0["is_valid_" .. l_5_0](l_4_0, l_5_1) then
			l_4_1:set_camera_attribute(l_5_0, l_5_1)
		end
  end
			l_4_4(i_0)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreChangeCameraAttributeCutsceneKey.is_valid_near_range = function(l_5_0, l_5_1)
	return l_5_1 == nil or (l_5_1 > 0 and (not l_5_0:far_range() and l_5_1 < math.huge))
end

CoreChangeCameraAttributeCutsceneKey.is_valid_far_range = function(l_6_0, l_6_1)
	return not l_6_0:near_range() and l_6_1 == nil or 0 < l_6_1
end


