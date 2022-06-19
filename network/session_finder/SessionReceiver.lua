SessionReceiver = SessionReceiver or class()
function SessionReceiver.init(A0_0)
	A0_0._sessions = {}
	Network:set_receiver("SessionReceiver", A0_0)
end
function SessionReceiver.faith_session_info(A0_1, A1_2, A2_3)
	cat_print("pebj", "Received Session Info")
	A1_2.rpc_sender = A2_3
	A0_1._sessions[A1_2.name] = A1_2
end
function SessionReceiver.session_infos(A0_4)
	local L1_5
	L1_5 = A0_4._sessions
	return L1_5
end
