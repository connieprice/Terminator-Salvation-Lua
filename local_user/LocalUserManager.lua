require("local_user/LocalUser")
LocalUserManager = LocalUserManager or class()
function LocalUserManager.init(A0_0, A1_1)
	local L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8
	A0_0._users = L2_2
	for L5_5, L6_6 in L2_2(L3_3) do
		L7_7 = A1_1.controller_index
		L7_7 = L7_7[L6_6]
		L8_8 = managers
		L8_8 = L8_8.controller
		L8_8 = L8_8.create_controller
		L8_8 = L8_8(L8_8, nil, L7_7)
		A0_0._users[L6_6] = LocalUser:new(A1_1.users[L6_6], L6_6, L8_8, L7_7)
	end
	A0_0._user_index_to_player_slot_id = L2_2
end
function LocalUserManager.default_data(A0_9)
	local L1_10
	L1_10 = {}
	A0_9.user_indexes = L1_10
	L1_10 = {}
	A0_9.user_index_to_player_slot_id = L1_10
	L1_10 = {}
	A0_9.users = L1_10
end
function LocalUserManager.save(A0_11, A1_12)
	A1_12.user_index_to_player_slot_id = A0_11._user_index_to_player_slot_id
	A1_12.user_indexes = {}
	A1_12.users = {}
	A1_12.controller_index = {}
	for 