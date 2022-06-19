if not ContextActionHudIdle then
	ContextActionHudIdle = class(FiniteStateMachineState)
end
ContextActionHudIdle.transition = function(l_1_0)
	if l_1_0.item:wants_to_show_new_text() then
		return ContextActionHudShow
	end
end

if not ContextActionHudShow then
	ContextActionHudShow = class(FiniteStateMachineState)
end
ContextActionHudShow.init = function(l_2_0)
	l_2_0._timer = 0
	if not l_2_0.item:wants_to_show_new_text() then
		return ContextActionHudIdle
	end
	l_2_0.item:construct_panel()
end

ContextActionHudShow.update = function(l_3_0, l_3_1)
	l_3_0._timer = l_3_0._timer + l_3_1
end

ContextActionHudShow.transition = function(l_4_0)
	return ContextActionHudShowReady
end

if not ContextActionHudShowReady then
	ContextActionHudShowReady = class(FiniteStateMachineState)
end
ContextActionHudShowReady.init = function(l_5_0)
	l_5_0._timer = 0
end

ContextActionHudShowReady.update = function(l_6_0, l_6_1)
	l_6_0._timer = l_6_0._timer + l_6_1
end

ContextActionHudShowReady.transition = function(l_7_0)
	if (not l_7_0.item._use_timeout or l_7_0._timer <= 4) and not l_7_0.item:wants_to_hide() then
		return 
	end
	return ContextActionHudDestroy
end

if not ContextActionHudDestroy then
	ContextActionHudDestroy = class(FiniteStateMachineState)
end
ContextActionHudDestroy.init = function(l_8_0)
	l_8_0.item:destroy_panel()
end

ContextActionHudDestroy.transition = function(l_9_0)
	return ContextActionHudIdle
end


