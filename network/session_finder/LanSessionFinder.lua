require("network/session_finder/SessionReceiver")
LanSessionFinder = LanSessionFinder or class()
function LanSessionFinder.init(A0_0)
	A0_0._broadcaster = Network:broadcast(tweak_data.network.SERVER_PORT)
	cat_print("pebj", "Binding LanSessionFinder to port " .. tweak_data.network.ANY_PORT)
	A0_0._session_receiver = SessionReceiver:new()
	Network:bind(tweak_data.network.SERVER_PORT, A0_0._session_receiver)
	A0_0._timer = 0
	A0_0._finder_timer = 0
end
function LanSessionFinder.send_find_sessions(A0_1)
	cat_print("pebj", "sending find_sessions")
	A0_1._broadcaster:faith_find_session(tweak_data.network.VERSION)
end
function LanSessionFinder.update(A0_2, A1_3)
	if A0_2:is_done() then
		return
	end
	A0_2._timer = A0_2._timer + A1_3
	A0_2._finder_timer = A0_2._finder_timer + A1_3
	if A0_2._finder_timer < tweak_data.network.LAN_SESSION_FINDER_TIME then
		return
	end
	A0_2:send_find_sessions()
	A0_2._finder_timer = 0
end
function LanSessionFinder.is_done(A0_4)
	local L2_5
	L2_5 = A0_4._timer
	L2_5 = L2_5 >= tweak_data.network.LAN_SESSION_DISCOVERY_TIME
	return L2_5
end
function LanSessionFinder.session_infos(A0_6)
	return A0_6._session_receiver:session_infos()
end
