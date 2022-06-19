require("network/session_finder/SessionClient")
SessionProvider = SessionProvider or class()
function SessionProvider.init(A0_0)
	Network:bind_callback(A0_0)
	Network:set_server(false)
	Network:set_receiver("SessionProvider", A0_0)
	A0_0:clear()
end
function SessionProvider.destroy(A0_1)
	Network:unbind_callback()
end
function SessionProvider.save(A0_2, A1_3)
	local L2_4
	L2_4 = A0_2._level_instance_id
	A1_3.level_instance_id = L2_4
	L2_4 = A0_2._level_name
	A1_3.level_name = L2_4
	L2_4 = 1
	A1_3.session_peer_data = {}
	for 