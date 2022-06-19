core:module("CoreSubtitleSequencePlayer")
core:require_module("CoreClass")
if not SubtitleSequencePlayer then
	SubtitleSequencePlayer = CoreClass.class()
end
SubtitleSequencePlayer.init = function(l_1_0, l_1_1, l_1_2)
	assert(l_1_1, "Invalid sequence.")
	assert(l_1_2, "Invalid presenter.")
	l_1_0.__presenter = l_1_2
	l_1_0.__sequence = l_1_0.__presenter:preprocess_sequence(l_1_1)
end

SubtitleSequencePlayer.is_done = function(l_2_0)
	return l_2_0.__sequence:duration() <= l_2_0.__time or 0
end

SubtitleSequencePlayer.update = function(l_3_0, l_3_1, l_3_2)
	l_3_0.__time = (l_3_0.__time or 0) + l_3_2
	l_3_0:evaluate_at_time(l_3_0.__time)
end

SubtitleSequencePlayer.evaluate_at_time = function(l_4_0, l_4_1)
	do
		if l_4_1 ~= l_4_0._last_evaluated_time then
			local l_4_2 = table.inject((l_4_0.__sequence:subtitles()), nil, function(l_5_0, l_5_1)
		-- upvalues: l_4_1
		return l_5_1:is_active_at_time(l_4_1) and l_5_1 or l_5_0
  end)
			if l_4_2 ~= l_4_0.__previous_subtitle then
				local l_4_3, l_4_4 = l_4_0.__presenter:show_text, l_4_0.__presenter
				do
					local l_4_5 = l_4_2 and l_4_2:string() or ""
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				if l_4_2 then
					l_4_3(l_4_4, l_4_5, l_4_2:duration())
				end
				l_4_0.__previous_subtitle = l_4_2
			end
			l_4_0._last_evaluated_time = l_4_1
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


