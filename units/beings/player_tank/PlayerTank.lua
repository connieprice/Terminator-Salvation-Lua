require("units/beings/player/states/PlayerRailTurretState")
require("units/beings/player/states/PlayerRailTrainState")
require("units/beings/player_tank/gui/MachineHud")
if not PlayerTank then
	PlayerTank = class(Player)
end
PlayerTank.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._player_data = l_1_0._unit:player_data()
	l_1_0._input = l_1_0._unit:input()
	l_1_0._emitter = managers.action_event:create_emitter(l_1_1)
	l_1_0._inventory = PlayerInventory:new(l_1_1, l_1_0._inventory_setup)
	l_1_0:spawn_weapons(l_1_0._weapons)
	l_1_0._input:set_eye_target_position(Vector3(0, 0, 0))
	l_1_0._input:set_aim_target_position(Vector3(0, 0, 0))
	l_1_0:set_drama_name()
end

PlayerTank.destroy = function(l_2_0)
	l_2_0._unit = nil
	l_2_0._emitter:destroy()
end

PlayerTank.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	l_3_0._unit:camera_data().eye_target_position = l_3_0._input:eye_target_position()
	l_3_0:_update_weapon(l_3_0._primary_weapon_l, l_3_0._input:primary_fire_l(), l_3_0._input:aim_target_position())
	l_3_0:_update_weapon(l_3_0._primary_weapon_r, l_3_0._input:primary_fire_r(), l_3_0._input:aim_target_position())
	l_3_0:_update_weapon(l_3_0._secondary_weapon_l, l_3_0._input:secondary_fire_l(), l_3_0._input:aim_target_position())
	l_3_0:_update_weapon(l_3_0._secondary_weapon_r, l_3_0._input:secondary_fire_r(), l_3_0._input:aim_target_position())
	l_3_0:_update_turret_rotation()
	l_3_0:_update_shake()
end

PlayerTank.set_drama_name = function(l_4_0)
	if l_4_0.character_name then
		managers.unit_scripting:register_unit(l_4_0.character_name, l_4_0._unit)
		managers.drama_scene:set_unit_name_to_script_name(l_4_0.character_name, l_4_0.character_name)
	end
end

PlayerTank._update_shake = function(l_5_0)
	local l_5_1 = l_5_0._unit:rail()._vehicle
	if l_5_1 and tweak_data.rail.vehicle.rail_vehicle_tank.SHAKE_START_SPEED < l_5_1:base():get_speed_vector():length() then
		l_5_0._player_data.rail_vehicle_shake = "tank"
	else
		l_5_0._player_data.rail_vehicle_shake = nil
	end
end

PlayerTank._update_turret_rotation = function(l_6_0)
	if l_6_0._turret_object then
		local l_6_1 = Rotation:look_at(l_6_0._turret_object:position(), l_6_0._input:eye_target_position(), Vector3(0, 0, 1))
		l_6_1 = Rotation(l_6_1:yaw(), 0, l_6_1:roll())
		local l_6_2 = l_6_0._unit:rail()._vehicle
		l_6_2:base():set_turret_rotation(l_6_1, l_6_0._input:look_input_axis())
	end
end

PlayerTank._update_weapon = function(l_7_0, l_7_1, l_7_2, l_7_3)
	if l_7_1 and alive(l_7_1) then
		local l_7_4 = l_7_1:weapon_data()
		local l_7_5 = l_7_1:base()
		if l_7_2 and not l_7_4._bullets_in_clip == 0 then
			l_7_4.fire_input = 1
		else
			l_7_4.fire_input = 0
		end
		l_7_4.aim_target_position = l_7_3
		 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_7_4._bullets_in_clip == 0 then
		end
		l_7_1:base():reload()
	end
end

PlayerTank.get_weapon_overheat_percent = function(l_8_0)
	local l_8_1 = 0
	local l_8_2 = 0
	local l_8_3 = false
	local l_8_4 = false
	if l_8_0._primary_weapon_l then
		l_8_1 = l_8_0._primary_weapon_l:logic():get_overheat_percent()
		l_8_3 = l_8_0._primary_weapon_l:logic():is_overheated()
	end
	if l_8_0._primary_weapon_r then
		l_8_2 = l_8_0._primary_weapon_r:logic():get_overheat_percent()
		l_8_4 = l_8_0._primary_weapon_r:logic():is_overheated()
	end
	local l_8_5 = {}
	l_8_5.primary_l = l_8_1
	l_8_5.primary_r = l_8_2
	local l_8_6 = {}
	l_8_6.primary_l = l_8_3
	l_8_6.primary_r = l_8_4
	return l_8_5, l_8_6
end

PlayerTank.get_weapon_power_up_percent = function(l_9_0)
	local l_9_1 = 0
	local l_9_2 = 0
	if l_9_0._secondary_weapon_l then
		l_9_1 = l_9_0:_fire_delay_percent(l_9_0._secondary_weapon_l)
	end
	if l_9_0._secondary_weapon_r then
		l_9_2 = l_9_0:_fire_delay_percent(l_9_0._secondary_weapon_r)
	end
	local l_9_3 = {}
	l_9_3.secondary_l = l_9_1
	l_9_3.secondary_r = l_9_2
	return l_9_3
end

PlayerTank._fire_delay_percent = function(l_10_0, l_10_1)
	if (Application:time() - l_10_1:logic()._fire_time) / l_10_1:logic()._fire_delay > 1 then
		return 1
	end
end

PlayerTank.enter_rail = function(l_11_0)
	local l_11_1 = l_11_0._unit:rail()._vehicle
	local l_11_2 = l_11_1:base():get_primary_weapons()
	local l_11_3 = l_11_1:base():get_secondary_weapons()
	l_11_0._primary_weapon_l = l_11_2[1]
	l_11_0._primary_weapon_r = l_11_2[2]
	l_11_0._secondary_weapon_l = l_11_3[1]
	l_11_0._secondary_weapon_r = l_11_3[2]
	l_11_0._turret_object = l_11_1:base():get_turret_object()
	l_11_0._unit:look():set_yaw_angle(l_11_1:rotation():roll())
end

PlayerTank.in_cover = function(l_12_0)
	return false
end

PlayerTank.spawn_weapon_state = function(l_13_0, l_13_1)
	local l_13_5, l_13_6, l_13_7, l_13_8, l_13_9, l_13_10, l_13_11, l_13_12, l_13_13, l_13_14 = nil
	l_13_0:destroy_weapons()
	for i_0,i_1 in ipairs(l_13_1) do
		if i_1.name ~= "" and i_1.name ~= nil then
			l_13_0:spawn_weapon(i_1.name, i_1.ammo)
		end
	end
end

PlayerTank.spawn_weapons = function(l_14_0, l_14_1)
	l_14_0:destroy_weapons()
	for l_14_5 = 1, #l_14_1 do
		l_14_0:spawn_weapon(l_14_1[l_14_5], nil)
	end
end

PlayerTank.destroy_weapons = function(l_15_0)
	local l_15_5, l_15_6, l_15_7, l_15_8 = nil
	local l_15_1 = l_15_0._inventory:all_items()
	for i_0,i_1 in ipairs(l_15_1) do
		i_1:set_slot(0)
	end
	l_15_0._inventory:clear()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PlayerTank.spawn_weapon = function(l_16_0, l_16_1, l_16_2)
	local l_16_3 = World:spawn_unit(l_16_1, l_16_0._unit:position(), l_16_0._unit:rotation())
	assert(l_16_3)
	if l_16_2 then
		l_16_3:logic():set_ammo(l_16_2)
	end
	local l_16_4 = l_16_0._weapon_types[l_16_3:name()]
	l_16_0._inventory:insert_item(l_16_3, l_16_0._inventory:find_free_slot(l_16_4), l_16_4)
	l_16_3:set_visible(false)
end


