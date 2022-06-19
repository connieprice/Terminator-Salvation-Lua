require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreVisualFXCutsceneKey = CoreVisualFXCutsceneKey or class(CoreCutsceneKeyBase)
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
function CoreVisualFXCutsceneKey.__tostring(A0_0)
	return "Trigger visual effect \"" .. A0_0:effect() .. "\" on \"" .. A0_0:object_name() .. " in " .. A0_0:unit_name() .. "\"."
end
function CoreVisualFXCutsceneKey.can_evaluate_with_player(A0_1, A1_2)
	local L2_3
	L2_3 = true
	return L2_3
end
function CoreVisualFXCutsceneKey.prime(A0_4, A1_5)
	if not World:effect_manager():has_effect(A0_4:effect()) then
		World:effect_manager():load(A0_4:effect(), false)
	end
end
function CoreVisualFXCutsceneKey.unload(A0_6, A1_7)
	A0_6:stop()
end
function CoreVisualFXCutsceneKey.play(A0_8, A1_9, A2_10, A3_11)
	if A2_10 then
		A0_8:stop()
	elseif not A3_11 then
		A0_8:stop()
		A0_8:prime(A1_9)
		function A0_8._effect_abort_func()
			_UPVALUE0_:kill(_UPVALUE1_)
		end
	end
end
function CoreVisualFXCutsceneKey.update(A0_12, A1_13, A2_14)
	if A0_12:duration() and A2_14 > A0_12:duration() then
		A0_12:stop()
	end
end
function CoreVisualFXCutsceneKey.is_valid_unit_name(A0_15, A1_16)
	return A1_16 == nil or A1_16 == "" or CoreCutsceneKeyBase.is_valid_unit_name(A0_15, A1_16)
end
function CoreVisualFXCutsceneKey.is_valid_object_name(A0_17, A1_18)
	return A1_18 == nil or A1_18 == "" or table.contains(A0_17:_unit_object_names(A0_17:unit_name()), A1_18) or false
end
function CoreVisualFXCutsceneKey.is_valid_effect(A0_19, A1_20)
	return Database:has("effect", A1_20)
end
function CoreVisualFXCutsceneKey.is_valid_duration(A0_21, A1_22)
	local L2_23
	L2_23 = A1_22 == nil or A1_22 > 0
	return L2_23
end
function CoreVisualFXCutsceneKey.is_valid_offset(A0_24, A1_25)
	local L2_26
	L2_26 = A1_25 ~= nil
	return L2_26
end
function CoreVisualFXCutsceneKey.is_valid_rotation(A0_27, A1_28)
	local L2_29
	L2_29 = A1_28 ~= nil
	return L2_29
end
function CoreVisualFXCutsceneKey.refresh_control_for_unit_name(A0_30, A1_31)
	A0_30.super.refresh_control_for_unit_name(A0_30, A1_31, A0_30:unit_name())
	A1_31:append("")
	if A0_30:unit_name() == "" then
		A1_31:set_value("")
	end
end
function CoreVisualFXCutsceneKey.refresh_control_for_object_name(A0_32, A1_33)
	A0_32.super.refresh_control_for_object_name(A0_32, A1_33, A0_32:unit_name(), A0_32:object_name())
	A1_33:append("")
	if A0_32:object_name() == "" or not A0_32:is_valid_object_name(A0_32:object_name()) then
		A0_32:set_object_name("")
		A1_33:set_value("")
	end
	A1_33:set_enabled(A0_32:unit_name() ~= "")
end
function CoreVisualFXCutsceneKey.refresh_control_for_effect(A0_34, A1_35)
	local L2_36
	L2_36 = A1_35.freeze
	L2_36(A1_35)
	L2_36 = A1_35.clear
	L2_36(A1_35)
	L2_36 = A0_34.effect
	L2_36 = L2_36(A0_34)
	for 