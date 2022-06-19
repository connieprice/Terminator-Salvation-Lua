require("music/SoundInstance")
if not UnitDrama then
	UnitDrama = class()
end
UnitDrama.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._emitter = managers.action_event:create_emitter(l_1_1)
	l_1_0:set_mood("calm")
	l_1_0._look_at_unit = nil
	l_1_0._default_battle_mood = true
end

UnitDrama.destroy = function(l_2_0)
	if l_2_0._say_sound_instance then
		l_2_0:_stop_talking()
	end
end

UnitDrama._soundbank_name_from_scenario_id_or_sound_actor_name = function(l_3_0, l_3_1, l_3_2)
	if l_3_1 then
		return "vc_lv" .. l_3_1 .. "_sound"
	else
		return "vc_cd_" .. l_3_2 .. "_sound"
	end
end

UnitDrama._add_lipsync = function(l_4_0)
	local l_4_1 = l_4_0:_face_actor_redirect("generic_lipsync")
	l_4_0._say_animation = l_4_0._machine:play_redirect(l_4_1)
end

UnitDrama.death = function(l_5_0, l_5_1)
	local l_5_2, l_5_3 = managers.dynamic_dialog:find_a_conversation_for_player(l_5_1, "scream")
	if not l_5_2 then
		return 
	end
	local l_5_4 = l_5_1:drama().actor_name
	local l_5_5 = managers.drama_scene:actor_to_script_unit_name(l_5_4)
	if not l_5_5 then
		cat_print("debug", "The character '" .. l_5_0._voice_line.actor_name .. "' is required but not spawned on the level")
		return 
	end
	l_5_0._speaker = managers.unit_scripting:get_unit_by_name(l_5_5)
	if not alive(l_5_0._speaker) then
		l_5_0._speaker = nil
		return 
	end
	assert(l_5_0._speaker, "The character '" .. l_5_5 .. "' is required but not spawned on the level")
	local l_5_6 = l_5_0._speaker:drama().sound_actor_name
	l_5_0._speaker:drama():say(l_5_2, nil, l_5_6)
	managers.scene_trigger:voice_line_started(l_5_2)
	l_5_0._conversation_id = l_5_2
end

UnitDrama.say = function(l_6_0, l_6_1, l_6_2, l_6_3)
	l_6_0:say_radio(l_6_1, l_6_2, l_6_3)
	l_6_0:_add_lipsync()
end

UnitDrama.say_radio = function(l_7_0, l_7_1, l_7_2, l_7_3)
	local l_7_4 = l_7_0:_soundbank_name_from_scenario_id_or_sound_actor_name(l_7_2, l_7_3)
	local l_7_5 = "vc_" .. l_7_1
	l_7_0._say_sound = Sound:make_bank(l_7_4, l_7_5)
	assert(l_7_0._say_sound, "couldn't find soundbank_name:sound=" .. l_7_4 .. ":" .. l_7_5)
	local l_7_6 = l_7_0._unit:get_object(l_7_0._sound_output_object_name)
	l_7_0._say_sound:set_output(l_7_6)
	local l_7_7 = l_7_0._say_sound:play()
	l_7_0._say_sound_instance = SoundInstance:new(l_7_7)
	l_7_0._machine = l_7_0._unit:anim_state_machine()
	l_7_0._emitter:say_start(l_7_0._unit, l_7_1)
end

UnitDrama._face_actor_redirect = function(l_8_0, l_8_1)
	if l_8_0.face_actor_name then
		l_8_1 = l_8_1 .. "_" .. l_8_0.face_actor_name
	end
	return l_8_1
end

UnitDrama._stop_talking = function(l_9_0)
	l_9_0._emitter:say_stop(l_9_0._unit)
	if l_9_0._say_sound_instance:is_playing() then
		l_9_0._say_sound_instance:stop()
	end
	l_9_0._unit:play_redirect("mouth_idle")
	l_9_0._say_sound_instance:destroy()
	l_9_0._say_sound_instance = nil
	l_9_0._machine = nil
	l_9_0._say_sound = nil
end

UnitDrama.is_speaking = function(l_10_0)
	if l_10_0._say_sound_instance then
		local l_10_1, l_10_2 = l_10_0._say_sound_instance:is_playing, l_10_0._say_sound_instance
		return l_10_1(l_10_2)
	else
		return false
	end
end

UnitDrama.set_default_battle_mood = function(l_11_0, l_11_1)
	l_11_0._default_battle_mood = l_11_1
end

UnitDrama.set_mood = function(l_12_0, l_12_1)
	l_12_0._mood_name = l_12_1
	local l_12_2 = l_12_0:_face_actor_redirect("face_mood_" .. l_12_0._mood_name)
	l_12_0._unit:play_redirect(l_12_2)
end

UnitDrama.update = function(l_13_0, l_13_1, l_13_2, l_13_3)
	l_13_0:update_drama(l_13_3)
end

UnitDrama.update_drama = function(l_14_0, l_14_1)
	if l_14_0._speaker and not l_14_0._speaker:drama():is_speaking() then
		managers.scene_trigger:voice_line_ended(l_14_0._conversation_id)
		l_14_0._speaker = nil
	end
	l_14_0:update_look_at_timer(l_14_1)
	if l_14_0._default_battle_mood and alive(l_14_0._unit) then
		local l_14_2 = l_14_0._unit:damage_data():is_fully_damaged()
		if l_14_0._mood_name ~= "stressed" and l_14_2 == false and managers.dynamic_dialog:is_in_combat() then
			l_14_0:set_mood("stressed")
		end
	elseif l_14_0._mood_name ~= "dead" and l_14_2 then
		l_14_0:set_mood("dead")
	elseif l_14_0._mood_name ~= "calm" and not managers.dynamic_dialog:is_in_combat() then
		l_14_0:set_mood("calm")
	end
	if not l_14_0._machine then
		return 
	end
	if l_14_0._say_sound_instance:is_playing() == false then
		l_14_0:_stop_talking()
		return 
	end
end

UnitDrama.set_next_look_at_position = function(l_15_0, l_15_1, l_15_2, l_15_3)
	local l_15_4 = l_15_0._unit:player_data()
	l_15_4.look_at_position = l_15_1
	l_15_4.look_at_relative_fov = l_15_3
	l_15_0._look_at_timer = l_15_2
end

UnitDrama.set_next_look_at_unit = function(l_16_0, l_16_1, l_16_2, l_16_3)
	l_16_0._look_at_unit = l_16_1
	l_16_0:set_next_look_at_position(l_16_1:position(), l_16_2, l_16_3)
end

UnitDrama.update_look_at_timer = function(l_17_0, l_17_1)
	if l_17_0._look_at_timer then
		l_17_0._look_at_timer = l_17_0._look_at_timer - l_17_1
	if l_17_0._look_at_timer <= 0 then
		end
		l_17_0._look_at_timer = nil
		local l_17_2 = l_17_0._unit:player_data()
		l_17_2.look_at_position = nil
		l_17_2.look_at_relative_fov = nil
		l_17_0._look_at_unit = nil
	end
	if l_17_0._look_at_unit ~= nil and alive(l_17_0._look_at_unit) then
		l_17_0._unit:player_data().look_at_position = l_17_0._look_at_unit:position()
	end
end


