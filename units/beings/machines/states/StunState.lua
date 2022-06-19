if not StunState then
	StunState = class()
end
StunState.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._unit = l_1_1
	l_1_0._stun_time = l_1_3
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
	l_1_0._time_being_stunned = 0
	l_1_0._previous_redirect = l_1_2
	l_1_0._emitter = managers.action_event:create_emitter(l_1_1)
	l_1_0._emitter:unit_stun_enter(l_1_0._unit)
	l_1_0._emitter:stun_enter(l_1_0._unit)
end

StunState.enter = function(l_2_0)
end

StunState.leave = function(l_3_0)
	l_3_0._emitter:unit_stun_exit(l_3_0._unit)
	l_3_0._emitter:destroy()
end

StunState.update = function(l_4_0, l_4_1)
	l_4_0._time_being_stunned = l_4_0._time_being_stunned + l_4_1
	if l_4_0._stun_time < l_4_0._time_being_stunned then
		if not l_4_0._previous_redirect then
			return false
		end
		local l_4_2 = l_4_0._unit:play_redirect(l_4_0._previous_redirect)
		assert(l_4_2, "No redirect found: " .. l_4_0._previous_redirect)
	end
	if not l_4_0._enemy_data.is_stunned then
		return false
	end
	return true
end


