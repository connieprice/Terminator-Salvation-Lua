require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreLightGroupCutsceneKey = CoreLightGroupCutsceneKey or class(CoreCutsceneKeyBase)
CoreLightGroupCutsceneKey.ELEMENT_NAME = "light_group"
CoreLightGroupCutsceneKey.NAME = "Light Group"
CoreLightGroupCutsceneKey:register_serialized_attribute("group", "")
CoreLightGroupCutsceneKey:register_serialized_attribute("enable", false, toboolean)
CoreLightGroupCutsceneKey:attribute_affects("group", "enable")
function CoreLightGroupCutsceneKey.__tostring(A0_0)
	local L2_1
	L2_1 = string
	L2_1 = L2_1.format
	return L2_1("Change light group, %s stateto %s.", A0_0:group(), tostring(A0_0:enable()))
end
function CoreLightGroupCutsceneKey.prime(A0_2)
	A0_2:_build_group_cache()
end
function CoreLightGroupCutsceneKey.evaluate(A0_3)
	local L1_4, L2_5, L3_6, L4_7, L5_8, L6_9
	L1_4 = assert
	L1_4 = L1_4(L2_5, L3_6)
	for L5_8, L6_9 in L2_5(L3_6) do
		A0_3:_enable_lights(L6_9, A0_3:enable())
	end
end
function CoreLightGroupCutsceneKey.revert(A0_10)
	local L1_11, L2_12, L3_13, L4_14, L5_15, L6_16, L7_17
	L2_12 = A0_10
	L1_11 = A0_10.preceeding_key
	L3_13.group = L4_14
	L1_11 = L1_11(L2_12, L3_13)
	if L1_11 then
		L2_12 = L1_11.evaluate
		L2_12(L3_13)
	else
		L2_12 = assert
		L2_12 = L2_12(L3_13, L4_14)
		for L6_16, L7_17 in L3_13(L4_14) do
			A0_10:_enable_lights(L7_17, false)
		end
	end
end
function CoreLightGroupCutsceneKey.unload(A0_18)
	local L1_19, L2_20, L3_21, L4_22, L5_23, L6_24, L7_25, L8_26, L9_27, L10_28
	L10_28 = L2_20(L3_21)
	for L4_22, L5_23 in L1_19(L2_20, L3_21, L4_22, L5_23, L6_24, L7_25, L8_26, L9_27, L10_28, L2_20(L3_21)) do
		for L9_27, L10_28 in L6_24(L7_25) do
			A0_18:_enable_lights(L10_28, false)
		end
	end
end
function CoreLightGroupCutsceneKey.can_evaluate_with_player(A0_29, A1_30)
	local L2_31
	L2_31 = true
	return L2_31
end
function CoreLightGroupCutsceneKey.is_valid_group(A0_32, A1_33)
	local L2_34
	for 