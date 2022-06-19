require("network/session_finder/SessionReceiver")
if not LanSessionFinder then
	LanSessionFinder = class()
end
LanSessionFinder.init = function(l_1_0)
	l_1_0._broadcaster = Network:broadcast(tweak_data.network.SERVER_PORT)
	cat_print("pebj", "Binding LanSessionFinder to port " .. tweak_data.network.ANY_PORT)
	l_1_0._session_receiver = SessionReceiver:new()
	Network:bind(tweak_data.network.SERVER_PORT, l_1_0._session_receiver)
	l_1_0._timer = 0
	l_1_0._finder_timer = 0
end

LanSessionFinder.send_find_sessions = function(l_2_0)
	cat_print("pebj", "sending find_sessions")
	l_2_0._broadcaster:faith_find_session(tweak_data.network.VERSION)
end

LanSessionFinder.update = function(l_3_0, l_3_1)
	if l_3_0:is_done() then
		return 
	end
	l_3_0._timer = l_3_0._timer + l_3_1
	l_3_0._finder_timer = l_3_0._finder_timer + l_3_1
	if l_3_0._finder_timer < tweak_data.network.LAN_SESSION_FINDER_TIME then
		return 
	end
	l_3_0:send_find_sessions()
	l_3_0._finder_timer = 0
end

LanSessionFinder.is_done = function(l_4_0)
	return tweak_data.network.LAN_SESSION_DISCOVERY_TIME <= l_4_0._timer
end

LanSessionFinder.session_infos = function(l_5_0)
	local l_5_1, l_5_2 = l_5_0._session_receiver:session_infos, l_5_0._session_receiver
	return l_5_1(l_5_2)
end


