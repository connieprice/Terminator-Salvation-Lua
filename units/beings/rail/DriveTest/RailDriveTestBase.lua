require("setups/DebugSetup")
if not RailDriveTestBase then
	RailDriveTestBase = class()
end
RailDriveTestBase.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._unit:set_driving("script")
	l_1_0._turn = 0
	l_1_0._unit:set_gravity(Vector3(0, 0, -2000))
end

RailDriveTestBase.update = function(l_2_0, l_2_1, l_2_2, l_2_3)
	local l_2_4 = l_2_1:input()
	local l_2_5 = (l_2_4:eye_target_position())
	local l_2_6, l_2_7 = nil, nil
	l_2_7 = l_2_4:aim_target_position()
	l_2_0:_update_movement(l_2_1, l_2_3)
	l_2_1:camera_data().eye_target_position = l_2_5
end

RailDriveTestBase._update_movement = function(l_3_0, l_3_1, l_3_2)
	local l_3_3 = l_3_1:input()
	local l_3_4 = l_3_3:movement()
	if l_3_4.z > 0 then
		l_3_1:vehicle():brake(l_3_4.z)
	else
		l_3_1:vehicle():brake(0)
	end
	l_3_1:vehicle():gas(l_3_4.x)
	l_3_1:vehicle():turn(l_3_4.y)
end


