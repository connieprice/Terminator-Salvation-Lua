Menu2DPageControllerPCPlayer2 = Menu2DPageControllerPCPlayer2 or class(Menu2DPageControllerPC)
function Menu2DPageControllerPCPlayer2.init(A0_0, A1_1, A2_2)
	Menu2DPageControllerPC.init(A0_0, A1_1, A2_2)
end
function Menu2DPageControllerPCPlayer2.user(A0_3)
	local L1_4
	L1_4 = managers
	L1_4 = L1_4.player_slot
	L1_4 = L1_4.slot
	L1_4 = L1_4(L1_4, 2)
	assert(L1_4)
	return L1_4:user()
end
function Menu2DPageControllerPCPlayer2.controller_wrapper(A0_5)
	return A0_5:user():controller_wrapper()
end
function Menu2DPageControllerPCPlayer2.create_controller_checker(A0_6)
	local L1_7, L2_8
	L1_7 = ControllerWrapperInputPressedChecker
	L2_8 = L1_7
	L1_7 = L1_7.new
	L1_7 = L1_7(L2_8, A0_6:controller_wrapper())
	A0_6._controller_checker = L1_7
end
