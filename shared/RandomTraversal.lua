if not RandomTraversal then
	RandomTraversal = class()
end
RandomTraversal.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0.shuffle_at_end_of_list = l_1_2
	l_1_0._count = l_1_1
	if not l_1_0.shuffle_at_end_of_list then
		l_1_0:shuffle()
	end
end

RandomTraversal.set_count = function(l_2_0, l_2_1)
	if l_2_1 < l_2_0._count then
		l_2_0._count = l_2_1
		l_2_0:shuffle()
	else
		l_2_0._count = l_2_1
	end
end

RandomTraversal.current_index = function(l_3_0)
	return l_3_0._index + 1
end

RandomTraversal.next_index = function(l_4_0)
	if l_4_0.shuffle_at_end_of_list and l_4_0._index == l_4_0._start_index then
		l_4_0:shuffle()
	end
	local l_4_1 = l_4_0._index
	l_4_0._index = l_4_0._index + l_4_0._inc
	l_4_0._index = math.fmod(l_4_0._index, l_4_0._count)
	l_4_0._index = math.floor(l_4_0._index)
	return l_4_1 + 1
end

RandomTraversal.shuffle = function(l_5_0)
	l_5_0:_select_random_prime_number()
	l_5_0:_select_random_start_index()
end

local l_0_0 = RandomTraversal
do
	local l_0_1 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

end
 -- WARNING: undefined locals caused missing assignments!

