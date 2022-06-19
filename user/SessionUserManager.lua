SessionUserManager = SessionUserManager or class()
function SessionUserManager.init(A0_0, A1_1)
	local L2_2, L3_3, L4_4, L5_5, L6_6
	A0_0._users = L2_2
	A0_0._session_user_id_to_track_id = L2_2
	for L5_5, L6_6 in L2_2(L3_3) do
		A0_0._users[L5_5] = managers.local_user:user_from_user_index(L6_6)
	end
end
function SessionUserManager.default_data(A0_7)
	local L1_8
	L1_8 = {}
	A0_7.users = L1_8
	L1_8 = {}
	A0_7.session_user_id_to_track_id = L1_8
end
function SessionUserManager.save(A0_9, A1_10)
	A1_10.session_user_id_to_track_id = A0_9._session_user_id_to_track_id
	A1_10.users = {}
	for 