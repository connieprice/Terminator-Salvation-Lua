require("units/beings/player/gui/SubtitleQueueItem")
if not SubtitleQueue then
	SubtitleQueue = class()
end
SubtitleQueue.init = function(l_1_0)
	l_1_0._wall_timer = TimerManager:wall()
	l_1_0._items = Queue:new()
end

SubtitleQueue.add_text = function(l_2_0, l_2_1, l_2_2, l_2_3)
	assert(l_2_2, "Wrong localization string:'" .. l_2_1 .. "' with ID " .. l_2_3)
	local l_2_4 = SubtitleQueueItem:new(l_2_0._wall_timer, l_2_1, l_2_2)
	l_2_0._items:push_last(l_2_4)
	return l_2_4
end

SubtitleQueue.next_item_regardless_of_time = function(l_3_0)
	if not l_3_0:has_line() then
		return 
	end
	return l_3_0._items:pop_first()
end

SubtitleQueue.next_item = function(l_4_0, l_4_1)
	if not l_4_0:has_line() then
		return 
	end
	local l_4_2 = l_4_0._items:peek_first()
	if l_4_1 < l_4_2:start_time() then
		return 
	end
	l_4_0._items:pop_first()
	return l_4_2
end

SubtitleQueue.top_two_items = function(l_5_0, l_5_1)
	local l_5_2 = (l_5_0:next_item(l_5_1))
	local l_5_3 = nil
	if l_5_2 ~= nil then
		l_5_3 = l_5_0:next_item_regardless_of_time()
	end
	return l_5_2, l_5_3
end

SubtitleQueue.has_line = function(l_6_0)
	return not l_6_0._items:is_empty()
end

SubtitleQueue.has_line_to_show = function(l_7_0, l_7_1)
	if not l_7_0:has_line() then
		return false
	end
	local l_7_2 = l_7_0._items:peek_first()
	if l_7_2:start_time() <= l_7_1 then
		return true
	end
	return false
end


