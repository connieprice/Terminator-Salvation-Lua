require("network/session_finder/SessionProvider")
Host = Host or class()
function Host.init(A0_0)
	A0_0._session_provider = SessionProvider:new()
	Network:set_receiver("Host", A0_0)
end
function Host.destroy(A0_1)
	A0_1._session_provider:destroy()
	A0_1._session_provider = nil
end
function Host.save(A0_2, A1_3)
	A0_2._session_provider:save(A1_3)
end
function Host.load(A0_4, A1_5)
	A0_4._session_provider:load(A1_5)
end
function Host.update(A0_6, A1_7)
	A0_6._session_provider:update(A1_7)
end
function Host.session_provider(A0_8)
	local L1_9
	L1_9 = A0_8._session_provider
	return L1_9
end
