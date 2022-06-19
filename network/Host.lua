require("network/session_finder/SessionProvider")
if not Host then
	Host = class()
end
Host.init = function(l_1_0)
	l_1_0._session_provider = SessionProvider:new()
	Network:set_receiver("Host", l_1_0)
end

Host.destroy = function(l_2_0)
	l_2_0._session_provider:destroy()
	l_2_0._session_provider = nil
end

Host.save = function(l_3_0, l_3_1)
	l_3_0._session_provider:save(l_3_1)
end

Host.load = function(l_4_0, l_4_1)
	l_4_0._session_provider:load(l_4_1)
end

Host.update = function(l_5_0, l_5_1)
	l_5_0._session_provider:update(l_5_1)
end

Host.session_provider = function(l_6_0)
	return l_6_0._session_provider
end


