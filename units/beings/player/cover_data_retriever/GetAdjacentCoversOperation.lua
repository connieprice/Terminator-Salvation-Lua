require("shared/scheduler/Operation")
if not GetAdjacentCoversOperation then
	GetAdjacentCoversOperation = class(Operation)
end
GetAdjacentCoversOperation.init = function(l_1_0, l_1_1)
	assert(l_1_1)
	l_1_0._cover = l_1_1
	l_1_0.left_cover = nil
	l_1_0.right_cover = nil
end

GetAdjacentCoversOperation.start = function(l_2_0)
	local l_2_1 = managers.cover_util:get_adjacent_covers(l_2_0._cover)
	l_2_0.right_cover = managers.cover_util
	l_2_0.left_cover = l_2_1
	l_2_0._done = true
end

GetAdjacentCoversOperation.done = function(l_3_0)
	return l_3_0._done
end


