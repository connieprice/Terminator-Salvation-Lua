CoreCutsceneKeyCollection = CoreCutsceneKeyCollection or class()
function CoreCutsceneKeyCollection.keys(A0_0, A1_1)
	return A0_0:keys_between(-1, math.huge, A1_1)
end
function CoreCutsceneKeyCollection.keys_between(A0_2, A1_3, A2_4, A3_5)
	local L4_6
	if A1_3 == A2_4 then
		function L4_6()
			local L0_7, L1_8
		end
		return L4_6
	end
	L4_6 = A0_2._all_keys_sorted_by_time
	L4_6 = L4_6(A0_2)
	if A1_3 < A2_4 then
		return function()
			local L0_9
			while true do
				L0_9 = _UPVALUE0_
				if L0_9 < _UPVALUE1_ then
					L0_9 = _UPVALUE0_
					L0_9 = L0_9 + 1
					_UPVALUE0_ = L0_9
					L0_9 = _UPVALUE2_
					L0_9 = L0_9[_UPVALUE0_]
					if L0_9 and L0_9:time() > _UPVALUE3_ then
						if L0_9:time() <= _UPVALUE4_ then
							if _UPVALUE5_ == nil or _UPVALUE5_ == L0_9.ELEMENT_NAME then
								return L0_9
							end
							else
								break
							end
						end
					end
			end
		end
	else
		return function()
			local L0_10
			while true do
				L0_10 = _UPVALUE0_
				if L0_10 > 1 then
					L0_10 = _UPVALUE0_
					L0_10 = L0_10 - 1
					_UPVALUE0_ = L0_10
					L0_10 = _UPVALUE1_
					L0_10 = L0_10[_UPVALUE0_]
					if L0_10 and L0_10:time() <= _UPVALUE2_ then
						if L0_10:time() > _UPVALUE3_ then
							if _UPVALUE4_ == nil or _UPVALUE4_ == L0_10.ELEMENT_NAME then
								return L0_10
							end
							else
								break
							end
						end
					end
			end
		end
	end
end
function CoreCutsceneKeyCollection.keys_to_update(A0_11, A1_12, A2_13)
	local L3_14
	L3_14 = A0_11._all_keys_sorted_by_time
	L3_14 = L3_14(A0_11)
	return function()
		local L0_15
		while true do
			L0_15 = _UPVALUE0_
			if L0_15 < _UPVALUE1_ then
				L0_15 = _UPVALUE0_
				L0_15 = L0_15 + 1
				_UPVALUE0_ = L0_15
				L0_15 = _UPVALUE2_
				L0_15 = L0_15[_UPVALUE0_]
			end
			if L0_15:time() > _UPVALUE3_ then
				break
			elseif (_UPVALUE4_ == nil or _UPVALUE4_ == L0_15.ELEMENT_NAME) and type(L0_15.update) == "function" then
				return L0_15
			end
		end
	end
end
function CoreCutsceneKeyCollection.first_key(A0_16, A1_17, A2_18, A3_19)
	local L4_20, L5_21, L6_22, L7_23, L8_24
	L8_24 = L5_21(L6_22)
	for L7_23, L8_24 in L4_20(L5_21, L6_22, L7_23, L8_24, L5_21(L6_22)) do
		if A1_17 <= L8_24:time() and (A2_18 == nil or A2_18 == L8_24.ELEMENT_NAME) then
			if A3_19 ~= nil then
			elseif table.true_for_all(A3_19, function(A0_25, A1_26)
				return _UPVALUE0_[A1_26](_UPVALUE0_) == A0_25
			end) then
				return L8_24, L7_23
			end
		end
	end
end
function CoreCutsceneKeyCollection.last_key_before(A0_27, A1_28, A2_29, A3_30)
	local L4_31, L5_32
	for 