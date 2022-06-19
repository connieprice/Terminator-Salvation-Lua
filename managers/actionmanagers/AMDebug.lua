AMDebug = AMDebug or class(CoreActionElement)
function AMDebug.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
	cat_debug("rail", A0_0.message)
end
function AMDebug.activate_now(A0_3)
	local L1_4
	L1_4 = "a"
	if A0_3.clear_logfile == true then
		L1_4 = "w"
	end
	Application:debug("DebugHub:", A0_3.message)
	File:open("data/settings/DebugHub.txt", L1_4):write("DebugHub:")
	File:open("data/settings/DebugHub.txt", L1_4):write(A0_3.message .. "\n")
	File:open("data/settings/DebugHub.txt", L1_4):close()
	A0_3:deactivate_now()
end
