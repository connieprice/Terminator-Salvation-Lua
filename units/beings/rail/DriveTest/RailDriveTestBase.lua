require("setups/DebugSetup")
RailDriveTestBase = RailDriveTestBase or class()
function RailDriveTestBase.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._unit:set_driving("script")
	A0_0._turn = 0
	A0_0._unit:set_gravity(Vector3(0, 0, -2000))
end
function RailDriveTestBase.update(A0_2, A1_3, A2_4, A3_5)
	local L4_6, L5_7, L6_8, L7_9
	L5_7 = A1_3
	L4_6 = A1_3.input
	L4_6 = L4_6(L5_7)
	L6_8 = L4_6
	L5_7 = L4_6.eye_target_position
	L5_7 = L5_7(L6_8)
	L6_8, L7_9 = nil, nil
	L7_9 = L4_6:aim_target_position()
	A0_2:_update_movement(A1_3, A3_5)
	A1_3:camera_data().eye_target_position = L5_7
end
function RailDriveTestBase._update_movement(A0_10, A1_11, A2_12)
	if A1_11:input():movement().z > 0 then
		A1_11:vehicle():brake(A1_11:input():movement().z)
	else
		A1_11:vehicle():brake(0)
	end
	A1_11:vehicle():gas(A1_11:input():movement().x)
	A1_11:vehicle():turn(A1_11:input():movement().y)
end
