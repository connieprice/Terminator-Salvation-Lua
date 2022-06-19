core:module("CoreSubtitleSequence")
core:require_module("CoreClass")
SubtitleSequence = SubtitleSequence or CoreClass.class()
Subtitle = Subtitle or CoreClass.class()
StringIDSubtitle = StringIDSubtitle or CoreClass.class(Subtitle)
function SubtitleSequence.init(A0_0, A1_1)
	if A1_1 then
		A0_0:_load_from_xml(A1_1)
	end
end
function SubtitleSequence.name(A0_2)
	return A0_2:parameters().name or ""
end
function SubtitleSequence.duration(A0_3)
	return A0_3.__subtitles and A0_3.__subtitles[#A0_3.__subtitles]:end_time()
end
function SubtitleSequence.parameters(A0_4)
	return A0_4.__parameters or {}
end
function SubtitleSequence.subtitles(A0_5)
	return A0_5.__subtitles or {}
end
function SubtitleSequence.add_subtitle(A0_6, A1_7)
	A0_6.__subtitles = A0_6.__subtitles or {}
	table.insert_sorted(A0_6.__subtitles, A1_7, function(A0_8, A1_9)
		return A0_8:start_time() < A1_9:start_time()
	end)
end
function SubtitleSequence._load_from_xml(A0_10, A1_11)
	local L2_12, L3_13, L4_14, L5_15, L6_16, L7_17, L8_18
	L2_12(L3_13, L4_14)
	L3_13 = A1_11 and L3_13 == "sequence"
	L2_12(L3_13, L4_14)
	L5_15 = "name"
	L2_12(L3_13, L4_14)
	A0_10.__parameters = L2_12
	A0_10.__subtitles = L2_12
	for L5_15 in L2_12(L3_13) do
		L7_17 = A0_10
		L6_16 = A0_10._xml_assert
		L8_18 = L5_15.parameter
		L8_18 = L8_18(L5_15, "text_id")
		L6_16 = L6_16(L7_17, L8_18, L5_15, string.format("Sequence \"%s\" has entries without text_ids.", A0_10:name()))
		L7_17 = managers
		L7_17 = L7_17.localization
		L8_18 = L7_17
		L7_17 = L7_17.exists
		L7_17 = L7_17(L8_18, L6_16)
		if not L7_17 then
			L8_18 = A0_10
			L7_17 = A0_10._report_bad_string_id
			L7_17(L8_18, L6_16)
		end
		L8_18 = A0_10
		L7_17 = A0_10._xml_assert
		L7_17 = L7_17(L8_18, tonumber(L5_15:parameter("time")), L5_15, string.format("Sequence \"%s\" has entries without valid times.", A0_10:name()))
		L8_18 = StringIDSubtitle
		L8_18 = L8_18.new
		L8_18 = L8_18(L8_18, L6_16, L7_17, tonumber(L5_15:parameter("duration") or 2))
		A0_10:add_subtitle(CoreClass.freeze(L8_18))
	end
	L2_12(L3_13)
end
function SubtitleSequence._report_bad_string_id(A0_19, A1_20)
	Localizer:lookup(A1_20)
end
function SubtitleSequence._xml_assert(A0_21, A1_22, A2_23, A3_24)
	local L4_25
	L4_25 = A1_22 or L4_25(string.format("Error parsing \"%s\" - %s", string.gsub(A2_23:file(), "^.*[/\\]", ""), A3_24))
	return L4_25
end
function Subtitle.init(A0_26, A1_27, A2_28, A3_29)
	A0_26.__string_data = A1_27 ~= nil and assert(tostring(A1_27), "Invalid string argument.") or ""
	A0_26.__start_time = assert(tonumber(A2_28), "Invalid start time argument.")
	A0_26.__duration = A3_29 ~= nil and assert(tonumber(A3_29), "Invalid duration argument.") or nil
end
function Subtitle.string(A0_30)
	local L1_31
	L1_31 = A0_30.__string_data
	return L1_31
end
function Subtitle.start_time(A0_32)
	local L1_33
	L1_33 = A0_32.__start_time
	return L1_33
end
function Subtitle.end_time(A0_34)
	return A0_34:start_time() + (A0_34:duration() or math.huge)
end
function Subtitle.duration(A0_35)
	local L1_36
	L1_36 = A0_35.__duration
	return L1_36
end
function Subtitle.is_active_at_time(A0_37, A1_38)
	return A1_38 > A0_37:start_time() and A1_38 < A0_37:end_time()
end
function StringIDSubtitle.string(A0_39)
	assert(managers.localization, "Localization Manager not ready.")
	return managers.localization:text(A0_39.__string_data)
end
