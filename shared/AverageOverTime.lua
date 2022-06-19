require("shared/Queue")
AverageOverTime = AverageOverTime or class()
function AverageOverTime.init(A0_0, A1_1, A2_2)
	assert(A1_1 > 0)
	A0_0._max_sample_count = A1_1
	A0_0._values = Queue:new()
	if A2_2 == nil then
		A0_0._total = 0
	else
		A0_0._total = A2_2
	end
	A0_0._time = 0
	A0_0._time_since_debug = 0
end
function AverageOverTime.add(A0_3, A1_4, A2_5)
	local L3_6
	L3_6 = A0_3._values
	L3_6 = L3_6.size
	L3_6 = L3_6(L3_6)
	if L3_6 == A0_3._max_sample_count then
		L3_6 = A0_3._values
		L3_6 = L3_6.pop_first
		L3_6 = L3_6(L3_6)
		A0_3._total = A0_3._total - L3_6.value
		A0_3._time = A0_3._time - L3_6.time
	end
	L3_6 = {}
	L3_6.value = A1_4
	L3_6.time = A2_5
	A0_3._values:push_last(L3_6)
	A0_3._total = A0_3._total + L3_6.value
	A0_3._time = A0_3._time + L3_6.time
	A0_3._time_since_debug = A0_3._time_since_debug + A2_5
	if A0_3._time_since_debug > 5 then
		A0_3._time_since_debug = 0
	end
end
function AverageOverTime.value(A0_7)
	local L1_8
	L1_8 = A0_7._time
	if L1_8 <= 0.1 then
		L1_8 = 0
		return L1_8
	end
	L1_8 = A0_7._total
	L1_8 = L1_8 / A0_7._time
	return L1_8
end
function AverageOverTime.clear(A0_9)
	A0_9._values:clear()
	A0_9._total = 0
	A0_9._time = 0
end
function AverageOverTime.is_complete(A0_10)
	return A0_10._values:size() == A0_10._max_sample_count
end
function AverageOverTime.count(A0_11)
	return A0_11._values:size()
end
