PortalManager = PortalManager or class(CorePortalManager)
function PortalManager.init(A0_0)
	CorePortalManager.init(A0_0)
end
function PortalManager.use_position(A0_1)
	local L1_2, L2_3, L3_4, L4_5, L5_6, L6_7, L7_8
	L1_2 = script_debug
	L1_2 = L1_2._freeflight
	if L1_2 then
		L1_2 = script_debug
		L1_2 = L1_2._freeflight
		L1_2 = L1_2.in_focus
		L1_2 = L1_2(L2_3)
	end
	if L1_2 then
		return L2_3(L3_4)
	else
		L7_8 = L3_4(L4_5)
		for L5_6, L6_7 in L2_3(L3_4, L4_5, L5_6, L6_7, L7_8, L3_4(L4_5)) do
			L7_8 = L6_7.user
			L7_8 = L7_8(L6_7)
			if L7_8 and managers.user_viewport and managers.user_viewport:viewport(L7_8) then
				return managers.user_viewport:viewport(L7_8):engine_camera():position()
			end
		end
	end
end
