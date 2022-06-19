if not Queue then
	Queue = class()
end
Queue.init = function(l_1_0)
	l_1_0._table = {}
	l_1_0._first = 0
	l_1_0._last = -1
end

Queue.push_first = function(l_2_0, l_2_1)
	l_2_0._first = l_2_0._first - 1
	l_2_0._table[l_2_0._first] = l_2_1
end

Queue.push_last = function(l_3_0, l_3_1)
	l_3_0._last = l_3_0._last + 1
	l_3_0._table[l_3_0._last] = l_3_1
end

Queue.pop_first = function(l_4_0)
	if l_4_0:is_empty() then
		error("Queue is empty")
	end
	local l_4_1 = l_4_0._table[l_4_0._first]
	l_4_0._table[l_4_0._first] = nil
	l_4_0._first = l_4_0._first + 1
	return l_4_1
end

Queue.pop_last = function(l_5_0)
	if l_5_0:is_empty() then
		error("Queue is empty")
	end
	local l_5_1 = l_5_0._table[l_5_0._last]
	l_5_0._table[l_5_0._last] = nil
	l_5_0._last = l_5_0._last - 1
	return l_5_1
end

Queue.peek_first = function(l_6_0)
	if l_6_0:is_empty() then
		error("Queue is empty")
	end
	return l_6_0._table[l_6_0._first]
end

Queue.is_empty = function(l_7_0)
	return l_7_0._last < l_7_0._first
end

Queue.size = function(l_8_0)
	return l_8_0._last - l_8_0._first + 1
end


