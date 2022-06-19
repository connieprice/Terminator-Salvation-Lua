SpiderState = SpiderState or class()
function SpiderState.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._can_move = true
	A0_0._can_rotate = true
	A0_0._emitter = managers.action_event:create_emitter(A0_0._unit)
	A0_0._base = A1_1:base()
end
function SpiderState.leave(A0_2)
	A0_2._emitter:destroy()
end
function SpiderState._set_can_move(A0_3, A1_4)
	A0_3._can_move = A1_4
end
function SpiderState._set_can_rotate(A0_5, A1_6)
	A0_5._can_rotate = A1_6
end
function SpiderState.can_move(A0_7)
	local L1_8
	L1_8 = A0_7._can_move
	return L1_8
end
function SpiderState.can_rotate(A0_9)
	local L1_10
	L1_10 = A0_9._can_rotate
	return L1_10
end
function SpiderState._request_stun(A0_11)
	local L1_12
	L1_12 = "stun"
	L1_12 = L1_12 .. math.random(1, 4)
	A0_11._unit:play_redirect(L1_12)
end
function SpiderState._request_scan(A0_13)
	A0_13._unit:play_redirect("scan")
end
function SpiderState.update(A0_14)
	local L1_15
end
