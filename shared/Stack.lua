Stack = Stack or class()
function Stack.init(A0_0)
	A0_0:clear()
end
function Stack.push(A0_1, A1_2)
	local L2_3
	L2_3 = A0_1._last
	L2_3 = L2_3 + 1
	A0_1._last = L2_3
	L2_3 = A0_1._table
	L2_3[A0_1._last] = A1_2
end
function Stack.pop(A0_4)
	if A0_4:is_empty() then
		error("Stack is empty")
	end
	A0_4._table[A0_4._last] = nil
	A0_4._last = A0_4._last - 1
	return A0_4._table[A0_4._last]
end
function Stack.top(A0_5)
	if A0_5:is_empty() then
		error("Stack is empty")
	end
	return A0_5._table[A0_5._last]
end
function Stack.is_empty(A0_6)
	return A0_6._last == 0
end
function Stack.size(A0_7)
	local L1_8
	L1_8 = A0_7._last
	return L1_8
end
function Stack.clear(A0_9)
	A0_9._last = 0
	A0_9._table = {}
end
