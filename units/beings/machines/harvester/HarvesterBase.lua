require("shared/FiniteStateMachine")
if not HarvesterBase then
	HarvesterBase = class()
end
HarvesterBase._LEFT_HAND_OBJECT_NAME = "a_left_hand"
HarvesterBase._LEFT_HAND_IK_MODIFIER_OBJECT_NAME = "left_hand_ik"
local l_0_0 = HarvesterBase
local l_0_1 = {}
local l_0_2 = {}
l_0_2.round = 1
l_0_2.position = Vector3(1150, 500, 1000)
l_0_2.yaw = 20
l_0_2.width = 950
l_0_2.height = 500
l_0_2.length = 900
local l_0_3 = {}
l_0_3.round = 2
l_0_3.position = Vector3(-1100, 220, 100)
l_0_3.yaw = 0
l_0_3.width = 1000
l_0_3.height = 500
l_0_3.length = 500
local l_0_4 = {}
l_0_4.round = 3
l_0_4.position = Vector3(1150, 500, 1000)
l_0_4.yaw = 20
l_0_4.width = 950
l_0_4.height = 500
l_0_4.length = 900
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

l_0_0._SLAP_ATTACK_AREAS = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._damage_data = l_1_1:damage_data()
	l_1_0._asm = l_1_0._unit:anim_state_machine()
	l_1_0._left_hand_obj = l_1_0._unit:get_object(HarvesterBase._LEFT_HAND_OBJECT_NAME)
	l_1_0._left_hand_ik_modifier = l_1_0._asm:get_modifier(HarvesterBase._LEFT_HAND_IK_MODIFIER_OBJECT_NAME)
	l_1_0._slap_attack_target_slots = managers.slot:get_mask("players")
	l_1_0._round = nil
	l_1_0._state = nil
	local l_1_2 = {}
	l_1_2.john_connor = "Hips"
	l_1_2.blair = "Hips"
	l_1_0._target_objects = l_1_2
	l_1_0._current_target_1 = nil
	l_1_2(l_1_0)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_2(l_1_0)
end

l_0_0.init = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_2_0)
	l_2_0._weapon = World:spawn_unit(l_2_0._weapon_class, l_2_0._unit:position(), l_2_0._unit:rotation())
	assert(l_2_0._weapon)
	l_2_0._weapon:base():setup(l_2_0._unit, l_2_0._weapon_parent_object_names)
	l_2_0._weapon:base():set_equiped(true)
	l_2_0._weapon_data = l_2_0._weapon:weapon_data()
end

l_0_0._setup_weapons = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_3_0)
	l_3_0._rounds = {}
	local l_3_1 = l_3_0._rounds
	local l_3_2 = {}
	local l_3_3 = {}
	l_3_3.anim = "idle"
	l_3_3.state = l_3_0._state_idle
	l_3_2.state_idle = l_3_3
	l_3_2.state_enter, l_3_3 = l_3_3, {anim = "wall_intro", state = l_3_0._state_enter, sequence_name = "enter_round_1"}
	l_3_2.state_loop, l_3_3 = l_3_3, {anim = "wall_grab_loop", state = l_3_0._state_loop}
	l_3_2.state_grab_start, l_3_3 = l_3_3, {anim = "wall_grab_game_over", state = l_3_0._state_grab_start}
	l_3_2.state_grab_end, l_3_3 = l_3_3, {anim = "", state = l_3_0._state_grab_end, target_anim = "bosses/harvester/player_wall_grab_game_over"}
	l_3_2.state_slap_start, l_3_3 = l_3_3, {anim = "wall_smash_player", state = l_3_0._state_slap_start}
	l_3_2.state_slap_end, l_3_3 = l_3_3, {anim = "", state = l_3_0._state_slap_end}
	l_3_2.state_hurt, l_3_3 = l_3_3, {anim = "wall_hurt_exit", state = l_3_0._state_hurt, sequence_name = "hurt_round_1"}
	l_3_1[1] = l_3_2
	l_3_1 = l_3_0._rounds
	l_3_3 = {anim = "idle", state = l_3_0._state_idle}
	l_3_3 = {anim = "roof_grab_enter", state = l_3_0._state_enter, sequence_name = "enter_round_2"}
	l_3_3 = {anim = "roof_grab_loop", state = l_3_0._state_loop}
	l_3_3 = {anim = "roof_grab_game_over", state = l_3_0._state_grab_start}
	l_3_3 = {anim = "", state = l_3_0._state_grab_end, target_anim = "bosses/harvester/player_roof_grab_game_over"}
	l_3_3 = {anim = "roof_smash_player_left", state = l_3_0._state_slap_start}
	l_3_3 = {anim = "", state = l_3_0._state_slap_end}
	l_3_3 = {anim = "roof_hurt_exit", state = l_3_0._state_hurt, sequence_name = "hurt_round_2"}
	l_3_1[2], l_3_2 = l_3_2, {state_idle = l_3_3, state_enter = l_3_3, state_loop = l_3_3, state_grab_start = l_3_3, state_grab_end = l_3_3, state_slap_start = l_3_3, state_slap_end = l_3_3, state_hurt = l_3_3}
	l_3_1 = l_3_0._rounds
	l_3_3 = {anim = "idle", state = l_3_0._state_idle}
	l_3_3 = {anim = "wall_grab_enter", state = l_3_0._state_enter, sequence_name = "enter_round_3"}
	l_3_3 = {anim = "wall_grab_loop", state = l_3_0._state_loop}
	l_3_3 = {anim = "wall_grab_game_over", state = l_3_0._state_grab_start}
	l_3_3 = {anim = "", state = l_3_0._state_grab_end, target_anim = "bosses/harvester/player_wall_grab_game_over"}
	l_3_3 = {anim = "wall_smash_player", state = l_3_0._state_slap_start}
	l_3_3 = {anim = "", state = l_3_0._state_slap_end}
	l_3_3 = {anim = "wall_hurt_exit", state = l_3_0._state_hurt, sequence_name = "hurt_round_3"}
	l_3_1[3], l_3_2 = l_3_2, {state_idle = l_3_3, state_enter = l_3_3, state_loop = l_3_3, state_grab_start = l_3_3, state_grab_end = l_3_3, state_slap_start = l_3_3, state_slap_end = l_3_3, state_hurt = l_3_3}
end

l_0_0._init_anims_and_states = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_4_0, l_4_1)
	managers.unit_scripting:unit_destroyed(l_4_0._unit)
end

l_0_0.destroy = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_5_0, l_5_1, l_5_2, l_5_3)
	if l_5_0._state then
		l_5_0._state(l_5_0, l_5_2, l_5_3)
	end
	if Global.category_debug_render.harvester_boss then
		l_5_0:_debug()
	end
	if not alive(l_5_0._weapon) then
		l_5_0:_setup_weapons()
	end
	l_5_0._weapon_data.fire_input = l_5_0.fire_input or 0
	for l_5_7 = 1, 20 do
		local l_5_8 = "target_" .. l_5_7
		l_5_0._weapon_data.targets[l_5_7] = l_5_0[l_5_8]
	end
end

l_0_0.update = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_6_0, l_6_1)
	Application:debug("CHANGE STATE", l_6_1)
	l_6_0._state = l_6_0._rounds[l_6_0._round][l_6_1].state
end

l_0_0._change_state = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_7_0, l_7_1)
	local l_7_2 = l_7_0._rounds[l_7_0._round][l_7_1].anim
	Application:debug("PLAY REDIRECT", l_7_2)
	l_7_0._asm:play_redirect(l_7_2)
end

l_0_0._play_redirect = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_8_0, l_8_1)
	local l_8_2 = l_8_0._rounds[l_8_0._round][l_8_1].sequence_name
	Application:debug("RUN SEQUENCE", l_8_2)
	managers.sequence:run_sequence_simple(l_8_2, l_8_0._unit)
end

l_0_0._run_sequence = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_9_0)
	local l_9_11, l_9_12, l_9_13, l_9_14 = nil
	local l_9_1 = l_9_0:get_slap_area_oobb(l_9_0._round)
	local l_9_6 = l_9_0._unit:find_units
	local l_9_7 = l_9_0._unit
	l_9_6 = l_9_6(l_9_7, "obb", l_9_1.center, l_9_1.x, l_9_1.y, l_9_1.z, l_9_0._slap_attack_target_slots)
	local l_9_2 = nil
	if l_9_6 then
		l_9_7 = ipairs
		l_9_2 = l_9_6
		l_9_7 = l_9_7(l_9_2)
		for i_0,i_1 in l_9_7 do
			for i_0,i_1 in pairs(l_9_0._target_units) do
				if alive(managers.unit_scripting:get_unit_by_name(i_1.script_name)) and managers.unit_scripting:get_unit_by_name(i_1.script_name) == l_9_5 then
					return managers.unit_scripting:get_unit_by_name(i_1.script_name)
				end
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0._get_targets_in_slap_attack_area = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_10_0)
	local l_10_1 = l_10_0:get_slap_area_oobb(l_10_0._round)
	local l_10_2 = OOBB(l_10_1.center, l_10_1.x, l_10_1.y, l_10_1.z)
	local l_10_3 = Draw:brush()
	l_10_3:set_color(Color(0.2, 1, 0, 0))
	l_10_3:oobb(l_10_2)
end

l_0_0._debug = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_11_0, l_11_1, l_11_2)
end

l_0_0._state_idle = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_12_0, l_12_1, l_12_2)
	local l_12_3 = l_12_0:_get_targets_in_slap_attack_area()
	if l_12_3 then
		l_12_0._slap_attack_target_unit = l_12_3
		l_12_0:_play_redirect("state_slap_start")
		l_12_0:_change_state("state_slap_start")
		return 
	end
	if l_12_0._hurt_damage <= l_12_0._damage_data.damage then
		l_12_0:_play_redirect("state_hurt")
		l_12_0:_change_state("state_hurt")
		l_12_0:_run_sequence("state_hurt")
		return 
	end
end

l_0_0._state_enter = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_13_0, l_13_1, l_13_2)
	if l_13_0._next_attack_time <= l_13_1 then
		l_13_0:_play_redirect("state_grab_start")
		l_13_0:_change_state("state_grab_start")
		return 
	end
	local l_13_3 = l_13_0:_get_targets_in_slap_attack_area()
	if l_13_3 then
		l_13_0._slap_attack_target_unit = l_13_3
		l_13_0:_play_redirect("state_slap_start")
		l_13_0:_change_state("state_slap_start")
		return 
	end
	if l_13_0._hurt_damage <= l_13_0._damage_data.damage then
		l_13_0:_play_redirect("state_hurt")
		l_13_0:_change_state("state_hurt")
		l_13_0:_run_sequence("state_hurt")
		return 
	end
end

l_0_0._state_loop = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_14_0, l_14_1, l_14_2)
end

l_0_0._state_hurt = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_15_0, l_15_1, l_15_2)
	local l_15_3 = l_15_0._slap_attack_target_unit
	l_15_3:damage():set_fully_damaged()
	l_15_0:_change_state("state_slap_end")
end

l_0_0._state_slap_start = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_16_0, l_16_1, l_16_2)
end

l_0_0._state_dual_slap_start = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_17_0, l_17_1, l_17_2)
end

l_0_0._state_slap_end = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_18_0, l_18_1, l_18_2)
	local l_18_6, l_18_7, l_18_8, l_18_9 = nil
	for i_0,i_1 in pairs(l_18_0._target_units) do
		if alive(managers.unit_scripting:get_unit_by_name(i_1.script_name)) then
			local l_18_12 = nil
			l_18_0._left_hand_ik_modifier:set_target_position(managers.unit_scripting:get_unit_by_name(i_1.script_name):get_object(l_18_0._target_objects[managers.unit_scripting:get_unit_by_name(i_1.script_name):name()]):position())
			l_18_0._grab_attack_target_unit = l_18_12
			return 
		end
	end
end

l_0_0._state_grab_start = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_19_0, l_19_1, l_19_2)
end

l_0_0._state_grab_end = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_20_0, l_20_1, l_20_2, l_20_3, l_20_4)
	l_20_0._round = l_20_1
	l_20_0._target_units = l_20_2
	l_20_0._grab_attack_time = l_20_3
	l_20_0._hurt_damage = l_20_4
	l_20_0:_play_redirect("state_enter")
	l_20_0:_change_state("state_enter")
	l_20_0:_run_sequence("state_enter")
end

l_0_0.start_round = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_21_0, l_21_1)
	local l_21_2 = HarvesterBase._SLAP_ATTACK_AREAS[l_21_1]
	local l_21_3 = l_21_0._unit:rotation() * Rotation(Vector3(0, 0, 1), l_21_2.yaw)
	local l_21_4 = l_21_3:x() * l_21_2.width * 0.5
	local l_21_5 = l_21_3:y() * l_21_2.length * 0.5
	local l_21_6 = l_21_3:z() * l_21_2.height * 0.5
	local l_21_7 = l_21_3:x() * l_21_2.position.x
	local l_21_8 = l_21_3:y() * l_21_2.position.y
	local l_21_9 = l_21_3:z() * l_21_2.position.z
	local l_21_10 = l_21_0._unit:position() + l_21_7 + l_21_8 + l_21_9
	local l_21_11 = {}
	l_21_11.center = l_21_10
	l_21_11.x = l_21_4
	l_21_11.y = l_21_5
	l_21_11.z = l_21_6
	return l_21_11
end

l_0_0.get_slap_area_oobb = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_22_0)
	Application:debug("Enter grab loop (callback from animation)")
	l_22_0._next_attack_time = Application:time() + l_22_0._grab_attack_time
	l_22_0:_change_state("state_loop")
end

l_0_0.enter_state_loop = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_23_0)
	Application:debug("Enter grab end (callback from animation)")
	local l_23_1 = l_23_0._rounds[l_23_0._round].state_grab_end.target_anim
	l_23_0._grab_attack_target_unit:base():grabbed(l_23_1)
	l_23_0._grab_attack_target_unit:set_rotation(Rotation(Vector3(0, 0, 1), 180))
	local l_23_2 = l_23_0._target_objects[l_23_0._grab_attack_target_unit:name()]
	l_23_0._unit:link(HarvesterBase._LEFT_HAND_OBJECT_NAME, l_23_0._grab_attack_target_unit, l_23_2)
	l_23_0:_change_state("state_grab_end")
end

l_0_0.enter_state_grab_end = l_0_1
l_0_0 = HarvesterBase
l_0_1 = function(l_24_0)
	Application:debug("Exiting hurt animation (callback from animation)")
	l_24_0._emitter = managers.action_event:create_emitter(l_24_0._unit)
	l_24_0._emitter:unit_fully_damaged(l_24_0._unit)
	l_24_0._emitter:destroy()
	managers.unit_scripting:unit_dead(l_24_0._unit)
	l_24_0._unit:set_slot(0)
end

l_0_0.exit_state_hurt = l_0_1

