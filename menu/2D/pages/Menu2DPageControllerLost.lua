require("menu/2D/Menu2DPage")
Menu2DPageControllerLost = Menu2DPageControllerLost or class(Menu2DPageMessage)
function Menu2DPageControllerLost.open(A0_0, A1_1, A2_2, A3_3)
	local L4_4, L5_5, L6_6
	L4_4 = managers
	L4_4 = L4_4.menu
	L5_5 = L4_4
	L4_4 = L4_4.disconnected_controller_index
	L4_4 = L4_4(L5_5)
	L5_5, L6_6 = nil, nil
	if not L4_4 then
		L5_5 = ""
	else
		L4_4 = L4_4 + 1
		L6_6 = {NR = L4_4}
	end
	Menu2DPageMessage.open(A0_0, A1_1, A2_2, A3_3, L6_6, L5_5)
end
function Menu2DPageControllerLost.confirm_mode(A0_7)
	local L1_8
	return L1_8
end
