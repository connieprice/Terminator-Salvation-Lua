CallbacksList = CallbacksList or class()
function CallbacksList.init(A0_0)
	A0_0._callbacks = {}
end
function CallbacksList.add(A0_1, A1_2, A2_3)
	assert(type(A2_3) ~= "table")
	assert(not A0_1._callbacks[A1_2], "Callback id already registered!")
	A0_1._callbacks[A1_2] = A2_3
end
function CallbacksList.remove(A0_4, A1_5)
	assert(A0_4._callbacks[A1_5], "Callback id not registered!")
	A0_4._callbacks[A1_5] = nil
end
function CallbacksList.call(A0_6, ...)
	local L2_8, L3_9, L4_10, L5_11, L6_12
	for L5_11, L6_12 in L2_8(L3_9) do
		L6_12(...)
	end
end
function CallbacksList.public_interface(A0_13)
	local L1_14, L2_15
	L1_14 = {}
	function L2_15(...)
		local L2_17, L3_18
		L2_17 = _UPVALUE0_
		L3_18 = L2_17
		L2_17 = L2_17.add
		L2_17(L3_18, ...)
	end
	L1_14.add = L2_15
	function L2_15(...)
		local L2_20, L3_21
		L2_20 = _UPVALUE0_
		L3_21 = L2_20
		L2_20 = L2_20.remove
		L2_20(L3_21, ...)
	end
	L1_14.remove = L2_15
	return L1_14
end
