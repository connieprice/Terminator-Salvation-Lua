require("units/beings/player/states/PlayerRailTurretState")
require("units/beings/player/states/PlayerRailTrainState")
require("units/beings/player_tank/gui/MachineHud")
PlayerTank = PlayerTank or class(Player)
function PlayerTank.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._player_data = A0_0._unit:player_data()
	A0_0._input = A0_0._unit:input()
	A0_0._emitter = managers.action_event:create_emitter(A1_1)
	A0_0._inventory = PlayerInventory:new(A1_1, A0_0._inventory_setup)
	A0_0:spawn_weapons(A0_0._weapons)
	A0_0._input:set_eye_target_position(Vector3(0, 0, 0))
	A0_0._input:set_aim_target_position(Vector3(0, 0, 0))
	A0_0:set_drama_name()
end
function PlayerTank.destroy(A0_2)
	A0_2._unit = nil
	A0_2._emitter:destroy()
end
function PlayerTank.update(A0_3, A1_4, A2_5, A3_6)
	A0_3._unit:camera_data().eye_target_position = A0_3._input:eye_target_position()
	A0_3:_update_weapon(A0_3._primary_weapon_l, A0_3._input:primary_fire_l(), A0_3._input:aim_target_position())
	A0_3:_update_weapon(A0_3._primary_weapon_r, A0_3._input:primary_fire_r(), A0_3._input:aim_target_position())
	A0_3:_update_weapon(A0_3._secondary_weapon_l, A0_3._input:secondary_fire_l(), A0_3._input:aim_target_position())
	A0_3:_update_weapon(A0_3._secondary_weapon_r, A0_3._input:secondary_fire_r(), A0_3._input:aim_target_position())
	A0_3:_update_turret_rotation()
	A0_3:_update_shake()
end
function PlayerTank.set_drama_name(A0_7)
	if A0_7.character_name then
		managers.unit_scripting:register_unit(A0_7.character_name, A0_7._unit)
		managers.drama_scene:set_unit_name_to_script_name(A0_7.character_name, A0_7.character_name)
	end
end
function PlayerTank._update_shake(A0_8)
	if A0_8._unit:rail()._vehicle and A0_8._unit:rail()._vehicle:base():get_speed_vector():length() > tweak_data.rail.vehicle.rail_vehicle_tank.SHAKE_START_SPEED then
		A0_8._player_data.rail_vehicle_shake = "tank"
	else
		A0_8._player_data.rail_vehicle_shake = nil
	end
end
function PlayerTank._update_turret_rotation(A0_9)
	local L1_10
	L1_10 = A0_9._turret_object
	if L1_10 then
		L1_10 = Rotation
		L1_10 = L1_10.look_at
		L1_10 = L1_10(L1_10, A0_9._turret_object:position(), A0_9._input:eye_target_position(), Vector3(0, 0, 1))
		L1_10 = Rotation(L1_10:yaw(), 0, L1_10:roll())
		A0_9._unit:rail()._vehicle:base():set_turret_rotation(L1_10, A0_9._input:look_input_axis())
	end
end
function PlayerTank._update_weapon(A0_11, A1_12, A2_13, A3_14)
	if A1_12 and alive(A1_12) then
		if A2_13 and not (A1_12:weapon_data()._bullets_in_clip == 0) then
			A1_12:weapon_data().fire_input = 1
		else
			A1_12:weapon_data().fire_input = 0
		end
		A1_12:weapon_data().aim_target_position = A3_14
		if A1_12:weapon_data()._bullets_in_clip == 0 then
			A1_12:base():reload()
		end
	end
end
function PlayerTank.get_weapon_overheat_percent(A0_15)
	local L1_16, L2_17, L3_18, L4_19, L5_20, L6_21
	L1_16 = 0
	L2_17 = 0
	L3_18 = false
	L4_19 = false
	L5_20 = A0_15._primary_weapon_l
	if L5_20 then
		L5_20 = A0_15._primary_weapon_l
		L6_21 = L5_20
		L5_20 = L5_20.logic
		L5_20 = L5_20(L6_21)
		L6_21 = L5_20
		L5_20 = L5_20.get_overheat_percent
		L5_20 = L5_20(L6_21)
		L1_16 = L5_20
		L5_20 = A0_15._primary_weapon_l
		L6_21 = L5_20
		L5_20 = L5_20.logic
		L5_20 = L5_20(L6_21)
		L6_21 = L5_20
		L5_20 = L5_20.is_overheated
		L5_20 = L5_20(L6_21)
		L3_18 = L5_20
	end
	L5_20 = A0_15._primary_weapon_r
	if L5_20 then
		L5_20 = A0_15._primary_weapon_r
		L6_21 = L5_20
		L5_20 = L5_20.logic
		L5_20 = L5_20(L6_21)
		L6_21 = L5_20
		L5_20 = L5_20.get_overheat_percent
		L5_20 = L5_20(L6_21)
		L2_17 = L5_20
		L5_20 = A0_15._primary_weapon_r
		L6_21 = L5_20
		L5_20 = L5_20.logic
		L5_20 = L5_20(L6_21)
		L6_21 = L5_20
		L5_20 = L5_20.is_overheated
		L5_20 = L5_20(L6_21)
		L4_19 = L5_20
	end
	L5_20 = {}
	L5_20.primary_l = L1_16
	L5_20.primary_r = L2_17
	L6_21 = {}
	L6_21.primary_l = L3_18
	L6_21.primary_r = L4_19
	return L5_20, L6_21
end
function PlayerTank.get_weapon_power_up_percent(A0_22)
	local L1_23, L2_24
	L1_23 = 0
	L2_24 = 0
	if A0_22._secondary_weapon_l then
		L1_23 = A0_22:_fire_delay_percent(A0_22._secondary_weapon_l)
	end
	if A0_22._secondary_weapon_r then
		L2_24 = A0_22:_fire_delay_percent(A0_22._secondary_weapon_r)
	end
	;({}).secondary_l = L1_23
	;({}).secondary_r = L2_24
	return {}
end
function PlayerTank._fire_delay_percent(A0_25, A1_26)
	return 1
end
function PlayerTank.enter_rail(A0_27)
	A0_27._primary_weapon_l = A0_27._unit:rail()._vehicle:base():get_primary_weapons()[1]
	A0_27._primary_weapon_r = A0_27._unit:rail()._vehicle:base():get_primary_weapons()[2]
	A0_27._secondary_weapon_l = A0_27._unit:rail()._vehicle:base():get_secondary_weapons()[1]
	A0_27._secondary_weapon_r = A0_27._unit:rail()._vehicle:base():get_secondary_weapons()[2]
	A0_27._turret_object = A0_27._unit:rail()._vehicle:base():get_turret_object()
	A0_27._unit:look():set_yaw_angle(A0_27._unit:rail()._vehicle:rotation():roll())
end
function PlayerTank.in_cover(A0_28)
	local L1_29
	L1_29 = false
	return L1_29
end
function PlayerTank.spawn_weapon_state(A0_30, A1_31)
	A0_30:destroy_weapons()
	for 