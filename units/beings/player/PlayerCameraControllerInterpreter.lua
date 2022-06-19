if not PlayerCameraControllerInterpreter then
	PlayerCameraControllerInterpreter = class()
end
PlayerCameraControllerInterpreter.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._player_data = l_1_1:player_data()
end

PlayerCameraControllerInterpreter.enable = function(l_2_0, l_2_1)
	l_2_0._controller = l_2_1
end

PlayerCameraControllerInterpreter.disable = function(l_3_0)
	l_3_0._controller = nil
end

PlayerCameraControllerInterpreter.update = function(l_4_0)
	if not l_4_0._controller then
		return 
	end
	local l_4_1 = (l_4_0._unit:camera())
	local l_4_2 = nil
	if l_4_0._player_data.on_rail_vehicle then
		l_4_2 = l_4_0._controller:get_input_axis("look") * tweak_data.player.aim.LOOK_SPEED_BASE_RAIL_TURRET
	else
		l_4_2 = l_4_0._controller:get_input_axis("look") * tweak_data.player.aim.LOOK_SPEED_BASE
	end
	if l_4_0._player_data.invert_y then
		l_4_2 = -l_4_2:with_x(-l_4_2.x)
	end
	l_4_1:set_look_vector(l_4_2)
end

PlayerCameraControllerInterpreter.save = function(l_5_0, l_5_1)
end

PlayerCameraControllerInterpreter.load = function(l_6_0, l_6_1)
end


