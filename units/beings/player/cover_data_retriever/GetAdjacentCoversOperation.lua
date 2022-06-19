require("shared/scheduler/Operation")
GetAdjacentCoversOperation = GetAdjacentCoversOperation or class(Operation)
function GetAdjacentCoversOperation.init(A0_0, A1_1)
	assert(A1_1)
	A0_0._cover = A1_1
	A0_0.left_cover = nil
	A0_0.right_cover = nil
end
function GetAdjacentCoversOperation.start(A0_2)
	A0_2.left_cover, A0_2.right_cover = managers.cover_util:get_adjacent_covers(A0_2._cover)
	A0_2._done = true
end
function GetAdjacentCoversOperation.done(A0_3)
	local L1_4
	L1_4 = A0_3._done
	return L1_4
end
