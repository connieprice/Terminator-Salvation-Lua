require("network/Host")
require("network/Peer")
NetworkManager = NetworkManager or class()
function NetworkManager.init(A0_0, A1_1)
	A0_0._host = Host:new()
	A0_0._peer = Peer:new()
end
function NetworkManager.destroy(A0_2)
	A0_2:stop_hosting()
	A0_2._peer:destroy()
	A0_2._peer = nil
	A0_2._host:destroy()
	A0_2._host = nil
end
function NetworkManager.update(A0_3, A1_4)
	if A0_3._host then
		A0_3._host:update(A1_4)
	end
	if A0_3._peer then
		A0_3._peer:update(A1_4)
	end
end
function NetworkManager.save(A0_5, A1_6)
	A1_6.host = {}
	A0_5._host:save(A1_6.host)
	A1_6.peer = {}
	A0_5._peer:save(A1_6.peer)
end
function NetworkManager.load(A0_7, A1_8)
	A0_7._host = Host:new()
	A0_7._host:load(A1_8.host)
	A0_7._peer = Peer
	A0_7._peer:load(A1_8.peer)
end
function NetworkManager.wants_to_load_world(A0_9)
	return A0_9._peer:wants_to_load_world()
end
function NetworkManager.ack_load_world(A0_10)
	A0_10._peer:ack_load_world()
end
function NetworkManager.host(A0_11)
	local L1_12
	L1_12 = A0_11._host
	return L1_12
end
function NetworkManager.peer(A0_13)
	local L1_14
	L1_14 = A0_13._peer
	return L1_14
end
function NetworkManager.start_hosting(A0_15)
	A0_15._host:session_provider():received_ownership()
end
function NetworkManager.stop_hosting(A0_16)
	A0_16._host:session_provider():lost_ownership()
end
