require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreSimpleAnimationCutsceneKey = CoreSimpleAnimationCutsceneKey or class(CoreCutsceneKeyBase)
CoreSimpleAnimationCutsceneKey.ELEMENT_NAME = "simple_animation"
CoreSimpleAnimationCutsceneKey.NAME = "Simple Animation"
CoreSimpleAnimationCutsceneKey:register_serialized_attribute("unit_name", "")
CoreSimpleAnimationCutsceneKey:register_serialized_attribute("group", "")
CoreSimpleAnimationCutsceneKey:attribute_affects("unit_name", "group")
CoreSimpleAnimationCutsceneKey.control_for_group = CoreCutsceneKeyBase.standard_combo_box_control
function CoreSimpleAnimationCutsceneKey.__tostring(A0_0)
	return "Trigger simple animation \"" .. A0_0:group() .. "\" on \"" .. A0_0:unit_name() .. "\"."
end
function CoreSimpleAnimationCutsceneKey.skip(A0_1, A1_2)
	local L2_3, L3_4
	L3_4 = A0_1
	L2_3 = A0_1._unit
	L2_3 = L2_3(L3_4, A0_1:unit_name())
	L3_4 = A0_1.group
	L3_4 = L3_4(A0_1)
	L2_3:anim_play(L3_4, 0)
	L2_3:anim_set_time(L3_4, L2_3:anim_length(L3_4))
end
function CoreSimpleAnimationCutsceneKey.evaluate(A0_5, A1_6, A2_7)
	A0_5:_unit(A0_5:unit_name()):anim_play(A0_5:group(), 0)
end
function CoreSimpleAnimationCutsceneKey.revert(A0_8, A1_9)
	local L2_10, L3_11
	L3_11 = A0_8
	L2_10 = A0_8._unit
	L2_10 = L2_10(L3_11, A0_8:unit_name())
	L3_11 = A0_8.group
	L3_11 = L3_11(A0_8)
	if L2_10:anim_is_playing(L3_11) then
		L2_10:anim_set_time(L3_11, 0)
		L2_10:anim_stop(L3_11)
	end
end
function CoreSimpleAnimationCutsceneKey.update(A0_12, A1_13, A2_14)
	A0_12:_unit(A0_12:unit_name()):anim_set_time(A0_12:group(), A2_14)
end
function CoreSimpleAnimationCutsceneKey.is_valid_unit_name(A0_15, A1_16)
	return A0_15.super.is_valid_unit_name(A0_15, A1_16) and #A0_15:_unit_animation_groups(A1_16) > 0
end
function CoreSimpleAnimationCutsceneKey.is_valid_group(A0_17, A1_18)
	return table.contains(A0_17:_unit_animation_groups(A0_17:unit_name()), A1_18)
end
function CoreSimpleAnimationCutsceneKey.refresh_control_for_group(A0_19, A1_20)
	local L2_21, L3_22, L4_23, L5_24, L6_25, L7_26, L8_27
	L3_22 = A1_20
	L2_21 = A1_20.freeze
	L2_21(L3_22)
	L3_22 = A1_20
	L2_21 = A1_20.clear
	L2_21(L3_22)
	L3_22 = A0_19
	L2_21 = A0_19._unit_animation_groups
	L8_27 = L4_23(L5_24)
	L2_21 = L2_21(L3_22, L4_23, L5_24, L6_25, L7_26, L8_27, L4_23(L5_24))
	L3_22 = table
	L3_22 = L3_22.empty
	L3_22 = L3_22(L4_23)
	if not L3_22 then
		L3_22 = A1_20.set_enabled
		L3_22(L4_23, L5_24)
		L3_22 = A0_19.group
		L3_22 = L3_22(L4_23)
		for L7_26, L8_27 in L4_23(L5_24) do
			A1_20:append(L8_27)
			if L8_27 == L3_22 then
				A1_20:set_value(L8_27)
			end
		end
	else
		L3_22 = A1_20.set_enabled
		L3_22(L4_23, L5_24)
	end
	L3_22 = A1_20.thaw
	L3_22(L4_23)
end
