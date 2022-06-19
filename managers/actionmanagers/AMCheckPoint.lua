if not AMCheckPoint then
	AMCheckPoint = class(CoreActionElement)
end
AMCheckPoint.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
	managers.world:add_checkpoint(l_1_0)
end

AMCheckPoint.activate_now = function(l_2_0)
	local l_2_1 = l_2_0.checkpoint
	assert(l_2_0.checkpoint_index)
	managers.save:save_progress(l_2_0.checkpoint_index)
	l_2_0:deactivate_now()
end


