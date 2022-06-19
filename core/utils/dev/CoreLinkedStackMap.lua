CoreLinkedStackMap = CoreLinkedStackMap or class()
function CoreLinkedStackMap.init(A0_0)
	A0_0._linked_map = {}
	A0_0._top_link = nil
	A0_0._bottom_link = nil
	A0_0._last_link_id = 0
end
function CoreLinkedStackMap.top_link(A0_1)
	local L1_2
	L1_2 = A0_1._top_link
	return L1_2
end
function CoreLinkedStackMap.top(A0_3)
	local L1_4
	L1_4 = A0_3._top_link
	if L1_4 then
		L1_4 = A0_3._top_link
		L1_4 = L1_4.value
	end
	return L1_4
end
function CoreLinkedStackMap.get_linked_map(A0_5)
	local L1_6
	L1_6 = A0_5._linked_map
	return L1_6
end
function CoreLinkedStackMap.get(A0_7, A1_8)
	return A0_7._linked_map[A1_8]
end
function CoreLinkedStackMap.iterator(A0_9)
	local L1_10, L2_11, L3_12, L4_13
	function L1_10(A0_14, A1_15)
		local L2_16
		L2_16 = next
		L2_16 = L2_16(A0_14, A1_15)
		return L2_16, L2_16(A0_14, A1_15) and L2_16(A0_14, A1_15).value
	end
	L2_11 = L1_10
	L3_12 = A0_9._linked_map
	L4_13 = nil
	return L2_11, L3_12, L4_13
end
function CoreLinkedStackMap.top_bottom_iterator(A0_17)
	local L1_18, L2_19, L3_20, L4_21
	function L1_18(A0_22, A1_23)
		local L2_24, L3_25, L4_26
		if A1_23 then
			L2_24 = A0_22[A1_23]
			L2_24 = L2_24.previous
			if L2_24 then
				L3_25 = L2_24.id
				L4_26 = L2_24.value
				return L3_25, L4_26
			else
				L3_25, L4_26 = nil, nil
				return L3_25, L4_26
			end
		else
			L2_24 = _UPVALUE0_
			L2_24 = L2_24._top_link
			if L2_24 then
				L2_24 = _UPVALUE0_
				L2_24 = L2_24._top_link
				L2_24 = L2_24.id
				L3_25 = _UPVALUE0_
				L3_25 = L3_25._top_link
				L3_25 = L3_25.value
				return L2_24, L3_25
			else
				L2_24, L3_25 = nil, nil
				return L2_24, L3_25
			end
		end
	end
	L2_19 = L1_18
	L3_20 = A0_17._linked_map
	L4_21 = nil
	return L2_19, L3_20, L4_21
end
function CoreLinkedStackMap.bottom_top_iterator(A0_27)
	local L1_28, L2_29, L3_30, L4_31
	function L1_28(A0_32, A1_33)
		local L2_34, L3_35, L4_36
		if A1_33 then
			L2_34 = A0_32[A1_33]
			L2_34 = L2_34.next
			if L2_34 then
				L3_35 = L2_34.id
				L4_36 = L2_34.value
				return L3_35, L4_36
			else
				L3_35, L4_36 = nil, nil
				return L3_35, L4_36
			end
		else
			L2_34 = _UPVALUE0_
			L2_34 = L2_34._bottom_link
			if L2_34 then
				L2_34 = _UPVALUE0_
				L2_34 = L2_34._bottom_link
				L2_34 = L2_34.id
				L3_35 = _UPVALUE0_
				L3_35 = L3_35._bottom_link
				L3_35 = L3_35.value
				return L2_34, L3_35
			else
				L2_34, L3_35 = nil, nil
				return L2_34, L3_35
			end
		end
	end
	L2_29 = L1_28
	L3_30 = A0_27._linked_map
	L4_31 = nil
	return L2_29, L3_30, L4_31
end
function CoreLinkedStackMap.add(A0_37, A1_38)
	local L2_39, L3_40
	L2_39 = A0_37._last_link_id
	L2_39 = L2_39 + 1
	A0_37._last_link_id = L2_39
	L2_39 = {}
	L2_39.value = A1_38
	L3_40 = A0_37._last_link_id
	L2_39.id = L3_40
	L3_40 = A0_37._linked_map
	L3_40[A0_37._last_link_id] = L2_39
	L3_40 = A0_37._top_link
	if L3_40 then
		L3_40 = A0_37._top_link
		L3_40.next = L2_39
		L3_40 = A0_37._top_link
		L2_39.previous = L3_40
	else
		A0_37._bottom_link = L2_39
	end
	A0_37._top_link = L2_39
	L3_40 = A0_37._last_link_id
	return L3_40
end
function CoreLinkedStackMap.remove(A0_41, A1_42)
	local L2_43, L3_44, L4_45, L5_46
	L2_43 = A0_41._linked_map
	L2_43 = L2_43[A1_42]
	if L2_43 then
		L3_44 = L2_43.previous
		L4_45 = L2_43.next
		if L3_44 then
			L3_44.next = L4_45
		end
		if L4_45 then
			L4_45.previous = L3_44
		end
		L5_46 = A0_41._top_link
		if L5_46 == L2_43 then
			A0_41._top_link = L3_44
		end
		L5_46 = A0_41._bottom_link
		if L5_46 == L2_43 then
			A0_41._bottom_link = L4_45
		end
		L5_46 = A0_41._linked_map
		L5_46[A1_42] = nil
	end
end
function CoreLinkedStackMap.to_string(A0_47)
	local L1_48, L2_49
	L1_48 = ""
	L2_49 = A0_47._top_link
	while L2_49 do
		if L1_48 == "" then
			L1_48 = tostring(L2_49.value)
		else
			L1_48 = L1_48 .. ", " .. tostring(L2_49.value)
		end
		L2_49 = L2_49.previous
	end
	return L1_48
end
