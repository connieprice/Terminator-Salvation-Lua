require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreSequenceCutsceneKey = CoreSequenceCutsceneKey or class(CoreCutsceneKeyBase)
CoreSequenceCutsceneKey.ELEMENT_NAME = "sequence"
CoreSequenceCutsceneKey.NAME = "Sequence"
CoreSequenceCutsceneKey:register_serialized_attribute("unit_name", "")
CoreSequenceCutsceneKey:register_serialized_attribute("name", "")
CoreSequenceCutsceneKey:attribute_affects("unit_name", "name")
CoreSequenceCutsceneKey.control_for_name = CoreCutsceneKeyBase.standard_combo_box_control
function CoreSequenceCutsceneKey.__tostring(A0_0)
	return "Trigger sequence \"" .. A0_0:name() .. "\" on \"" .. A0_0:unit_name() .. "\"."
end
function CoreSequenceCutsceneKey.evaluate(A0_1, A1_2, A2_3)
	A0_1:_unit_extension(A0_1:unit_name(), "damage"):run_sequence_simple(A0_1:name())
end
function CoreSequenceCutsceneKey.revert(A0_4, A1_5)
	A0_4:_run_sequence_if_exists("undo_" .. A0_4:name())
end
function CoreSequenceCutsceneKey.skip(A0_6, A1_7)
	A0_6:_run_sequence_if_exists("skip_" .. A0_6:name())
end
function CoreSequenceCutsceneKey.is_valid_unit_name(A0_8, A1_9)
	local L2_10
	L2_10 = A0_8._unit_type
	L2_10 = L2_10(A0_8, A1_9, true)
	return L2_10 ~= nil and A0_8.super.is_valid_unit_name(A0_8, A1_9) and managers.sequence:has(L2_10)
end
function CoreSequenceCutsceneKey.is_valid_name(A0_11, A1_12)
	local L2_13
	L2_13 = A0_11._unit_type
	L2_13 = L2_13(A0_11, A0_11:unit_name(), true)
	return L2_13 ~= nil and not string.begins(A1_12, "undo_") and not string.begins(A1_12, "skip_") and table.contains(managers.sequence:get_sequence_list(L2_13), A1_12)
end
function CoreSequenceCutsceneKey.refresh_control_for_name(A0_14, A1_15)
	local L2_16, L3_17, L4_18, L5_19, L6_20, L7_21, L8_22, L9_23
	L3_17 = A1_15
	L2_16 = A1_15.freeze
	L2_16(L3_17)
	L3_17 = A1_15
	L2_16 = A1_15.clear
	L2_16(L3_17)
	L3_17 = A0_14
	L2_16 = A0_14._unit_type
	L4_18 = A0_14.unit_name
	L4_18 = L4_18(L5_19)
	L2_16 = L2_16(L3_17, L4_18, L5_19)
	if L2_16 then
		L3_17 = managers
		L3_17 = L3_17.sequence
		L4_18 = L3_17
		L3_17 = L3_17.get_sequence_list
		L3_17 = L3_17(L4_18, L5_19)
	else
		L3_17 = L3_17 or {}
	end
	L4_18 = table
	L4_18 = L4_18.empty
	L4_18 = L4_18(L5_19)
	if not L4_18 then
		L4_18 = A1_15.set_enabled
		L4_18(L5_19, L6_20)
		L4_18 = A0_14.name
		L4_18 = L4_18(L5_19)
		for L8_22, L9_23 in L5_19(L6_20) do
			A1_15:append(L9_23)
			if L9_23 == L4_18 then
				A1_15:set_value(L4_18)
			end
		end
	else
		L4_18 = A1_15.set_enabled
		L4_18(L5_19, L6_20)
	end
	L4_18 = A1_15.thaw
	L4_18(L5_19)
end
function CoreSequenceCutsceneKey._run_sequence_if_exists(A0_24, A1_25)
	local L2_26
	L2_26 = A0_24._unit_type
	L2_26 = L2_26(A0_24, A0_24:unit_name())
	if table.contains(managers.sequence:get_sequence_list(L2_26), A1_25) then
		A0_24:_unit_extension(A0_24:unit_name(), "damage"):run_sequence_simple(A1_25)
	end
end
