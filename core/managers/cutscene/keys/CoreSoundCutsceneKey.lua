require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreSoundCutsceneKey = CoreSoundCutsceneKey or class(CoreCutsceneKeyBase)
CoreSoundCutsceneKey.ELEMENT_NAME = "sound"
CoreSoundCutsceneKey.NAME = "Sound"
CoreSoundCutsceneKey:register_serialized_attribute("bank", "")
CoreSoundCutsceneKey:register_serialized_attribute("cue", "")
CoreSoundCutsceneKey:register_serialized_attribute("unit_name", "")
CoreSoundCutsceneKey:register_serialized_attribute("object_name", "")
CoreSoundCutsceneKey:register_serialized_attribute("sync_to_video", false, toboolean)
CoreSoundCutsceneKey:attribute_affects("bank", "cue")
CoreSoundCutsceneKey.control_for_unit_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreSoundCutsceneKey.control_for_object_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreSoundCutsceneKey.control_for_bank = CoreCutsceneKeyBase.standard_combo_box_control
function CoreSoundCutsceneKey.__tostring(A0_0)
	return "Trigger sound \"" .. A0_0:bank() .. "/" .. A0_0:cue() .. "\" on \"" .. A0_0:unit_name() .. "\"."
end
function CoreSoundCutsceneKey.prime(A0_1, A1_2)
	A0_1:sound():prime()
end
function CoreSoundCutsceneKey.skip(A0_3, A1_4)
	A0_3:stop()
end
function CoreSoundCutsceneKey.can_evaluate_with_player(A0_5, A1_6)
	local L2_7
	L2_7 = true
	return L2_7
end
function CoreSoundCutsceneKey.play(A0_8, A1_9, A2_10, A3_11)
	if A2_10 then
		A0_8:stop()
	elseif not A3_11 then
		if A0_8:unit_name() ~= "" and A0_8:object_name() ~= "" then
			A0_8:sound():set_output(A0_8:_unit_object(A0_8:unit_name(), A0_8:object_name()))
		end
		A0_8:_trigger_sound()
	end
end
function CoreSoundCutsceneKey.update(A0_12, A1_13, A2_14)
	if A0_12.is_in_cutscene_editor then
		A0_12:handle_cutscene_editor_scrubbing(A1_13, A2_14)
	end
end
function CoreSoundCutsceneKey.handle_cutscene_editor_scrubbing(A0_15, A1_16, A2_17)
	if A0_15._last_evaluated_time then
		if A2_17 == A0_15._last_evaluated_time then
			A0_15._stopped_frame_count = (A0_15._stopped_frame_count or 0) + 1
			if A0_15._stopped_frame_count > 10 then
				A0_15._stopped_frame_count = nil
				A0_15:stop()
			end
		else
			A0_15._stopped_frame_count = nil
			if A0_15._sound_abort_func == nil or A2_17 < A0_15._last_evaluated_time or A2_17 - A0_15._last_evaluated_time > 1 then
				A0_15:_trigger_sound(A2_17)
			end
		end
	end
	A0_15._last_evaluated_time = A2_17
end
function CoreSoundCutsceneKey.is_valid_unit_name(A0_18, A1_19)
	return A1_19 == nil or A1_19 == "" or CoreCutsceneKeyBase.is_valid_unit_name(A0_18, A1_19)
end
function CoreSoundCutsceneKey.is_valid_object_name(A0_20, A1_21)
	return A1_21 == nil or A1_21 == "" or CoreCutsceneKeyBase.is_valid_object_name(A0_20, A1_21)
end
function CoreSoundCutsceneKey.is_valid_bank(A0_22, A1_23)
	return A1_23 and A1_23 ~= "" and table.contains(Sound:soundbanks(), A1_23)
end
function CoreSoundCutsceneKey.is_valid_cue(A0_24, A1_25)
	return A1_25 and A1_25 ~= "" and A0_24:is_valid_bank(A0_24:bank()) and Sound:make_bank(A0_24:bank(), A1_25) ~= nil
end
function CoreSoundCutsceneKey.refresh_control_for_bank(A0_26, A1_27)
	local L2_28, L3_29, L4_30, L5_31, L6_32, L7_33
	L2_28 = A1_27.freeze
	L2_28(L3_29)
	L2_28 = A1_27.clear
	L2_28(L3_29)
	L2_28 = A0_26.bank
	L2_28 = L2_28(L3_29)
	L7_33 = L4_30(L5_31)
	for L6_32, L7_33 in L3_29(L4_30, L5_31, L6_32, L7_33, L4_30(L5_31)) do
		A1_27:append(L7_33)
		if L7_33 == L2_28 then
			A1_27:set_value(L2_28)
		end
	end
	L3_29(L4_30)
end
function CoreSoundCutsceneKey.refresh_control_for_unit_name(A0_34, A1_35)
	CoreCutsceneKeyBase.refresh_control_for_unit_name(A0_34, A1_35)
	A1_35:append("")
	if A0_34:unit_name() == "" then
		A1_35:set_value("")
	end
end
function CoreSoundCutsceneKey.refresh_control_for_object_name(A0_36, A1_37)
	CoreCutsceneKeyBase.refresh_control_for_object_name(A0_36, A1_37)
	A1_37:append("")
	if A0_36:object_name() == "" then
		A1_37:set_value("")
	end
end
function CoreSoundCutsceneKey.on_attribute_before_changed(A0_38, A1_39, A2_40, A3_41)
	if A1_39 ~= "sync_to_video" then
		A0_38:stop()
	end
end
function CoreSoundCutsceneKey.on_attribute_changed(A0_42, A1_43, A2_44, A3_45)
	if A1_43 == "bank" or A1_43 == "cue" then
		A0_42._sound = nil
		if A0_42:is_valid() then
			A0_42:prime()
		end
	end
end
function CoreSoundCutsceneKey.sound(A0_46)
	if A0_46._sound == nil then
		A0_46._sound = assert(Sound:make_bank(A0_46:bank(), A0_46:cue()), "Sound \"" .. A0_46:bank() .. "/" .. A0_46:cue() .. "\" not found.")
	end
	return A0_46._sound
end
function CoreSoundCutsceneKey.stop(A0_47)
	if A0_47._sound_abort_func then
		A0_47._sound_abort_func()
		A0_47._sound_abort_func = nil
	end
	A0_47._last_evaluated_time = nil
end
function CoreSoundCutsceneKey._trigger_sound(A0_48, A1_49)
	local L2_50
	L2_50 = A0_48.stop
	L2_50(A0_48)
	L2_50 = A0_48.sound
	L2_50 = L2_50(A0_48)
	L2_50 = L2_50.play
	L2_50 = L2_50(L2_50, A0_48:sync_to_video() and "running_offset" or "offset", A1_49 or 0)
	if alive(L2_50) then
		function A0_48._sound_abort_func()
			if alive(_UPVALUE0_) and _UPVALUE0_:is_playing() then
				_UPVALUE0_:stop()
			end
		end
	end
end
