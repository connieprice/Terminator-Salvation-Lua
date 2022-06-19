if not SessionReceiver then
	SessionReceiver = class()
end
SessionReceiver.init = function(l_1_0)
	l_1_0._sessions = {}
	Network:set_receiver("SessionReceiver", l_1_0)
end

SessionReceiver.faith_session_info = function(l_2_0, l_2_1, l_2_2)
	cat_print("pebj", "Received Session Info")
	l_2_1.rpc_sender = l_2_2
	l_2_0._sessions[l_2_1.name] = l_2_1
end

SessionReceiver.session_infos = function(l_3_0)
	return l_3_0._sessions
end


