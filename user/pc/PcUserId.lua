PcUserId = PcUserId or class()
PcUserId._next_id = 0
function PcUserId.init(A0_0, A1_1)
	local L2_2, L3_3
	if A1_1 then
		A0_0.user_id = A1_1
	else
		L2_2 = PcUserId
		L3_3 = PcUserId
		L3_3 = L3_3._next_id
		L3_3 = L3_3 + 1
		L2_2._next_id = L3_3
		L2_2 = PcUserId
		L2_2 = L2_2._next_id
		A0_0.user_id = L2_2
	end
end
function PcUserId.key(A0_4)
	local L1_5
	L1_5 = A0_4.user_id
	return L1_5
end
