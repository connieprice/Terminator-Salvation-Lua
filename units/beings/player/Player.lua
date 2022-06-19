require("units/beings/player/states/PlayerOnGround")
require("units/beings/player/states/PlayerWarping")
require("units/beings/player/states/PlayerDead")
require("units/beings/player/states/PlayerWounded")
require("units/beings/player/states/PlayerBoardingVehicle")
require("units/beings/player/states/PlayerRailTurretState")
require("units/beings/player/states/PlayerRailTrainState")
require("units/beings/player/states/PlayerGrabbed")
require("units/beings/player/states/PlayerInactiveState")
require("units/beings/player/gui/PlayerHud")
require("units/beings/player/new_gui/NewPlayerHud")
require("units/beings/player/sounds/PlayerWorldEffectsSound")
require("units/beings/player/cover_data_retriever/CoverDataRetriever")
require("shared/updatescheduler/UpdateSchedulerDtMethod")
if not Player then
	Player = class()
end
Player._IK_HEAD_MODIFIER_NAME = "ik_head"
Player._HEAD_OBJECT_NAME = "Head"
Player._HEAD_LIMIT_REFERENCE_OBJECT_NAME = "Spine1"
Player._MAX_ABS_HEAD_YAW = 70
Player._MIN_HEAD_PITCH = -10
Player._MAX_HEAD_PITCH = 10
Player._HEAD_YAW_SPEED = 7
Player._HEAD_PITCH_SPEED = 7
Player._HEAD_KEEP_SAME_SIDE_MIN_ANGLE = 160
Player.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	local l_1_2 = l_1_1:anim_state_machine()
	l_1_0._machine = l_1_2
	l_1_0._player_data = l_1_0._unit:player_data()
	l_1_0._input = l_1_0._unit:input()
	l_1_0:set_low_frequency_update_enabled(true)
	if l_1_0._dont_enter_onground_state then
		l_1_0:_enter_state(PlayerInactiveState:new(l_1_0._unit))
	else
		l_1_0:_enter_state(PlayerOnGround:new(l_1_0._unit))
	end
	l_1_0._state_calls = {}
	l_1_0._unit:set_driving("animation")
	l_1_0._was_zoom_aim = false
	l_1_0._was_weapon_in_left_hand = false
	if l_1_0._separate_distance then
		l_1_0._unit:set_separate_distance(l_1_0._separate_distance)
	end
	local l_1_3 = l_1_0._weapons
	l_1_0._inventory = PlayerInventory:new(l_1_1, l_1_0._inventory_setup)
	l_1_0._weapon_equip = {}
	l_1_0._weapon_equip.current = nil
	l_1_0._weapon_equip.right = nil
	l_1_0._weapon_equip.left = nil
	l_1_0._weapon_equip.equip = nil
	l_1_0._weapon_equip.current_weapon_data = nil
	l_1_0._weapon_equip.current_secondary_weapon = nil
	l_1_0._weapon_equip.current_secondary_weapon_data = nil
	l_1_0._left_hand_locked_aim = l_1_2:get_modifier("ik_left_hand_locked_aim")
	l_1_0._right_hand_locked_aim = l_1_2:get_modifier("ik_right_hand_locked_aim")
	l_1_0:spawn_weapons(l_1_0._weapons)
	l_1_0._ik_head = l_1_2:get_modifier(Player._IK_HEAD_MODIFIER_NAME)
	l_1_0._head = l_1_1:get_object(Player._HEAD_OBJECT_NAME)
	assert(l_1_0._head, Player._HEAD_OBJECT_NAME)
	l_1_0._head_limit_reference_object = l_1_1:get_object(Player._HEAD_LIMIT_REFERENCE_OBJECT_NAME)
	assert(l_1_0._head_limit_reference_object, Player._HEAD_LIMIT_REFERENCE_OBJECT_NAME)
	managers.action_event:register_listener(l_1_0, l_1_1, l_1_1)
	l_1_0._emitter = managers.action_event:create_emitter(l_1_1)
	l_1_0._rotation_speed = 4
	l_1_0._warp_to = nil
	local l_1_4 = managers.scheduler
	l_1_0._cover_data_retriever = CoverDataRetriever:new(l_1_4)
	l_1_0._cover_data_retriever:set_priorities(1, 1, 1, 1)
	l_1_2:set_instant_blending("aim", true)
	l_1_0._time_since_i_gave_ammo = 0
	l_1_0:_update_qm_animation_speed()
	local l_1_5 = l_1_1:get_object("aim")
	l_1_0._aimer = AimPoseAimer:new(l_1_2, l_1_5, "g_yaw", "g_pitch", 40)
	l_1_0._aimer:use_exponent_lerp(2, 1)
	l_1_0._character_anims = "male"
	local l_1_6 = "player_head_aim_ik"
	l_1_0._head_aim_ik_updater = UpdateSchedulerDtMethod:new(managers.update_scheduler:add_function(l_1_0._update_head_aim_ik, l_1_6))
	l_1_0._interactables_slotmask = managers.slot:get_mask("interactables")
	l_1_0._last_separate_weight = -1
	l_1_0._damage_data = l_1_0._unit:damage_data()
	l_1_0._secondary_weapon_visibility = false
	l_1_0._allow_head_modifier = false
	l_1_0._machine:forbid_modifier(Player._IK_HEAD_MODIFIER_NAME)
	l_1_0._crouch_param = 0
	l_1_0._damage = l_1_1:damage()
	l_1_0._fire_stopped = true
	l_1_0._fire_started = false
	l_1_0._next_effect_hit = 0
end

Player.destroy = function(l_2_0)
	local l_2_5, l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_11, l_2_12, l_2_13, l_2_14 = nil
	managers.action_event:unregister_listener(l_2_0)
	managers.unit_scripting:unit_destroyed(l_2_0._unit)
	l_2_0._emitter:destroy()
	l_2_0._unit = nil
	local l_2_1 = l_2_0._inventory:all_items()
	for i_0,i_1 in pairs(l_2_1) do
		if alive(i_1) then
			i_1:base():disable()
			i_1:set_slot(0)
		end
	end
	l_2_0._inventory:clear()
	l_2_0._inventory:destroy()
	l_2_0._head_aim_ik_updater:remove()
	l_2_0._variable_frequency_updater:remove()
	l_2_0._current_state_variable_frequency_post_updater:remove()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

local l_0_0 = function(l_3_0, l_3_1, l_3_2, l_3_3)
	if l_3_0 then
		local l_3_4, l_3_5 = l_3_1
	else
		return UpdateSchedulerDtMethod:new(managers.update_scheduler:add_function(l_3_3, l_3_2))
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 6 
end

Player._setup_variable_frequency_updater = function(l_4_0, l_4_1)
	-- upvalues: l_0_0
	if l_4_0._variable_frequency_updater then
		l_4_0._variable_frequency_updater:remove()
	end
	l_4_0._variable_frequency_updater = l_0_0(l_4_1, "low_frequency_player_base", "high_frequency_player_base", l_4_0.variable_frequency_update)
end

Player._setup_current_state_variable_frequency_post_updater = function(l_5_0, l_5_1)
	-- upvalues: l_0_0
	if l_5_0._current_state_variable_frequency_post_updater then
		l_5_0._current_state_variable_frequency_post_updater:remove()
	end
	l_5_0._current_state_variable_frequency_post_updater = l_0_0(l_5_1, "low_frequency_player_movement_state", "high_frequency_player_movement_state", l_5_0._current_state_variable_frequency_post_update)
end

Player.set_low_frequency_update_enabled = function(l_6_0, l_6_1)
	l_6_0:_setup_variable_frequency_updater(l_6_1)
	l_6_0:_setup_current_state_variable_frequency_post_updater(l_6_1)
end

Player.spawn_human_controllable_weapons = function(l_7_0)
	if l_7_0._human_controllable_weapons then
		l_7_0:spawn_weapons(l_7_0._human_controllable_weapons)
	end
end

Player.destroy_weapons = function(l_8_0)
	local l_8_5, l_8_6, l_8_7, l_8_8, l_8_9, l_8_10, l_8_11, l_8_12, l_8_13, l_8_14, l_8_15, l_8_16 = nil
	local l_8_1 = l_8_0._inventory:all_items()
	for i_0,i_1 in ipairs(l_8_1) do
		l_8_0:_setup_weapon_unlink(i_1)
		i_1:unlink()
		i_1:set_slot(0)
	end
	l_8_0._inventory:clear()
	l_8_0._weapon_equip = {}
	l_8_0._weapon_equip.current = nil
	l_8_0._weapon_equip.right = nil
	l_8_0._weapon_equip.left = nil
	l_8_0._weapon_equip.equip = nil
	l_8_0._weapon_equip.current_weapon_data = nil
	l_8_0._weapon_equip.current_secondary_weapon = nil
	l_8_0._weapon_equip.current_secondary_weapon_data = nil
	l_8_0._player_data.hud_inventory_primary_active_slot = nil
	l_8_0._player_data.hud_inventory_secondary_active_slot = nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Player.spawn_weapons = function(l_9_0, l_9_1)
	l_9_0:destroy_weapons()
	local l_9_2 = l_9_1
	for l_9_6 = 1, #l_9_2 do
		local l_9_7 = World:spawn_unit(l_9_2[l_9_6], l_9_0._unit:position(), l_9_0._unit:rotation())
		assert(l_9_7)
		l_9_0:_setup_weapon_link(l_9_7)
		local l_9_8 = l_9_0._weapon_types[l_9_7:name()]
		l_9_0._inventory:insert_item(l_9_7, l_9_0._inventory:find_free_slot(l_9_8), l_9_8)
		if l_9_8 == "primary" then
			if l_9_6 == 1 then
				l_9_0._unit:link("a_weapon_right_back", l_9_7, l_9_7:orientation_object():name())
				l_9_0._weapon_equip.right = l_9_7
				l_9_0._weapon_equip.current = l_9_7
				l_9_0._weapon_equip.current_weapon_data = l_9_7:weapon_data()
				l_9_0._player_data.hud_inventory_primary_active_slot = l_9_0._inventory:find_slot_index(l_9_0._weapon_equip.current)
				l_9_7:base():weapon_stocked(false)
			else
				l_9_0._unit:link(l_9_0._weapon_link_table[l_9_2[l_9_6]], l_9_7, l_9_7:orientation_object():name())
				l_9_7:base():weapon_stocked(true)
			end
		elseif l_9_8 == "secondary" then
			if not l_9_0._weapon_equip.current_secondary_weapon then
				l_9_0._weapon_equip.current_secondary_weapon = l_9_7
				l_9_0._weapon_equip.current_secondary_weapon_data = l_9_7:weapon_data()
				l_9_0._player_data.hud_inventory_secondary_active_slot = l_9_0._inventory:find_slot_index(l_9_7)
			end
			l_9_0._unit:link("a_weapon_right_back", l_9_7, l_9_7:orientation_object():name())
			l_9_7:set_visible(false)
		else
			assert(0)
		end
	end
	l_9_0:update_hand_positions()
end

Player._check_for_close_player_that_gives_ammo = function(l_10_0)
	if l_10_0:can_receive_ammo_for_weapon() == false then
		return 
	end
	local l_10_1 = tweak_data.player.RECEIVE_AMMO_DISTANCE
	local l_10_7 = World:find_units_quick
	local l_10_8 = World
	l_10_7 = l_10_7(l_10_8, l_10_0._unit, "sphere", l_10_0._unit:position(), l_10_1, managers.slot:get_mask("players"))
	local l_10_2 = nil
	l_10_8 = #l_10_7
	if l_10_8 == 0 then
		return 
	end
	l_10_8 = nil
	local l_10_3 = nil
	l_10_2 = pairs
	l_10_3 = l_10_7
	l_10_2 = l_10_2(l_10_3)
	for i_0,i_1 in l_10_2 do
		if l_10_6:base():can_give_ammo() then
			l_10_8 = l_10_6
	else
		end
	end
	if not l_10_8 then
		return 
	end
	l_10_0:_pick_up_ammo_sound(l_10_0:current_weapon():logic():unit():name())
	l_10_0:current_weapon():logic():fill_ammo(l_10_0:current_weapon():logic():clip_size() * tweak_data.player.RECEIVE_AMMO_SIZE_MULTIPLIER)
	l_10_8:base():received_ammo()
	l_10_0._emitter:unit_player_received_ammo_from_player(l_10_0._unit, l_10_8)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Player.is_low_on_ammo = function(l_11_0)
	local l_11_1 = l_11_0:current_weapon()
	if not alive(l_11_1) then
		return false
	end
	return l_11_1:logic():bullet_count() < l_11_1:logic():clip_size()
end

Player.can_receive_ammo_for_weapon = function(l_12_0)
	if TableAlgorithms.find_value(l_12_0:current_weapon():name(), tweak_data.player.RECEIVE_AMMO_WEAPONS) ~= nil then
		return true
	end
	return false
end

Player.can_give_ammo = function(l_13_0)
	return tweak_data.player.RECEIVE_AMMO_TIME < l_13_0._time_since_i_gave_ammo
end

Player.received_ammo = function(l_14_0)
	l_14_0._time_since_i_gave_ammo = 0
end

Player.spawn_weapon_state = function(l_15_0, l_15_1)
	local l_15_6, l_15_7, l_15_8, l_15_9, l_15_10, l_15_11, l_15_12, l_15_13 = nil
	l_15_0:destroy_weapons()
	local l_15_2 = l_15_1
	for i_0,i_1 in ipairs(l_15_2) do
		if i_1.name ~= "" and i_1.name ~= nil then
			assert(World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()))
			World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()):logic():set_ammo(i_1.ammo)
			l_15_0:_setup_weapon_link(World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()))
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_15_0._inventory:insert_item(World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()), l_15_0._inventory:find_free_slot(l_15_0._weapon_types[World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()):name()]), l_15_0._weapon_types[World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()):name()])
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_15_0._weapon_types[World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()):name()] == "primary" then
				if l_15_14 == 1 then
					l_15_0._unit:link("a_weapon_right_back", World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()), World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()):orientation_object():name())
					l_15_0._weapon_equip.right = World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation())
					l_15_0._weapon_equip.current = World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation())
					l_15_0._weapon_equip.current_weapon_data = World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()):weapon_data()
					l_15_0._player_data.hud_inventory_primary_active_slot = l_15_0._inventory:find_slot_index(l_15_0._weapon_equip.current)
					World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()):base():weapon_stocked(false)
				end
			else
				l_15_0._unit:link(l_15_0._weapon_link_table[l_15_15.name], World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()), World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()):orientation_object():name())
				World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()):base():weapon_stocked(true)
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		elseif l_15_0._weapon_types[World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()):name()] == "secondary" then
			if not l_15_0._weapon_equip.current_secondary_weapon then
				l_15_0._weapon_equip.current_secondary_weapon = World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation())
				l_15_0._weapon_equip.current_secondary_weapon_data = World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()):weapon_data()
				l_15_0._player_data.hud_inventory_secondary_active_slot = l_15_0._inventory:find_slot_index(World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()))
			end
			l_15_0._unit:link("a_weapon_right_back", World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()), World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()):orientation_object():name())
			World:spawn_unit(i_1.name, l_15_0._unit:position(), l_15_0._unit:rotation()):set_visible(false)
		else
			assert(0)
		end
	end
	l_15_0:update_hand_positions()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Player._setup_weapon_link = function(l_16_0, l_16_1)
	for l_16_5 = 0, l_16_1:num_bodies() - 1 do
		local l_16_6 = l_16_1:body(l_16_5)
		l_16_6:set_enabled(false)
	end
	l_16_1:base():setup(l_16_0._unit)
	l_16_1:base():set_equiped(true)
end

Player._setup_weapon_unlink = function(l_17_0, l_17_1)
	for l_17_5 = 0, l_17_1:num_bodies() - 1 do
		local l_17_6 = l_17_1:body(l_17_5)
		l_17_6:enable_with_no_velocity()
	end
	l_17_1:base():setup(nil)
	l_17_1:base():set_equiped(false)
end

Player.unit_call = function(l_18_0, l_18_1, l_18_2, l_18_3, ...)
	if l_18_0[l_18_2] then
		local l_18_5 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		if type(l_18_5) == "function" then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

	if nil then
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_18_6 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

	if getmetatable(nil)[l_18_3] then
		end
		getmetatable(nil)[l_18_3](l_18_6, ...)
	end
end

Player.unit_extension_call = function(l_19_0, l_19_1, l_19_2, l_19_3, l_19_4, ...)
	if l_19_0[l_19_2] then
		local l_19_6 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		if type(l_19_6) == "function" then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

	if nil then
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_19_7 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

	if getmetatable(nil)[l_19_3] then
		end
		local l_19_8 = nil
	if getmetatable(nil)[l_19_3](l_19_7) then
		end
		getmetatable(nil)[l_19_3](l_19_7)[l_19_4](getmetatable(nil)[l_19_3](l_19_7), ...)
	end
end

Player.unit_explosion = function(l_20_0, l_20_1, l_20_2)
	if managers.player:is_human_player(l_20_0._unit) then
		local l_20_3 = l_20_2 - l_20_0._unit:position()
	if l_20_3:length() < tweak_data.player.CLOSE_TO_EXPLOSION_DISTANCE then
		end
		managers.volume:activate_set("explosion", l_20_0._unit:position())
	end
end

Player.variable_frequency_update = function(l_21_0, l_21_1)
	local l_21_11, l_21_12, l_21_13, l_21_14 = nil
	local l_21_2 = l_21_0._player_data
	if l_21_0._game_over_fade_started ~= nil then
		l_21_0:_game_over_fade()
	end
	if l_21_0:is_low_on_ammo() then
		l_21_0:_check_for_close_player_that_gives_ammo()
	end
	l_21_0._time_since_i_gave_ammo = l_21_0._time_since_i_gave_ammo + l_21_1
	local l_21_3 = l_21_0._input
	l_21_0:update_switch_weapon(l_21_3)
	l_21_0:update_primary_weapon(l_21_3)
	if not l_21_0._player_data.on_rail_vehicle then
		l_21_0:update_secondary_weapon(l_21_3)
		l_21_0:check_interactables()
	end
	if l_21_0._can_respawn_delay then
		l_21_0._can_respawn_delay = l_21_0._can_respawn_delay - l_21_1
	if l_21_0._can_respawn_delay <= 0 then
		end
		l_21_0._can_respawn_delay = nil
		l_21_2.can_respawn = true
	end
	local l_21_4 = l_21_0._machine
	local l_21_5 = l_21_0._warp_to
	if l_21_5 then
		l_21_0:_enter_state(l_21_5.state)
		local l_21_6 = l_21_4:play(l_21_5.animation_state)
		l_21_6 = l_21_4:play_redirect(l_21_5.weapon_pose_state)
		l_21_0._warp_to = nil
	end
	if l_21_2.has_left_battle_area_timer ~= -1 then
		l_21_2.has_left_battle_area_timer = l_21_2.has_left_battle_area_timer - l_21_1
	if l_21_2.has_left_battle_area_timer < 0 then
		end
		local l_21_7 = managers.player:human_players()
		for i_0,i_1 in pairs(l_21_7) do
			l_21_0._game_over_fade_started = true
			i_1:player_data().has_left_battle_area_timer = -1
		end
		l_21_0._player_data.has_left_battle_area_time_out = true
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_21_7 = l_21_2.is_crouching
	if l_21_7 then
		l_21_7 = 1
	if not l_21_7 then
		end
	end
	l_21_7 = 0
	do
		local l_21_15 = nil
	do
		end
		local l_21_16 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		if math.abs(l_21_16) > 0.001 then
			l_21_0._crouch_param = math.clamp(l_21_0._crouch_param + (l_21_7 - l_21_0._crouch_param) * 6 * l_21_1, 0, 1)
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_21_4:set_global("g_crouch", math.clamp(l_21_0._crouch_param + (l_21_7 - l_21_0._crouch_param) * 6 * l_21_1, 0, 1))
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		if not l_21_0._drama then
			l_21_0._unit:set_extension_update_enabled("drama", false)
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		if not l_21_0._drama then
			l_21_0._drama = l_21_0._unit:drama()
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_21_0._drama then
			l_21_0._drama:update_drama(l_21_1)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Player._update_separate_weight = function(l_22_0, l_22_1, l_22_2, l_22_3)
	local l_22_4 = nil
	if l_22_3.in_cover then
		if l_22_3.cover_outer_position then
			l_22_4 = tweak_data.player.separate_weight.in_cover_outer_position
		else
			if l_22_2:normalized_movement():length() > 0 then
				l_22_4 = tweak_data.player.separate_weight.in_cover
			end
		elseif l_22_3.peeking_up or l_22_3.peeking_left or l_22_3.peeking_right then
			l_22_4 = tweak_data.player.separate_weight.in_cover * 36
		else
			l_22_4 = tweak_data.player.separate_weight.in_cover * 6
		end
	elseif l_22_3.entering_wounded then
		l_22_4 = tweak_data.player.separate_weight.entering_wounded
	else
		l_22_4 = tweak_data.player.separate_weight.on_ground
	end
	if l_22_4 ~= l_22_0._last_separate_weight then
		l_22_1:set_separate_weight(l_22_4)
		l_22_0._last_separate_weight = l_22_4
	end
end

Player.update = function(l_23_0, l_23_1, l_23_2, l_23_3)
	local l_23_12, l_23_14 = nil
	l_23_0._wants_to_switch_weapons = false
	local l_23_4 = l_23_0._player_data
	local l_23_5 = l_23_0._input
	l_23_0._damage:update_player_damage(l_23_1, l_23_2, l_23_3)
	if l_23_4.ragdoll_and_kill == true then
		l_23_4.ragdoll_and_kill = false
		l_23_0._damage:set_fully_damaged()
	end
	local l_23_6 = l_23_5:eye_target_position()
	l_23_0:_update_separate_weight(l_23_1, l_23_5, l_23_4)
	l_23_4.time_since_incoming_fire = l_23_4.time_since_incoming_fire + l_23_3
	if l_23_0._current_state.update then
		local l_23_7 = l_23_0._current_state:update(l_23_2, l_23_3)
		if l_23_7 then
			l_23_0:_enter_state(l_23_7)
		else
			local l_23_11, l_23_13 = l_23_0._current_state_variable_frequency_post_updater:update, l_23_0._current_state_variable_frequency_post_updater
			l_23_11(l_23_13, l_23_0, l_23_3)
		end
		for i_0,i_1 in ipairs(l_23_0._state_calls) do
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_23_0._current_state and l_23_0._current_state[i_1.func] and type(l_23_0._current_state[i_1.func]) == "function" then
				l_23_0._current_state[i_1.func](l_23_0._current_state, unpack(i_1.args))
			end
		end
		l_23_0._state_calls = {}
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_23_7 = l_23_0._variable_frequency_updater
	l_23_7(l_23_7, l_23_0, l_23_3)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_23_4.show_alternative_hud = l_23_7
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_23_7(l_23_0, l_23_3, l_23_4)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Player._current_state_variable_frequency_post_update = function(l_24_0, l_24_1)
	l_24_0._current_state:variable_frequency_post_update(l_24_1)
end

Player._game_over_fade = function(l_25_0)
	managers.menu._ingame_gui:fade_down_with_speed(3)
	if managers.menu._ingame_gui:is_faded_down() then
		l_25_0._game_over_fade_started = nil
		managers.game_transition:game_over()
	end
end

Player._update_qm_animation_speed = function(l_26_0)
	local l_26_1 = l_26_0._unit:anim_state_machine()
	l_26_1:set_global("qm_short_side_enter_speed", tweak_data.player.cover.QM_SHORT_SIDE_ENTER_SPEED)
	l_26_1:set_global("qm_short_side_pre_speed", tweak_data.player.cover.QM_SHORT_SIDE_PRE_SPEED)
	l_26_1:set_global("qm_short_side_leap_speed", tweak_data.player.cover.QM_SHORT_SIDE_LEAP_SPEED)
	l_26_1:set_global("qm_short_side_exit_speed", tweak_data.player.cover.QM_SHORT_SIDE_EXIT_SPEED)
	l_26_1:set_global("qm_short_diagonal_enter_speed", tweak_data.player.cover.QM_SHORT_DIAGONAL_ENTER_SPEED)
	l_26_1:set_global("qm_short_diagonal_pre_speed", tweak_data.player.cover.QM_SHORT_DIAGONAL_PRE_SPEED)
	l_26_1:set_global("qm_short_diagonal_leap_speed", tweak_data.player.cover.QM_SHORT_DIAGONAL_LEAP_SPEED)
	l_26_1:set_global("qm_short_diagonal_exit_speed", tweak_data.player.cover.QM_SHORT_DIAGONAL_EXIT_SPEED)
	l_26_1:set_global("qm_short_forward_enter_speed", tweak_data.player.cover.QM_SHORT_FORWARD_ENTER_SPEED)
	l_26_1:set_global("qm_short_forward_pre_speed", tweak_data.player.cover.QM_SHORT_FORWARD_PRE_SPEED)
	l_26_1:set_global("qm_short_forward_leap_speed", tweak_data.player.cover.QM_SHORT_FORWARD_LEAP_SPEED)
	l_26_1:set_global("qm_short_forward_exit_speed", tweak_data.player.cover.QM_SHORT_FORWARD_EXIT_SPEED)
	l_26_1:set_global("qm_short_jump_enter_speed", tweak_data.player.cover.QM_SHORT_JUMP_ENTER_SPEED)
	l_26_1:set_global("qm_short_jump_pre_speed", tweak_data.player.cover.QM_SHORT_JUMP_PRE_SPEED)
	l_26_1:set_global("qm_short_jump_leap_speed", tweak_data.player.cover.QM_SHORT_JUMP_LEAP_SPEED)
	l_26_1:set_global("qm_short_jump_exit_speed", tweak_data.player.cover.QM_SHORT_JUMP_EXIT_SPEED)
	l_26_1:set_global("qm_long_side_enter_speed", tweak_data.player.cover.QM_LONG_SIDE_ENTER_SPEED)
	l_26_1:set_global("qm_long_side_pre_speed", tweak_data.player.cover.QM_LONG_SIDE_PRE_SPEED)
	l_26_1:set_global("qm_long_side_leap_speed", tweak_data.player.cover.QM_LONG_SIDE_LEAP_SPEED)
	l_26_1:set_global("qm_long_side_exit_speed", tweak_data.player.cover.QM_LONG_SIDE_EXIT_SPEED)
	l_26_1:set_global("qm_long_diagonal_enter_speed", tweak_data.player.cover.QM_LONG_DIAGONAL_ENTER_SPEED)
	l_26_1:set_global("qm_long_diagonal_pre_speed", tweak_data.player.cover.QM_LONG_DIAGONAL_PRE_SPEED)
	l_26_1:set_global("qm_long_diagonal_leap_speed", tweak_data.player.cover.QM_LONG_DIAGONAL_LEAP_SPEED)
	l_26_1:set_global("qm_long_diagonal_exit_speed", tweak_data.player.cover.QM_LONG_DIAGONAL_EXIT_SPEED)
	l_26_1:set_global("qm_long_forward_enter_speed", tweak_data.player.cover.QM_LONG_FORWARD_ENTER_SPEED)
	l_26_1:set_global("qm_long_forward_pre_speed", tweak_data.player.cover.QM_LONG_FORWARD_PRE_SPEED)
	l_26_1:set_global("qm_long_forward_leap_speed", tweak_data.player.cover.QM_LONG_FORWARD_LEAP_SPEED)
	l_26_1:set_global("qm_long_forward_exit_speed", tweak_data.player.cover.QM_LONG_FORWARD_EXIT_SPEED)
	l_26_1:set_global("qm_long_jump_enter_speed", tweak_data.player.cover.QM_LONG_JUMP_ENTER_SPEED)
	l_26_1:set_global("qm_long_jump_pre_speed", tweak_data.player.cover.QM_LONG_JUMP_PRE_SPEED)
	l_26_1:set_global("qm_long_jump_leap_speed", tweak_data.player.cover.QM_LONG_JUMP_LEAP_SPEED)
	l_26_1:set_global("qm_long_jump_exit_speed", tweak_data.player.cover.QM_LONG_JUMP_EXIT_SPEED)
end

Player._enter_state = function(l_27_0, l_27_1)
	local l_27_2 = l_27_0._current_state
	if l_27_2 and l_27_2.leave then
		l_27_2:leave()
	end
	l_27_2 = l_27_1
	if l_27_2.enter then
		l_27_2:enter()
	end
	l_27_0._current_state = l_27_2
end

Player._set_down = function(l_28_0, l_28_1)
	local l_28_7, l_28_8 = nil
	l_28_0._player_data.is_down = l_28_1
	local l_28_2 = true
	local l_28_3 = managers.player:human_players()
	for i_0,i_1 in pairs(l_28_3) do
		if not i_1:base():is_down() then
			l_28_2 = false
		end
	end
	if l_28_2 then
		l_28_0._can_respawn_delay = 2
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Player.can_be_revived = function(l_29_0)
	if l_29_0._player_data.is_down and l_29_0._player_data.wounded then
		return not l_29_0._player_data.entering_wounded
	end
end

Player.is_down = function(l_30_0)
	return l_30_0._player_data.is_down
end

Player.revive = function(l_31_0)
	l_31_0._unit:play_redirect("revived")
	l_31_0._damage_data:revive()
end

Player.current_weapon = function(l_32_0)
	return l_32_0._weapon_equip.current
end

Player.update_primary_weapon = function(l_33_0, l_33_1)
	local l_33_2 = l_33_0._player_data
	local l_33_3 = l_33_0._weapon_equip.current
	if not alive(l_33_3) then
		return 
	end
	local l_33_4 = l_33_0._weapon_equip.current_weapon_data
	l_33_2.can_aim = l_33_4._can_aim
	if l_33_0._fire_started and l_33_1:fire() < tweak_data.player.weapon.FIRE_TRIGGER_THRESHOLD then
		l_33_0._fire_started = false
	end
	local l_33_5 = l_33_1:fire()
	if l_33_0._fire_started and l_33_0._fire_stopped then
		l_33_5 = 0
	end
	if not l_33_2.can_shoot and (l_33_4._bullets_in_clip > 0 or l_33_4._ammo_pool > 0) then
		l_33_2.fire_input = math.max(l_33_5, l_33_2.fire_input)
	end
	if not l_33_2.throwing_grenade and not l_33_2.is_down and not l_33_2.reloading and not l_33_2.switching_weapon and not l_33_2.quickmove and not l_33_0._damage_data:is_fully_damaged() and not l_33_2.warping then
		local l_33_6, l_33_7, l_33_8, l_33_10, l_33_13, l_33_15, l_33_18, l_33_21, l_33_23, l_33_25, l_33_28 = l_33_0._wants_to_switch_weapons
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_33_2.firing or l_33_6 then
		l_33_2.fire_input = 0
	end
	if l_33_2.anim_fire then
		l_33_4.fire_input = 1
		l_33_2.anim_fire = false
	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif l_33_2.can_shoot and not l_33_6 then
		l_33_4.fire_input = math.max(l_33_5, l_33_2.fire_input)
		if tweak_data.player.weapon.FIRE_TRIGGER_THRESHOLD < l_33_4.fire_input then
			l_33_0._fire_started = true
			l_33_0._fire_stopped = false
		end
	else
		l_33_4.fire_input = 0
	end
	if not l_33_4._fire_start then
		local l_33_9, l_33_11, l_33_14, l_33_16, l_33_19, l_33_22, l_33_24, l_33_26, l_33_29 = , l_33_4._firing
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_33_11 and not l_33_0._recoil_anim then
		l_33_2.fire_input = 0
		l_33_0._recoil_anim = l_33_0._weapon_recoil_anims[l_33_3:name()]
		if l_33_0._recoil_anim then
			local l_33_12 = nil
			l_33_0._unit:play_redirect(l_33_0._recoil_anim .. "_start")
		end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif not l_33_11 and l_33_0._recoil_anim then
		local l_33_17 = nil
		l_33_0._unit:play_redirect(l_33_0._recoil_anim .. "_end")
		l_33_0._recoil_anim = nil
	end
	if tweak_data.player.weapon.FIRE_TRIGGER_THRESHOLD >= l_33_4.fire_input and not l_33_4._fire_end and not l_33_4._firing then
		local l_33_20 = nil
	end
	l_33_2.firing = l_33_4._fire_start
	if not l_33_0._fire_stopped and not l_33_2.firing then
		l_33_0._fire_stopped = true
	end
	if l_33_2.reload_finished then
		l_33_4._reload_request = true
		l_33_2.reload_finished = false
		l_33_2.finishing_reload = false
	end
	if l_33_2.reloading and l_33_2.cancel_weapon_pose and not l_33_2.finishing_reload then
		l_33_0._unit:play_redirect("cancel_weapon_pose")
		l_33_2.finishing_reload = true
		l_33_2.cancel_weapon_pose = false
	end
	if not l_33_2.switching_weapon and not l_33_2.throwing_grenade and not l_33_2.blind_firing_up and not l_33_2.blind_firing_side and not l_33_2.finishing_reload and not l_33_2.reloading and not l_33_2.quickmove and not l_33_2.wounded and not l_33_0._wants_to_switch_weapons and l_33_4._reload_ready and not l_33_4._reload_request and (l_33_4._reload_required or l_33_1:reload()) and l_33_4._bullets_in_clip < l_33_4._clip_size and l_33_4._ammo_pool > 0 then
		local l_33_27 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_33_0._weapon_reload_anims[l_33_3:name()] then
			l_33_0._unit:play_redirect(l_33_0._weapon_reload_anims[l_33_3:name()])
		end
	else
		l_33_4._reload_request = true
	end
	local l_33_30 = nil
	local l_33_31 = l_33_3:base()
	l_33_4.aim_target_position = l_33_1:aim_target_position()
	if l_33_2.firing_from_vehicle then
		l_33_4.miss_dispersion = l_33_4.miss_dispersion * l_33_2.vehicle_miss_dispersion_modifier
		l_33_31:set_dispersion_modifier(tweak_data.player.weapon.DEFAULT_DISPERSION_MODIFIER)
	else
		l_33_4.miss_dispersion = l_33_1:miss_dispersion()
		if l_33_2.blind_firing_up or l_33_2.blind_firing_side then
			l_33_31:set_dispersion_modifier(tweak_data.player.weapon.BLIND_FIRE_DISPERSION_MODIFIER)
		end
	elseif l_33_2.is_precision_aiming then
		l_33_31:set_dispersion_modifier(tweak_data.player.weapon.ZOOM_AIM_DISPERSION_MODIFIER)
	else
		l_33_31:set_dispersion_modifier(tweak_data.player.weapon.DEFAULT_DISPERSION_MODIFIER)
	end
end

Player.current_state_name = function(l_34_0)
	local l_34_1, l_34_2 = l_34_0._current_state:name, l_34_0._current_state
	return l_34_1(l_34_2)
end

Player.weapon = function(l_35_0)
	local l_35_1, l_35_2 = l_35_0:current_weapon, l_35_0
	return l_35_1(l_35_2)
end

Player.weapon_data = function(l_36_0)
	return l_36_0._weapon_equip.current_weapon_data
end

Player.weapon_type = function(l_37_0)
	if l_37_0:current_weapon() then
		local l_37_1, l_37_2 = l_37_0:current_weapon():name, l_37_0:current_weapon()
		return l_37_1(l_37_2)
	else
		return nil
	end
end

Player.can_shoot = function(l_38_0)
	return l_38_0._player_data.can_shoot
end

Player.in_cover = function(l_39_0)
	return l_39_0._player_data.in_cover
end

Player.enter_rail = function(l_40_0)
	local l_40_1 = l_40_0._unit:rail():get_rail_state()
	if l_40_1 ~= nil then
		l_40_0:_enter_state(l_40_1)
	end
end

Player.grabbed = function(l_41_0, l_41_1)
	l_41_0:_enter_state(PlayerGrabbed:new(l_41_0._unit, l_41_1))
end

Player.on_moving_to_cover_action_trigger = function(l_42_0)
	l_42_0._player_data.moving_to_cover_action_triggered = true
end

Player.reloading = function(l_43_0)
	l_43_0._emitter:unit_player_reloading(l_43_0._unit)
end

Player.check_interactables = function(l_44_0)
	local l_44_13, l_44_14, l_44_15, l_44_16, l_44_17, l_44_18 = nil
	local l_44_1 = l_44_0._player_data
	local l_44_2 = l_44_0._unit
	l_44_1.current_interactable = nil
	l_44_1.interact_will_only_pick_up_ammo = false
	l_44_1.interact_use = false
	if l_44_1.reloading or not l_44_2:interact_query() then
		return false
	end
	l_44_0._max_interact_distance = tweak_data.player.INTERACT_DISTANCE
	local l_44_3 = l_44_2:position()
	local l_44_4 = l_44_2:find_units_quick("sphere", l_44_3, l_44_0._max_interact_distance, l_44_0._interactables_slotmask)
	if #l_44_4 == 0 then
		return false
	end
	local l_44_5 = 1000000
	local l_44_6 = l_44_2:rotation()
	local l_44_7 = l_44_6:y():with_z(0)
	local l_44_8 = l_44_0._inventory
	do
		local l_44_9 = l_44_0._weapon_types
		for i_0,i_1 in pairs(l_44_4) do
			if alive(i_1) and i_1:interact() and i_1:interact():can_interact_with_player(l_44_2) then
				mvector3.subtract(i_1:position(), l_44_3)
				mvector3.set_z(i_1:position(), 0)
				local l_44_21 = nil
				local l_44_22 = nil
			if mvector3.dot(l_44_7, i_1:position()) > 0 and mvector3.length(i_1:position()) < l_44_5 then
				end
				l_44_1.current_interactable = l_44_20
				local l_44_23 = nil
				if l_44_21:interactable_type() == "weapon" then
					local l_44_24 = nil
					if l_44_9[l_44_20:name()] ~= nil and l_44_20:logic() then
						local l_44_25 = nil
						if l_44_8:item(l_44_20:name()) then
							l_44_1.interact_will_only_pick_up_ammo = l_44_8:item(l_44_20:name()):logic()
							 -- DECOMPILER ERROR: Confused about usage of registers!

							if l_44_8:item(l_44_20:name()):logic() then
								l_44_1.interact_weapon_has_bullet_count = l_44_20:logic():bullet_count()
							else
								l_44_1.interact_weapon_has_bullet_count = 0
							end
							l_44_1.current_interactable_weapon_name = l_44_20:name()
						end
					 -- DECOMPILER ERROR: Confused about usage of registers!

					elseif l_44_25 == "ammo_box" then
						local l_44_26 = nil
						local l_44_27 = nil
						if l_44_8:item(l_44_21:weapon_name()) then
							l_44_1.interact_will_only_pick_up_ammo = true
							l_44_1.interact_weapon_has_bullet_count = l_44_8:item(l_44_21:weapon_name()):logic():max_ammo()
							l_44_1.current_interactable_weapon_name = l_44_21:weapon_name()
						end
					else
						l_44_1.interact_use = true
						l_44_5 = l_44_23
					end
				end
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 108 
end

Player.inventory = function(l_45_0)
	return l_45_0._inventory
end

Player.dynamic_link = function(l_46_0, l_46_1, l_46_2, l_46_3)
	l_46_0._unit:set_driving("orientation_object")
	l_46_0._unit:link(l_46_2)
	local l_46_4 = l_46_0:_dynamic_link_modifier()
	l_46_4:link(l_46_0._unit:get_object(l_46_1), l_46_2:get_object(l_46_3))
	l_46_0._unit:anim_state_machine():force_modifier("dynamic_link")
	l_46_0:kill_mover()
end

Player.unlink = function(l_47_0)
	l_47_0._unit:unlink()
	local l_47_1 = l_47_0:_dynamic_link_modifier()
	l_47_1:unlink()
	l_47_0._unit:anim_state_machine():forbid_modifier("dynamic_link")
end

Player._dynamic_link_modifier = function(l_48_0)
	return l_48_0._unit:anim_state_machine():get_modifier("dynamic_link")
end

Player.ragdoll = function(l_49_0)
	local l_49_7, l_49_8, l_49_9, l_49_10, l_49_13 = nil
	local l_49_1 = {}
	l_49_1.rag_Hips = "Hips"
	l_49_1.rag_Head = "Head"
	l_49_1.rag_LeftUpLeg = "LeftUpLeg"
	l_49_1.rag_RightUpLeg = "RightUpLeg"
	l_49_1.rag_LeftLeg = "LeftLeg"
	l_49_1.rag_RightLeg = "RightLeg"
	l_49_1.rag_Spine = "Spine1"
	l_49_1.rag_Spine2 = "Spine2"
	l_49_1.rag_LeftForeArm = "LeftForeArm"
	l_49_1.rag_RightForeArm = "RightForeArm"
	l_49_1.rag_LeftArm = "LeftArm"
	l_49_1.rag_RightArm = "RightArm"
	local l_49_2 = {}
	local l_49_3 = {}
	for i_0,i_1 in pairs(l_49_1) do
		l_49_2[l_49_11] = l_49_0._unit:body(i_1):velocity()
		l_49_3[l_49_11] = l_49_0._unit:body(i_1):angular_velocity()
	end
	l_49_0:kill_mover()
	l_49_0._unit:set_animatable_enabled("all", false)
	l_49_0._unit:play_state("ragdoll")
	local l_49_12 = l_49_0._unit
	managers.sequence:run_sequence_simple("ragdoll", l_49_12)
	for l_49_12,i_1 in pairs(l_49_1) do
		do
			l_49_0._unit:body(l_49_12):set_velocity(l_49_2[l_49_12] * 2)
			l_49_0._unit:body(l_49_12):set_angular_velocity(l_49_3[l_49_12])
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Player.anim_redirect = function(l_50_0, l_50_1, l_50_2)
	l_50_0._unit:anim_state_machine():play_redirect(l_50_2)
end

Player.anim_set_current_weapon = function(l_51_0, l_51_1, l_51_2)
	l_51_0._weapon_equip.current = l_51_0._weapon_equip[l_51_2]
	l_51_0._player_data.hud_inventory_primary_active_slot = l_51_0._inventory:find_slot_index(l_51_0._weapon_equip.current)
	assert(l_51_0._weapon_equip.current, "cannot set current weapon " .. l_51_2)
	l_51_0._weapon_equip.current:base():weapon_stocked(false)
	l_51_0:update_hand_positions()
	l_51_0._weapon_equip.current_weapon_data = l_51_0._weapon_equip.current:weapon_data()
end

Player.anim_link_weapon = function(l_52_0, l_52_1, l_52_2, l_52_3, l_52_4, l_52_5)
	local l_52_6 = l_52_0._weapon_equip
	local l_52_7 = l_52_6[l_52_2]
	local l_52_8 = l_52_6[l_52_3]
	if l_52_7 then
		l_52_6[l_52_3] = l_52_7
		l_52_6[l_52_2] = l_52_8
		local l_52_9 = l_52_0._unit:get_object(l_52_4)
		if not l_52_5 then
			local l_52_11 = nil
			local l_52_12 = nil
			do
				local l_52_13 = l_52_9:rotation():inverse() * l_52_7:get_object(l_52_7:orientation_object():name()):rotation()
				l_52_0._unit:link(l_52_4, l_52_7, l_52_11)
				l_52_12:set_local_position(l_52_12:position() - l_52_9:position():rotate_with(l_52_9:rotation():inverse()))
				l_52_12:set_local_rotation(l_52_13)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 18 
end

Player.switch_current_weapon = function(l_53_0, l_53_1)
	local l_53_2 = l_53_0._weapon_equip.current
	local l_53_3 = l_53_0._weapon_equip.equip
	assert(l_53_3)
	if l_53_2 then
		l_53_0._unit:link("back_m4_dummy", l_53_2, l_53_2:orientation_object():name())
		l_53_2:base():weapon_stocked(true)
	end
	l_53_0._unit:link("a_weapon_right_back", l_53_3, l_53_3:orientation_object():name())
	l_53_3:base():weapon_stocked(false)
	l_53_0._weapon_equip.current = l_53_3
	l_53_0._weapon_equip.current_weapon_data = l_53_3:weapon_data()
	l_53_0._weapon_equip.right = l_53_3
	l_53_0._weapon_equip.left = nil
	l_53_0._weapon_equip.equip = nil
	l_53_0._player_data.hud_inventory_primary_active_slot = l_53_0._inventory:find_slot_index(l_53_0._weapon_equip.current)
	l_53_0:update_hand_positions()
end

Player.anim_align_link_weapon = function(l_54_0, l_54_1, l_54_2, l_54_3, l_54_4, l_54_5)
	local l_54_6 = l_54_0._weapon_equip
	local l_54_7 = l_54_6[l_54_2]
	if l_54_7 then
		if l_54_3 == "nil" then
			l_54_6[l_54_2] = nil
		else
			l_54_6[l_54_2] = l_54_6[l_54_3]
		end
		local l_54_8 = l_54_0._unit:get_object(l_54_4)
		do
			if not l_54_5 then
				l_54_0._unit:link(l_54_4, l_54_7, l_54_7:orientation_object():name())
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 22 
end

Player.anim_throw_weapon = function(l_55_0, l_55_1, l_55_2)
	local l_55_3 = l_55_0._weapon_equip[l_55_2]
	l_55_0._weapon_equip[l_55_2] = nil
	l_55_3:unlink()
	local l_55_4 = l_55_0._inventory:find_slot_index(l_55_3)
	if l_55_4 ~= nil then
		l_55_0._inventory:remove_item(l_55_4)
	end
	l_55_0:_setup_weapon_unlink(l_55_3)
	l_55_3:unlink()
	local l_55_5 = l_55_3:body("default_body")
	if l_55_5 then
		local l_55_6 = l_55_0._unit:get_object("aim")
		local l_55_7 = Draw:brush(Color(1, 0, 0))
		l_55_5:set_position(l_55_5:position() + l_55_6:rotation():y() * 100)
		l_55_7:line(l_55_3:position(), l_55_3:position() + l_55_6:rotation():y() * 2 * 800)
		l_55_5:push(l_55_3:mass(), l_55_6:rotation():y() * 2 * 800)
	end
end

Player.anim_drop_weapon = function(l_56_0, l_56_1, l_56_2)
	local l_56_3 = l_56_0._weapon_equip[l_56_2]
	l_56_0._weapon_equip[l_56_2] = nil
	l_56_3:unlink()
	local l_56_4 = l_56_0._inventory:find_slot_index(l_56_3)
	if l_56_4 ~= nil then
		l_56_0._inventory:remove_item(l_56_4)
	end
	l_56_0:_setup_weapon_unlink(l_56_3)
	l_56_3:unlink()
end

Player.anim_attach_ammo_to_right_hand = function(l_57_0, l_57_1)
	l_57_0._bullets_to_fill = math.min(l_57_0._ammo_weapon_target:bullet_space_left(), l_57_0._bullets_in_weapon_to_pick_up)
	l_57_0._ammo_pickup_unit:logic():remove_bullets(l_57_0._bullets_to_fill)
	if l_57_0._bullets_to_fill == l_57_0._bullets_in_weapon_to_pick_up then
		l_57_0._ammo_pickup_unit:set_slot(0)
		l_57_0._ammo_pickup_unit = nil
	end
end

Player.anim_attach_grenade_to_left_hand = function(l_58_0, l_58_1)
	l_58_0._weapon_equip.current:base():attach_grenade_to_left_hand()
end

Player.anim_detach_grenade_from_left_hand = function(l_59_0, l_59_1)
	l_59_0._weapon_equip.current:base():detach_grenade_from_left_hand()
end

Player.anim_add_ammo = function(l_60_0, l_60_1)
	local l_60_2 = l_60_0._ammo_weapon_target:fill_ammo(l_60_0._bullets_to_fill)
	l_60_0._emitter:unit_ammo_fill(l_60_0._unit, l_60_2, l_60_0._ammo_weapon_target)
	l_60_0._ammo_weapon_target = nil
end

Player.force_equip_weapon = function(l_61_0, l_61_1, l_61_2)
	local l_61_3 = l_61_0._inventory:find_free_slot("primary")
	local l_61_4 = l_61_0._weapon_equip.current
	if alive(l_61_4) then
		l_61_4:weapon_data().fire_input = 0
		if l_61_3 ~= nil then
			l_61_0._unit:link(l_61_0._weapon_link_table[l_61_4:name()], l_61_4, l_61_4:orientation_object():name())
		else
			l_61_0:set_weapon_visibility(l_61_4, false)
			l_61_0._weapon_equip.hidden = l_61_4
		end
	else
		Application:debug("Player:force_equip_weapon -> no current_weapon found!")
	end
	l_61_0._weapon_equip.current = l_61_1
	l_61_0._weapon_equip.current_weapon_data = l_61_1:weapon_data()
	l_61_0._weapon_equip.right = l_61_1
	l_61_0._player_data.hud_inventory_primary_active_slot = l_61_0._inventory:find_slot_index(l_61_0._weapon_equip.current)
	l_61_0:_setup_weapon_link(l_61_1)
	if l_61_2 then
		l_61_0._unit:link(l_61_2, l_61_1, l_61_1:orientation_object():name())
	end
	l_61_0:update_hand_positions()
end

Player.set_unequiped_weapon_visiblity = function(l_62_0, l_62_1, l_62_2)
	local l_62_7, l_62_8, l_62_9, l_62_10, l_62_11, l_62_12, l_62_13, l_62_14, l_62_15, l_62_16 = nil
	local l_62_3 = l_62_0._inventory:all_items()
	for i_0,i_1 in pairs(l_62_3) do
		if i_1 ~= l_62_0._weapon_equip.current then
			l_62_0:set_weapon_visibility(i_1, l_62_1)
		if l_62_2 ~= nil then
			end
			i_1:set_enabled(not l_62_2)
		end
	end
end

Player.set_current_weapon_visibility = function(l_63_0, l_63_1, l_63_2)
	do
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if l_63_2 and l_63_2 ~= "true" then
			l_63_0:set_weapon_visibility(l_63_0._weapon_equip.current, not l_63_0._weapon_equip.current)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 10 
end

Player.set_weapon_visibility = function(l_64_0, l_64_1, l_64_2)
	assert(l_64_1)
	l_64_1:set_visible(l_64_2)
	local l_64_3 = l_64_1:base():reload_unit()
	if l_64_3 then
		l_64_3:set_visible(l_64_2)
	end
end

Player.unequip_forced_weapon = function(l_65_0)
	local l_65_1 = l_65_0._weapon_equip.hidden
	if not l_65_1 then
		local l_65_2 = l_65_0._inventory:find_first_item("primary")
		l_65_1 = l_65_0._inventory:item_by_index(l_65_2)
	end
	assert(l_65_1)
	l_65_0:set_weapon_visibility(l_65_1, true)
	l_65_0._weapon_equip.right = l_65_1
	l_65_0._weapon_equip.current = l_65_1
	l_65_0._weapon_equip.current_weapon_data = l_65_1:weapon_data()
	local l_65_3 = "a_weapon_right_back"
	l_65_0._unit:link(l_65_3, l_65_1, l_65_1:orientation_object():name())
	l_65_0._player_data.hud_inventory_primary_active_slot = l_65_0._inventory:find_slot_index(l_65_0._weapon_equip.current)
	l_65_0._weapon_equip.hidden = nil
	l_65_0:update_hand_positions()
end

Player.equip_primary_weapon = function(l_66_0, l_66_1)
	local l_66_2 = l_66_0._player_data
	if not l_66_2.switching_weapon and not l_66_2.picking_up then
		local l_66_3 = l_66_0._weapon_equip
		if not l_66_3.right then
			local l_66_4, l_66_5 = l_66_3.left
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_66_4 == nil then
			return 
		end
		local l_66_6 = nil
	if l_66_1 ~= nil then
		end
		local l_66_7 = nil
		local l_66_8 = l_66_6:name()
	if l_66_8 ~= l_66_7:name() then
		end
		local l_66_9 = nil
		if l_66_0._weapon_switch_anims[l_66_8] == nil then
			return 
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_66_10 = nil
		if l_66_0._weapon_switch_anims[l_66_8][l_66_9] == nil then
			return 
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_66_11 = nil
	if l_66_0._unit:play_redirect(l_66_0._weapon_switch_anims[l_66_8][l_66_9]) ~= "" and l_66_0._unit:play_redirect(l_66_0._weapon_switch_anims[l_66_8][l_66_9]) ~= nil then
		end
	if l_66_1 ~= l_66_3.right then
		end
	if l_66_1 ~= l_66_3.left then
		end
		l_66_3.equip = l_66_1
		l_66_0._wants_to_switch_weapons = true
	end
end

Player.pick_up_ammo_from_weapon = function(l_67_0, l_67_1)
	assert(l_67_1)
	local l_67_2 = l_67_0._player_data
	if l_67_2.picking_up or l_67_2.switching_weapon then
		return 
	end
	l_67_0:pick_up_ammo(l_67_1:name(), l_67_1)
end

Player.pick_up_ammo = function(l_68_0, l_68_1, l_68_2)
	local l_68_3 = l_68_0._inventory:item(l_68_1)
	if not l_68_3 then
		return 
	end
	local l_68_4 = (l_68_3:logic())
	local l_68_5 = nil
	if l_68_2 then
		local l_68_6 = l_68_2:logic()
		local l_68_7 = l_68_6:bullet_count()
		l_68_5 = math.max(0, math.min(l_68_4:bullet_space_left(), l_68_7))
		l_68_6:remove_bullets(l_68_5)
		local l_68_8 = assert
		l_68_8(l_68_6:bullet_count() >= 0)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_68_8 == 0 then
			l_68_8(l_68_2, 0)
		end
	else
		l_68_5 = l_68_4:bullet_space_left()
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_68_11 = l_68_4:fill_ammo(l_68_8)
	l_68_0._emitter:unit_ammo_fill(l_68_0._unit, l_68_11, l_68_4)
	if l_68_11 > 0 then
		l_68_0:_pick_up_ammo_sound(l_68_1)
	end
end

Player._pick_up_ammo_sound = function(l_69_0, l_69_1)
	local l_69_2 = "foley_pickup_"
	if l_69_1 == "rpg7_grenadelauncher_onfoot" then
		l_69_2 = l_69_2 .. "rocket"
	elseif l_69_1 == "m67_grenade" then
		l_69_2 = l_69_2 .. "grenade"
	elseif l_69_1 == "pipebomb" then
		l_69_2 = l_69_2 .. l_69_1
	else
		l_69_2 = l_69_2 .. "ammo"
	end
	l_69_0._unit:play(l_69_2)
end

Player.pickup_primary_weapon = function(l_70_0, l_70_1, l_70_2)
	local l_70_3 = l_70_0._weapon_equip
	local l_70_4 = l_70_3.right
	if l_70_4 == nil then
		return 
	end
	local l_70_5 = l_70_1
	if l_70_5 ~= nil then
		local l_70_6 = l_70_4:name()
		local l_70_7 = l_70_5:name()
	if l_70_6 ~= l_70_7 then
		end
		local l_70_8 = l_70_0._unit:play_redirect("pickup_rifle")
	if l_70_8 ~= "" and l_70_8 ~= nil then
		end
		l_70_3.equip = l_70_1
		local l_70_9 = assert
		l_70_9(l_70_1 ~= l_70_3.right and l_70_1 ~= l_70_3.left)
		l_70_9 = l_70_0._inventory
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_70_9 == nil then
			l_70_0._inventory:remove_item(l_70_9)
			l_70_3.current:set_position(l_70_1:position())
			l_70_3.current:set_rotation(l_70_1:rotation())
			l_70_3.current:unlink()
			l_70_0:_setup_weapon_unlink(l_70_3.current)
			l_70_3.current = nil
			l_70_3.right = nil
			l_70_3.left = nil
		end
		l_70_0:inventory():insert_item(l_70_1, l_70_9, l_70_2)
		l_70_0:_setup_weapon_link(l_70_1)
		l_70_0:switch_current_weapon(l_70_0._unit)
		l_70_0._wants_to_switch_weapons = true
	end
end

Player.pickup_secondary_weapon = function(l_71_0, l_71_1, l_71_2)
	assert(l_71_1)
	local l_71_3 = l_71_0._weapon_equip
	if l_71_0._inventory:find_free_slot(l_71_2) == nil then
		local l_71_4, l_71_5, l_71_6, l_71_7, l_71_8, l_71_9, l_71_10, l_71_11 = l_71_0._inventory:find_slot_index(l_71_3.current_secondary_weapon)
		l_71_5 = l_71_0._inventory
		l_71_5, l_71_6 = l_71_5:remove_item, l_71_5
		l_71_7 = l_71_4
		l_71_5(l_71_6, l_71_7)
		l_71_5 = l_71_3.current_secondary_weapon
		l_71_5, l_71_6 = l_71_5:set_position, l_71_5
		l_71_7, l_71_8 = l_71_1:position, l_71_1
		l_71_8, l_71_7 = .end, l_71_7(l_71_8)
		l_71_5(l_71_6, l_71_7, l_71_8, l_71_9, l_71_10, l_71_11)
		l_71_5 = l_71_3.current_secondary_weapon
		l_71_5, l_71_6 = l_71_5:set_rotation, l_71_5
		l_71_7, l_71_8 = l_71_1:rotation, l_71_1
		l_71_8, l_71_7 = .end, l_71_7(l_71_8)
		l_71_5(l_71_6, l_71_7, l_71_8, l_71_9, l_71_10, l_71_11)
		l_71_5, l_71_6 = l_71_0:_setup_weapon_unlink, l_71_0
		l_71_7 = l_71_3.current_secondary_weapon
		l_71_5(l_71_6, l_71_7)
		l_71_5 = l_71_3.current_secondary_weapon
		l_71_5, l_71_6 = l_71_5:unlink, l_71_5
		l_71_5(l_71_6)
		l_71_5 = l_71_3.current_secondary_weapon
		l_71_5, l_71_6 = l_71_5:set_rotation, l_71_5
		l_71_7, l_71_8 = l_71_1:rotation, l_71_1
		l_71_8, l_71_7 = .end, l_71_7(l_71_8)
		l_71_5(l_71_6, l_71_7, l_71_8, l_71_9, l_71_10, l_71_11)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_71_0:inventory():insert_item(l_71_1, l_71_4, l_71_2)
	l_71_0._player_data.hud_inventory_secondary_active_slot = l_71_0._inventory:find_slot_index(l_71_1)
	l_71_3.current_secondary_weapon = l_71_1
	l_71_3.current_secondary_weapon_data = l_71_1:weapon_data()
	l_71_0._unit:link("a_weapon_right_back", l_71_1, l_71_1:orientation_object():name())
	l_71_1:set_visible(false)
	l_71_0:_setup_weapon_link(l_71_1)
end

Player.pick_up_weapon = function(l_72_0, l_72_1)
	local l_72_2 = l_72_0._player_data
	if not l_72_0._wants_to_switch_weapons and not l_72_2.picking_up and not l_72_2.switching_weapon and not l_72_2.firing then
		local l_72_3 = l_72_0._weapon_types[l_72_1:name()]
		assert(l_72_3)
		local l_72_4 = "pickup_" .. l_72_3 .. "_weapon"
		local l_72_5 = l_72_0[l_72_4]
		assert(l_72_5)
		l_72_5(l_72_0, l_72_1, l_72_3)
		local l_72_6 = WeaponUtilities.weapon_name_to_short_name[l_72_1:name()]
		local l_72_7 = "foley_pickup_" .. l_72_6
		l_72_0._unit:play(l_72_7)
	end
end

Player.play_state = function(l_73_0, l_73_1, l_73_2)
	l_73_1:play_state(l_73_2)
end

Player.movement_state_call = function(l_74_0, l_74_1, l_74_2, ...)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_74_0._current_state and l_74_0._current_state[l_74_2] and type(l_74_0._current_state[l_74_2]) == "function" then
		l_74_0._current_state[l_74_2](l_74_0._current_state, ...)
	end
end

Player.deffered_state_call = function(l_75_0, l_75_1, l_75_2, ...)
	local l_75_4 = table.insert
	local l_75_5 = l_75_0._state_calls
	local l_75_6 = {func = l_75_2}
	l_75_6.args = {...}
	l_75_4(l_75_5, l_75_6)
end

Player.player_has_control = function(l_76_0)
	if not managers.worldcamera:current_world_camera() then
		local l_76_1 = l_76_0._player_data.player_has_controllable_camera
	else
		return false
	end
end

Player.play_custom_animation = function(l_77_0, l_77_1)
	local l_77_2 = l_77_0._unit:play_redirect(l_77_1)
	if l_77_2 == "" then
		cat_print("debug", "Redirect '" .. l_77_1 .. "' not defined from current states")
	end
end

Player.weapon_type = function(l_78_0, l_78_1)
	return l_78_0._weapon_types[l_78_1]
end

Player.secondary_weapon = function(l_79_0)
	local l_79_1, l_79_2 = l_79_0:current_secondary_weapon, l_79_0
	return l_79_1(l_79_2)
end

Player.secondary_weapon_data = function(l_80_0)
	local l_80_1, l_80_2 = l_80_0:current_secondary_weapon():weapon_data, l_80_0:current_secondary_weapon()
	return l_80_1(l_80_2)
end

Player.secondary_weapon_type = function(l_81_0)
	local l_81_1, l_81_2 = l_81_0:current_secondary_weapon():name, l_81_0:current_secondary_weapon()
	return l_81_1(l_81_2)
end

Player.current_secondary_weapon = function(l_82_0)
	return l_82_0._weapon_equip.current_secondary_weapon
end

Player.equip_secondary_weapon = function(l_83_0, l_83_1)
	local l_83_2 = l_83_0._player_data
	local l_83_3 = assert
	do
		l_83_3(not l_83_1 or l_83_0._weapon_types[l_83_1:name()] == "secondary")
		l_83_3 = l_83_2.switching_weapon
		if not l_83_3 then
			l_83_3 = l_83_2.picking_up
		if not l_83_3 then
			end
			l_83_3 = l_83_0._weapon_equip
			l_83_3.current_secondary_weapon = l_83_1
			l_83_3 = l_83_0._weapon_equip
			l_83_3.current_secondary_weapon_data = l_83_1:weapon_data()
			l_83_3 = l_83_0._inventory
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_83_2.hud_inventory_secondary_active_slot = l_83_3
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Player.update_switch_weapon = function(l_84_0, l_84_1)
	local l_84_2 = l_84_0._player_data
	if not l_84_2.firing and l_84_1:weapon_slot() ~= 0 and not l_84_2.blind_firing_side and not l_84_2.blind_firing_up and not l_84_2.switching_weapon and not l_84_2.wounded and not l_84_2.throwing_grenade and not l_84_0._wants_to_switch_weapons then
		local l_84_3 = l_84_0._inventory:item_by_index(l_84_1:weapon_slot())
	if l_84_3 then
		end
		local l_84_4 = l_84_0._weapon_types[l_84_3:name()]
		local l_84_5 = "equip_" .. l_84_4 .. "_weapon"
		local l_84_6 = l_84_0[l_84_5]
		assert(l_84_6)
		l_84_6(l_84_0, l_84_3)
	end
end

Player.update_hand_positions = function(l_85_0, l_85_1)
	local l_85_2 = l_85_0._weapon_equip.current
	if alive(l_85_2) then
		local l_85_3 = l_85_2:get_object("a_front_hand")
		local l_85_4 = l_85_2:orientation_object()
	if l_85_3 then
		end
		while l_85_3 ~= l_85_4 do
			local l_85_5, l_85_6, l_85_7, l_85_8 = Vector3(0, 0, 0) + l_85_3:local_position()
			l_85_6, l_85_7 = l_85_3:parent, l_85_3
			l_85_6 = l_85_6(l_85_7)
			l_85_3 = l_85_6
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_85_0._left_hand_locked_aim:set_target_position(l_85_5)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_85_0._right_hand_locked_aim:set_target_position(l_85_5)
	end
end

Player.can_secondary_fire = function(l_86_0)
	local l_86_1 = l_86_0._player_data
	if not l_86_1.throwing_grenade and l_86_1.can_fire_grenade and not l_86_1.switching_weapon and alive(l_86_0._weapon_equip.current_secondary_weapon) and l_86_0._weapon_equip.current_secondary_weapon_data._bullets_in_clip > 0 then
		return true
	end
	return false
end

Player.update_secondary_weapon = function(l_87_0, l_87_1)
	local l_87_2 = l_87_0._player_data
	local l_87_3 = l_87_0._weapon_equip.current_secondary_weapon
	if not alive(l_87_3) then
		return 0
	end
	if l_87_0._secondary_weapon_visibility ~= l_87_2.grenade_visible then
		l_87_3:set_visible(l_87_2.grenade_visible)
		l_87_0._secondary_weapon_visibility = l_87_2.grenade_visible
	end
	local l_87_4 = l_87_0._weapon_equip.current_secondary_weapon_data
	if l_87_2.fire_grenade then
		l_87_4.fire_input = 1
		l_87_2.fire_grenade = false
	else
		l_87_4.fire_input = 0
	end
	l_87_4.aim_target_position = l_87_1:aim_target_position()
	l_87_4.miss_dispersion = 0
	l_87_4._dispersion_modifier = 0
	l_87_4._reload_request = l_87_4._bullets_in_clip == 0 and l_87_4._ammo_pool > 0
end

Player.on_spawn_projectile = function(l_88_0, l_88_1)
	local l_88_2 = l_88_1:base()
	if l_88_2 and l_88_2.set_blind_fire and not l_88_0._player_data.blind_firing_up then
		l_88_2:set_blind_fire(l_88_0._player_data.blind_firing_side)
		if l_88_2 and l_88_2.set_precision_aiming then
			l_88_2:set_precision_aiming(l_88_0._player_data.is_precision_aiming)
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 15 
end

Player.set_rotation_speed = function(l_89_0, l_89_1)
	l_89_0._rotation_speed = l_89_1
end

Player.check_fully_damaged = function(l_90_0)
	if l_90_0._damage_data:is_fully_damaged() then
		if l_90_0._player_data.revive_when_fully_damaged then
			local l_90_1, l_90_2 = PlayerWounded:new, PlayerWounded
			local l_90_3 = l_90_0._unit
			return l_90_1(l_90_2, l_90_3)
		end
	else
		local l_90_4, l_90_5 = PlayerDead:new, PlayerDead
		local l_90_6 = l_90_0._unit
		return l_90_4(l_90_5, l_90_6)
	end
	return 
end

Player.activate_mover = function(l_91_0, l_91_1)
	l_91_0._unit:activate_mover(l_91_1)
	l_91_0._unit:mover():set_high_quality(l_91_0._unit:player_data().high_mover_quality)
	l_91_0._mover_name = l_91_1
end

Player.kill_mover = function(l_92_0)
	l_92_0._unit:kill_mover()
end

Player.set_mover_high_quality = function(l_93_0, l_93_1)
	l_93_0._unit:player_data().high_mover_quality = l_93_1
	if l_93_0._unit:mover() then
		l_93_0._unit:mover():set_high_quality(l_93_1)
	end
end

Player.check_enter_cover = function(l_94_0, l_94_1, l_94_2)
	local l_94_3 = l_94_0._player_data
	if l_94_3.in_cover and l_94_1 then
		if l_94_3.cover_outer_position then
			local l_94_4, l_94_5 = PlayerInBackCover:new, PlayerInBackCover
			local l_94_6 = l_94_0._unit
			local l_94_7 = l_94_1:cover()
			local l_94_8 = l_94_1:closest_cover_point():position()
			local l_94_9 = l_94_2
			return l_94_4(l_94_5, l_94_6, l_94_7, l_94_8, l_94_9)
		end
	else
		local l_94_10, l_94_11 = PlayerInCover:new, PlayerInCover
		local l_94_12 = l_94_0._unit
		local l_94_13 = l_94_1:cover()
		local l_94_14, l_94_15 = l_94_1:closest_cover_point():position(), .end
		return l_94_10(l_94_11, l_94_12, l_94_13, l_94_14, l_94_15)
	end
	return nil
end

Player.warp_to = function(l_95_0, l_95_1, l_95_2)
	l_95_0._warp_to = {}
	l_95_0._warp_to.animation_state = "onground/rifle/stand/idle/idle"
	l_95_0._warp_to.weapon_pose_state = "cancel_weapon_pose"
	l_95_0._warp_to.state = PlayerWarping:new(l_95_0._unit, l_95_2, l_95_1)
end

Player.footstep = function(l_96_0, l_96_1, l_96_2, l_96_3)
	l_96_0._emitter:unit_footstep(l_96_0._unit, l_96_2, l_96_3)
end

Player._update_head_aim = function(l_97_0, l_97_1, l_97_2)
	local l_97_3 = nil
	do
		local l_97_4, l_97_7 = , not l_97_2.should_aim_head_at_eye_target_position or l_97_2.look_at_unit
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_97_7 then
		local l_97_5, l_97_6 = nil
		if l_97_0._head_aim_ik_updater and not l_97_0._allow_head_modifier then
			l_97_0._machine:allow_modifier(Player._IK_HEAD_MODIFIER_NAME)
		end
	 -- DECOMPILER ERROR: Overwrote pending register.

	elseif l_97_0._head_aim_ik_updater:update(l_97_0, l_97_1, l_97_4) then
		l_97_0._machine:forbid_modifier(Player._IK_HEAD_MODIFIER_NAME)
		l_97_0._allow_head_modifier = false
	end
end

Player._update_head_aim_ik = function(l_98_0, l_98_1, l_98_2)
	local l_98_3 = l_98_2:position()
	local l_98_4 = l_98_0._head
	local l_98_5 = l_98_4:position()
	local l_98_6 = l_98_4:rotation()
	local l_98_7 = l_98_6:z()
	local l_98_8 = l_98_0._head_limit_reference_object
	local l_98_9 = l_98_8:rotation()
	local l_98_10 = l_98_9:z()
	local l_98_11 = l_98_9:x()
	local l_98_12 = l_98_7:to_polar_with_reference(l_98_10, l_98_11)
	local l_98_13 = l_98_12.spin
	local l_98_14 = l_98_12.pitch
	local l_98_15 = l_98_3 - l_98_5:to_polar_with_reference(l_98_10, l_98_11)
	local l_98_16 = l_98_15.spin
	local l_98_17 = l_98_15.pitch
	local l_98_18 = nil
	local l_98_19 = math.abs(l_98_16)
	if Player._MAX_ABS_HEAD_YAW < l_98_19 then
		if Player._HEAD_KEEP_SAME_SIDE_MIN_ANGLE <= l_98_19 then
			l_98_18 = math.sign(l_98_13) * Player._MAX_ABS_HEAD_YAW
		else
			l_98_18 = math.sign(l_98_16) * Player._MAX_ABS_HEAD_YAW
		end
	else
		l_98_18 = l_98_16
	end
	local l_98_20 = math.clamp(l_98_17, Player._MIN_HEAD_PITCH, Player._MAX_HEAD_PITCH)
	local l_98_21 = l_98_13 + (l_98_18 - l_98_13) * l_98_1 * Player._HEAD_YAW_SPEED
	local l_98_22 = l_98_14 + (l_98_20 - l_98_14) * l_98_1 * Player._HEAD_PITCH_SPEED
	local l_98_23 = Polar(l_98_15.r, l_98_22, l_98_21)
	local l_98_24 = l_98_5 + l_98_23:to_vector_with_reference(l_98_10, l_98_11)
	local l_98_25 = l_98_0._ik_head
	l_98_25:set_target_z_look_at(l_98_24)
end

Player._draw_position_trace = function(l_99_0)
	local l_99_1 = l_99_0._unit:position()
	if l_99_0._prev_pos then
		local l_99_2 = Draw:pen("permanent")
		l_99_2:set("green")
		l_99_2:line(l_99_0._prev_pos, l_99_1)
		print("speed " .. l_99_1 - l_99_0._prev_pos:length())
	end
	l_99_0._prev_pos = l_99_0._unit:position()
end

Player._update_aim_parameters = function(l_100_0, l_100_1, l_100_2, l_100_3, l_100_4, l_100_5, l_100_6, l_100_7)
	local l_100_8 = l_100_0._player_data
	if l_100_8.global_aiming then
		if l_100_8.local_yaw_normalized > -0.01 and l_100_8.local_yaw_normalized < 0.01 then
			l_100_8.local_yaw_normalized = 0
		end
		if l_100_8.local_pitch_normalized > -0.01 and l_100_8.local_pitch_normalized < 0.01 then
			l_100_8.local_pitch_normalized = 0
		end
		l_100_0._aimer:set_yaw_pitch(l_100_8.local_yaw_normalized, l_100_8.local_pitch_normalized)
	else
		local l_100_9 = l_100_0._input
		local l_100_10 = l_100_9:aim_target_position()
		if l_100_6 then
			l_100_10 = l_100_9:eye_target_position()
		end
		l_100_0._aimer:update(l_100_1, l_100_10, l_100_4, l_100_5, l_100_2, l_100_3, l_100_8.min_yaw_angle, l_100_8.max_yaw_angle, l_100_8.min_pitch_angle, l_100_8.max_pitch_angle, l_100_7)
	end
end

Player._anim_state_names = function(l_101_0)
	local l_101_7, l_101_8, l_101_9, l_101_10 = nil
	local l_101_1 = l_101_0._machine
	local l_101_2 = l_101_1:config():segments()
	local l_101_3 = ""
	for i_0,i_1 in pairs(l_101_2) do
		if l_101_1:segment_state(i_1) and l_101_1:segment_state(i_1) ~= "" then
			l_101_3 = l_101_3 .. "Segment name: " .. i_1 .. ", State name: " .. l_101_1:segment_state(i_1) .. ". "
		end
	end
	return l_101_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Player.character_anims = function(l_102_0)
	return l_102_0._character_anims
end

local l_0_1 = function(l_103_0, l_103_1, l_103_2)
	if l_103_0 and not l_103_1 then
		local l_103_3, l_103_4 = l_103_2
	else
		return nil
	end
end

local l_0_2 = function(l_104_0, l_104_1, l_104_2, l_104_3, l_104_4, l_104_5)
	if l_104_0 and l_104_1 then
		local l_104_6 = tweak_data.player.cover.DISTANCE_FROM_EDGE
	end
	do return end
	if l_104_2 and l_104_3 and l_104_4 then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	return -l_104_5
end

Player.distance_to_cover_edge = function(l_105_0, l_105_1, l_105_2, l_105_3, l_105_4, l_105_5)
	-- upvalues: l_0_2 , l_0_1
	local l_105_6 = l_105_1.cover_line
	assert(l_105_6.is_valid)
	local l_105_7 = l_105_6.value
	local l_105_8 = l_105_1.left_cover
	local l_105_9 = l_105_8.value
	local l_105_10 = l_105_8.is_valid
	local l_105_11 = l_105_1.right_cover
	local l_105_12 = l_105_11.value
	local l_105_13 = l_105_11.is_valid
	local l_105_14 = l_105_1.change_to_left_cover_distance
	local l_105_15 = l_105_1.change_to_right_cover_distance
	if l_105_8.is_valid and l_105_11.is_valid and l_105_14.is_valid then
		local l_105_16, l_105_18, l_105_21, l_105_23, l_105_26 = l_105_15.is_valid
	end
	if l_105_10 and l_105_9 ~= nil and not l_105_0._player_data.peeking_left then
		local l_105_17 = nil
	end
	do
		local l_105_19, l_105_22, l_105_24, l_105_27 = not l_105_14.is_valid
	end
	if l_105_13 and l_105_12 ~= nil and not l_105_0._should_clamp_at_right_edge and not l_105_0._player_data.peeking_right then
		local l_105_20 = nil
	end
	do
		local l_105_25, l_105_28 = not l_105_15.is_valid
	end
	local l_105_29 = nil
	local l_105_30 = l_0_2(l_105_2, l_105_20, l_105_10, l_105_9, l_105_14.is_valid, l_105_14.value)
	local l_105_31 = l_0_2(l_105_3, l_105_29, l_105_13, l_105_12, l_105_15.is_valid, l_105_15.value)
	local l_105_32 = (l_105_7:length())
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_105_4 then
		do return end
	end
	do
		local l_105_33 = nil
		l_105_4 = l_105_7:closest_cover_point(l_105_5, l_105_30, l_105_31, 2)
		l_105_33 = 
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_105_34 = nil
	local l_105_35 = l_105_33
	if not l_105_30 or l_105_31 then
		local l_105_38 = l_105_32 - l_105_34
		local l_105_39 = nil
		do
			local l_105_40 = nil
			return {result_is_valid = l_105_17, cover_point = l_105_4, cover_line_distance = l_105_34, cover_line_length = l_105_32, clamp_at_left_edge = l_105_20, clamp_at_right_edge = l_105_29, distance_from_left_edge = l_105_30, distance_from_right_edge = l_105_31, distance_to_left_edge = l_105_35, distance_to_right_edge = l_105_38, distance_to_clamped_left_edge = l_105_39, distance_to_clamped_right_edge = l_105_40, distance_to_left_cover_edge = l_0_1(l_105_10, l_105_9, l_105_34 - l_105_30), distance_to_right_cover_edge = l_0_1(l_105_13, l_105_12, l_105_32 - l_105_34 - l_105_31)}
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 96 
end

Player.show_bullet_hit = function(l_106_0)
	if not l_106_0._next_effect_hit_duration then
		l_106_0._next_effect_hit = Application:time() + (l_106_0._next_effect_hit > Application:time() or 0)
		return true
		return false
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 14 
end


