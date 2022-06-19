StunState = StunState or class()
function StunState.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._unit = A1_1
	A0_0._stun_time = A3_3
	A0_0._enemy_data = A0_0._unit:enemy_data()
	A0_0._time_being_stunned = 0
	A0_0._previous_redirect = A2_2
	A0_0._emitter = managers.action_event:create_emitter(A1_1)
	A0_0._emitter:unit_stun_enter(A0_0._unit)
	A0_0._emitter:stun_enter(A0_0._unit)
end
function StunState.enter(A0_4)
	local L1_5
end
function StunState.leave(A0_6)
	A0_6._emitter:unit_stun_exit(A0_6._unit)
	A0_6._emitter:destroy()
end
function StunState.update(A0_7, A1_8)
	local L2_9
	L2_9 = A0_7._time_being_stunned
	L2_9 = L2_9 + A1_8
	A0_7._time_being_stunned = L2_9
	L2_9 = A0_7._time_being_stunned
	if L2_9 > A0_7._stun_time then
		L2_9 = A0_7._previous_redirect
		if not L2_9 then
			L2_9 = false
			return L2_9
		end
		L2_9 = A0_7._unit
		L2_9 = L2_9.play_redirect
		L2_9 = L2_9(L2_9, A0_7._previous_redirect)
		assert(L2_9, "No redirect found: " .. A0_7._previous_redirect)
	end
	L2_9 = A0_7._enemy_data
	L2_9 = L2_9.is_stunned
	if not L2_9 then
		L2_9 = false
		return L2_9
	end
	L2_9 = true
	return L2_9
end
