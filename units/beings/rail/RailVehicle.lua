require("shared/Angle")
RailVehicle = RailVehicle or class()
require("units/beings/rail/RailVehicleSeat")
require("units/beings/rail/cameras/RailCameraLinkInfo")
require("shared/Stack")
require("shared/TableAlgorithms")
RailVehicle._ROTATION_SAMPLE_COUNT = 10
function RailVehicle.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._unit:set_driving("animation")
	A0_0._seats = {}
	A0_0._damage_callbacks = {}
	A0_0._active_damage_callbacks = {}
	A0_0._activated_callback_hubs = {}
	A0_0._state_machine = A0_0._unit:anim_state_machine()
	A0_0._animation_set_name = A0_0._unit:name()
	A0_0._animation_set = AnimationManager:animation_set(A0_0._animation_set_name)
	assert(A0_0._animation_set, "The animation set must have the same name as the unit" .. A0_0._animation_set_name)
	A0_0._speed_vectors = AverageOverTime:new(25, Vector3(0, 0, 0))
	A0_0._acceleration_vectors = AverageOverTime:new(25, Vector3(0, 0, 0))
	A0_0._accelerations = AverageOverTime:new(10)
	A0_0._total_current_rot = Vector3(0, 0, 0)
	A0_0._current_position = A0_0._unit:position()
	A0_0._current_speed_vector = Vector3(0, 0, 0)
	A0_0._current_acc_vector = Vector3(0, 0, 0)
	A0_0._current_acc = 0
	A0_0._start_rotation = A0_0._unit:rotation()
	A0_0._start_position = A0_0._unit:position()
	A0_0._unit:set_animation_lod(1, 1000000, 500, 1000000)
	A0_0._current_state = nil
	A0_0._current_anim_time = 0
	A0_0._total_animation_time = 0
	A0_0._animation_speed_mult = 1
	A0_0._last_wheel_rot = 0
	A0_0._transition = false
	A0_0._ragdolled = false
	A0_0._warp_to_start = true
	A0_0._heavy_acc = false
	A0_0._heavy_dec = false
	if A0_0._turret_unit_name then
		A0_0._turret_unit = World:spawn_unit(A0_0._turret_unit_name, Vector3(0, 0, 0), Rotation(0, 0, 0))
		A0_0:link_unit_to_vehicle(A0_0._turret_unit, A0_0._turret_align_object, true)
		A0_0._turret_unit:turret():set_vehicle(A0_0._unit)
	end
	A0_0._emitter = managers.action_event:create_emitter(A1_1)
end
function RailVehicle.set_seats(A0_2, A1_3)
	A0_2._seats = A1_3
end
function RailVehicle.spawn_driver_and_passenger(A0_4, A1_5, A2_6)
	if A1_5 ~= "empty seat" and A0_4._driver_align_object then
		if A1_5 and A1_5 ~= "" then
			A0_4._driver_name = A1_5
		end
		A0_4._driver = A0_4:spawn_driver(A0_4._driver_name, A0_4._driver_align_object, true)
	end
	if A2_6 ~= "empty seat" and A0_4._passenger_align_object then
		if A2_6 and A2_6 ~= "" then
			A0_4._passenger_name = A2_6
		end
		A0_4._passenger = A0_4:spawn_driver(A0_4._passenger_name, A0_4._passenger_align_object, false)
	end
end
function RailVehicle.spawn_driver(A0_7, A1_8, A2_9, A3_10)
	local L4_11, L5_12, L6_13
	if A1_8 then
		L5_12 = A0_7._unit
		L6_13 = L5_12
		L5_12 = L5_12.get_object
		L5_12 = L5_12(L6_13, A2_9)
		L6_13 = World
		L6_13 = L6_13.spawn_unit
		L6_13 = L6_13(L6_13, A1_8, L5_12:position(), L5_12:rotation())
		L4_11 = L6_13
		L6_13 = L4_11.driver
		L6_13 = L6_13(L4_11)
		L6_13 = L6_13.setup
		L6_13(L6_13, A3_10)
		L6_13 = A0_7._unit
		L6_13 = L6_13.link
		L6_13(L6_13, A2_9, L4_11, L4_11:orientation_object():name())
		L6_13 = L4_11.driver
		L6_13 = L6_13(L4_11)
		L6_13 = L6_13.set_vehicle
		L6_13(L6_13, A0_7._unit)
		L6_13 = L4_11.damage
		L6_13 = L6_13(L4_11)
		L6_13 = L6_13.set_immune_to_damage
		L6_13(L6_13, true)
		L6_13 = L4_11.driver
		L6_13 = L6_13(L4_11)
		L6_13 = L6_13.character_name
		if L6_13 then
			managers.unit_scripting:register_unit(L6_13, L4_11)
			managers.drama_scene:set_unit_name_to_script_name(L6_13, L6_13)
		end
		return L4_11
	end
end
function RailVehicle.get_turret_unit(A0_14)
	local L1_15
	L1_15 = A0_14._turret_unit
	return L1_15
end
function RailVehicle.get_ai_player_miss_dispersion_modifier(A0_16)
	return A0_16._unit:vehicle_data()._ai_player_miss_dispersion_modifier
end
function RailVehicle.update(A0_17, A1_18, A2_19, A3_20)
	if A0_17._ragdolled then
		return
	end
	if A0_17._transition then
		A0_17:start(A0_17._trans_anim, A0_17._trans_time)
		A0_17._transition = false
	else
		A0_17:_update_animation(A3_20)
	end
	A0_17:calculate_speed(A3_20)
	A0_17:_update_damage_status()
	A0_17:_update_connector_callbacks(A2_19, A3_20)
	A0_17:_update_animation_speed_interpolator(A3_20)
end
function RailVehicle.transition(A0_21, A1_22, A2_23, A3_24)
	A0_21._transition = true
	A0_21._trans_anim = A1_22
	A0_21._trans_time = A2_23
	if A3_24 then
		A0_21._warp_to_start = false
	end
end
function RailVehicle.start(A0_25, A1_26, A2_27)
	assert(A1_26 ~= nil, "No animation defined in rail-vehicle")
	A0_25._state_machine:play_redirect(A1_26)
	A0_25._current_state = A0_25._state_machine:segment_state_object("body")
	A0_25._current_animation = A0_25._current_state:animations()[1]
	if A0_25._current_animation then
		A0_25._total_animation_time = A0_25._animation_set:animation_total_duration(A0_25._current_animation)
	end
	if A0_25._warp_to_start then
		A0_25._unit:warp_to(A0_25._start_rotation, A0_25._start_position)
	end
	if A2_27 then
		A0_25._current_anim_time = A2_27
	else
		A0_25._current_anim_time = 0
	end
	A0_25:_update_animation(0)
	A0_25._unit:set_driving("script")
end
function RailVehicle.set_animation_start(A0_28, A1_29, A2_30)
	A0_28._start_position = A1_29
	A0_28._start_rotation = A2_30
end
function RailVehicle._update_animation(A0_31, A1_32)
	A0_31._unit:set_driving("animation")
	if A0_31._total_animation_time > 0 then
		A0_31._current_anim_time = A0_31._current_anim_time + A1_32 * A0_31._animation_speed_mult
		A0_31._state_machine:set_global("g_time", A0_31._current_anim_time / A0_31._total_animation_time)
	end
end
function RailVehicle.set_animation_speed(A0_33, A1_34)
	A0_33._animation_speed_mult = A1_34
end
function RailVehicle.set_animation_speed_interpolator_target(A0_35, A1_36, A2_37)
	if not A0_35._animation_speed_interpolator then
		A0_35._animation_speed_interpolator = InterpolatorLinear:new(A0_35._animation_speed_mult, 1 / A2_37)
		A0_35._animation_speed_interpolator:set_target(A1_36)
	else
		A0_35._animation_speed_interpolator:set_target(A1_36)
		A0_35._animation_speed_interpolator:set_speed(1 / A2_37)
	end
end
function RailVehicle._update_animation_speed_interpolator(A0_38, A1_39)
	if A0_38._animation_speed_interpolator and not A0_38._animation_speed_interpolator:has_reached_target() then
		A0_38._animation_speed_interpolator:update(A1_39)
		A0_38._animation_speed_mult = A0_38._animation_speed_interpolator:value()
	end
end
function RailVehicle.link_player_to_first_empty_seat(A0_40, A1_41)
	local L2_42, L3_43, L4_44, L5_45, L6_46
	for L5_45, L6_46 in L2_42(L3_43) do
		if L6_46:is_empty() then
			A0_40:_link_player_to_seat(A1_41, L6_46)
			return true
		end
	end
	return L2_42
end
function RailVehicle.link_player_to_seat_name(A0_47, A1_48, A2_49)
	local L3_50
	L3_50 = assert
	L3_50(A0_47._seats[A2_49])
	L3_50 = A0_47._seats
	L3_50 = L3_50[A2_49]
	if L3_50:is_empty() then
		A0_47:_link_player_to_seat(A1_48, L3_50)
		return true
	end
	return false
end
function RailVehicle._link_player_to_seat(A0_51, A1_52, A2_53, A3_54)
	local L4_55
	A1_52:unlink()
	if A2_53:get_align_object() ~= nil then
		L4_55 = A2_53:get_align_object()
	else
		L4_55 = A0_51._align_object
	end
	if A0_51._turret_unit then
		A0_51:link_unit_to_turret(A1_52, L4_55, A3_54)
		A0_51:offset_player_position_on_vehicle(A0_51._turret_unit, A1_52, L4_55, A2_53, A3_54)
	else
		A1_52:base():kill_mover()
		A0_51._unit:link(L4_55, A1_52, A1_52:orientation_object():name())
	end
	A2_53:set_unit(A1_52)
end
function RailVehicle.unlink_player(A0_56, A1_57)
	A1_57:rail():exit_vehicle()
	A1_57:unlink()
	A1_57:play_redirect("idle_std")
end
function RailVehicle.get_first_linked_player(A0_58)
	for 