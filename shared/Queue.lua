Queue = Queue or class()
function Queue.init(A0_0)
	A0_0._table = {}
	A0_0._first = 0
	A0_0._last = -1
end
function Queue.push_first(A0_1, A1_2)
	local L2_3
	L2_3 = A0_1._first
	L2_3 = L2_3 - 1
	A0_1._first = L2_3
	L2_3 = A0_1._table
	L2_3[A0_1._first] = A1_2
end
function Queue.push_last(A0_4, A1_5)
	local L2_6
	L2_6 = A0_4._last
	L2_6 = L2_6 + 1
	A0_4._last = L2_6
	L2_6 = A0_4._table
	L2_6[A0_4._last] = A1_5
end
function Queue.pop_first(A0_7)
	if A0_7:is_empty() then
		error("Queue is empty")
	end
	A0_7._table[A0_7._first] = nil
	A0_7._first = A0_7._first + 1
	return A0_7._table[A0_7._first]
end
function Queue.pop_last(A0_8)
	if A0_8:is_empty() then
		error("Queue is empty")
	end
	A0_8._table[A0_8._last] = nil
	A0_8._last = A0_8._last - 1
	return A0_8._table[A0_8._last]
end
function Queue.peek_first(A0_9)
	if A0_9:is_empty() then
		error("Queue is empty")
	end
	return A0_9._table[A0_9._first]
end
function Queue.is_empty(A0_10)
	return A0_10._first > A0_10._last
end
function Queue.size(A0_11)
	local L1_12
	L1_12 = A0_11._last
	L1_12 = L1_12 - A0_11._first
	L1_12 = L1_12 + 1
	return L1_12
end
