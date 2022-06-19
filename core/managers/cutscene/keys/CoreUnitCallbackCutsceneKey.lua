require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreUnitCallbackCutsceneKey = CoreUnitCallbackCutsceneKey or class(CoreCutsceneKeyBase)
CoreUnitCallbackCutsceneKey.ELEMENT_NAME = "unit_callback"
CoreUnitCallbackCutsceneKey.NAME = "Unit Callback"
CoreUnitCallbackCutsceneKey:register_serialized_attribute("unit_name", "")
CoreUnitCallbackCutsceneKey:register_serialized_attribute("extension", "")
CoreUnitCallbackCutsceneKey:register_serialized_attribute("method", "")
CoreUnitCallbackCutsceneKey:register_serialized_attribute("enabled", true, toboolean)
CoreUnitCallbackCutsceneKey:register_serialized_attribute("arguments")
CoreUnitCallbackCutsceneKey:attribute_affects("unit_name", "extension")
CoreUnitCallbackCutsceneKey:attribute_affects("extension", "method")
CoreUnitCallbackCutsceneKey:attribute_affects("method", "arguments")
CoreUnitCallbackCutsceneKey.control_for_unit_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreUnitCallbackCutsceneKey.control_for_extension = CoreCutsceneKeyBase.standard_combo_box_control
CoreUnitCallbackCutsceneKey.control_for_method = CoreCutsceneKeyBase.standard_combo_box_control
function CoreUnitCallbackCutsceneKey.__tostring(A0_0)
	return "Call " .. A0_0:unit_name() .. ":" .. A0_0:extension() .. "():" .. A0_0:method() .. "(" .. A0_0:arguments_string() .. ")"
end
function CoreUnitCallbackCutsceneKey.arguments_string(A0_1)
	local L2_2
	L2_2 = string
	L2_2 = L2_2.join
	return L2_2(", ", table.collect(A0_1._method_params and A0_1._method_params[A0_1:method()] or {}, function(A0_3)
		return A0_3:inspect()
	end))
end
function CoreUnitCallbackCutsceneKey.load(A0_4, A1_5, A2_6)
	local L3_7, L4_8, L5_9, L6_10, L7_11, L8_12
	L3_7 = A0_4.super
	L3_7 = L3_7.load
	L3_7(L4_8, L5_9, L6_10)
	L3_7 = {}
	A0_4._method_params = L3_7
	L3_7 = {}
	for L7_11 in L4_8(L5_9) do
		L8_12 = CoreUnitCallbackCutsceneKeyParam
		L8_12 = L8_12.new
		L8_12 = L8_12(L8_12)
		L8_12:load(L7_11)
		table.insert(L3_7, L8_12)
	end
	L7_11 = A0_4
	L8_12 = L6_10(L7_11)
	if L4_8 then
		L4_8[L5_9] = L3_7
	end
end
function CoreUnitCallbackCutsceneKey._save_under(A0_13, A1_14)
	local L2_15
	L2_15 = A0_13.super
	L2_15 = L2_15._save_under
	L2_15 = L2_15(A0_13, A1_14)
	for 