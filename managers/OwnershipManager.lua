if not OwnershipManager then
	OwnershipManager = class()
end
OwnershipManager.init = function(l_1_0)
end

OwnershipManager.owner_rpc = function(l_2_0, l_2_1)
	return managers.network:peer():host_rpc()
end

OwnershipManager.interested_rpc = function(l_3_0, l_3_1)
	return managers.network:peer():peers_rpc()
end

OwnershipManager.is_owner = function(l_4_0, l_4_1)
	return true
end


