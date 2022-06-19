core:module("CoreSubtitleSequence")
core:require_module("CoreClass")
if not SubtitleSequence then
	SubtitleSequence = CoreClass.class()
end
if not Subtitle then
	Subtitle = CoreClass.class()
end
if not StringIDSubtitle then
	StringIDSubtitle = CoreClass.class(Subtitle)
end
SubtitleSequence.init = function(l_1_0, l_1_1)
	if l_1_1 then
		l_1_0:_load_from_xml(l_1_1)
	end
end

SubtitleSequence.name = function(l_2_0)
	return l_2_0:parameters().name or ""
end

SubtitleSequence.duration = function(l_3_0)
	if l_3_0.__subtitles then
		return l_3_0.__subtitles[#l_3_0.__subtitles]:end_time()
	end
end

SubtitleSequence.parameters = function(l_4_0)
	if not l_4_0.__parameters then
		return {}
	end
end

SubtitleSequence.subtitles = function(l_5_0)
	if not l_5_0.__subtitles then
		return {}
	end
end

SubtitleSequence.add_subtitle = function(l_6_0, l_6_1)
	if not l_6_0.__subtitles then
		l_6_0.__subtitles = {}
	end
	table.insert_sorted(l_6_0.__subtitles, l_6_1, function(l_7_0, l_7_1)
		return l_7_0:start_time() < l_7_1:start_time()
  end)
end

SubtitleSequence._load_from_xml = function(l_7_0, l_7_1)
	assert(managers.localization, "Localization Manager not ready.")
	local l_7_2 = assert
	l_7_2(not l_7_1 or l_7_1:name() == "sequence", "Attempting to construct from non-sequence XML node.")
	l_7_2 = assert
	local l_7_5 = l_7_1:parameter
	l_7_5 = l_7_5(l_7_1, "name")
	l_7_2(l_7_5, "Sequence must have a name.")
	l_7_2, l_7_5 = l_7_1:parameter_map, l_7_1
	l_7_2 = l_7_2(l_7_5)
	l_7_0.__parameters = l_7_2
	l_7_0.__subtitles, l_7_2 = l_7_2, {}
	l_7_2, l_7_5 = l_7_1:children, l_7_1
	l_7_2 = l_7_2(l_7_5)
	for i_0 in l_7_2 do
		if not managers.localization:exists(l_7_0:_xml_assert(i_0:parameter("text_id"), i_0, string.format("Sequence \"%s\" has entries without text_ids.", l_7_0:name()))) then
			l_7_0:_report_bad_string_id(l_7_0:_xml_assert(i_0:parameter("text_id"), i_0, string.format("Sequence \"%s\" has entries without text_ids.", l_7_0:name())))
		end
		local l_7_7 = nil
		local l_7_8 = nil
		l_7_0:add_subtitle(CoreClass.freeze(StringIDSubtitle:new(l_7_7, l_7_0:_xml_assert(tonumber(l_7_6:parameter("time")), l_7_6, string.format("Sequence \"%s\" has entries without valid times.", l_7_0:name())), tonumber(l_7_6:parameter("duration") or 2))))
	end
	CoreClass.freeze(l_7_0.__subtitles)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SubtitleSequence._report_bad_string_id = function(l_8_0, l_8_1)
	Localizer:lookup(l_8_1)
end

SubtitleSequence._xml_assert = function(l_9_0, l_9_1, l_9_2, l_9_3)
	do
		if not l_9_1 then
			return error(string.format("Error parsing \"%s\" - %s", string.gsub(l_9_2:file(), "^.*[/\\]", ""), l_9_3))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Subtitle.init = function(l_10_0, l_10_1, l_10_2, l_10_3)
	l_10_0.__string_data = l_10_1 ~= nil and assert(tostring(l_10_1), "Invalid string argument.") or ""
	l_10_0.__start_time = assert(tonumber(l_10_2), "Invalid start time argument.")
	l_10_0.__duration = l_10_3 ~= nil and assert(tonumber(l_10_3), "Invalid duration argument.") or nil
end

Subtitle.string = function(l_11_0)
	return l_11_0.__string_data
end

Subtitle.start_time = function(l_12_0)
	return l_12_0.__start_time
end

Subtitle.end_time = function(l_13_0)
	if not l_13_0:duration() then
		return l_13_0:start_time() + math.huge
	end
end

Subtitle.duration = function(l_14_0)
	return l_14_0.__duration
end

Subtitle.is_active_at_time = function(l_15_0, l_15_1)
	return l_15_0:start_time() < l_15_1 and l_15_1 < l_15_0:end_time()
end

StringIDSubtitle.string = function(l_16_0)
	assert(managers.localization, "Localization Manager not ready.")
	local l_16_1, l_16_2 = managers.localization:text, managers.localization
	local l_16_3 = l_16_0.__string_data
	return l_16_1(l_16_2, l_16_3)
end


