if not SpiderState then
	SpiderState = class()
end
SpiderState.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._can_move = true
	l_1_0._can_rotate = true
	l_1_0._emitter = managers.action_event:create_emitter(l_1_0._unit)
	l_1_0._base = l_1_1:base()
end

SpiderState.leave = function(l_2_0)
	l_2_0._emitter:destroy()
end

SpiderState._set_can_move = function(l_3_0, l_3_1)
	l_3_0._can_move = l_3_1
end

SpiderState._set_can_rotate = function(l_4_0, l_4_1)
	l_4_0._can_rotate = l_4_1
end

SpiderState.can_move = function(l_5_0)
	return l_5_0._can_move
end

SpiderState.can_rotate = function(l_6_0)
	return l_6_0._can_rotate
end

SpiderState._request_stun = function(l_7_0)
	local l_7_1 = "stun" .. math.random(1, 4)
	l_7_0._unit:play_redirect(l_7_1)
end

SpiderState._request_scan = function(l_8_0)
	l_8_0._unit:play_redirect("scan")
end

SpiderState.update = function(l_9_0)
end


