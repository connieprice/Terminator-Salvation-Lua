local L0_0
L0_0 = core
L0_0 = L0_0.module
L0_0(L0_0, "CoreEvent")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreClass")
function L0_0(A0_1, A1_2, A2_3, A3_4)
	local L4_5
	if A1_2 and A2_3 then
		L4_5 = A1_2[A2_3]
		if L4_5 then
			if A3_4 ~= nil then
				if A0_1 then
					function L4_5(...)
						local L3_7, L4_8
						L3_7 = _UPVALUE0_
						L4_8 = _UPVALUE1_
						L3_7 = L3_7[L4_8]
						L4_8 = _UPVALUE2_
						return L3_7(L4_8, _UPVALUE3_, ...)
					end
					return L4_5
				else
					function L4_5(...)
						local L3_10
						L3_10 = _UPVALUE0_
						L3_10 = L3_10[_UPVALUE1_]
						return L3_10(_UPVALUE2_, ...)
					end
					return L4_5
				end
			elseif A0_1 then
				function L4_5(...)
					local L3_12
					L3_12 = _UPVALUE0_
					L3_12 = L3_12[_UPVALUE1_]
					return L3_12(_UPVALUE2_, ...)
				end
				return L4_5
			else
				function L4_5(...)
					return _UPVALUE0_[_UPVALUE1_](...)
				end
				return L4_5
			end
		end
	elseif A1_2 then
		L4_5 = A1_2 and L4_5(getmetatable(A1_2) or A1_2)
		error("Callback on class \"" .. tostring(L4_5) .. "\" refers to a non-existing function \"" .. tostring(A2_3) .. "\".")
	elseif A2_3 then
		L4_5 = error
		L4_5("Callback to function \"" .. tostring(A2_3) .. "\" is on a nil class.")
	else
		L4_5 = error
		L4_5("Callback class and function was nil.")
	end
end
callback = L0_0
L0_0 = 0
function get_ticket(A0_14)
	local L1_15
	L1_15 = {
		A0_14,
		math.random(A0_14 - 1)
	}
	return L1_15
end
function valid_ticket(A0_16)
	local L1_17, L2_18
	L1_17 = _UPVALUE0_
	L2_18 = A0_16[1]
	L1_17 = L1_17 % L2_18
	L2_18 = A0_16[2]
	L1_17 = L1_17 == L2_18
	return L1_17
end
function update_tickets()
	local L0_19, L1_20
	L0_19 = _UPVALUE0_
	L0_19 = L0_19 + 1
	_UPVALUE0_ = L0_19
	L0_19 = _UPVALUE0_
	if L0_19 > 30 then
		L0_19 = 0
		_UPVALUE0_ = L0_19
	end
end
BasicEventHandling = {}
function BasicEventHandling.connect(A0_21, A1_22, A2_23, A3_24)
	local L4_25
	L4_25 = A0_21._event_callbacks
	L4_25 = L4_25 or {}
	A0_21._event_callbacks = L4_25
	L4_25 = A0_21._event_callbacks
	L4_25[A1_22] = A0_21._event_callbacks[A1_22] or {}
	function L4_25(...)
		local L1_27, L2_28, L3_29
		L1_27 = _UPVALUE0_
		L2_28 = _UPVALUE1_
		L3_29 = ...
		L1_27(L2_28, L3_29)
	end
	table.insert(A0_21._event_callbacks[A1_22], L4_25)
	return L4_25
end
function BasicEventHandling.disconnect(A0_30, A1_31, A2_32)
	if A0_30._event_callbacks and A0_30._event_callbacks[A1_31] then
		table.delete(A0_30._event_callbacks[A1_31], A2_32)
		if table.empty(A0_30._event_callbacks[A1_31]) then
			A0_30._event_callbacks[A1_31] = nil
			if table.empty(A0_30._event_callbacks) then
				A0_30._event_callbacks = nil
			end
		end
	end
end
function BasicEventHandling._has_callbacks_for_event(A0_33, A1_34)
	local L2_35
	L2_35 = A0_33._event_callbacks
	L2_35 = L2_35 ~= nil and L2_35 ~= nil
	return L2_35
end
function BasicEventHandling._send_event(A0_36, A1_37, ...)
	local L3_39, L4_40, L5_41, L6_42, L7_43
	if L3_39 then
		for L6_42, L7_43 in L3_39(L4_40) do
			L7_43(...)
		end
	end
end
CallbackHandler = CallbackHandler or CoreClass.class()
function CallbackHandler.init(A0_44)
	A0_44:clear()
end
function CallbackHandler.clear(A0_45)
	A0_45._t = 0
	A0_45._sorted = {}
end
function CallbackHandler.__insert_sorted(A0_46, A1_47)
	local L2_48
	L2_48 = 1
	while A0_46._sorted[L2_48] and (A0_46._sorted[L2_48].next == nil or A1_47.next > A0_46._sorted[L2_48].next) do
		L2_48 = L2_48 + 1
	end
	table.insert(A0_46._sorted, L2_48, A1_47)
end
function CallbackHandler.add(A0_49, A1_50, A2_51, A3_52)
	local L4_53
	A3_52 = A3_52 or -1
	L4_53 = {}
	L4_53.f = A1_50
	L4_53.interval = A2_51
	L4_53.times = A3_52
	L4_53.next = A0_49._t + A2_51
	A0_49:__insert_sorted(L4_53)
	return L4_53
end
function CallbackHandler.remove(A0_54, A1_55)
	if A1_55 then
		A1_55.next = nil
	end
end
function CallbackHandler.update(A0_56, A1_57)
	local L2_58
	L2_58 = A0_56._t
	L2_58 = L2_58 + A1_57
	A0_56._t = L2_58
	while true do
		L2_58 = A0_56._sorted
		L2_58 = L2_58[1]
		if L2_58 == nil then
			return
		elseif L2_58.next == nil then
			table.remove(A0_56._sorted, 1)
		elseif L2_58.next > A0_56._t then
			return
		else
			table.remove(A0_56._sorted, 1)
			L2_58.f(L2_58, A0_56._t)
			if L2_58.times >= 0 then
				L2_58.times = L2_58.times - 1
				if L2_58.times <= 0 then
					L2_58.next = nil
				end
			end
			if L2_58.next then
				L2_58.next = L2_58.next + L2_58.interval
				A0_56:__insert_sorted(L2_58)
			end
		end
	end
end
function over(A0_59, A1_60)
	local L2_61
	L2_61 = 0
	while true do
		L2_61 = L2_61 + coroutine.yield()
		if A0_59 <= L2_61 then
			break
		end
		A1_60(L2_61 / A0_59, L2_61)
	end
	A1_60(1, A0_59)
end
function seconds(A0_62, A1_63)
	local L2_64
	if not A1_63 then
		L2_64 = seconds
		return L2_64, A0_62, 0
	end
	if A0_62 and A0_62 <= A1_63 then
		L2_64 = nil
		return L2_64
	end
	L2_64 = coroutine
	L2_64 = L2_64.yield
	L2_64 = L2_64()
	A1_63 = A1_63 + L2_64
	if A0_62 and A0_62 < A1_63 then
		A1_63 = A0_62
	end
	if A0_62 then
		return A1_63, A1_63 / A0_62, L2_64
	else
		return A1_63, A1_63, L2_64
	end
end
function wait(A0_65)
	local L1_66
	L1_66 = 0
	while A0_65 > L1_66 do
		L1_66 = L1_66 + coroutine.yield()
	end
end
