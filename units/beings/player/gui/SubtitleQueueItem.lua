if not SubtitleQueueItem then
	SubtitleQueueItem = class()
end
SubtitleQueueItem.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._timer = l_1_1
	l_1_0._localized_text = l_1_2
	l_1_0._time_offset = l_1_3
	l_1_0._start_time = l_1_0._timer:time() + l_1_3
end

SubtitleQueueItem.mark_as_done = function(l_2_0)
	l_2_0._end_time = l_2_0._timer:time()
end

SubtitleQueueItem.duration = function(l_3_0)
	return l_3_0._end_time - l_3_0._start_time
end

SubtitleQueueItem.start_time = function(l_4_0)
	return l_4_0._start_time
end

SubtitleQueueItem.end_time = function(l_5_0)
	return l_5_0._end_time
end


