RandomTraversal = RandomTraversal or class()
function RandomTraversal.init(A0_0, A1_1, A2_2)
	A0_0.shuffle_at_end_of_list = A2_2
	A0_0._count = A1_1
	if not A0_0.shuffle_at_end_of_list then
		A0_0:shuffle()
	end
end
function RandomTraversal.set_count(A0_3, A1_4)
	if A1_4 < A0_3._count then
		A0_3._count = A1_4
		A0_3:shuffle()
	else
		A0_3._count = A1_4
	end
end
function RandomTraversal.current_index(A0_5)
	return A0_5._index + 1
end
function RandomTraversal.next_index(A0_6)
	if A0_6.shuffle_at_end_of_list and A0_6._index == A0_6._start_index then
		A0_6:shuffle()
	end
	A0_6._index = A0_6._index + A0_6._inc
	A0_6._index = math.fmod(A0_6._index, A0_6._count)
	A0_6._index = math.floor(A0_6._index)
	return A0_6._index + 1
end
function RandomTraversal.shuffle(A0_7)
	A0_7:_select_random_prime_number()
	A0_7:_select_random_start_index()
end
RandomTraversal.prime_numbers = {
	82561,
	83641,
	87383,
	92593,
	102409,
	103963,
	104551,
	104707
}
function RandomTraversal._select_random_prime_number(A0_8)
	local L1_9, L2_10
	L1_9 = assert
	L2_10 = A0_8._count
	L2_10 = L2_10 < 82500
	L1_9(L2_10, "sorry, random traversal can only handle counts that are < 82500")
	L1_9 = RandomTraversal
	L1_9 = L1_9.prime_numbers
	L1_9 = #L1_9
	L2_10 = math
	L2_10 = L2_10.random
	L2_10 = L2_10(1, L1_9)
	A0_8._inc = RandomTraversal.prime_numbers[L2_10]
	assert(A0_8._inc, "tried to set prime_index" .. L2_10)
end
function RandomTraversal._select_random_start_index(A0_11)
	A0_11._index = math.random(0, A0_11._count - 1)
	A0_11._start_index = A0_11._index
end
