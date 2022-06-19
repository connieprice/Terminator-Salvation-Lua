if not Stack then
	Stack = class()
end
Stack.init = function(l_1_0)
	l_1_0:clear()
end

Stack.push = function(l_2_0, l_2_1)
	l_2_0._last = l_2_0._last + 1
	l_2_0._table[l_2_0._last] = l_2_1
end

Stack.pop = function(l_3_0)
	if l_3_0:is_empty() then
		error("Stack is empty")
	end
	local l_3_1 = l_3_0._table[l_3_0._last]
	l_3_0._table[l_3_0._last] = nil
	l_3_0._last = l_3_0._last - 1
	return l_3_1
end

Stack.top = function(l_4_0)
	if l_4_0:is_empty() then
		error("Stack is empty")
	end
	return l_4_0._table[l_4_0._last]
end

Stack.is_empty = function(l_5_0)
	return l_5_0._last == 0
end

Stack.size = function(l_6_0)
	return l_6_0._last
end

Stack.clear = function(l_7_0)
	l_7_0._last = 0
	l_7_0._table = {}
end


