require("units/beings/player/gui/SubtitleQueueItem")
SubtitleQueue = SubtitleQueue or class()
function SubtitleQueue.init(A0_0)
	A0_0._wall_timer = TimerManager:wall()
	A0_0._items = Queue:new()
end
function SubtitleQueue.add_text(A0_1, A1_2, A2_3, A3_4)
	local L4_5
	L4_5 = assert
	L4_5(A2_3, "Wrong localization string:'" .. A1_2 .. "' with ID " .. A3_4)
	L4_5 = SubtitleQueueItem
	L4_5 = L4_5.new
	L4_5 = L4_5(L4_5, A0_1._wall_timer, A1_2, A2_3)
	A0_1._items:push_last(L4_5)
	return L4_5
end
function SubtitleQueue.next_item_regardless_of_time(A0_6)
	if not A0_6:has_line() then
		return
	end
	return (A0_6._items:pop_first())
end
function SubtitleQueue.next_item(A0_7, A1_8)
	if not A0_7:has_line() then
		return
	end
	if A1_8 < A0_7._items:peek_first():start_time() then
		return
	end
	A0_7._items:pop_first()
	return (A0_7._items:peek_first())
end
function SubtitleQueue.top_two_items(A0_9, A1_10)
	local L2_11, L3_12
	L3_12 = A0_9
	L2_11 = A0_9.next_item
	L2_11 = L2_11(L3_12, A1_10)
	L3_12 = nil
	if L2_11 ~= nil then
		L3_12 = A0_9:next_item_regardless_of_time()
	end
	return L2_11, L3_12
end
function SubtitleQueue.has_line(A0_13)
	return not A0_13._items:is_empty()
end
function SubtitleQueue.has_line_to_show(A0_14, A1_15)
	if not A0_14:has_line() then
		return false
	end
	if A1_15 >= A0_14._items:peek_first():start_time() then
		return true
	end
	return false
end
