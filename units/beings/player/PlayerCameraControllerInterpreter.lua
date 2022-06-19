PlayerCameraControllerInterpreter = PlayerCameraControllerInterpreter or class()
function PlayerCameraControllerInterpreter.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._player_data = A1_1:player_data()
end
function PlayerCameraControllerInterpreter.enable(A0_2, A1_3)
	A0_2._controller = A1_3
end
function PlayerCameraControllerInterpreter.disable(A0_4)
	local L1_5
	A0_4._controller = nil
end
function PlayerCameraControllerInterpreter.update(A0_6)
	local L1_7, L2_8
	L1_7 = A0_6._controller
	if not L1_7 then
		return
	end
	L1_7 = A0_6._unit
	L2_8 = L1_7
	L1_7 = L1_7.camera
	L1_7 = L1_7(L2_8)
	L2_8 = nil
	if A0_6._player_data.on_rail_vehicle then
		L2_8 = A0_6._controller:get_input_axis("look") * tweak_data.player.aim.LOOK_SPEED_BASE_RAIL_TURRET
	else
		L2_8 = A0_6._controller:get_input_axis("look") * tweak_data.player.aim.LOOK_SPEED_BASE
	end
	if A0_6._player_data.invert_y then
		L2_8 = -L2_8:with_x(-L2_8.x)
	end
	L1_7:set_look_vector(L2_8)
end
function PlayerCameraControllerInterpreter.save(A0_9, A1_10)
end
function PlayerCameraControllerInterpreter.load(A0_11, A1_12)
end
