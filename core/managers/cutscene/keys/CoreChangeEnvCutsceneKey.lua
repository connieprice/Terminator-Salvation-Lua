require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreChangeEnvCutsceneKey = CoreChangeEnvCutsceneKey or class(CoreCutsceneKeyBase)
CoreChangeEnvCutsceneKey.ELEMENT_NAME = "change_env"
CoreChangeEnvCutsceneKey.NAME = "Environment Change"
CoreChangeEnvCutsceneKey:register_serialized_attribute("name", "")
CoreChangeEnvCutsceneKey:register_serialized_attribute("transition_time", 0, tonumber)
function CoreChangeEnvCutsceneKey.__tostring(A0_0)
	return "Change environment to \"" .. A0_0:name() .. "\"."
end
function CoreChangeEnvCutsceneKey.prime(A0_1, A1_2)
	managers.environment:preload_environment(A0_1:name(), false)
end
function CoreChangeEnvCutsceneKey.unload(A0_3, A1_4)
	if A0_3.__previous_environment_name then
		managers.viewport:first_active_viewport():set_environment(A0_3.__previous_environment_name)
	end
end
function CoreChangeEnvCutsceneKey.evaluate(A0_5, A1_6, A2_7)
	local L3_8
	L3_8 = A0_5.__previous_environment_name
	if not L3_8 then
		L3_8 = managers
		L3_8 = L3_8.environment
		L3_8 = L3_8.get_current_environment_name
		L3_8 = L3_8(L3_8)
	end
	A0_5.__previous_environment_name = L3_8
	L3_8 = A0_5.transition_time
	L3_8 = L3_8(A0_5)
	if L3_8 and L3_8 > 0 then
		managers.environment:change_environment(A0_5:name(), L3_8)
	else
		managers.viewport:first_active_viewport():set_environment(A0_5:name())
	end
end
function CoreChangeEnvCutsceneKey.can_evaluate_with_player(A0_9, A1_10)
	local L2_11
	L2_11 = true
	return L2_11
end
function CoreChangeEnvCutsceneKey.is_valid_name(A0_12, A1_13)
	return Database:has("environment", A1_13)
end
function CoreChangeEnvCutsceneKey.is_valid_transition_time(A0_14, A1_15)
	local L2_16
	L2_16 = A1_15 and A1_15 >= 0
	return L2_16
end
CoreChangeEnvCutsceneKey.control_for_name = CoreCutsceneKeyBase.standard_combo_box_control
function CoreChangeEnvCutsceneKey.refresh_control_for_name(A0_17, A1_18)
	local L2_19
	L2_19 = A1_18.freeze
	L2_19(A1_18)
	L2_19 = A1_18.clear
	L2_19(A1_18)
	L2_19 = A0_17.name
	L2_19 = L2_19(A0_17)
	for 