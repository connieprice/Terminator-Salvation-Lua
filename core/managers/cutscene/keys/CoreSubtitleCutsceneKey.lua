require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreSubtitleCutsceneKey then
	CoreSubtitleCutsceneKey = class(CoreCutsceneKeyBase)
end
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
CoreSubtitleCutsceneKey.__tostring = function(l_1_0)
	return "Display subtitle \"" .. l_1_0:string_id() .. "\"."
end

CoreSubtitleCutsceneKey.can_evaluate_with_player = function(l_2_0, l_2_1)
	return true
end

CoreSubtitleCutsceneKey.unload = function(l_3_0, l_3_1)
	managers.subtitle:clear_subtitle()
end

CoreSubtitleCutsceneKey.play = function(l_4_0, l_4_1, l_4_2, l_4_3)
	if l_4_2 then
		managers.subtitle:clear_subtitle()
	elseif not l_4_3 then
		managers.subtitle:show_subtitle(l_4_0:string_id(), l_4_0:duration())
	end
end

CoreSubtitleCutsceneKey.is_valid_category = function(l_5_0, l_5_1)
	do
		return not l_5_1 or l_5_1 ~= ""
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSubtitleCutsceneKey.is_valid_string_id = function(l_6_0, l_6_1)
	do
		return not l_6_1 or l_6_1 ~= ""
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSubtitleCutsceneKey.is_valid_duration = function(l_7_0, l_7_1)
	do
		return not l_7_1 or l_7_1 > 0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSubtitleCutsceneKey.control_for_localized_text = function(l_8_0, l_8_1)
	local l_8_2 = EWS:TextCtrl(l_8_1, "", "", "NO_BORDER,TE_RICH,TE_MULTILINE,TE_READONLY")
	l_8_2:set_min_size(l_8_2:get_min_size():with_y(160))
	l_8_2:set_background_colour(l_8_1:background_colour():unpack())
	return l_8_2
end

CoreSubtitleCutsceneKey.refresh_control_for_category = function(l_9_0, l_9_1)
	local l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_12, l_9_13, l_9_14 = nil
	l_9_1:freeze()
	l_9_1:clear()
	local l_9_2 = managers.localization:xml_names()
	if table.empty(l_9_2) then
		l_9_1:set_enabled(false)
	else
		l_9_1:set_enabled(true)
		local l_9_3 = l_9_0:category()
		for i_0,i_1 in ipairs(l_9_2) do
			l_9_1:append(i_1)
			if i_1 == l_9_3 then
				l_9_1:set_value(l_9_3)
			end
		end
	end
	l_9_1:thaw()
end

CoreSubtitleCutsceneKey.refresh_control_for_string_id = function(l_10_0, l_10_1)
	l_10_1:freeze()
	l_10_1:clear()
	if l_10_0:category() ~= "" then
		local l_10_11, l_10_12, l_10_13, l_10_14, l_10_15, l_10_16, l_10_17, l_10_18 = managers.localization:string_map, managers.localization, l_10_0:category(), .end
		l_10_11 = l_10_11(l_10_12, l_10_13, l_10_14, l_10_15, l_10_16, l_10_17, l_10_18)
	if not l_10_11 then
		end
	end
	do
		local l_10_2, l_10_3, l_10_4, l_10_5, l_10_6, l_10_19 = nil
	end
	l_10_12 = table
	l_10_12 = l_10_12.empty
	l_10_13, l_10_11 = l_10_11, {}
	l_10_12 = l_10_12(l_10_13)
	if l_10_12 then
		l_10_12, l_10_13 = l_10_1:set_enabled, l_10_1
		l_10_14 = false
		l_10_12(l_10_13, l_10_14)
	else
		l_10_12, l_10_13 = l_10_1:set_enabled, l_10_1
		l_10_14 = true
		l_10_12(l_10_13, l_10_14)
		l_10_12, l_10_13 = l_10_0:string_id, l_10_0
		l_10_12 = l_10_12(l_10_13)
		local l_10_7 = nil
		l_10_13 = ipairs
		l_10_14 = l_10_11
		l_10_13 = l_10_13(l_10_14)
		for l_10_16,l_10_17 in l_10_13 do
			local l_10_8, l_10_9, l_10_10 = nil
			l_10_18, l_10_7 = l_10_1:append, l_10_1
			l_10_8 = l_10_17
			l_10_18(l_10_7, l_10_8)
			if l_10_17 == l_10_12 then
				l_10_18, l_10_7 = l_10_1:set_value, l_10_1
				l_10_8 = l_10_12
				l_10_18(l_10_7, l_10_8)
			end
		end
	end
	l_10_12(l_10_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSubtitleCutsceneKey.refresh_control_for_localized_text = function(l_11_0, l_11_1)
	if l_11_0:is_valid_category(l_11_0:category()) and l_11_0:is_valid_string_id(l_11_0:string_id()) then
		l_11_1:set_value(managers.localization:text(l_11_0:string_id()))
	else
		l_11_1:set_value("<No String Id>")
	end
end

CoreSubtitleCutsceneKey.validate_control_for_attribute = function(l_12_0, l_12_1)
	if l_12_1 ~= "localized_text" then
		local l_12_2 = l_12_0.super.validate_control_for_attribute
		local l_12_3 = l_12_0
		local l_12_4 = l_12_1
		return l_12_2(l_12_3, l_12_4)
	end
	return true
end


