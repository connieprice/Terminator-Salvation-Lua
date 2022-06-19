core:module("CoreSubtitleSequencePlayer")
core:require_module("CoreClass")
SubtitleSequencePlayer = SubtitleSequencePlayer or CoreClass.class()
function SubtitleSequencePlayer.init(A0_0, A1_1, A2_2)
	assert(A1_1, "Invalid sequence.")
	assert(A2_2, "Invalid presenter.")
	A0_0.__presenter = A2_2
	A0_0.__sequence = A0_0.__presenter:preprocess_sequence(A1_1)
end
function SubtitleSequencePlayer.is_done(A0_3)
	local L1_4
	L1_4 = A0_3.__time
	L1_4 = L1_4 or 0
	L1_4 = L1_4 >= A0_3.__sequence:duration()
	return L1_4
end
function SubtitleSequencePlayer.update(A0_5, A1_6, A2_7)
	A0_5.__time = (A0_5.__time or 0) + A2_7
	A0_5:evaluate_at_time(A0_5.__time)
end
function SubtitleSequencePlayer.evaluate_at_time(A0_8, A1_9)
	if A1_9 ~= A0_8._last_evaluated_time then
		if table.inject(A0_8.__sequence:subtitles(), nil, function(A0_10, A1_11)
			return A1_11:is_active_at_time(_UPVALUE0_) and A1_11 or A0_10
		end) ~= A0_8.__previous_subtitle then
			A0_8.__presenter:show_text(table.inject(A0_8.__sequence:subtitles(), nil, function(A0_12, A1_13)
				return A1_13:is_active_at_time(_UPVALUE0_) and A1_13 or A0_12
			end) and table.inject(A0_8.__sequence:subtitles(), nil, function(A0_14, A1_15)
				return A1_15:is_active_at_time(_UPVALUE0_) and A1_15 or A0_14
			end):string() or "", table.inject(A0_8.__sequence:subtitles(), nil, function(A0_16, A1_17)
				return A1_17:is_active_at_time(_UPVALUE0_) and A1_17 or A0_16
			end) and table.inject(A0_8.__sequence:subtitles(), nil, function(A0_18, A1_19)
				return A1_19:is_active_at_time(_UPVALUE0_) and A1_19 or A0_18
			end):duration())
			A0_8.__previous_subtitle = table.inject(A0_8.__sequence:subtitles(), nil, function(A0_20, A1_21)
				return A1_21:is_active_at_time(_UPVALUE0_) and A1_21 or A0_20
			end)
		end
		A0_8._last_evaluated_time = A1_9
	end
end
