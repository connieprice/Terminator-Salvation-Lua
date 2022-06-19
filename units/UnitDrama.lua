require("music/SoundInstance")
UnitDrama = UnitDrama or class()
function UnitDrama.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._emitter = managers.action_event:create_emitter(A1_1)
	A0_0:set_mood("calm")
	A0_0._look_at_unit = nil
	A0_0._default_battle_mood = true
end
function UnitDrama.destroy(A0_2)
	if A0_2._say_sound_instance then
		A0_2:_stop_talking()
	end
end
function UnitDrama._soundbank_name_from_scenario_id_or_sound_actor_name(A0_3, A1_4, A2_5)
	if A1_4 then
		return "vc_lv" .. A1_4 .. "_sound"
	else
		return "vc_cd_" .. A2_5 .. "_sound"
	end
end
function UnitDrama._add_lipsync(A0_6)
	local L1_7
	L1_7 = A0_6._face_actor_redirect
	L1_7 = L1_7(A0_6, "generic_lipsync")
	A0_6._say_animation = A0_6._machine:play_redirect(L1_7)
end
function UnitDrama.death(A0_8, A1_9)
	local L2_10, L3_11, L4_12, L5_13, L6_14
	L2_10 = managers
	L2_10 = L2_10.dynamic_dialog
	L3_11 = L2_10
	L2_10 = L2_10.find_a_conversation_for_player
	L4_12 = A1_9
	L5_13 = "scream"
	L3_11 = L2_10(L3_11, L4_12, L5_13)
	if not L2_10 then
		return
	end
	L5_13 = A1_9
	L4_12 = A1_9.drama
	L4_12 = L4_12(L5_13)
	L4_12 = L4_12.actor_name
	L5_13 = managers
	L5_13 = L5_13.drama_scene
	L6_14 = L5_13
	L5_13 = L5_13.actor_to_script_unit_name
	L5_13 = L5_13(L6_14, L4_12)
	if not L5_13 then
		L6_14 = cat_print
		L6_14("debug", "The character '" .. A0_8._voice_line.actor_name .. "' is required but not spawned on the level")
		return
	end
	L6_14 = managers
	L6_14 = L6_14.unit_scripting
	L6_14 = L6_14.get_unit_by_name
	L6_14 = L6_14(L6_14, L5_13)
	A0_8._speaker = L6_14
	L6_14 = alive
	L6_14 = L6_14(A0_8._speaker)
	if not L6_14 then
		A0_8._speaker = nil
		return
	end
	L6_14 = assert
	L6_14(A0_8._speaker, "The character '" .. L5_13 .. "' is required but not spawned on the level")
	L6_14 = A0_8._speaker
	L6_14 = L6_14.drama
	L6_14 = L6_14(L6_14)
	L6_14 = L6_14.sound_actor_name
	A0_8._speaker:drama():say(L2_10, nil, L6_14)
	managers.scene_trigger:voice_line_started(L2_10)
	A0_8._conversation_id = L2_10
end
function UnitDrama.say(A0_15, A1_16, A2_17, A3_18)
	A0_15:say_radio(A1_16, A2_17, A3_18)
	A0_15:_add_lipsync()
end
function UnitDrama.say_radio(A0_19, A1_20, A2_21, A3_22)
	local L4_23, L5_24, L6_25, L7_26
	L5_24 = A0_19
	L4_23 = A0_19._soundbank_name_from_scenario_id_or_sound_actor_name
	L6_25 = A2_21
	L7_26 = A3_22
	L4_23 = L4_23(L5_24, L6_25, L7_26)
	L5_24 = "vc_"
	L6_25 = A1_20
	L5_24 = L5_24 .. L6_25
	L6_25 = Sound
	L7_26 = L6_25
	L6_25 = L6_25.make_bank
	L6_25 = L6_25(L7_26, L4_23, L5_24)
	A0_19._say_sound = L6_25
	L6_25 = assert
	L7_26 = A0_19._say_sound
	L6_25(L7_26, "couldn't find soundbank_name:sound=" .. L4_23 .. ":" .. L5_24)
	L6_25 = A0_19._unit
	L7_26 = L6_25
	L6_25 = L6_25.get_object
	L6_25 = L6_25(L7_26, A0_19._sound_output_object_name)
	L7_26 = A0_19._say_sound
	L7_26 = L7_26.set_output
	L7_26(L7_26, L6_25)
	L7_26 = A0_19._say_sound
	L7_26 = L7_26.play
	L7_26 = L7_26(L7_26)
	A0_19._say_sound_instance = SoundInstance:new(L7_26)
	A0_19._machine = A0_19._unit:anim_state_machine()
	A0_19._emitter:say_start(A0_19._unit, A1_20)
end
function UnitDrama._face_actor_redirect(A0_27, A1_28)
	if A0_27.face_actor_name then
		A1_28 = A1_28 .. "_" .. A0_27.face_actor_name
	end
	return A1_28
end
function UnitDrama._stop_talking(A0_29)
	A0_29._emitter:say_stop(A0_29._unit)
	if A0_29._say_sound_instance:is_playing() then
		A0_29._say_sound_instance:stop()
	end
	A0_29._unit:play_redirect("mouth_idle")
	A0_29._say_sound_instance:destroy()
	A0_29._say_sound_instance = nil
	A0_29._machine = nil
	A0_29._say_sound = nil
end
function UnitDrama.is_speaking(A0_30)
	if A0_30._say_sound_instance then
		return A0_30._say_sound_instance:is_playing()
	else
		return false
	end
end
function UnitDrama.set_default_battle_mood(A0_31, A1_32)
	A0_31._default_battle_mood = A1_32
end
function UnitDrama.set_mood(A0_33, A1_34)
	local L2_35
	A0_33._mood_name = A1_34
	L2_35 = A0_33._face_actor_redirect
	L2_35 = L2_35(A0_33, "face_mood_" .. A0_33._mood_name)
	A0_33._unit:play_redirect(L2_35)
end
function UnitDrama.update(A0_36, A1_37, A2_38, A3_39)
	A0_36:update_drama(A3_39)
end
function UnitDrama.update_drama(A0_40, A1_41)
	if A0_40._speaker and not A0_40._speaker:drama():is_speaking() then
		managers.scene_trigger:voice_line_ended(A0_40._conversation_id)
		A0_40._speaker = nil
	end
	A0_40:update_look_at_timer(A1_41)
	if A0_40._default_battle_mood and alive(A0_40._unit) then
		if A0_40._mood_name ~= "stressed" and A0_40._unit:damage_data():is_fully_damaged() == false and managers.dynamic_dialog:is_in_combat() then
			A0_40:set_mood("stressed")
		elseif A0_40._mood_name ~= "dead" and A0_40._unit:damage_data():is_fully_damaged() then
			A0_40:set_mood("dead")
		elseif A0_40._mood_name ~= "calm" and not managers.dynamic_dialog:is_in_combat() then
			A0_40:set_mood("calm")
		end
	end
	if not A0_40._machine then
		return
	end
	if A0_40._say_sound_instance:is_playing() == false then
		A0_40:_stop_talking()
		return
	end
end
function UnitDrama.set_next_look_at_position(A0_42, A1_43, A2_44, A3_45)
	A0_42._unit:player_data().look_at_position = A1_43
	A0_42._unit:player_data().look_at_relative_fov = A3_45
	A0_42._look_at_timer = A2_44
end
function UnitDrama.set_next_look_at_unit(A0_46, A1_47, A2_48, A3_49)
	A0_46._look_at_unit = A1_47
	A0_46:set_next_look_at_position(A1_47:position(), A2_48, A3_49)
end
function UnitDrama.update_look_at_timer(A0_50, A1_51)
	if A0_50._look_at_timer then
		A0_50._look_at_timer = A0_50._look_at_timer - A1_51
		if A0_50._look_at_timer <= 0 then
			A0_50._look_at_timer = nil
			A0_50._unit:player_data().look_at_position = nil
			A0_50._unit:player_data().look_at_relative_fov = nil
			A0_50._look_at_unit = nil
		end
	end
	if A0_50._look_at_unit ~= nil and alive(A0_50._look_at_unit) then
		A0_50._unit:player_data().look_at_position = A0_50._look_at_unit:position()
	end
end
