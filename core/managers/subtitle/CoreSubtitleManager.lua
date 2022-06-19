core:module("CoreSubtitleManager")
core:require_module("CoreClass")
core:require_module("CoreDebug")
core:require_module("CoreTable")
core:require_module("CoreSubtitlePresenter")
core:require_module("CoreSubtitleSequence")
core:require_module("CoreSubtitleSequencePlayer")
SubtitleManager = SubtitleManager or CoreClass.class()
function SubtitleManager.init(A0_0, A1_1, A2_2)
	A0_0.__sequence_file_path = A1_1 or "data/lib/managers/xml/subtitle_sequence.xml"
	A0_0.__presenter = A2_2 or CoreSubtitlePresenter.OverlayPresenter:new()
	A0_0:_update_presenter_visibility()
	A0_0:_parse_xml()
end
function SubtitleManager.destroy(A0_3)
	A0_3:_set_presenter(nil)
end
function SubtitleManager.update(A0_4, A1_5, A2_6)
	if A0_4.__player then
		A0_4.__player:update(A1_5, A2_6)
		if A0_4.__player:is_done() then
			A0_4.__player = nil
		end
	end
	A0_4:_presenter():update(A1_5, A2_6)
end
function SubtitleManager.enabled(A0_7)
	local L1_8
	L1_8 = Global
	L1_8 = L1_8.__SubtitleManager__enabled
	L1_8 = L1_8 or false
	return L1_8
end
function SubtitleManager.set_enabled(A0_9, A1_10)
	Global.__SubtitleManager__enabled = not not A1_10
	A0_9:_update_presenter_visibility()
end
function SubtitleManager.visible(A0_11)
	return not A0_11.__hidden
end
function SubtitleManager.set_visible(A0_12, A1_13)
	A0_12.__hidden = not A1_13 or nil
	A0_12:_update_presenter_visibility()
end
function SubtitleManager.clear_subtitle(A0_14)
	A0_14:show_subtitle_localized("")
end
function SubtitleManager.is_showing_subtitles(A0_15)
	return A0_15:enabled() and A0_15:visible() and A0_15.__player ~= nil
end
function SubtitleManager.show_subtitle(A0_16, A1_17, A2_18, A3_19)
	A0_16:show_subtitle_localized(managers.localization:text(A1_17, A3_19), A2_18)
end
function SubtitleManager.show_subtitle_localized(A0_20, A1_21, A2_22)
	local L3_23
	L3_23 = CoreSubtitleSequence
	L3_23 = L3_23.SubtitleSequence
	L3_23 = L3_23.new
	L3_23 = L3_23(L3_23)
	L3_23:add_subtitle(CoreSubtitleSequence.Subtitle:new(A1_21, 0, A2_22 or 3))
	A0_20.__player = CoreSubtitleSequencePlayer.SubtitleSequencePlayer:new(L3_23, A0_20:_presenter())
end
function SubtitleManager.run_subtitle_sequence(A0_24, A1_25)
	local L2_26, L3_27
	L2_26 = A1_25 and L2_26(L3_27, string.format("Sequence \"%s\" not found in \"%s\".", A1_25, A0_24.__sequence_file_path))
	L3_27 = L2_26 and L3_27(L3_27, L2_26, A0_24:_presenter())
	A0_24.__player = L3_27
end
function SubtitleManager.subtitle_sequence_ids(A0_28)
	return CoreTable.table.map_keys(A0_28.__subtitle_sequences or {})
end
function SubtitleManager.has_subtitle_sequence(A0_29, A1_30)
	local L2_31
	L2_31 = A0_29.__subtitle_sequences
	if L2_31 then
		L2_31 = A0_29.__subtitle_sequences
		L2_31 = L2_31[A1_30]
	end
	L2_31 = L2_31 ~= nil
	return L2_31
end
function SubtitleManager._presenter(A0_32)
	return assert(A0_32.__presenter, "Invalid presenter. SubtitleManager has been destroyed.")
end
function SubtitleManager._set_presenter(A0_33, A1_34)
	assert(A1_34 == nil or type(A1_34.preprocess_sequence) == "function", "Invalid presenter.")
	if A0_33.__presenter then
		A0_33.__presenter:destroy()
	end
	A0_33.__presenter = A1_34
end
function SubtitleManager._update_presenter_visibility(A0_35)
	local L1_36
	L1_36 = A0_35._presenter
	L1_36 = L1_36(A0_35)
	L1_36[A0_35:enabled() and A0_35:visible() and "show" or "hide"](L1_36)
end
function SubtitleManager._parse_xml(A0_37)
	local L1_38, L2_39, L3_40, L4_41, L5_42
	L1_38 = {}
	A0_37.__subtitle_sequences = L1_38
	L1_38 = A0_37.__sequence_file_path
	if L1_38 then
		L1_38 = File
		L1_38 = L1_38.exists
		L1_38 = L1_38(L2_39, L3_40)
		if L1_38 then
			L1_38 = CoreDebug
			L1_38 = L1_38.cat_print
			L5_42 = A0_37.__sequence_file_path
			L5_42 = L3_40(L4_41, L5_42)
			L1_38(L2_39, L3_40, L4_41, L5_42, L3_40(L4_41, L5_42))
			L1_38 = File
			L1_38 = L1_38.parse_xml
			L1_38 = L1_38(L2_39, L3_40)
			if L1_38 then
				if L2_39 == "subtitle_sequence" then
					for L5_42 in L2_39(L3_40) do
						if L5_42:name() == "sequence" then
							A0_37.__subtitle_sequences[CoreSubtitleSequence.SubtitleSequence:new(L5_42):name()] = CoreSubtitleSequence.SubtitleSequence:new(L5_42)
						end
					end
				end
			end
		end
	end
end
function SubtitleManager.show(A0_43)
	Application:stack_dump_error("SubtitleManager:show() is deprecated. Use SubtitleManager:set_visible(true) instead.")
	A0_43:set_visible(true)
end
function SubtitleManager.hide(A0_44)
	Application:stack_dump_error("SubtitleManager:hide() is deprecated. Use SubtitleManager:set_visible(false) instead.")
	A0_44:set_visible(false)
end
