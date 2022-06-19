require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreVisualFXCutsceneKey then
	CoreVisualFXCutsceneKey = class(CoreCutsceneKeyBase)
end
CoreVisualFXCutsceneKey.ELEMENT_NAME = "visual_fx"
CoreVisualFXCutsceneKey.NAME = "Visual Effect"
CoreVisualFXCutsceneKey:register_serialized_attribute("unit_name", "")
CoreVisualFXCutsceneKey:register_serialized_attribute("object_name", "")
CoreVisualFXCutsceneKey:register_serialized_attribute("effect", "")
CoreVisualFXCutsceneKey:register_serialized_attribute("duration", nil, tonumber)
CoreVisualFXCutsceneKey:register_serialized_attribute("offset", Vector3(0, 0, 0), CoreCutsceneKeyBase.string_to_vector)
CoreVisualFXCutsceneKey:register_serialized_attribute("rotation", Rotation(), CoreCutsceneKeyBase.string_to_rotation)
CoreVisualFXCutsceneKey:register_serialized_attribute("force_synch", false, toboolean)
CoreVisualFXCutsceneKey.control_for_effect = CoreCutsceneKeyBase.standard_combo_box_control
CoreVisualFXCutsceneKey.__tostring = function(l_1_0)
	return "Trigger visual effect \"" .. l_1_0:effect() .. "\" on \"" .. l_1_0:object_name() .. " in " .. l_1_0:unit_name() .. "\"."
end

CoreVisualFXCutsceneKey.can_evaluate_with_player = function(l_2_0, l_2_1)
	return true
end

CoreVisualFXCutsceneKey.prime = function(l_3_0, l_3_1)
	local l_3_2 = World:effect_manager()
	if not l_3_2:has_effect(l_3_0:effect()) then
		l_3_2:load(l_3_0:effect(), false)
	end
end

CoreVisualFXCutsceneKey.unload = function(l_4_0, l_4_1)
	l_4_0:stop()
end

CoreVisualFXCutsceneKey.play = function(l_5_0, l_5_1, l_5_2, l_5_3)
	if l_5_2 then
		l_5_0:stop()
	elseif not l_5_3 then
		l_5_0:stop()
		l_5_0:prime(l_5_1)
		local l_5_4 = World:effect_manager()
		do
			local l_5_5 = l_5_0:_unit_object(l_5_0:unit_name(), l_5_0:object_name(), true)
			local l_5_6, l_5_7 = l_5_4:spawn, l_5_4
			local l_5_8 = {}
			l_5_8.effect = l_5_0:effect()
			l_5_8.parent = l_5_5
			l_5_8.position = l_5_0:offset()
			l_5_8.rotation = l_5_0:rotation()
			l_5_8.force_synch = l_5_0:force_synch()
			l_5_6 = l_5_6(l_5_7, l_5_8)
			l_5_7 = function()
				-- upvalues: l_5_4 , l_5_6
				l_5_4:kill(l_5_6)
      end
			l_5_0._effect_abort_func = l_5_7
		end
	end
end

CoreVisualFXCutsceneKey.update = function(l_6_0, l_6_1, l_6_2)
	if l_6_0:duration() and l_6_0:duration() < l_6_2 then
		l_6_0:stop()
	end
end

CoreVisualFXCutsceneKey.is_valid_unit_name = function(l_7_0, l_7_1)
	if l_7_1 ~= nil and l_7_1 ~= "" then
		local l_7_2 = CoreCutsceneKeyBase.is_valid_unit_name(l_7_0, l_7_1)
		l_7_2 = l_7_2
		return l_7_2
	end
end

CoreVisualFXCutsceneKey.is_valid_object_name = function(l_8_0, l_8_1)
	if l_8_1 ~= nil and l_8_1 ~= "" and not table.contains(l_8_0:_unit_object_names(l_8_0:unit_name()), l_8_1) then
		local l_8_2 = false
	end
	l_8_2 = l_8_2
	return l_8_2
end

CoreVisualFXCutsceneKey.is_valid_effect = function(l_9_0, l_9_1)
	local l_9_2, l_9_3 = Database:has, Database
	local l_9_4 = "effect"
	local l_9_5 = l_9_1
	return l_9_2(l_9_3, l_9_4, l_9_5)
end

CoreVisualFXCutsceneKey.is_valid_duration = function(l_10_0, l_10_1)
	return l_10_1 == nil or l_10_1 > 0
end

CoreVisualFXCutsceneKey.is_valid_offset = function(l_11_0, l_11_1)
	return l_11_1 ~= nil
end

CoreVisualFXCutsceneKey.is_valid_rotation = function(l_12_0, l_12_1)
	return l_12_1 ~= nil
end

CoreVisualFXCutsceneKey.refresh_control_for_unit_name = function(l_13_0, l_13_1)
	l_13_0.super.refresh_control_for_unit_name(l_13_0, l_13_1, l_13_0:unit_name())
	l_13_1:append("")
	if l_13_0:unit_name() == "" then
		l_13_1:set_value("")
	end
end

CoreVisualFXCutsceneKey.refresh_control_for_object_name = function(l_14_0, l_14_1)
	l_14_0.super.refresh_control_for_object_name(l_14_0, l_14_1, l_14_0:unit_name(), l_14_0:object_name())
	l_14_1:append("")
	if l_14_0:object_name() == "" or not l_14_0:is_valid_object_name(l_14_0:object_name()) then
		l_14_0:set_object_name("")
		l_14_1:set_value("")
	end
	local l_14_2, l_14_3 = l_14_1:set_enabled, l_14_1
	l_14_2(l_14_3, l_14_0:unit_name() ~= "")
end

CoreVisualFXCutsceneKey.refresh_control_for_effect = function(l_15_0, l_15_1)
	l_15_1:freeze()
	l_15_1:clear()
	local l_15_2 = l_15_0:effect()
	local l_15_6, l_15_7 = ipairs, Database:all(false, "effect")
	l_15_6 = l_15_6(l_15_7)
	for i_0,i_1 in l_15_6 do
		l_15_1:append(l_15_5:name())
		if l_15_5:name() == l_15_2 then
			l_15_1:set_value(l_15_2)
		end
	end
	l_15_1:thaw()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreVisualFXCutsceneKey.on_attribute_before_changed = function(l_16_0, l_16_1, l_16_2, l_16_3)
	l_16_0:stop()
end

CoreVisualFXCutsceneKey.stop = function(l_17_0)
	if l_17_0._effect_abort_func then
		l_17_0._effect_abort_func()
		l_17_0._effect_abort_func = nil
	end
end


