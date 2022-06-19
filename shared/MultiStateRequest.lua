MultiStateRequest = MultiStateRequest or class()
function MultiStateRequest.init(A0_0)
	A0_0._request_states = {}
end
function MultiStateRequest.request(A0_1, A1_2, A2_3)
	A0_1._request_states[A1_2] = A2_3
end
function MultiStateRequest.wants_enabled_state(A0_4)
	for 