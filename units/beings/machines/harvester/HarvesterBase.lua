require("shared/FiniteStateMachine")
HarvesterBase = HarvesterBase or class()
HarvesterBase._LEFT_HAND_OBJECT_NAME = "a_left_hand"
HarvesterBase._LEFT_HAND_IK_MODIFIER_OBJECT_NAME = "left_hand_ik"
HarvesterBase._SLAP_ATTACK_AREAS = {
	{
		round = 1,
		position = Vector3(1150, 500, 1000),
		yaw = 20,
		width = 950,
		height = 500,
		length = 900
	},
	{
		round = 2,
		position = Vector3(-1100, 220, 100),
		yaw = 0,
		width = 1000,
		height = 500,
		length = 500
	},
	{
		round = 3,
		position = Vector3(1150, 500, 1000),
		yaw = 20,
		width = 950,
		height = 500,
		length = 900
	}
}
function HarvesterBase.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._damage_data = A1_1:damage_data()
	A0_0._asm = A0_0._unit:anim_state_machine()
	A0_0._left_hand_obj = A0_0._unit:get_object(HarvesterBase._LEFT_HAND_OBJECT_NAME)
	A0_0._left_hand_ik_modifier = A0_0._asm:get_modifier(HarvesterBase._LEFT_HAND_IK_MODIFIER_OBJECT_NAME)
	A0_0._slap_attack_target_slots = managers.slot:get_mask("players")
	A0_0._round = nil
	A0_0._state = nil
	A0_0._target_objects = {john_connor = "Hips", blair = "Hips"}
	A0_0._current_target_1 = nil
	A0_0:_init_anims_and_states()
	A0_0:_setup_weapons()
end
function HarvesterBase._setup_weapons(A0_2)
	A0_2._weapon = World:spawn_unit(A0_2._weapon_class, A0_2._unit:position(), A0_2._unit:rotation())
	assert(A0_2._weapon)
	A0_2._weapon:base():setup(A0_2._unit, A0_2._weapon_parent_object_names)
	A0_2._weapon:base():set_equiped(true)
	A0_2._weapon_data = A0_2._weapon:weapon_data()
end
function HarvesterBase._init_anims_and_states(A0_3)
	local L1_4, L2_5, L3_6, L4_7
	L1_4 = {}
	A0_3._rounds = L1_4
	L1_4 = A0_3._rounds
	L2_5 = {}
	L3_6 = {}
	L3_6.anim = "idle"
	L4_7 = A0_3._state_idle
	L3_6.state = L4_7
	L2_5.state_idle = L3_6
	L3_6 = {}
	L3_6.anim = "wall_intro"
	L4_7 = A0_3._state_enter
	L3_6.state = L4_7
	L3_6.sequence_name = "enter_round_1"
	L2_5.state_enter = L3_6
	L3_6 = {}
	L3_6.anim = "wall_grab_loop"
	L4_7 = A0_3._state_loop
	L3_6.state = L4_7
	L2_5.state_loop = L3_6
	L3_6 = {}
	L3_6.anim = "wall_grab_game_over"
	L4_7 = A0_3._state_grab_start
	L3_6.state = L4_7
	L2_5.state_grab_start = L3_6
	L3_6 = {}
	L3_6.anim = ""
	L4_7 = A0_3._state_grab_end
	L3_6.state = L4_7
	L3_6.target_anim = "bosses/harvester/player_wall_grab_game_over"
	L2_5.state_grab_end = L3_6
	L3_6 = {}
	L3_6.anim = "wall_smash_player"
	L4_7 = A0_3._state_slap_start
	L3_6.state = L4_7
	L2_5.state_slap_start = L3_6
	L3_6 = {}
	L3_6.anim = ""
	L4_7 = A0_3._state_slap_end
	L3_6.state = L4_7
	L2_5.state_slap_end = L3_6
	L3_6 = {}
	L3_6.anim = "wall_hurt_exit"
	L4_7 = A0_3._state_hurt
	L3_6.state = L4_7
	L3_6.sequence_name = "hurt_round_1"
	L2_5.state_hurt = L3_6
	L1_4[1] = L2_5
	L1_4 = A0_3._rounds
	L2_5 = {}
	L3_6 = {}
	L3_6.anim = "idle"
	L4_7 = A0_3._state_idle
	L3_6.state = L4_7
	L2_5.state_idle = L3_6
	L3_6 = {}
	L3_6.anim = "roof_grab_enter"
	L4_7 = A0_3._state_enter
	L3_6.state = L4_7
	L3_6.sequence_name = "enter_round_2"
	L2_5.state_enter = L3_6
	L3_6 = {}
	L3_6.anim = "roof_grab_loop"
	L4_7 = A0_3._state_loop
	L3_6.state = L4_7
	L2_5.state_loop = L3_6
	L3_6 = {}
	L3_6.anim = "roof_grab_game_over"
	L4_7 = A0_3._state_grab_start
	L3_6.state = L4_7
	L2_5.state_grab_start = L3_6
	L3_6 = {}
	L3_6.anim = ""
	L4_7 = A0_3._state_grab_end
	L3_6.state = L4_7
	L3_6.target_anim = "bosses/harvester/player_roof_grab_game_over"
	L2_5.state_grab_end = L3_6
	L3_6 = {}
	L3_6.anim = "roof_smash_player_left"
	L4_7 = A0_3._state_slap_start
	L3_6.state = L4_7
	L2_5.state_slap_start = L3_6
	L3_6 = {}
	L3_6.anim = ""
	L4_7 = A0_3._state_slap_end
	L3_6.state = L4_7
	L2_5.state_slap_end = L3_6
	L3_6 = {}
	L3_6.anim = "roof_hurt_exit"
	L4_7 = A0_3._state_hurt
	L3_6.state = L4_7
	L3_6.sequence_name = "hurt_round_2"
	L2_5.state_hurt = L3_6
	L1_4[2] = L2_5
	L1_4 = A0_3._rounds
	L2_5 = {}
	L3_6 = {}
	L3_6.anim = "idle"
	L4_7 = A0_3._state_idle
	L3_6.state = L4_7
	L2_5.state_idle = L3_6
	L3_6 = {}
	L3_6.anim = "wall_grab_enter"
	L4_7 = A0_3._state_enter
	L3_6.state = L4_7
	L3_6.sequence_name = "enter_round_3"
	L2_5.state_enter = L3_6
	L3_6 = {}
	L3_6.anim = "wall_grab_loop"
	L4_7 = A0_3._state_loop
	L3_6.state = L4_7
	L2_5.state_loop = L3_6
	L3_6 = {}
	L3_6.anim = "wall_grab_game_over"
	L4_7 = A0_3._state_grab_start
	L3_6.state = L4_7
	L2_5.state_grab_start = L3_6
	L3_6 = {}
	L3_6.anim = ""
	L4_7 = A0_3._state_grab_end
	L3_6.state = L4_7
	L3_6.target_anim = "bosses/harvester/player_wall_grab_game_over"
	L2_5.state_grab_end = L3_6
	L3_6 = {}
	L3_6.anim = "wall_smash_player"
	L4_7 = A0_3._state_slap_start
	L3_6.state = L4_7
	L2_5.state_slap_start = L3_6
	L3_6 = {}
	L3_6.anim = ""
	L4_7 = A0_3._state_slap_end
	L3_6.state = L4_7
	L2_5.state_slap_end = L3_6
	L3_6 = {}
	L3_6.anim = "wall_hurt_exit"
	L4_7 = A0_3._state_hurt
	L3_6.state = L4_7
	L3_6.sequence_name = "hurt_round_3"
	L2_5.state_hurt = L3_6
	L1_4[3] = L2_5
end
function HarvesterBase.destroy(A0_8, A1_9)
	managers.unit_scripting:unit_destroyed(A0_8._unit)
end
function HarvesterBase.update(A0_10, A1_11, A2_12, A3_13)
	local L4_14, L5_15, L6_16, L7_17
	if L4_14 then
		L7_17 = A3_13
		L4_14(L5_15, L6_16, L7_17)
	end
	if L4_14 then
		L4_14(L5_15)
	end
	if not L4_14 then
		L4_14(L5_15)
	end
	L4_14.fire_input = L5_15
	for L7_17 = 1, 20 do
		A0_10._weapon_data.targets[L7_17] = A0_10["target_" .. L7_17]
	end
end
function HarvesterBase._change_state(A0_18, A1_19)
	Application:debug("CHANGE STATE", A1_19)
	A0_18._state = A0_18._rounds[A0_18._round][A1_19].state
end
function HarvesterBase._play_redirect(A0_20, A1_21)
	local L2_22
	L2_22 = A0_20._rounds
	L2_22 = L2_22[A0_20._round]
	L2_22 = L2_22[A1_21]
	L2_22 = L2_22.anim
	Application:debug("PLAY REDIRECT", L2_22)
	A0_20._asm:play_redirect(L2_22)
end
function HarvesterBase._run_sequence(A0_23, A1_24)
	local L2_25
	L2_25 = A0_23._rounds
	L2_25 = L2_25[A0_23._round]
	L2_25 = L2_25[A1_24]
	L2_25 = L2_25.sequence_name
	Application:debug("RUN SEQUENCE", L2_25)
	managers.sequence:run_sequence_simple(L2_25, A0_23._unit)
end
function HarvesterBase._get_targets_in_slap_attack_area(A0_26)
	local L1_27, L2_28, L3_29, L4_30, L5_31, L6_32, L7_33, L8_34, L9_35, L10_36, L11_37, L12_38, L13_39
	L2_28 = A0_26
	L1_27 = A0_26.get_slap_area_oobb
	L1_27 = L1_27(L2_28, L3_29)
	L2_28 = A0_26._unit
	L2_28 = L2_28.find_units
	L6_32 = L1_27.x
	L7_33 = L1_27.y
	L2_28 = L2_28(L3_29, L4_30, L5_31, L6_32, L7_33, L8_34, L9_35)
	if L2_28 then
		for L6_32, L7_33 in L3_29(L4_30) do
			for L11_37, L12_38 in L8_34(L9_35) do
				L13_39 = managers
				L13_39 = L13_39.unit_scripting
				L13_39 = L13_39.get_unit_by_name
				L13_39 = L13_39(L13_39, L12_38.script_name)
				if alive(L13_39) and L13_39 == L7_33 then
					return L13_39
				end
			end
		end
	end
end
function HarvesterBase._debug(A0_40)
	local L1_41, L2_42
	L2_42 = A0_40
	L1_41 = A0_40.get_slap_area_oobb
	L1_41 = L1_41(L2_42, A0_40._round)
	L2_42 = OOBB
	L2_42 = L2_42(L1_41.center, L1_41.x, L1_41.y, L1_41.z)
	Draw:brush():set_color(Color(0.2, 1, 0, 0))
	Draw:brush():oobb(L2_42)
end
function HarvesterBase._state_idle(A0_43, A1_44, A2_45)
end
function HarvesterBase._state_enter(A0_46, A1_47, A2_48)
	if A0_46:_get_targets_in_slap_attack_area() then
		A0_46._slap_attack_target_unit = A0_46:_get_targets_in_slap_attack_area()
		A0_46:_play_redirect("state_slap_start")
		A0_46:_change_state("state_slap_start")
		return
	end
	if A0_46._damage_data.damage >= A0_46._hurt_damage then
		A0_46:_play_redirect("state_hurt")
		A0_46:_change_state("state_hurt")
		A0_46:_run_sequence("state_hurt")
		return
	end
end
function HarvesterBase._state_loop(A0_49, A1_50, A2_51)
	if A1_50 >= A0_49._next_attack_time then
		A0_49:_play_redirect("state_grab_start")
		A0_49:_change_state("state_grab_start")
		return
	end
	if A0_49:_get_targets_in_slap_attack_area() then
		A0_49._slap_attack_target_unit = A0_49:_get_targets_in_slap_attack_area()
		A0_49:_play_redirect("state_slap_start")
		A0_49:_change_state("state_slap_start")
		return
	end
	if A0_49._damage_data.damage >= A0_49._hurt_damage then
		A0_49:_play_redirect("state_hurt")
		A0_49:_change_state("state_hurt")
		A0_49:_run_sequence("state_hurt")
		return
	end
end
function HarvesterBase._state_hurt(A0_52, A1_53, A2_54)
end
function HarvesterBase._state_slap_start(A0_55, A1_56, A2_57)
	A0_55._slap_attack_target_unit:damage():set_fully_damaged()
	A0_55:_change_state("state_slap_end")
end
function HarvesterBase._state_dual_slap_start(A0_58, A1_59, A2_60)
end
function HarvesterBase._state_slap_end(A0_61, A1_62, A2_63)
end
function HarvesterBase._state_grab_start(A0_64, A1_65, A2_66)
	local L3_67, L4_68, L5_69, L6_70, L7_71, L8_72, L9_73
	for L6_70, L7_71 in L3_67(L4_68) do
		L8_72 = managers
		L8_72 = L8_72.unit_scripting
		L9_73 = L8_72
		L8_72 = L8_72.get_unit_by_name
		L8_72 = L8_72(L9_73, L7_71.script_name)
		L9_73 = alive
		L9_73 = L9_73(L8_72)
		if L9_73 then
			L9_73 = A0_64._target_objects
			L9_73 = L9_73[L8_72:name()]
			A0_64._left_hand_ik_modifier:set_target_position(L8_72:get_object(L9_73):position())
			A0_64._grab_attack_target_unit = L8_72
			return
		end
	end
end
function HarvesterBase._state_grab_end(A0_74, A1_75, A2_76)
end
function HarvesterBase.start_round(A0_77, A1_78, A2_79, A3_80, A4_81)
	A0_77._round = A1_78
	A0_77._target_units = A2_79
	A0_77._grab_attack_time = A3_80
	A0_77._hurt_damage = A4_81
	A0_77:_play_redirect("state_enter")
	A0_77:_change_state("state_enter")
	A0_77:_run_sequence("state_enter")
end
function HarvesterBase.get_slap_area_oobb(A0_82, A1_83)
	local L2_84
	L2_84 = HarvesterBase
	L2_84 = L2_84._SLAP_ATTACK_AREAS
	L2_84 = L2_84[A1_83]
	return {
		center = A0_82._unit:position() + (A0_82._unit:rotation() * Rotation(Vector3(0, 0, 1), L2_84.yaw)):x() * L2_84.position.x + (A0_82._unit:rotation() * Rotation(Vector3(0, 0, 1), L2_84.yaw)):y() * L2_84.position.y + (A0_82._unit:rotation() * Rotation(Vector3(0, 0, 1), L2_84.yaw)):z() * L2_84.position.z,
		x = (A0_82._unit:rotation() * Rotation(Vector3(0, 0, 1), L2_84.yaw)):x() * L2_84.width * 0.5,
		y = (A0_82._unit:rotation() * Rotation(Vector3(0, 0, 1), L2_84.yaw)):y() * L2_84.length * 0.5,
		z = (A0_82._unit:rotation() * Rotation(Vector3(0, 0, 1), L2_84.yaw)):z() * L2_84.height * 0.5
	}
end
function HarvesterBase.enter_state_loop(A0_85)
	Application:debug("Enter grab loop (callback from animation)")
	A0_85._next_attack_time = Application:time() + A0_85._grab_attack_time
	A0_85:_change_state("state_loop")
end
function HarvesterBase.enter_state_grab_end(A0_86)
	local L1_87, L2_88
	L1_87 = Application
	L2_88 = L1_87
	L1_87 = L1_87.debug
	L1_87(L2_88, "Enter grab end (callback from animation)")
	L1_87 = A0_86._rounds
	L2_88 = A0_86._round
	L1_87 = L1_87[L2_88]
	L1_87 = L1_87.state_grab_end
	L1_87 = L1_87.target_anim
	L2_88 = A0_86._grab_attack_target_unit
	L2_88 = L2_88.base
	L2_88 = L2_88(L2_88)
	L2_88 = L2_88.grabbed
	L2_88(L2_88, L1_87)
	L2_88 = A0_86._grab_attack_target_unit
	L2_88 = L2_88.set_rotation
	L2_88(L2_88, Rotation(Vector3(0, 0, 1), 180))
	L2_88 = A0_86._target_objects
	L2_88 = L2_88[A0_86._grab_attack_target_unit:name()]
	A0_86._unit:link(HarvesterBase._LEFT_HAND_OBJECT_NAME, A0_86._grab_attack_target_unit, L2_88)
	A0_86:_change_state("state_grab_end")
end
function HarvesterBase.exit_state_hurt(A0_89)
	Application:debug("Exiting hurt animation (callback from animation)")
	A0_89._emitter = managers.action_event:create_emitter(A0_89._unit)
	A0_89._emitter:unit_fully_damaged(A0_89._unit)
	A0_89._emitter:destroy()
	managers.unit_scripting:unit_dead(A0_89._unit)
	A0_89._unit:set_slot(0)
end
