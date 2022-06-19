require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreSequenceCutsceneKey then
	CoreSequenceCutsceneKey = class(CoreCutsceneKeyBase)
end
CoreSequenceCutsceneKey.ELEMENT_NAME = "sequence"
CoreSequenceCutsceneKey.NAME = "Sequence"
CoreSequenceCutsceneKey:register_serialized_attribute("unit_name", "")
CoreSequenceCutsceneKey:register_serialized_attribute("name", "")
CoreSequenceCutsceneKey:attribute_affects("unit_name", "name")
CoreSequenceCutsceneKey.control_for_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreSequenceCutsceneKey.__tostring = function(l_1_0)
	return "Trigger sequence \"" .. l_1_0:name() .. "\" on \"" .. l_1_0:unit_name() .. "\"."
end

CoreSequenceCutsceneKey.evaluate = function(l_2_0, l_2_1, l_2_2)
	l_2_0:_unit_extension(l_2_0:unit_name(), "damage"):run_sequence_simple(l_2_0:name())
end

CoreSequenceCutsceneKey.revert = function(l_3_0, l_3_1)
	l_3_0:_run_sequence_if_exists("undo_" .. l_3_0:name())
end

CoreSequenceCutsceneKey.skip = function(l_4_0, l_4_1)
	l_4_0:_run_sequence_if_exists("skip_" .. l_4_0:name())
end

CoreSequenceCutsceneKey.is_valid_unit_name = function(l_5_0, l_5_1)
	local l_5_2 = l_5_0:_unit_type(l_5_1, true)
	if l_5_2 ~= nil and l_5_0.super.is_valid_unit_name(l_5_0, l_5_1) then
		local l_5_3 = managers.sequence:has(l_5_2)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_5_3
end

CoreSequenceCutsceneKey.is_valid_name = function(l_6_0, l_6_1)
	local l_6_2 = l_6_0:_unit_type(l_6_0:unit_name(), true)
	if l_6_2 ~= nil and not string.begins(l_6_1, "undo_") and not string.begins(l_6_1, "skip_") then
		local l_6_3 = table.contains(managers.sequence:get_sequence_list(l_6_2), l_6_1)
	else
		return false
	end
end

CoreSequenceCutsceneKey.refresh_control_for_name = function(l_7_0, l_7_1)
	local l_7_11, l_7_12, l_7_13, l_7_14, l_7_15, l_7_16, l_7_17, l_7_18 = nil
	l_7_1:freeze()
	l_7_1:clear()
	local l_7_2 = l_7_0:_unit_type(l_7_0:unit_name(), true)
	if not l_7_2 or not managers.sequence:get_sequence_list(l_7_2) then
		local l_7_3, l_7_4, l_7_5, l_7_6, l_7_19, l_7_20 = {}
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not table.empty(l_7_3) then
		l_7_1:set_enabled(true)
		local l_7_7 = nil
		for i_0,i_1 in ipairs(l_7_7) do
			local l_7_8 = l_7_0:name()
			l_7_1:append(i_1)
			if i_1 == l_7_8 then
				l_7_1:set_value(l_7_8)
			end
		end
	else
		l_7_1:set_enabled(false)
	end
	l_7_1:thaw()
end

CoreSequenceCutsceneKey._run_sequence_if_exists = function(l_8_0, l_8_1)
	local l_8_2 = l_8_0:_unit_type(l_8_0:unit_name())
	if table.contains(managers.sequence:get_sequence_list(l_8_2), l_8_1) then
		l_8_0:_unit_extension(l_8_0:unit_name(), "damage"):run_sequence_simple(l_8_1)
	end
end


