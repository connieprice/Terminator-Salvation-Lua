require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreSubtitleCutsceneKey = CoreSubtitleCutsceneKey or class(CoreCutsceneKeyBase)
CoreSubtitleCutsceneKey.ELEMENT_NAME = "subtitle"
CoreSubtitleCutsceneKey.NAME = "Subtitle"
CoreSubtitleCutsceneKey:register_serialized_attribute("category", "")
CoreSubtitleCutsceneKey:register_serialized_attribute("string_id", "")
CoreSubtitleCutsceneKey:register_serialized_attribute("duration", 3, tonumber)
CoreSubtitleCutsceneKey:register_control("divider")
CoreSubtitleCutsceneKey:register_control("localized_text")
CoreSubtitleCutsceneKey:attribute_affects("category", "string_id")
CoreSubtitleCutsceneKey:attribute_affects("string_id", "localized_text")
CoreSubtitleCutsceneKey.control_for_category = CoreCutsceneKeyBase.standard_combo_box_control
CoreSubtitleCutsceneKey.control_for_string_id = CoreCutsceneKeyBase.standard_combo_box_control
CoreSubtitleCutsceneKey.control_for_divider = CoreCutsceneKeyBase.standard_divider_control
function CoreSubtitleCutsceneKey.__tostring(A0_0)
	return "Display subtitle \"" .. A0_0:string_id() .. "\"."
end
function CoreSubtitleCutsceneKey.can_evaluate_with_player(A0_1, A1_2)
	local L2_3
	L2_3 = true
	return L2_3
end
function CoreSubtitleCutsceneKey.unload(A0_4, A1_5)
	managers.subtitle:clear_subtitle()
end
function CoreSubtitleCutsceneKey.play(A0_6, A1_7, A2_8, A3_9)
	if A2_8 then
		managers.subtitle:clear_subtitle()
	elseif not A3_9 then
		managers.subtitle:show_subtitle(A0_6:string_id(), A0_6:duration())
	end
end
function CoreSubtitleCutsceneKey.is_valid_category(A0_10, A1_11)
	local L2_12
	L2_12 = A1_11 and A1_11 ~= ""
	return L2_12
end
function CoreSubtitleCutsceneKey.is_valid_string_id(A0_13, A1_14)
	local L2_15
	L2_15 = A1_14 and A1_14 ~= ""
	return L2_15
end
function CoreSubtitleCutsceneKey.is_valid_duration(A0_16, A1_17)
	local L2_18
	L2_18 = A1_17 and A1_17 > 0
	return L2_18
end
function CoreSubtitleCutsceneKey.control_for_localized_text(A0_19, A1_20)
	EWS:TextCtrl(A1_20, "", "", "NO_BORDER,TE_RICH,TE_MULTILINE,TE_READONLY"):set_min_size(EWS:TextCtrl(A1_20, "", "", "NO_BORDER,TE_RICH,TE_MULTILINE,TE_READONLY"):get_min_size():with_y(160))
	EWS:TextCtrl(A1_20, "", "", "NO_BORDER,TE_RICH,TE_MULTILINE,TE_READONLY"):set_background_colour(A1_20:background_colour():unpack())
	return (EWS:TextCtrl(A1_20, "", "", "NO_BORDER,TE_RICH,TE_MULTILINE,TE_READONLY"))
end
function CoreSubtitleCutsceneKey.refresh_control_for_category(A0_21, A1_22)
	local L2_23, L3_24, L4_25, L5_26, L6_27, L7_28, L8_29
	L3_24 = A1_22
	L2_23 = A1_22.freeze
	L2_23(L3_24)
	L3_24 = A1_22
	L2_23 = A1_22.clear
	L2_23(L3_24)
	L2_23 = managers
	L2_23 = L2_23.localization
	L3_24 = L2_23
	L2_23 = L2_23.xml_names
	L2_23 = L2_23(L3_24)
	L3_24 = table
	L3_24 = L3_24.empty
	L3_24 = L3_24(L4_25)
	if L3_24 then
		L3_24 = A1_22.set_enabled
		L3_24(L4_25, L5_26)
	else
		L3_24 = A1_22.set_enabled
		L3_24(L4_25, L5_26)
		L3_24 = A0_21.category
		L3_24 = L3_24(L4_25)
		for L7_28, L8_29 in L4_25(L5_26) do
			A1_22:append(L8_29)
			if L8_29 == L3_24 then
				A1_22:set_value(L3_24)
			end
		end
	end
	L3_24 = A1_22.thaw
	L3_24(L4_25)
end
function CoreSubtitleCutsceneKey.refresh_control_for_string_id(A0_30, A1_31)
	local L2_32, L3_33, L4_34, L5_35, L6_36, L7_37, L8_38
	L3_33 = A1_31
	L2_32 = A1_31.freeze
	L2_32(L3_33)
	L3_33 = A1_31
	L2_32 = A1_31.clear
	L2_32(L3_33)
	L3_33 = A0_30
	L2_32 = A0_30.category
	L2_32 = L2_32(L3_33)
	if L2_32 ~= "" then
		L2_32 = managers
		L2_32 = L2_32.localization
		L3_33 = L2_32
		L2_32 = L2_32.string_map
		L8_38 = L4_34(L5_35)
		L2_32 = L2_32(L3_33, L4_34, L5_35, L6_36, L7_37, L8_38, L4_34(L5_35))
	else
		L2_32 = L2_32 or {}
	end
	L3_33 = table
	L3_33 = L3_33.empty
	L3_33 = L3_33(L4_34)
	if L3_33 then
		L3_33 = A1_31.set_enabled
		L3_33(L4_34, L5_35)
	else
		L3_33 = A1_31.set_enabled
		L3_33(L4_34, L5_35)
		L3_33 = A0_30.string_id
		L3_33 = L3_33(L4_34)
		for L7_37, L8_38 in L4_34(L5_35) do
			A1_31:append(L8_38)
			if L8_38 == L3_33 then
				A1_31:set_value(L3_33)
			end
		end
	end
	L3_33 = A1_31.thaw
	L3_33(L4_34)
end
function CoreSubtitleCutsceneKey.refresh_control_for_localized_text(A0_39, A1_40)
	if A0_39:is_valid_category(A0_39:category()) and A0_39:is_valid_string_id(A0_39:string_id()) then
		A1_40:set_value(managers.localization:text(A0_39:string_id()))
	else
		A1_40:set_value("<No String Id>")
	end
end
function CoreSubtitleCutsceneKey.validate_control_for_attribute(A0_41, A1_42)
	if A1_42 ~= "localized_text" then
		return A0_41.super.validate_control_for_attribute(A0_41, A1_42)
	end
	return true
end
