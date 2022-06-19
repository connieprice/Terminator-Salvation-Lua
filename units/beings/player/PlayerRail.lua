PlayerRail = PlayerRail or class()
function PlayerRail.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._vehicle = nil
	A0_0._player_data = A1_1:player_data()
	A0_0._align_rotation_to_camera = true
	A0_0._unit:set_extension_update_enabled("rail", false)
end
function PlayerRail.update(A0_2, A1_3, A2_4, A3_5)
	if alive(A0_2._vehicle) then
		if not A0_2._unit:base():player_has_control() then
			A0_2._vehicle:damage_data().invulnerable = true
		else
			A0_2._vehicle:damage_data().invulnerable = false
		end
		if managers.player and not managers.player:is_human_player(A0_2._unit) then
			A0_2._player_data.vehicle_miss_dispersion_modifier = A0_2._vehicle:base():get_ai_player_miss_dispersion_modifier() or 1
			A0_2._player_data.firing_from_vehicle = true
		end
		A0_2:update_align()
	end
	if not A0_2._unmounted_vehicles_registered then
		A0_2:_register_unmounted_vehicles()
		A0_2._unmounted_vehicles_registered = true
	end
end
function PlayerRail.destroy(A0_6)
	local L1_7
	A0_6._unit = nil
end
function PlayerRail.get_rail_state(A0_8)
	local L1_9, L2_10
	L1_9 = A0_8._vehicle
	if L1_9 ~= nil then
		L1_9 = A0_8._vehicle
		L2_10 = L1_9
		L1_9 = L1_9.base
		L1_9 = L1_9(L2_10)
		L2_10 = L1_9
		L1_9 = L1_9.get_seat
		L1_9 = L1_9(L2_10, A0_8._unit)
		L2_10 = assert
		L2_10(L1_9)
		L2_10 = rawget
		L2_10 = L2_10(_G, L1_9:get_state_name())
		assert(L2_10)
		return L2_10:new(A0_8._unit)
	end
end
function PlayerRail.enter_vehicle(A0_11, A1_12, A2_13)
	local L3_14
	if A1_12 then
		A0_11._vehicle = A1_12
		L3_14 = false
		if A2_13 == "random" then
			L3_14 = A0_11._vehicle:base():link_player_to_first_empty_seat(A0_11._unit)
		else
			L3_14 = A0_11._vehicle:base():link_player_to_seat_name(A0_11._unit, A2_13)
		end
		if L3_14 then
			A0_11._player_data.named_camera_targets.vehicle = A1_12
			A0_11._player_data.named_camera_targets.weapon = A1_12:base():get_turret_unit()
			A0_11._unit:base():enter_rail()
			A0_11._player_data.on_rail_vehicle = A0_11._vehicle
			A0_11._player_data.rail_vehicle_camera = A1_12:vehicle_data().default_camera
			A0_11._unit:difficulty_level():enter_rail()
			A0_11._unit:set_local_rotation(Rotation(0, 0, 0))
			A0_11._unit:set_extension_update_enabled("rail", true)
			return true
		end
	end
	L3_14 = false
	return L3_14
end
function PlayerRail.exit_vehicle(A0_15)
	A0_15._unit:unlink()
	A0_15._unit:play_redirect("idle_std")
	A0_15._player_data.on_rail_vehicle = nil
	A0_15._vehicle = nil
	A0_15._unit:set_extension_update_enabled("rail", false)
end
function PlayerRail.get_vehicle(A0_16)
	local L1_17
	L1_17 = A0_16._vehicle
	return L1_17
end
function PlayerRail.change_seat(A0_18, A1_19)
	A0_18._vehicle:base():move_player_to_seat_name(A0_18._unit, A1_19)
end
function PlayerRail.update_align(A0_20)
	local L1_21, L2_22
	L1_21 = A0_20._vehicle
	if not L1_21 then
		return
	end
	L1_21 = A0_20._vehicle
	L2_22 = L1_21
	L1_21 = L1_21.base
	L1_21 = L1_21(L2_22)
	L2_22 = L1_21
	L1_21 = L1_21.get_seat
	L1_21 = L1_21(L2_22, A0_20._unit)
	L2_22 = assert
	L2_22(L1_21)
	L2_22 = A0_20._unit
	L2_22 = L2_22.camera
	L2_22 = L2_22(L2_22)
	L2_22 = L2_22.camera_constraints
	L2_22 = L2_22(L2_22)
	if L2_22 then
		L2_22 = A0_20._vehicle:rotation():inverse():rotate_with(L2_22):roll()
		L1_21:set_rotation(Rotation(0, 0, L2_22))
	end
end
function PlayerRail.align_rotation_to_camera(A0_23, A1_24)
	A0_23._align_rotation_to_camera = A1_24
end
function PlayerRail.player_leave_vehicle(A0_25)
	A0_25._vehicle:base():get_first_linked_player():difficulty_level():exit_rail()
	A0_25._vehicle:base():get_first_linked_player():rail():exit_vehicle()
	A0_25._vehicle:base():get_first_linked_player():unlink()
end
function PlayerRail._register_unmounted_vehicles(A0_26)
	local L1_27, L2_28, L3_29, L4_30, L5_31, L6_32
	L1_27 = World
	L1_27 = L1_27.unit_manager
	L1_27 = L1_27(L2_28)
	L1_27 = L1_27.get_units
	L5_31 = "rail_vehicles"
	L6_32 = L3_29(L4_30, L5_31)
	L1_27 = L1_27(L2_28, L3_29, L4_30, L5_31, L6_32, L3_29(L4_30, L5_31))
	for L5_31, L6_32 in L2_28(L3_29) do
		if alive(L6_32) and L6_32:base()._unmounted_vehicle then
			A0_26._unit:difficulty_level():register_unmounted_rail_vehicle(L6_32)
		end
	end
end
