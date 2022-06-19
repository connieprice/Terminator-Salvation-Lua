require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreGuiCutsceneKey = CoreGuiCutsceneKey or class(CoreCutsceneKeyBase)
CoreGuiCutsceneKey.ELEMENT_NAME = "gui"
CoreGuiCutsceneKey.NAME = "Gui"
CoreGuiCutsceneKey.VALID_ACTIONS = {"show", "hide"}
CoreGuiCutsceneKey:register_serialized_attribute("action", "show")
CoreGuiCutsceneKey:register_serialized_attribute("name", "")
CoreGuiCutsceneKey.control_for_action = CoreCutsceneKeyBase.standard_combo_box_control
CoreGuiCutsceneKey.control_for_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreGuiCutsceneKey.refresh_control_for_action = CoreCutsceneKeyBase:standard_combo_box_control_refresh("action", CoreGuiCutsceneKey.VALID_ACTIONS)
function CoreGuiCutsceneKey.__tostring(A0_0)
	return string.capitalize(A0_0:action()) .. " gui \"" .. A0_0:name() .. "\"."
end
function CoreGuiCutsceneKey.prime(A0_1, A1_2)
	if A0_1:action() == "show" and A0_1:is_valid_name(A0_1:name()) then
		A1_2:load_gui(A0_1:name())
	end
end
function CoreGuiCutsceneKey.unload(A0_3, A1_4)
	if A1_4 then
		A0_3:play(A1_4, true)
	end
end
function CoreGuiCutsceneKey.play(A0_5, A1_6, A2_7, A3_8)
	if A2_7 then
		if A0_5:preceeding_key({
			name = A0_5:name()
		}) == nil or A0_5:preceeding_key({
			name = A0_5:name()
		}):action() == A0_5:inverse_action() then
			A0_5:_perform_action(A0_5:inverse_action(), A1_6)
		end
	else
		A0_5:_perform_action(A0_5:action(), A1_6)
	end
end
function CoreGuiCutsceneKey.inverse_action(A0_9)
	return A0_9:action() == "show" and "hide" or "show"
end
function CoreGuiCutsceneKey._perform_action(A0_10, A1_11, A2_12)
	A2_12:set_gui_visible(A0_10:name(), A1_11 == "show")
end
function CoreGuiCutsceneKey.is_valid_action(A0_13, A1_14)
	return table.contains(A0_13.VALID_ACTIONS, A1_14)
end
function CoreGuiCutsceneKey.is_valid_name(A0_15, A1_16)
	return Database:has("gui", A1_16)
end
function CoreGuiCutsceneKey.refresh_control_for_name(A0_17, A1_18)
	local L2_19
	L2_19 = A1_18.freeze
	L2_19(A1_18)
	L2_19 = A1_18.clear
	L2_19(A1_18)
	L2_19 = A0_17.name
	L2_19 = L2_19(A0_17)
	for 