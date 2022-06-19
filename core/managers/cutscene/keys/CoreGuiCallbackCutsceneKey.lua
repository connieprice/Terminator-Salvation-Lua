require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreGuiCallbackCutsceneKey = CoreGuiCallbackCutsceneKey or class(CoreCutsceneKeyBase)
CoreGuiCallbackCutsceneKey.ELEMENT_NAME = "gui_callback"
CoreGuiCallbackCutsceneKey.NAME = "Gui Callback"
CoreGuiCallbackCutsceneKey:register_serialized_attribute("name", "")
CoreGuiCallbackCutsceneKey:register_serialized_attribute("function_name", "")
CoreGuiCallbackCutsceneKey:register_serialized_attribute("enabled", true, toboolean)
CoreGuiCallbackCutsceneKey.control_for_name = CoreCutsceneKeyBase.standard_combo_box_control
function CoreGuiCallbackCutsceneKey.__tostring(A0_0)
	return "Call " .. A0_0:function_name() .. " in gui \"" .. A0_0:name() .. "\"."
end
function CoreGuiCallbackCutsceneKey.evaluate(A0_1, A1_2, A2_3)
	if A0_1:enabled() then
		A1_2:invoke_callback_in_gui(A0_1:name(), A0_1:function_name(), A1_2)
	end
end
function CoreGuiCallbackCutsceneKey.is_valid_name(A0_4, A1_5)
	return Database:has("gui", A1_5)
end
function CoreGuiCallbackCutsceneKey.refresh_control_for_name(A0_6, A1_7)
	local L2_8
	L2_8 = A1_7.freeze
	L2_8(A1_7)
	L2_8 = A1_7.clear
	L2_8(A1_7)
	L2_8 = A0_6.name
	L2_8 = L2_8(A0_6)
	for 