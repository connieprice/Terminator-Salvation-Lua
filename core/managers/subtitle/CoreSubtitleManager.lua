core:module("CoreSubtitleManager")
core:require_module("CoreClass")
core:require_module("CoreDebug")
core:require_module("CoreTable")
core:require_module("CoreSubtitlePresenter")
core:require_module("CoreSubtitleSequence")
core:require_module("CoreSubtitleSequencePlayer")
if not SubtitleManager then
	SubtitleManager = CoreClass.class()
end
SubtitleManager.init = function(l_1_0, l_1_1, l_1_2)
	do
		l_1_0.__sequence_file_path = l_1_1 or "data/lib/managers/xml/subtitle_sequence.xml"
		if not l_1_2 then
			l_1_0.__presenter = CoreSubtitlePresenter.OverlayPresenter:new()
		end
		l_1_0:_update_presenter_visibility()
		l_1_0:_parse_xml()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SubtitleManager.destroy = function(l_2_0)
	l_2_0:_set_presenter(nil)
end

SubtitleManager.update = function(l_3_0, l_3_1, l_3_2)
	if l_3_0.__player then
		l_3_0.__player:update(l_3_1, l_3_2)
	if l_3_0.__player:is_done() then
		end
		l_3_0.__player = nil
	end
	l_3_0:_presenter():update(l_3_1, l_3_2)
end

SubtitleManager.enabled = function(l_4_0)
	return Global.__SubtitleManager__enabled or false
end

SubtitleManager.set_enabled = function(l_5_0, l_5_1)
	Global.__SubtitleManager__enabled = not not l_5_1
	l_5_0:_update_presenter_visibility()
end

SubtitleManager.visible = function(l_6_0)
	return not l_6_0.__hidden
end

SubtitleManager.set_visible = function(l_7_0, l_7_1)
	if l_7_1 then
		local l_7_2 = nil
		l_7_2 = l_7_2
	end
	l_7_0.__hidden = l_7_2
	l_7_2(l_7_0)
end

SubtitleManager.clear_subtitle = function(l_8_0)
	l_8_0:show_subtitle_localized("")
end

SubtitleManager.is_showing_subtitles = function(l_9_0)
	return not l_9_0:enabled() or not l_9_0:visible() or l_9_0.__player ~= nil
end

SubtitleManager.show_subtitle = function(l_10_0, l_10_1, l_10_2, l_10_3)
	l_10_0:show_subtitle_localized(managers.localization:text(l_10_1, l_10_3), l_10_2)
end

SubtitleManager.show_subtitle_localized = function(l_11_0, l_11_1, l_11_2)
	local l_11_3 = CoreSubtitleSequence.SubtitleSequence:new()
	local l_11_4, l_11_5 = l_11_3:add_subtitle, l_11_3
	local l_11_6, l_11_7 = CoreSubtitleSequence.Subtitle:new, CoreSubtitleSequence.Subtitle
	local l_11_8 = l_11_1
	local l_11_9 = 0
	do
		l_11_7, l_11_6 = .end, l_11_6(l_11_7, l_11_8, l_11_9, l_11_2 or 3)
		l_11_4(l_11_5, l_11_6, l_11_7, l_11_8, l_11_9)
		l_11_4 = CoreSubtitleSequencePlayer
		l_11_4 = l_11_4.SubtitleSequencePlayer
		l_11_4, l_11_5 = l_11_4:new, l_11_4
		l_11_6 = l_11_3
		l_11_7, l_11_8 = l_11_0:_presenter, l_11_0
		l_11_8, l_11_7 = .end, l_11_7(l_11_8)
		l_11_4 = l_11_4(l_11_5, l_11_6, l_11_7, l_11_8, l_11_9)
		l_11_0.__player = l_11_4
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SubtitleManager.run_subtitle_sequence = function(l_12_0, l_12_1)
	do
		if not l_12_1 or assert(l_12_0.__subtitle_sequences[l_12_1], string.format("Sequence \"%s\" not found in \"%s\".", l_12_1, l_12_0.__sequence_file_path)) then
			l_12_0.__player = CoreSubtitleSequencePlayer.SubtitleSequencePlayer:new(assert(l_12_0.__subtitle_sequences[l_12_1], string.format("Sequence \"%s\" not found in \"%s\".", l_12_1, l_12_0.__sequence_file_path)), l_12_0:_presenter())
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

SubtitleManager.subtitle_sequence_ids = function(l_13_0)
	local l_13_1 = CoreTable.table.map_keys
	if not l_13_0.__subtitle_sequences then
		local l_13_2 = {}
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_13_1(l_13_2)
end

SubtitleManager.has_subtitle_sequence = function(l_14_0, l_14_1)
	return l_14_0.__subtitle_sequences and l_14_0.__subtitle_sequences[l_14_1] ~= nil
end

SubtitleManager._presenter = function(l_15_0)
	local l_15_1 = assert
	local l_15_2 = l_15_0.__presenter
	local l_15_3 = "Invalid presenter. SubtitleManager has been destroyed."
	return l_15_1(l_15_2, l_15_3)
end

SubtitleManager._set_presenter = function(l_16_0, l_16_1)
	local l_16_2 = assert
	l_16_2(l_16_1 == nil or type(l_16_1.preprocess_sequence) == "function", "Invalid presenter.")
	l_16_2 = l_16_0.__presenter
	if l_16_2 then
		l_16_2 = l_16_0.__presenter
		l_16_2(l_16_2)
	end
	l_16_0.__presenter = l_16_1
end

SubtitleManager._update_presenter_visibility = function(l_17_0)
	local l_17_1 = l_17_0:_presenter()
	if l_17_0:enabled() then
		local l_17_2 = l_17_0:visible()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_17_1[l_17_2 and "show" or "hide"](l_17_1)
end

SubtitleManager._parse_xml = function(l_18_0)
	l_18_0.__subtitle_sequences = {}
	if l_18_0.__sequence_file_path and File:exists(l_18_0.__sequence_file_path) then
		local l_18_5 = CoreDebug.cat_print
		l_18_5("spam", string.format("[SubtitleManager] Parsing subtitle sequences from \"%s\"", l_18_0.__sequence_file_path))
		l_18_5 = File
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_18_1 = nil
	if l_18_5 then
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

	if l_18_1 == "subtitle_sequence" then
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0 in l_18_1 do
			if l_18_4:name() == "sequence" then
				local l_18_6 = CoreSubtitleSequence.SubtitleSequence:new(l_18_4)
				l_18_0.__subtitle_sequences[l_18_6:name()] = l_18_6
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

SubtitleManager.show = function(l_19_0)
	Application:stack_dump_error("SubtitleManager:show() is deprecated. Use SubtitleManager:set_visible(true) instead.")
	l_19_0:set_visible(true)
end

SubtitleManager.hide = function(l_20_0)
	Application:stack_dump_error("SubtitleManager:hide() is deprecated. Use SubtitleManager:set_visible(false) instead.")
	l_20_0:set_visible(false)
end


