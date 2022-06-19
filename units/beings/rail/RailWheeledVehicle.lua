RailWheeledVehicle = RailWheeledVehicle or class(RailVehicle)
function RailWheeledVehicle.init(A0_0, A1_1)
	RailVehicle.init(A0_0, A1_1)
	A0_0:_init_effects()
end
function RailWheeledVehicle._init_effects(A0_2)
	local L1_3
	L1_3 = {}
	A0_2._looping_effects = L1_3
	L1_3 = {
		{
			speed_from = 1,
			speed_to = 15,
			effect_value = 8
		},
		{
			speed_from = 15,
			speed_to = 30,
			effect_value = 7
		},
		{
			speed_from = 30,
			speed_to = 45,
			effect_value = 6
		},
		{
			speed_from = 45,
			speed_to = 60,
			effect_value = 5
		},
		{
			speed_from = 60,
			speed_to = 75,
			effect_value = 4
		},
		{
			speed_from = 75,
			speed_to = 90,
			effect_value = 3
		},
		{
			speed_from = 90,
			speed_to = 105,
			effect_value = 2
		},
		{
			speed_from = 105,
			speed_to = 10000,
			effect_value = 1
		}
	}
	A0_2._exhaust_effect_parameters = L1_3
	L1_3 = {
		{
			acc_from = 10,
			acc_to = 20,
			effect = "car_gravel_small"
		},
		{
			acc_from = 20,
			acc_to = 30,
			effect = "car_gravel_medium"
		},
		{
			acc_from = 30,
			acc_to = 10000,
			effect = "car_gravel_medium"
		}
	}
	A0_2._gravel_effects_parameters = L1_3
end
function RailWheeledVehicle.update(A0_4, A1_5, A2_6, A3_7)
	RailVehicle.update(A0_4, A1_5, A2_6, A3_7)
	A0_4:_update_wheel_rotation()
	A0_4:_update_effects(A1_5, A2_6, A3_7)
end
function RailWheeledVehicle._update_wheel_rotation(A0_8)
	if A0_8._unit:get_object("at_wheel_lb") then
		if math.abs(angle_from_signed(A0_8._unit:get_object("at_wheel_lb"):new_local_rotation():yaw()) - A0_8._last_wheel_rot) > 180 then
			A0_8._forward = angle_from_signed(A0_8._unit:get_object("at_wheel_lb"):new_local_rotation():yaw()) - 360 < A0_8._last_wheel_rot
		else
			A0_8._forward = angle_from_signed(A0_8._unit:get_object("at_wheel_lb"):new_local_rotation():yaw()) < A0_8._last_wheel_rot
		end
		A0_8._last_wheel_rot = angle_from_signed(A0_8._unit:get_object("at_wheel_lb"):new_local_rotation():yaw())
	end
end
function RailWheeledVehicle._update_effects(A0_9, A1_10, A2_11, A3_12)
end
function RailWheeledVehicle._update_exhaust_effect(A0_13)
	local L1_14
	L1_14 = A0_13.get_speed_kmh
	L1_14 = L1_14(A0_13)
	if L1_14 < 0.5 then
		L1_14 = A0_13._remove_looping_effect
		L1_14(A0_13, "car_exhaust")
	else
		L1_14 = A0_13._unit
		L1_14 = L1_14.get_object
		L1_14 = L1_14(L1_14, "e_exhaust")
		if L1_14 then
			A0_13:_add_looping_effect("car_exhaust", "car_exhaust", L1_14, nil)
		end
	end
end
function RailWheeledVehicle._update_cruising_effect(A0_15)
	local L1_16, L2_17, L3_18, L4_19, L5_20
	L2_17 = A0_15
	L1_16 = A0_15.get_speed_kmh
	L1_16 = L1_16(L2_17)
	L2_17 = A0_15._exhaust_effect_parameters
	L2_17 = L2_17[1]
	L2_17 = L2_17.speed_from
	if L1_16 <= L2_17 then
		L3_18 = A0_15
		L2_17 = A0_15._remove_looping_effect
		L4_19 = "car_cruising_lb"
		L2_17(L3_18, L4_19)
		L3_18 = A0_15
		L2_17 = A0_15._remove_looping_effect
		L4_19 = "car_cruising_rb"
		L2_17(L3_18, L4_19)
	else
		L2_17 = A0_15._unit
		L3_18 = L2_17
		L2_17 = L2_17.get_object
		L4_19 = "e_wheel_lb"
		L2_17 = L2_17(L3_18, L4_19)
		L3_18 = A0_15._unit
		L4_19 = L3_18
		L3_18 = L3_18.get_object
		L5_20 = "e_wheel_rb"
		L3_18 = L3_18(L4_19, L5_20)
		if L2_17 and L3_18 then
			L4_19 = Rotation
			L5_20 = Vector3
			L5_20 = L5_20(0, -1, 0)
			L4_19 = L4_19(L5_20, L2_17:rotation():y())
			L5_20 = Rotation
			L5_20 = L5_20(Vector3(0, -1, 0), L3_18:rotation():y())
			A0_15:_add_looping_effect("car_cruising_lb", "car_cruising", L2_17, L4_19)
			A0_15:_add_looping_effect("car_cruising_rb", "car_cruising", L3_18, L5_20)
			for 