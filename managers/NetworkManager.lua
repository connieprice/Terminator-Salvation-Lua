require("network/Host")
require("network/Peer")
if not NetworkManager then
	NetworkManager = class()
end
NetworkManager.init = function(l_1_0, l_1_1)
	l_1_0._host = Host:new()
	l_1_0._peer = Peer:new()
end

NetworkManager.destroy = function(l_2_0)
	l_2_0:stop_hosting()
	l_2_0._peer:destroy()
	l_2_0._peer = nil
	l_2_0._host:destroy()
	l_2_0._host = nil
end

NetworkManager.update = function(l_3_0, l_3_1)
	if l_3_0._host then
		l_3_0._host:update(l_3_1)
	end
	if l_3_0._peer then
		l_3_0._peer:update(l_3_1)
	end
end

NetworkManager.save = function(l_4_0, l_4_1)
	l_4_1.host = {}
	l_4_0._host:save(l_4_1.host)
	l_4_1.peer = {}
	l_4_0._peer:save(l_4_1.peer)
end

NetworkManager.load = function(l_5_0, l_5_1)
	l_5_0._host = Host:new()
	l_5_0._host:load(l_5_1.host)
	l_5_0._peer = Peer
	l_5_0._peer:load(l_5_1.peer)
end

NetworkManager.wants_to_load_world = function(l_6_0)
	local l_6_1, l_6_2 = l_6_0._peer:wants_to_load_world, l_6_0._peer
	return l_6_1(l_6_2)
end

NetworkManager.ack_load_world = function(l_7_0)
	l_7_0._peer:ack_load_world()
end

NetworkManager.host = function(l_8_0)
	return l_8_0._host
end

NetworkManager.peer = function(l_9_0)
	return l_9_0._peer
end

NetworkManager.start_hosting = function(l_10_0)
	l_10_0._host:session_provider():received_ownership()
end

NetworkManager.stop_hosting = function(l_11_0)
	l_11_0._host:session_provider():lost_ownership()
end


