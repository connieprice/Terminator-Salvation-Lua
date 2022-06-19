Turret = Turret or class()
function Turret.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._traverse = A0_0._unit:get_object("at_traverse")
	A0_0._elevation = A0_0._unit:get_object("at_elevation")
	A0_0._pintle = A0_0._unit:get_object("at_pintle")
	A0_0._unit:set_driving("animation")
	if not A0_0._traverse then
		A0_0._traverse = A0_0._unit:orientation_object()
	end
	if A0_0._fire_name == nil then
		A0_0._fire = A0_0._unit:get_object("at_elevation")
	else
		A0_0._fire = A0_0._unit:get_object(A0_0._fire_name)
	end
	A0_0._traverse_yaw = 0
	A0_0._pitch = 0
	A0_0._yaw = 0
end
function Turret.set_vehicle(A0_2, A1_3)
	A0_2._vehicle = A1_3
end
function Turret.get_vehicle(A0_4)
	local L1_5
	L1_5 = A0_4._vehicle
	return L1_5
end
function Turret.dead(A0_6)
	local L1_7
end
function Turret.destroy(A0_8)
	A0_8._unit:set_slot(0)
	A0_8._unit = nil
end
function Turret.set_traverse_angle(A0_9, A1_10)
	A0_9._traverse_yaw = A1_10 - A0_9._unit:rotation():roll()
	A0_9._traverse:new_set_local_rotation(Rotation(A0_9._traverse:new_local_rotation():yaw(), A0_9._traverse:new_local_rotation():pitch(), A0_9._traverse_yaw))
end
function Turret.aim_at(A0_11, A1_12)
	local L2_13, L3_14, L4_15
	L2_13 = A0_11._traverse
	L3_14 = L2_13
	L2_13 = L2_13.rotation
	L2_13 = L2_13(L3_14)
	L3_14 = L2_13
	L2_13 = L2_13.inverse
	L2_13 = L2_13(L3_14)
	L3_14 = A0_11._traverse
	L4_15 = L3_14
	L3_14 = L3_14.position
	L3_14 = L3_14(L4_15)
	L4_15 = L3_14.rotate_with
	L4_15 = L4_15(L3_14, L2_13)
	L3_14 = L4_15
	L4_15 = A1_12.rotate_with
	L4_15 = L4_15(A1_12, L2_13)
	A0_11._pintle:new_set_local_rotation(Rotation(0, 0, Rotation:look_at(L3_14, L4_15, math.UP):roll()))
	A0_11._elevation:new_set_local_rotation(Rotation(Rotation:look_at(L3_14, L4_15, math.UP):yaw(), 0, 0))
	A0_11._unit:set_moving()
end
function Turret.set_aim_vec(A0_16, A1_17)
	local L2_18, L3_19
	L2_18 = A0_16._traverse
	L3_19 = L2_18
	L2_18 = L2_18.rotation
	L2_18 = L2_18(L3_19)
	L3_19 = L2_18
	L2_18 = L2_18.inverse
	L2_18 = L2_18(L3_19)
	L3_19 = A1_17.rotate_with
	L3_19 = L3_19(A1_17, L2_18)
	A0_16._pintle:new_set_local_rotation(Rotation(0, 0, Rotation:look_at(L3_19, math.UP):roll()))
	A0_16._elevation:new_set_local_rotation(Rotation(Rotation:look_at(L3_19, math.UP):yaw(), 0, 0))
	A0_16._unit:set_moving()
end
function Turret.draw_info(A0_20, A1_21, A2_22, A3_23)
	Draw:brush():set_screen(true)
	Draw:brush():set_blend_mode("add")
	Draw:brush():set_font("editor_font", 0.05)
	Draw:brush():set_color(Color(0, 0, 1, 1))
	Draw:brush():text(Vector3(A1_21, A2_22, 1), A3_23)
end
