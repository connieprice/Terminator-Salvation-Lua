local L0_0
L0_0 = require
L0_0("units/beings/player/states/PlayerOnGround")
L0_0 = require
L0_0("units/beings/player/states/PlayerWarping")
L0_0 = require
L0_0("units/beings/player/states/PlayerDead")
L0_0 = require
L0_0("units/beings/player/states/PlayerWounded")
L0_0 = require
L0_0("units/beings/player/states/PlayerBoardingVehicle")
L0_0 = require
L0_0("units/beings/player/states/PlayerRailTurretState")
L0_0 = require
L0_0("units/beings/player/states/PlayerRailTrainState")
L0_0 = require
L0_0("units/beings/player/states/PlayerGrabbed")
L0_0 = require
L0_0("units/beings/player/states/PlayerInactiveState")
L0_0 = require
L0_0("units/beings/player/gui/PlayerHud")
L0_0 = require
L0_0("units/beings/player/new_gui/NewPlayerHud")
L0_0 = require
L0_0("units/beings/player/sounds/PlayerWorldEffectsSound")
L0_0 = require
L0_0("units/beings/player/cover_data_retriever/CoverDataRetriever")
L0_0 = require
L0_0("shared/updatescheduler/UpdateSchedulerDtMethod")
L0_0 = Player
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0()
end
Player = L0_0
L0_0 = Player
L0_0._IK_HEAD_MODIFIER_NAME = "ik_head"
L0_0 = Player
L0_0._HEAD_OBJECT_NAME = "Head"
L0_0 = Player
L0_0._HEAD_LIMIT_REFERENCE_OBJECT_NAME = "Spine1"
L0_0 = Player
L0_0._MAX_ABS_HEAD_YAW = 70
L0_0 = Player
L0_0._MIN_HEAD_PITCH = -10
L0_0 = Player
L0_0._MAX_HEAD_PITCH = 10
L0_0 = Player
L0_0._HEAD_YAW_SPEED = 7
L0_0 = Player
L0_0._HEAD_PITCH_SPEED = 7
L0_0 = Player
L0_0._HEAD_KEEP_SAME_SIDE_MIN_ANGLE = 160
L0_0 = Player
function L0_0.init(A0_1, A1_2)
	local L2_3, L3_4, L4_5, L5_6, L6_7
	A0_1._unit = A1_2
	L3_4 = A1_2
	L2_3 = A1_2.anim_state_machine
	L2_3 = L2_3(L3_4)
	A0_1._machine = L2_3
	L3_4 = A0_1._unit
	L4_5 = L3_4
	L3_4 = L3_4.player_data
	L3_4 = L3_4(L4_5)
	A0_1._player_data = L3_4
	L3_4 = A0_1._unit
	L4_5 = L3_4
	L3_4 = L3_4.input
	L3_4 = L3_4(L4_5)
	A0_1._input = L3_4
	L4_5 = A0_1
	L3_4 = A0_1.set_low_frequency_update_enabled
	L5_6 = true
	L3_4(L4_5, L5_6)
	L3_4 = A0_1._dont_enter_onground_state
	if L3_4 then
		L4_5 = A0_1
		L3_4 = A0_1._enter_state
		L5_6 = PlayerInactiveState
		L6_7 = L5_6
		L5_6 = L5_6.new
		L6_7 = L5_6(L6_7, A0_1._unit)
		L3_4(L4_5, L5_6, L6_7, L5_6(L6_7, A0_1._unit))
	else
		L4_5 = A0_1
		L3_4 = A0_1._enter_state
		L5_6 = PlayerOnGround
		L6_7 = L5_6
		L5_6 = L5_6.new
		L6_7 = L5_6(L6_7, A0_1._unit)
		L3_4(L4_5, L5_6, L6_7, L5_6(L6_7, A0_1._unit))
	end
	L3_4 = {}
	A0_1._state_calls = L3_4
	L3_4 = A0_1._unit
	L4_5 = L3_4
	L3_4 = L3_4.set_driving
	L5_6 = "animation"
	L3_4(L4_5, L5_6)
	A0_1._was_zoom_aim = false
	A0_1._was_weapon_in_left_hand = false
	L3_4 = A0_1._separate_distance
	if L3_4 then
		L3_4 = A0_1._unit
		L4_5 = L3_4
		L3_4 = L3_4.set_separate_distance
		L5_6 = A0_1._separate_distance
		L3_4(L4_5, L5_6)
	end
	L3_4 = A0_1._weapons
	L4_5 = PlayerInventory
	L5_6 = L4_5
	L4_5 = L4_5.new
	L6_7 = A1_2
	L4_5 = L4_5(L5_6, L6_7, A0_1._inventory_setup)
	A0_1._inventory = L4_5
	L4_5 = {}
	A0_1._weapon_equip = L4_5
	L4_5 = A0_1._weapon_equip
	L4_5.current = nil
	L4_5 = A0_1._weapon_equip
	L4_5.right = nil
	L4_5 = A0_1._weapon_equip
	L4_5.left = nil
	L4_5 = A0_1._weapon_equip
	L4_5.equip = nil
	L4_5 = A0_1._weapon_equip
	L4_5.current_weapon_data = nil
	L4_5 = A0_1._weapon_equip
	L4_5.current_secondary_weapon = nil
	L4_5 = A0_1._weapon_equip
	L4_5.current_secondary_weapon_data = nil
	L5_6 = L2_3
	L4_5 = L2_3.get_modifier
	L6_7 = "ik_left_hand_locked_aim"
	L4_5 = L4_5(L5_6, L6_7)
	A0_1._left_hand_locked_aim = L4_5
	L5_6 = L2_3
	L4_5 = L2_3.get_modifier
	L6_7 = "ik_right_hand_locked_aim"
	L4_5 = L4_5(L5_6, L6_7)
	A0_1._right_hand_locked_aim = L4_5
	L5_6 = A0_1
	L4_5 = A0_1.spawn_weapons
	L6_7 = A0_1._weapons
	L4_5(L5_6, L6_7)
	L5_6 = L2_3
	L4_5 = L2_3.get_modifier
	L6_7 = Player
	L6_7 = L6_7._IK_HEAD_MODIFIER_NAME
	L4_5 = L4_5(L5_6, L6_7)
	A0_1._ik_head = L4_5
	L5_6 = A1_2
	L4_5 = A1_2.get_object
	L6_7 = Player
	L6_7 = L6_7._HEAD_OBJECT_NAME
	L4_5 = L4_5(L5_6, L6_7)
	A0_1._head = L4_5
	L4_5 = assert
	L5_6 = A0_1._head
	L6_7 = Player
	L6_7 = L6_7._HEAD_OBJECT_NAME
	L4_5(L5_6, L6_7)
	L5_6 = A1_2
	L4_5 = A1_2.get_object
	L6_7 = Player
	L6_7 = L6_7._HEAD_LIMIT_REFERENCE_OBJECT_NAME
	L4_5 = L4_5(L5_6, L6_7)
	A0_1._head_limit_reference_object = L4_5
	L4_5 = assert
	L5_6 = A0_1._head_limit_reference_object
	L6_7 = Player
	L6_7 = L6_7._HEAD_LIMIT_REFERENCE_OBJECT_NAME
	L4_5(L5_6, L6_7)
	L4_5 = managers
	L4_5 = L4_5.action_event
	L5_6 = L4_5
	L4_5 = L4_5.register_listener
	L6_7 = A0_1
	L4_5(L5_6, L6_7, A1_2, A1_2)
	L4_5 = managers
	L4_5 = L4_5.action_event
	L5_6 = L4_5
	L4_5 = L4_5.create_emitter
	L6_7 = A1_2
	L4_5 = L4_5(L5_6, L6_7)
	A0_1._emitter = L4_5
	A0_1._rotation_speed = 4
	A0_1._warp_to = nil
	L4_5 = managers
	L4_5 = L4_5.scheduler
	L5_6 = CoverDataRetriever
	L6_7 = L5_6
	L5_6 = L5_6.new
	L5_6 = L5_6(L6_7, L4_5)
	A0_1._cover_data_retriever = L5_6
	L5_6 = A0_1._cover_data_retriever
	L6_7 = L5_6
	L5_6 = L5_6.set_priorities
	L5_6(L6_7, 1, 1, 1, 1)
	L6_7 = L2_3
	L5_6 = L2_3.set_instant_blending
	L5_6(L6_7, "aim", true)
	A0_1._time_since_i_gave_ammo = 0
	L6_7 = A0_1
	L5_6 = A0_1._update_qm_animation_speed
	L5_6(L6_7)
	L6_7 = A1_2
	L5_6 = A1_2.get_object
	L5_6 = L5_6(L6_7, "aim")
	L6_7 = AimPoseAimer
	L6_7 = L6_7.new
	L6_7 = L6_7(L6_7, L2_3, L5_6, "g_yaw", "g_pitch", 40)
	A0_1._aimer = L6_7
	L6_7 = A0_1._aimer
	L6_7 = L6_7.use_exponent_lerp
	L6_7(L6_7, 2, 1)
	A0_1._character_anims = "male"
	L6_7 = "player_head_aim_ik"
	A0_1._head_aim_ik_updater = UpdateSchedulerDtMethod:new(managers.update_scheduler:add_function(A0_1._update_head_aim_ik, L6_7))
	A0_1._interactables_slotmask = managers.slot:get_mask("interactables")
	A0_1._last_separate_weight = -1
	A0_1._damage_data = A0_1._unit:damage_data()
	A0_1._secondary_weapon_visibility = false
	A0_1._allow_head_modifier = false
	A0_1._machine:forbid_modifier(Player._IK_HEAD_MODIFIER_NAME)
	A0_1._crouch_param = 0
	A0_1._damage = A1_2:damage()
	A0_1._fire_stopped = true
	A0_1._fire_started = false
	A0_1._next_effect_hit = 0
end
L0_0 = Player
function L0_0.destroy(A0_8)
	local L1_9, L2_10, L3_11, L4_12, L5_13, L6_14
	L1_9 = managers
	L1_9 = L1_9.action_event
	L1_9 = L1_9.unregister_listener
	L1_9(L2_10, L3_11)
	L1_9 = managers
	L1_9 = L1_9.unit_scripting
	L1_9 = L1_9.unit_destroyed
	L1_9(L2_10, L3_11)
	L1_9 = A0_8._emitter
	L1_9 = L1_9.destroy
	L1_9(L2_10)
	A0_8._unit = nil
	L1_9 = A0_8._inventory
	L1_9 = L1_9.all_items
	L1_9 = L1_9(L2_10)
	for L5_13, L6_14 in L2_10(L3_11) do
		if alive(L6_14) then
			L6_14:base():disable()
			L6_14:set_slot(0)
		end
	end
	L2_10(L3_11)
	L2_10(L3_11)
	L2_10(L3_11)
	L2_10(L3_11)
	L2_10(L3_11)
end
function L0_0(A0_15, A1_16, A2_17, A3_18)
	local L4_19, L6_20
	if A0_15 then
		L4_19 = A1_16
	else
		L4_19 = A2_17
	end
	L6_20 = UpdateSchedulerDtMethod
	L6_20 = L6_20.new
	L6_20 = L6_20(L6_20, managers.update_scheduler:add_function(A3_18, L4_19))
	return L6_20
end
function Player._setup_variable_frequency_updater(A0_21, A1_22)
	if A0_21._variable_frequency_updater then
		A0_21._variable_frequency_updater:remove()
	end
	A0_21._variable_frequency_updater = _UPVALUE0_(A1_22, "low_frequency_player_base", "high_frequency_player_base", A0_21.variable_frequency_update)
end
function Player._setup_current_state_variable_frequency_post_updater(A0_23, A1_24)
	if A0_23._current_state_variable_frequency_post_updater then
		A0_23._current_state_variable_frequency_post_updater:remove()
	end
	A0_23._current_state_variable_frequency_post_updater = _UPVALUE0_(A1_24, "low_frequency_player_movement_state", "high_frequency_player_movement_state", A0_23._current_state_variable_frequency_post_update)
end
function Player.set_low_frequency_update_enabled(A0_25, A1_26)
	A0_25:_setup_variable_frequency_updater(A1_26)
	A0_25:_setup_current_state_variable_frequency_post_updater(A1_26)
end
function Player.spawn_human_controllable_weapons(A0_27)
	if A0_27._human_controllable_weapons then
		A0_27:spawn_weapons(A0_27._human_controllable_weapons)
	end
end
function Player.destroy_weapons(A0_28)
	local L1_29, L2_30, L3_31, L4_32, L5_33, L6_34
	L1_29 = A0_28._inventory
	L1_29 = L1_29.all_items
	L1_29 = L1_29(L2_30)
	for L5_33, L6_34 in L2_30(L3_31) do
		A0_28:_setup_weapon_unlink(L6_34)
		L6_34:unlink()
		L6_34:set_slot(0)
	end
	L2_30(L3_31)
	A0_28._weapon_equip = L2_30
	L2_30.current = nil
	L2_30.right = nil
	L2_30.left = nil
	L2_30.equip = nil
	L2_30.current_weapon_data = nil
	L2_30.current_secondary_weapon = nil
	L2_30.current_secondary_weapon_data = nil
	L2_30.hud_inventory_primary_active_slot = nil
	L2_30.hud_inventory_secondary_active_slot = nil
end
function Player.spawn_weapons(A0_35, A1_36)
	local L2_37, L3_38, L4_39, L5_40, L6_41, L7_42, L8_43
	L2_37 = A0_35.destroy_weapons
	L2_37(L3_38)
	L2_37 = A1_36
	for L6_41 = 1, #L2_37 do
		L7_42 = World
		L8_43 = L7_42
		L7_42 = L7_42.spawn_unit
		L7_42 = L7_42(L8_43, L2_37[L6_41], A0_35._unit:position(), A0_35._unit:rotation())
		L8_43 = assert
		L8_43(L7_42)
		L8_43 = A0_35._setup_weapon_link
		L8_43(A0_35, L7_42)
		L8_43 = A0_35._weapon_types
		L8_43 = L8_43[L7_42:name()]
		A0_35._inventory:insert_item(L7_42, A0_35._inventory:find_free_slot(L8_43), L8_43)
		if L8_43 == "primary" then
			if L6_41 == 1 then
				A0_35._unit:link("a_weapon_right_back", L7_42, L7_42:orientation_object():name())
				A0_35._weapon_equip.right = L7_42
				A0_35._weapon_equip.current = L7_42
				A0_35._weapon_equip.current_weapon_data = L7_42:weapon_data()
				A0_35._player_data.hud_inventory_primary_active_slot = A0_35._inventory:find_slot_index(A0_35._weapon_equip.current)
				L7_42:base():weapon_stocked(false)
			else
				A0_35._unit:link(A0_35._weapon_link_table[L2_37[L6_41]], L7_42, L7_42:orientation_object():name())
				L7_42:base():weapon_stocked(true)
			end
		elseif L8_43 == "secondary" then
			if not A0_35._weapon_equip.current_secondary_weapon then
				A0_35._weapon_equip.current_secondary_weapon = L7_42
				A0_35._weapon_equip.current_secondary_weapon_data = L7_42:weapon_data()
				A0_35._player_data.hud_inventory_secondary_active_slot = A0_35._inventory:find_slot_index(L7_42)
			end
			A0_35._unit:link("a_weapon_right_back", L7_42, L7_42:orientation_object():name())
			L7_42:set_visible(false)
		else
			assert(0)
		end
	end
	L3_38(L4_39)
end
function Player._check_for_close_player_that_gives_ammo(A0_44)
	local L1_45, L2_46, L3_47, L4_48, L5_49
	L2_46 = A0_44
	L1_45 = A0_44.can_receive_ammo_for_weapon
	L1_45 = L1_45(L2_46)
	if L1_45 == false then
		return
	end
	L1_45 = tweak_data
	L1_45 = L1_45.player
	L1_45 = L1_45.RECEIVE_AMMO_DISTANCE
	L2_46 = World
	L3_47 = L2_46
	L2_46 = L2_46.find_units_quick
	L2_46 = L2_46(L3_47, L4_48, L5_49, A0_44._unit:position(), L1_45, managers.slot:get_mask("players"))
	L3_47 = #L2_46
	if L3_47 == 0 then
		return
	end
	L3_47 = nil
	for 