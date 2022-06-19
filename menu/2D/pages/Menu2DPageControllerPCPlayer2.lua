if not Menu2DPageControllerPCPlayer2 then
	Menu2DPageControllerPCPlayer2 = class(Menu2DPageControllerPC)
end
Menu2DPageControllerPCPlayer2.init = function(l_1_0, l_1_1, l_1_2)
	Menu2DPageControllerPC.init(l_1_0, l_1_1, l_1_2)
end

Menu2DPageControllerPCPlayer2.user = function(l_2_0)
	local l_2_1 = managers.player_slot:slot(2)
	assert(l_2_1)
	local l_2_2, l_2_3 = l_2_1:user, l_2_1
	return l_2_2(l_2_3)
end

Menu2DPageControllerPCPlayer2.controller_wrapper = function(l_3_0)
	local l_3_1, l_3_2 = l_3_0:user():controller_wrapper, l_3_0:user()
	return l_3_1(l_3_2)
end

Menu2DPageControllerPCPlayer2.create_controller_checker = function(l_4_0)
	l_4_0._controller_checker = ControllerWrapperInputPressedChecker:new(l_4_0:controller_wrapper())
end


