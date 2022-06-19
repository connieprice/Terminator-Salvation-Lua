ContextActionHudIdle = ContextActionHudIdle or class(FiniteStateMachineState)
function ContextActionHudIdle.transition(A0_0)
	if A0_0.item:wants_to_show_new_text() then
		return ContextActionHudShow
	end
end
ContextActionHudShow = ContextActionHudShow or class(FiniteStateMachineState)
function ContextActionHudShow.init(A0_1)
	A0_1._timer = 0
	if not A0_1.item:wants_to_show_new_text() then
		return ContextActionHudIdle
	end
	A0_1.item:construct_panel()
end
function ContextActionHudShow.update(A0_2, A1_3)
	local L2_4
	L2_4 = A0_2._timer
	L2_4 = L2_4 + A1_3
	A0_2._timer = L2_4
end
function ContextActionHudShow.transition(A0_5)
	local L1_6
	L1_6 = ContextActionHudShowReady
	return L1_6
end
ContextActionHudShowReady = ContextActionHudShowReady or class(FiniteStateMachineState)
function ContextActionHudShowReady.init(A0_7)
	local L1_8
	A0_7._timer = 0
end
function ContextActionHudShowReady.update(A0_9, A1_10)
	local L2_11
	L2_11 = A0_9._timer
	L2_11 = L2_11 + A1_10
	A0_9._timer = L2_11
end
function ContextActionHudShowReady.transition(A0_12)
	if (not A0_12.item._use_timeout or A0_12._timer <= 4) and not A0_12.item:wants_to_hide() then
		return
	end
	return ContextActionHudDestroy
end
ContextActionHudDestroy = ContextActionHudDestroy or class(FiniteStateMachineState)
function ContextActionHudDestroy.init(A0_13)
	A0_13.item:destroy_panel()
end
function ContextActionHudDestroy.transition(A0_14)
	local L1_15
	L1_15 = ContextActionHudIdle
	return L1_15
end
