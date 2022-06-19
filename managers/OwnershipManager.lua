OwnershipManager = OwnershipManager or class()
function OwnershipManager.init(A0_0)
	local L1_1
end
function OwnershipManager.owner_rpc(A0_2, A1_3)
	return (managers.network:peer():host_rpc())
end
function OwnershipManager.interested_rpc(A0_4, A1_5)
	return (managers.network:peer():peers_rpc())
end
function OwnershipManager.is_owner(A0_6, A1_7)
	local L2_8
	L2_8 = true
	return L2_8
end
