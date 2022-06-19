require("shared/SharedMath")
require("ai/common/NavigationGraphUtilities")
require("shared/SharedMath")
MovementPathUtilities = MovementPathUtilities or {}
function MovementPathUtilities.should_recalculate_path(A0_0, A1_1)
	local L2_2, L3_3
	L3_3 = A0_0
	L2_2 = A0_0.ai_data
	L2_2 = L2_2(L3_3)
	L3_3 = L2_2.path
	L3_3 = L3_3(L2_2)
	if not L3_3 then
		L3_3 = true
		return L3_3
	end
	L3_3 = L2_2.new_path_requested
	L3_3 = L3_3(L2_2)
	if L3_3 then
		L3_3 = true
		return L3_3
	end
	if A1_1 then
		L3_3 = L2_2._behavior
		L3_3 = L3_3.latest_target_position
		if L3_3 == nil then
			L3_3 = L2_2._behavior
			L3_3.latest_target_position = A1_1
			L3_3 = true
			return L3_3
		end
		L3_3 = mvector3
		L3_3 = L3_3.distance
		L3_3 = L3_3(L2_2._behavior.latest_target_position, A1_1)
		if L3_3 / mvector3.distance(A0_0:position(), A1_1) > 0.2 then
			L2_2._behavior.latest_target_position = A1_1
			return true
		end
	end
	L3_3 = L2_2.input
	L3_3 = L3_3.moving_to_position
	if L3_3 and not NavigationGraphUtilities.ai_check_can_move_there(A0_0, L3_3, nil, nil, true) then
		return true
	end
	return false
end
function MovementPathUtilities.path_length(A0_4, A1_5)
	local L2_6, L3_7, L4_8, L5_9, L6_10, L7_11, L8_12
	L2_6 = A0_4
	L3_7 = 0
	for L7_11, L8_12 in L4_8(L5_9) do
		L3_7 = L3_7 + mvector3.distance(L8_12, L2_6)
		L2_6 = L8_12
	end
	return L3_7
end
function MovementPathUtilities.remaining_path(A0_13)
	local L1_14, L2_15, L3_16, L4_17, L5_18
	L2_15 = A0_13
	L1_14 = A0_13.ai_data
	L1_14 = L1_14(L2_15)
	L3_16 = L1_14
	L2_15 = L1_14.path
	L2_15 = L2_15(L3_16)
	if L2_15 then
		L4_17 = L1_14
		L3_16 = L1_14.new_path_requested
		L3_16 = L3_16(L4_17)
	elseif L3_16 then
		L3_16 = nil
		return L3_16
	end
	L3_16 = L1_14.input
	L3_16 = L3_16.moving_to_position
	if not L3_16 then
		return L2_15
	end
	L4_17 = MovementPathUtilities
	L4_17 = L4_17.next_index
	L5_18 = L2_15
	L4_17 = L4_17(L5_18, L3_16)
	if L4_17 == 1 then
		return L2_15
	end
	L5_18 = {}
	for _FORV_9_ = L4_17 + 1, #L2_15 do
		table.insert(L5_18, L2_15[_FORV_9_])
	end
	if _FOR_ == 0 then
		return nil
	end
	return L5_18
end
function MovementPathUtilities.has_arrived(A0_19, A1_20)
	return 0.25 * A0_19:oobb():size().y > mvector3.distance(A0_19:position(), A1_20)
end
function MovementPathUtilities.next_index(A0_21, A1_22)
	for 