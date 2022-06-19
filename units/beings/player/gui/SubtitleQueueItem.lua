SubtitleQueueItem = SubtitleQueueItem or class()
function SubtitleQueueItem.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._timer = A1_1
	A0_0._localized_text = A2_2
	A0_0._time_offset = A3_3
	A0_0._start_time = A0_0._timer:time() + A3_3
end
function SubtitleQueueItem.mark_as_done(A0_4)
	A0_4._end_time = A0_4._timer:time()
end
function SubtitleQueueItem.duration(A0_5)
	return A0_5._end_time - A0_5._start_time
end
function SubtitleQueueItem.start_time(A0_6)
	local L1_7
	L1_7 = A0_6._start_time
	return L1_7
end
function SubtitleQueueItem.end_time(A0_8)
	local L1_9
	L1_9 = A0_8._end_time
	return L1_9
end
