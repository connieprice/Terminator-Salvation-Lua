core:module("CoreEvent")
core:require_module("CoreClass")
callback = function(l_1_0, l_1_1, l_1_2, l_1_3)
	if l_1_1 and l_1_2 and l_1_1[l_1_2] then
		if l_1_3 ~= nil then
			if l_1_0 then
				return function(...)
		-- upvalues: l_1_1 , l_1_2 , l_1_0 , l_1_3
		local l_2_1 = l_1_1[l_1_2]
		local l_2_2 = l_1_0
		local l_2_3 = l_1_3
		return l_2_1(l_2_2, l_2_3, ...)
  end
			else
				return function(...)
				-- upvalues: l_1_1 , l_1_2 , l_1_3
				local l_3_1 = l_1_1[l_1_2]
				local l_3_2 = l_1_3
				return l_3_1(l_3_2, ...)
      end
			end
		elseif l_1_0 then
			return function(...)
			-- upvalues: l_1_1 , l_1_2 , l_1_0
			local l_4_1 = l_1_1[l_1_2]
			local l_4_2 = l_1_0
			return l_4_1(l_4_2, ...)
    end
		else
			return function(...)
			-- upvalues: l_1_1 , l_1_2
			local l_5_1 = l_1_1[l_1_2]
			return l_5_1(...)
    end
		end
	elseif l_1_1 then
		error("Callback on class \"" .. tostring(CoreClass.class_name(not l_1_1 or getmetatable(l_1_1) or l_1_1)) .. "\" refers to a non-existing function \"" .. tostring(l_1_2) .. "\".")
	elseif l_1_2 then
		error("Callback to function \"" .. tostring(l_1_2) .. "\" is on a nil class.")
	else
		error("Callback class and function was nil.")
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

local l_0_0 = 0
get_ticket = function(l_2_0)
	do
		local l_2_1 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		return l_2_1
	end
	 -- WARNING: undefined locals caused missing assignments!
end

valid_ticket = function(l_3_0)
	-- upvalues: l_0_0
	return l_0_0 % l_3_0[1] == l_3_0[2]
end

update_tickets = function()
	-- upvalues: l_0_0
	l_0_0 = l_0_0 + 1
	if l_0_0 > 30 then
		l_0_0 = 0
	end
end

BasicEventHandling = {}
BasicEventHandling.connect = function(l_5_0, l_5_1, l_5_2, l_5_3)
	if not l_5_0._event_callbacks then
		l_5_0._event_callbacks = {}
	end
	if not l_5_0._event_callbacks[l_5_1] then
		l_5_0._event_callbacks[l_5_1] = {}
	end
	do
		table.insert(l_5_0._event_callbacks[l_5_1], function(...)
			-- upvalues: l_5_2 , l_5_3
			l_5_2(l_5_3, ...)
    end)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		return function(...)
			-- upvalues: l_5_2 , l_5_3
			l_5_2(l_5_3, ...)
    end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

BasicEventHandling.disconnect = function(l_6_0, l_6_1, l_6_2)
	if l_6_0._event_callbacks and l_6_0._event_callbacks[l_6_1] then
		table.delete(l_6_0._event_callbacks[l_6_1], l_6_2)
	if table.empty(l_6_0._event_callbacks[l_6_1]) then
		end
		l_6_0._event_callbacks[l_6_1] = nil
	if table.empty(l_6_0._event_callbacks) then
		end
		l_6_0._event_callbacks = nil
	end
end

BasicEventHandling._has_callbacks_for_event = function(l_7_0, l_7_1)
	return l_7_0._event_callbacks ~= nil and l_7_0._event_callbacks[l_7_1] ~= nil
end

BasicEventHandling._send_event = function(l_8_0, l_8_1, ...)
	local l_8_5, l_8_6, l_8_7, l_8_8 = nil
	if l_8_0._event_callbacks then
		if not l_8_0._event_callbacks[l_8_1] then
			for i_0,i_1 in ipairs({}) do
			end
			i_1(...)
		end
	end
end

if not CallbackHandler then
	CallbackHandler = CoreClass.class()
end
CallbackHandler.init = function(l_9_0)
	l_9_0:clear()
end

CallbackHandler.clear = function(l_10_0)
	l_10_0._t = 0
	l_10_0._sorted = {}
end

CallbackHandler.__insert_sorted = function(l_11_0, l_11_1)
	do
		while 1 do
			local l_11_2 = 1
			while l_11_0._sorted[l_11_2] and (l_11_0._sorted[l_11_2].next == nil or l_11_0._sorted[l_11_2].next < l_11_1.next) do
				l_11_2 = l_11_2 + 1
			end
			table.insert(l_11_0._sorted, l_11_2, l_11_1)
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

CallbackHandler.add = function(l_12_0, l_12_1, l_12_2, l_12_3)
	if not l_12_3 then
		l_12_3 = -1
	end
	local l_12_4 = {}
	l_12_4.f = l_12_1
	l_12_4.interval = l_12_2
	l_12_4.times = l_12_3
	l_12_4.next = l_12_0._t + l_12_2
	l_12_0:__insert_sorted(l_12_4)
	return l_12_4
end

CallbackHandler.remove = function(l_13_0, l_13_1)
	if l_13_1 then
		l_13_1.next = nil
	end
end

CallbackHandler.update = function(l_14_0, l_14_1)
	l_14_0._t = l_14_0._t + l_14_1
	while 1 do
		while 1 do
			while 1 do
				while 1 do
					do
						local l_14_2 = l_14_0._sorted[1]
						if l_14_2 == nil then
							return 
						end
					end
					if l_14_2.next == nil then
						table.remove(l_14_0._sorted, 1)
					end
					if l_14_0._t < l_14_2.next then
						return 
					end
				end
				table.remove(l_14_0._sorted, 1)
				l_14_2.f(l_14_2, l_14_0._t)
				if l_14_2.times >= 0 then
					l_14_2.times = l_14_2.times - 1
				if l_14_2.times <= 0 then
					end
					l_14_2.next = nil
				end
				if l_14_2.next then
					l_14_2.next = l_14_2.next + l_14_2.interval
					l_14_0:__insert_sorted(l_14_2)
				end
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

over = function(l_15_0, l_15_1)
	while 1 do
		local l_15_2 = 0 + coroutine.yield()
		if l_15_0 <= l_15_2 then
			do break end
		end
		l_15_1(l_15_2 / l_15_0, l_15_2)
	end
	l_15_1(1, l_15_0)
end

seconds = function(l_16_0, l_16_1)
	if not l_16_1 then
		return seconds, l_16_0, 0
	end
	if l_16_0 and l_16_0 <= l_16_1 then
		return nil
	end
	local l_16_2 = coroutine.yield()
	l_16_1 = l_16_1 + l_16_2
	if l_16_0 and l_16_0 < l_16_1 then
		l_16_1 = l_16_0
	end
	if l_16_0 then
		return l_16_1, l_16_1 / l_16_0, l_16_2
	else
		return l_16_1, l_16_1, l_16_2
	end
end

wait = function(l_17_0)
	while 1 do
		 -- DECOMPILER ERROR: Confused about usage of registers!

	if 0 < l_17_0 then
		end
	end
	 -- WARNING: undefined locals caused missing assignments!
end


