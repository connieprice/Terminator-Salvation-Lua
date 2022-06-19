if not CoreLinkedStackMap then
	CoreLinkedStackMap = class()
end
CoreLinkedStackMap.init = function(l_1_0)
	l_1_0._linked_map = {}
	l_1_0._top_link = nil
	l_1_0._bottom_link = nil
	l_1_0._last_link_id = 0
end

CoreLinkedStackMap.top_link = function(l_2_0)
	return l_2_0._top_link
end

CoreLinkedStackMap.top = function(l_3_0)
	if l_3_0._top_link then
		return l_3_0._top_link.value
	end
end

CoreLinkedStackMap.get_linked_map = function(l_4_0)
	return l_4_0._linked_map
end

CoreLinkedStackMap.get = function(l_5_0, l_5_1)
	return l_5_0._linked_map[l_5_1]
end

CoreLinkedStackMap.iterator = function(l_6_0)
	local l_6_1 = function(l_7_0, l_7_1)
		local l_7_2, l_7_3 = next(l_7_0, l_7_1)
		local l_7_4 = l_7_2
		do
			if l_7_3 then
				return l_7_4, l_7_3.value
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
  end
	return l_6_1, l_6_0._linked_map, nil
end

CoreLinkedStackMap.top_bottom_iterator = function(l_7_0)
	do
		return function(l_8_0, l_8_1)
		-- upvalues: l_7_0
		if l_8_1 then
			local l_8_2 = l_8_0[l_8_1].previous
			if l_8_2 then
				return l_8_2.id, l_8_2.value
			else
				return nil, nil
			end
		else
			if l_7_0._top_link then
				return l_7_0._top_link.id, l_7_0._top_link.value
			end
		else
			return nil, nil
		end
  end, l_7_0._linked_map, nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreLinkedStackMap.bottom_top_iterator = function(l_8_0)
	do
		return function(l_9_0, l_9_1)
		-- upvalues: l_8_0
		if l_9_1 then
			local l_9_2 = l_9_0[l_9_1].next
			if l_9_2 then
				return l_9_2.id, l_9_2.value
			else
				return nil, nil
			end
		else
			if l_8_0._bottom_link then
				return l_8_0._bottom_link.id, l_8_0._bottom_link.value
			end
		else
			return nil, nil
		end
  end, l_8_0._linked_map, nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreLinkedStackMap.add = function(l_9_0, l_9_1)
	l_9_0._last_link_id = l_9_0._last_link_id + 1
	local l_9_2 = {}
	l_9_2.value = l_9_1
	l_9_2.id = l_9_0._last_link_id
	l_9_0._linked_map[l_9_0._last_link_id] = l_9_2
	if l_9_0._top_link then
		l_9_0._top_link.next = l_9_2
		l_9_2.previous = l_9_0._top_link
	else
		l_9_0._bottom_link = l_9_2
	end
	l_9_0._top_link = l_9_2
	return l_9_0._last_link_id
end

CoreLinkedStackMap.remove = function(l_10_0, l_10_1)
	local l_10_2 = l_10_0._linked_map[l_10_1]
	if l_10_2 then
		local l_10_3 = l_10_2.previous
		local l_10_4 = l_10_2.next
		if l_10_3 then
			l_10_3.next = l_10_4
		end
		if l_10_4 then
			l_10_4.previous = l_10_3
		end
		if l_10_0._top_link == l_10_2 then
			l_10_0._top_link = l_10_3
		end
		if l_10_0._bottom_link == l_10_2 then
			l_10_0._bottom_link = l_10_4
		end
		l_10_0._linked_map[l_10_1] = nil
	end
end

CoreLinkedStackMap.to_string = function(l_11_0)
	local l_11_1 = ""
	do
		while 1 do
			local l_11_2 = l_11_0._top_link
			while l_11_2 do
				if l_11_1 == "" then
					l_11_1 = tostring(l_11_2.value)
				else
					l_11_1 = l_11_1 .. ", " .. tostring(l_11_2.value)
				end
				l_11_2 = l_11_2.previous
			end
			return l_11_1
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end


