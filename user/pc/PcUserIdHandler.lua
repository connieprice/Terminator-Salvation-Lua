require("user/pc/PcUserId")
PcUserIdHandler = PcUserIdHandler or class()
function PcUserIdHandler.init(A0_0)
	Network:set_receiver("PcUserIdHandler", A0_0)
	A0_0._next_local_id = 0
	A0_0._user_id_to_pc_user_id = {}
end
function PcUserIdHandler.send_id(A0_1, A1_2, A2_3)
	local L3_4
	L3_4 = A0_1.user_id_from_platform_specific_user_id
	L3_4 = L3_4(A0_1, A2_3)
	if not L3_4 then
		A0_1._next_local_id = A0_1._next_local_id + 1
		L3_4 = A0_1._next_local_id
		A0_1._user_id_to_pc_user_id[L3_4] = A2_3
	end
	A1_2:set_id_to_pc_user_id_lookup(L3_4, A2_3.user_id)
end
function PcUserIdHandler.set_id_to_pc_user_id_lookup(A0_5, A1_6, A2_7, A3_8)
	A0_5._user_id_to_pc_user_id[A1_6] = PcUserId:new(A2_7)
end
function PcUserIdHandler.user_id_from_platform_specific_user_id(A0_9, A1_10)
	local L2_11
	for 