require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreVolumeSetCutsceneKey = CoreVolumeSetCutsceneKey or class(CoreCutsceneKeyBase)
CoreVolumeSetCutsceneKey.ELEMENT_NAME = "volume_set"
CoreVolumeSetCutsceneKey.NAME = "Volume Set"
CoreVolumeSetCutsceneKey.VALID_ACTIONS = {"activate", "deactivate"}
CoreVolumeSetCutsceneKey:register_serialized_attribute("action", "activate")
CoreVolumeSetCutsceneKey:register_serialized_attribute("name", "")
CoreVolumeSetCutsceneKey.control_for_action = CoreCutsceneKeyBase.standard_combo_box_control
CoreVolumeSetCutsceneKey.control_for_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreVolumeSetCutsceneKey.refresh_control_for_action = CoreCutsceneKeyBase:standard_combo_box_control_refresh("action", CoreVolumeSetCutsceneKey.VALID_ACTIONS)
function CoreVolumeSetCutsceneKey.__tostring(A0_0)
	return string.capitalize(A0_0:action()) .. " volume set \"" .. A0_0:name() .. "\"."
end
function CoreVolumeSetCutsceneKey.unload(A0_1, A1_2)
	A0_1:play(A1_2, true)
end
function CoreVolumeSetCutsceneKey.play(A0_3, A1_4, A2_5, A3_6)
	if managers.volume == nil then
		return
	end
	if A2_5 then
		if A0_3:preceeding_key({
			name = A0_3:name()
		}) == nil or A0_3:preceeding_key({
			name = A0_3:name()
		}):action() == A0_3:inverse_action() then
			A0_3:_perform_action(A0_3:inverse_action())
		end
	else
		A0_3:_perform_action(A0_3:action())
	end
end
function CoreVolumeSetCutsceneKey.inverse_action(A0_7)
	return A0_7:action() == "activate" and "deactivate" or "activate"
end
function CoreVolumeSetCutsceneKey._perform_action(A0_8, A1_9)
	local L2_10, L3_11
	if A1_9 == "deactivate" then
		L2_10 = managers
		L2_10 = L2_10.volume
		L3_11 = L2_10
		L2_10 = L2_10.is_active
		L2_10 = L2_10(L3_11, A0_8:name())
		if L2_10 then
			L2_10 = managers
			L2_10 = L2_10.volume
			L3_11 = L2_10
			L2_10 = L2_10.deactivate_set
			L2_10(L3_11, A0_8:name())
		end
	elseif A1_9 == "activate" then
		L2_10 = managers
		L2_10 = L2_10.volume
		L3_11 = L2_10
		L2_10 = L2_10.is_active
		L2_10 = L2_10(L3_11, A0_8:name())
		if not L2_10 then
			L2_10 = managers
			L2_10 = L2_10.volume
			L3_11 = L2_10
			L2_10 = L2_10.activate_set
			L2_10(L3_11, A0_8:name())
		end
	end
end
function CoreVolumeSetCutsceneKey.is_valid_action(A0_12, A1_13)
	return table.contains(A0_12.VALID_ACTIONS, A1_13)
end
function CoreVolumeSetCutsceneKey.is_valid_name(A0_14, A1_15)
	return managers.volume and managers.volume:is_valid_volume_set_name(A1_15) or false
end
function CoreVolumeSetCutsceneKey.refresh_control_for_name(A0_16, A1_17)
	local L2_18, L3_19, L4_20, L5_21, L6_22, L7_23
	L2_18 = A1_17.freeze
	L2_18(L3_19)
	L2_18 = A1_17.clear
	L2_18(L3_19)
	L2_18 = managers
	L2_18 = L2_18.volume
	if L2_18 then
		L2_18 = A0_16.name
		L2_18 = L2_18(L3_19)
		L7_23 = L4_20(L5_21)
		for L6_22, L7_23 in L3_19(L4_20, L5_21, L6_22, L7_23, L4_20(L5_21)) do
			A1_17:append(L7_23)
			if L7_23 == L2_18 then
				A1_17:set_value(L2_18)
			end
		end
	end
	L2_18 = A1_17.thaw
	L2_18(L3_19)
end
