Rail2WheeledVehicle = Rail2WheeledVehicle or class(RailVehicle)
function Rail2WheeledVehicle.init(A0_0, A1_1)
	RailVehicle.init(A0_0, A1_1)
	A0_0._wheel_offset_position = Vector3(0, 0, -(A0_0._wheel_radius + 25))
	A0_0._wheel_to_ground_slot_mask = managers.slot:get_mask("solid_objects")
	A0_0._wheels = {
		{
			object = A0_0._unit:get_object("at_susp_wheel_b_center"),
			on_ground = true
		}
	}
	A0_0._looping_effects = {}
	A0_0._update_on_ground_delay = 0.1
	A0_0._update_on_ground_time = 0
end
function Rail2WheeledVehicle.update(A0_2, A1_3, A2_4, A3_5)
	RailVehicle.update(A0_2, A1_3, A2_4, A3_5)
	A0_2:_update_wheels(A1_3, A2_4, A3_5)
	A0_2:_update_wheel_effects()
end
function Rail2WheeledVehicle._update_wheels(A0_6, A1_7, A2_8, A3_9)
	A0_6:_update_on_ground(A1_7, A2_8, A3_9)
end
function Rail2WheeledVehicle._update_wheel_effects(A0_10)
	A0_10:_update_cruising_effect()
end
function Rail2WheeledVehicle._update_on_ground(A0_11, A1_12, A2_13, A3_14)
	if A2_13 >= A0_11._update_on_ground_time then
		for 