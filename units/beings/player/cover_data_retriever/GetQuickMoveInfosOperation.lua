require("shared/scheduler/Operation")
if not GetQuickMoveInfosOperation then
	GetQuickMoveInfosOperation = class(Operation)
end
GetQuickMoveInfosOperation.init = function(l_1_0, l_1_1)
	assert(l_1_1)
	l_1_0._cover = l_1_1
	l_1_0.quick_move_infos = nil
end

GetQuickMoveInfosOperation.start = function(l_2_0)
	l_2_0.quick_move_infos = managers.cover_util:quick_move_infos(l_2_0._cover)
	l_2_0._done = true
end

GetQuickMoveInfosOperation.done = function(l_3_0)
	return l_3_0._done
end


