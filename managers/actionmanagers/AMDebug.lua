if not AMDebug then
	AMDebug = class(CoreActionElement)
end
AMDebug.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
	cat_debug("rail", l_1_0.message)
end

AMDebug.activate_now = function(l_2_0)
	local l_2_1 = "a"
	if l_2_0.clear_logfile == true then
		l_2_1 = "w"
	end
	local l_2_2 = File:open("data/settings/DebugHub.txt", l_2_1)
	Application:debug("DebugHub:", l_2_0.message)
	l_2_2:write("DebugHub:")
	l_2_2:write(l_2_0.message .. "\n")
	l_2_2:close()
	l_2_0:deactivate_now()
end


