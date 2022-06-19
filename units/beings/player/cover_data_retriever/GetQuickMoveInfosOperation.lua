require("shared/scheduler/Operation")
GetQuickMoveInfosOperation = GetQuickMoveInfosOperation or class(Operation)
function GetQuickMoveInfosOperation.init(A0_0, A1_1)
	assert(A1_1)
	A0_0._cover = A1_1
	A0_0.quick_move_infos = nil
end
function GetQuickMoveInfosOperation.start(A0_2)
	A0_2.quick_move_infos = managers.cover_util:quick_move_infos(A0_2._cover)
	A0_2._done = true
end
function GetQuickMoveInfosOperation.done(A0_3)
	local L1_4
	L1_4 = A0_3._done
	return L1_4
end
