LocalSessionUserManager = LocalSessionUserManager or class()
function LocalSessionUserManager.init(A0_0, A1_1)
	local L2_2, L3_3, L4_4, L5_5, L6_6
	A0_0._users = L2_2
	for L5_5, L6_6 in L2_2(L3_3) do
		A0_0._users[managers.local_user:user_from_user_index(L6_6)] = managers.local_user:user_from_user_index(L6_6)
	end
end
function LocalSessionUserManager.default_data(A0_7)
	A0_7.users = {}
end
function LocalSessionUserManager.save(A0_8, A1_9)
	A1_9.users = {}
	for 