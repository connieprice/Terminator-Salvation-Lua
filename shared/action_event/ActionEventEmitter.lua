if not ActionEventEmitter then
	ActionEventEmitter = {}
end
ActionEventEmitter.new = function(l_1_0, l_1_1)
	local l_1_2 = {}
	l_1_2.unit = l_1_1
	l_1_2.name = l_1_0
	l_1_2._listener_data = {}
	l_1_2._continuous_events = {}
	local l_1_3 = {}
	l_1_2.destroy = function(l_2_0)
		managers.action_event:_destroy_emitter(l_2_0)
  end
	l_1_3.__index = function(l_3_0, l_3_1, ...)
		if l_3_1:sub(-6) == "_start" then
			l_3_0[l_3_1] = function(l_4_0, l_4_1, ...)
			-- upvalues: l_2_1
			managers.action_event:_start_event(l_4_1, l_4_0, l_2_1, ...)
    end
		else
			if l_3_1:sub(-5) == "_stop" then
				l_3_0[l_3_1] = function(l_5_0, l_5_1, ...)
			-- upvalues: l_2_1
			managers.action_event:_stop_event(l_5_1, l_5_0, l_2_1, ...)
    end
			end
		else
			if l_3_1:sub(-7) == "_change" then
				l_3_0[l_3_1] = function(l_6_0, l_6_1, ...)
			-- upvalues: l_2_1
			managers.action_event:_change_event(l_6_1, l_6_0, l_2_1, ...)
    end
			end
		else
			if l_3_1:sub(1, 5) == "unit_" then
				l_3_0[l_3_1] = function(l_7_0, l_7_1, ...)
			-- upvalues: l_2_1
			managers.action_event:_call_unit_event(l_7_1, l_7_0, l_2_1, ...)
    end
			end
		else
			l_3_0[l_3_1] = function(l_8_0, ...)
			-- upvalues: l_2_1
			managers.action_event:_fire_event(l_8_0, l_2_1, ...)
    end
		end
		return l_3_0[l_3_1]
  end
	setmetatable(l_1_2, l_1_3)
	return l_1_2
end


