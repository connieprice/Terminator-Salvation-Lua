AMCheckPoint = AMCheckPoint or class(CoreActionElement)
function AMCheckPoint.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
	managers.world:add_checkpoint(A0_0)
end
function AMCheckPoint.activate_now(A0_3)
	local L1_4
	L1_4 = A0_3.checkpoint
	assert(A0_3.checkpoint_index)
	managers.save:save_progress(A0_3.checkpoint_index)
	A0_3:deactivate_now()
end
