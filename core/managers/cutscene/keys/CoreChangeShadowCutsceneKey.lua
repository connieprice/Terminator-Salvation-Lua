require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreChangeShadowCutsceneKey = CoreChangeShadowCutsceneKey or class(CoreCutsceneKeyBase)
CoreChangeShadowCutsceneKey.ELEMENT_NAME = "change_shadow"
CoreChangeShadowCutsceneKey.NAME = "Shadow Change"
CoreChangeShadowCutsceneKey:register_serialized_attribute("name", "")
function CoreChangeShadowCutsceneKey.__tostring(A0_0)
	return "Change shadow settings to \"" .. A0_0:name() .. "\"."
end
function CoreChangeShadowCutsceneKey.prime(A0_1, A1_2)
	local L2_3, L3_4
	L2_3 = managers
	L2_3 = L2_3.shadow
	L3_4 = L2_3
	L2_3 = L2_3.preload
	L2_3(L3_4, A0_1:name())
end
function CoreChangeShadowCutsceneKey.evaluate(A0_5, A1_6, A2_7)
	local L3_8
	L3_8 = A0_5.name
	L3_8 = L3_8(A0_5)
	managers.shadow:preload(L3_8)
	managers.shadow:push(L3_8)
	A0_5._on_stack = true
end
function CoreChangeShadowCutsceneKey.revert(A0_9)
	local L1_10, L2_11
	L1_10 = A0_9._on_stack
	if L1_10 then
		L1_10 = managers
		L1_10 = L1_10.shadow
		L2_11 = L1_10
		L1_10 = L1_10.pop
		L1_10(L2_11, A0_9:name())
		A0_9._on_stack = false
	end
end
function CoreChangeShadowCutsceneKey.unload(A0_12)
	local L1_13, L2_14
	L1_13 = A0_12._on_stack
	if L1_13 then
		L1_13 = managers
		L1_13 = L1_13.shadow
		L2_14 = L1_13
		L1_13 = L1_13.pop
		L1_13(L2_14, A0_12:name())
		A0_12._on_stack = false
	end
end
function CoreChangeShadowCutsceneKey.can_evaluate_with_player(A0_15, A1_16)
	local L2_17
	L2_17 = true
	return L2_17
end
function CoreChangeShadowCutsceneKey.is_valid_name(A0_18, A1_19)
	local L2_20
	for 