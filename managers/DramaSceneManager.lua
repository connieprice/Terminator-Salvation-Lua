if not DramaSceneConversation then
	DramaSceneConversation = class()
end
DramaSceneConversation.init = function(l_1_0)
	l_1_0._lines = {}
end

if not DramaSceneManager then
	DramaSceneManager = class()
end
DramaSceneManager.init = function(l_2_0, l_2_1)
	local l_2_7, l_2_8, l_2_9, l_2_10, l_2_11, l_2_12 = nil
	l_2_0._sound_names = {}
	l_2_0._conversations = {}
	l_2_0._unit_name_to_script_name = {}
	local l_2_2 = true
	local l_2_3 = Database:all(l_2_2, "soundbank")
	for i_0,i_1 in pairs(l_2_3) do
		if i_1:name():sub(0, 5) == "vc_lv" then
			l_2_0:_read_sound_names(Database:load_node(i_1))
		end
	end
	l_2_0:set_unit_name_to_script_name("player2", "character_slot2")
	l_2_0:set_unit_name_to_script_name("player3", "character_slot3")
	l_2_0:set_unit_name_to_script_name("player4", "character_slot4")
	l_2_0._line_finished = false
	l_2_0._interrupt_finished = true
	l_2_0._wall_timer = TimerManager:wall()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

DramaSceneManager._split_voice_line_id = function(l_3_0, l_3_1)
	local l_3_2 = l_3_1:sub(1, 7)
	local l_3_3 = l_3_1:sub(3, 4)
	local l_3_4 = 9
	local l_3_5 = (l_3_1:find("_", l_3_4))
	local l_3_6 = nil
	if l_3_5 then
		l_3_6 = l_3_1:sub(l_3_4, l_3_5 - 1)
	end
	local l_3_7 = l_3_1:sub(l_3_5 + 1)
	local l_3_8 = tonumber(l_3_7)
	local l_3_9 = {}
	l_3_9.name = l_3_1
	l_3_9.wait_time = 0.4
	l_3_9.conversation_id = l_3_2
	l_3_9.scenario_id = l_3_3
	l_3_9.index = l_3_8
	l_3_9.actor_name = l_3_6
	return l_3_9
end

DramaSceneManager._read_sound_names = function(l_4_0, l_4_1)
	local l_4_5, l_4_6 = nil
	for i_0 in l_4_1:children() do
		local l_4_8 = nil
		if not l_4_0._conversations[l_4_0:_split_voice_line_id(i_0:parameter("name"):sub(4)).conversation_id] then
			local l_4_9 = nil
			DramaSceneConversation:new().volume_set = "cinematics_dialogue"
			l_4_0._conversations[l_4_9.conversation_id] = DramaSceneConversation:new()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_4_10 = nil
		l_4_0._conversations[l_4_9.conversation_id]._lines[l_4_10.index] = l_4_10
	end
end

DramaSceneManager.play_conversation = function(l_5_0, l_5_1, l_5_2)
	local l_5_3 = nil
	if l_5_0._conversation and l_5_0._conversation.volume_set then
		l_5_3 = l_5_0._conversation.volume_set
	end
	l_5_0._options = l_5_2
	assert(l_5_0._conversation_id == nil, "You must stop the first scene before starting a new")
	l_5_0._conversation_index = 0
	l_5_0._playing_sound = false
	l_5_0._conversation = l_5_0._conversations[l_5_1]
	l_5_0._conversation.old_volume_set_to_deactivate = l_5_3
	l_5_0._conversation.activate_volume_set = true
end

DramaSceneManager.update = function(l_6_0, l_6_1)
	if not l_6_0._conversation then
		return 
	end
	if not alive(l_6_0._speaker) then
		l_6_0:_start_next_sound()
		return 
	end
	if l_6_0._interrupt_time and l_6_0._interrupt_time ~= 0 then
		l_6_0._interrupt_time = l_6_0._interrupt_time - l_6_0._wall_timer:delta_time()
	if l_6_0._interrupt_time < 0 then
		end
		l_6_0:_start_next_sound()
		l_6_0._interrupt_finished = false
	end
	if l_6_0._speaker:drama():is_speaking() then
		return 
	end
	if l_6_0._line_finished == false and l_6_0._voice_line ~= nil then
		managers.scene_trigger:voice_line_ended(l_6_0._voice_line.name)
		l_6_0._line_finished = true
	end
	l_6_0._wait_time = l_6_0._wait_time - l_6_0._wall_timer:delta_time()
	if l_6_0._wait_time > 0 then
		return 
	end
	l_6_0:_start_next_sound()
end

DramaSceneManager.is_conversation_ongoing = function(l_7_0)
	return l_7_0._conversation ~= nil
end

DramaSceneManager.current_conversation = function(l_8_0)
	return l_8_0._conversation
end

DramaSceneManager._end_of_scene = function(l_9_0)
	managers.volume:deactivate_set(l_9_0._conversation.volume_set)
	l_9_0._conversation = nil
	l_9_0._conversation_index = nil
	l_9_0._voice_line = nil
end

DramaSceneManager.conversation_ids = function(l_10_0)
	local l_10_5 = nil
	local l_10_1 = {}
	for i_0,i_1 in pairs(l_10_0._conversations) do
		l_10_1[#l_10_1 + 1] = i_0
	end
	return l_10_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

DramaSceneManager.conversation_line_ids = function(l_11_0, l_11_1)
	local l_11_6, l_11_7, l_11_8, l_11_9 = nil
	local l_11_2 = {}
	if not l_11_0._conversations[l_11_1] then
		return l_11_2
	end
	for i_0,i_1 in pairs(l_11_0._conversations[l_11_1]._lines) do
		l_11_2[#l_11_2 + 1] = i_1.name
	end
	return l_11_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

DramaSceneManager.actor_units_in_conversation = function(l_12_0, l_12_1)
	local l_12_7, l_12_8 = nil
	local l_12_2 = l_12_0._conversations[l_12_1]
	local l_12_3 = {}
	for i_0,i_1 in pairs(l_12_2._lines) do
		l_12_3[l_12_0:_actor_to_unit_name(i_1.actor_name)] = true
	end
	return l_12_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

DramaSceneManager.actor_to_script_unit_name = function(l_13_0, l_13_1)
	local l_13_2 = l_13_0:_actor_to_unit_name(l_13_1)
	local l_13_3 = assert
	l_13_3(l_13_1 ~= nil)
	l_13_3 = l_13_0._unit_name_to_script_name
	l_13_3 = l_13_3[l_13_2]
	return l_13_3
end

local l_0_0 = DramaSceneManager
local l_0_1 = {}
l_0_1.xia = "xiao_lin"
l_0_1.ang = "angie_salter"
l_0_1.crz = "crazy_resistance_soldier"
l_0_1.smp = "simpson"
l_0_1.jcr = "john_connor"
l_0_1.bws = "blair"
l_0_1.rgs = "rogers"
l_0_1.rg2 = "rogers_set2"
l_0_1.dbk = "dobkin"
l_0_1.mpy = "murphy"
l_0_1.wls = "wells"
l_0_1.wrn = "warren"
l_0_1.sv1 = "survivalist_male_01"
l_0_1.sv2 = "survivalist_male_02"
l_0_1.sv3 = "survivalist_male_03"
l_0_1.sv4 = "survivalist_male_04"
l_0_1.sv5 = "survivalist_male_05"
l_0_1.sv6 = "survivalist_male_06"
l_0_1.sv7 = "survivalist_female_01"
l_0_1.su1 = "survivor_01"
l_0_1.su2 = "survivor_02"
l_0_1.jns = "jones"
l_0_1.pts = "peters"
l_0_1.lws = "lewis"
l_0_1.hpk = "hopkins"
l_0_1.gfn = "giffin"
l_0_1.dck = "deckard"
l_0_1.dwn = "david_weston"
l_0_1.brs = "barnes"
l_0_1.mks = "marks"
l_0_1.mk2 = "marks_set2"
l_0_1.tna = "tina"
l_0_1.ogy = "ogrady"
l_0_1.lda = "linda"
l_0_1.rp1 = "resistance_pilot_01"
l_0_1.rp2 = "resistance_pilot_02"
l_0_1.con = "connie"
l_0_1.rf1 = "resistance_male_01"
l_0_1.rf2 = "resistance_female_01"
l_0_1.rf3 = "resistance_male_03"
l_0_1.rs4 = "resistance_male_04"
l_0_1.rs6 = "resistance_soldier_06"
l_0_1.rs7 = "resistance_soldier_07"
l_0_1.rf6 = "resistance_fighter_06"
l_0_1.rf7 = "resistance_fighter_07"
l_0_1.rf8 = "resistance_female_04"
l_0_1.rs8 = "resistance_soldier_08"
l_0_1.rs9 = "resistance_female_05"
l_0_1.rf9 = "resistance_female_02"
l_0_1.s10 = "resistance_soldier_10"
l_0_1.s11 = "resistance_female_06"
l_0_1.s12 = "resistance_male_09"
l_0_1.s13 = "resistance_soldier_13"
l_0_1.s14 = "resistance_male_08"
l_0_1.s15 = "resistance_soldier_15"
l_0_1.s16 = "resistance_male_02"
l_0_0.actor_to_unit_name = l_0_1
l_0_0 = DramaSceneManager
l_0_1 = function(l_14_0, l_14_1)
	local l_14_2 = DramaSceneManager.actor_to_unit_name[l_14_1]
	assert(l_14_2, "_actor_to_unit_name needs a lookup for '" .. l_14_1 .. "'")
	return l_14_2
end

l_0_0._actor_to_unit_name = l_0_1
l_0_0 = DramaSceneManager
l_0_1 = function(l_15_0)
	if l_15_0._conversation ~= nil then
		l_15_0._speaker:drama():destroy()
		l_15_0:_end_of_scene()
	end
end

l_0_0.stop_scene = l_0_1
l_0_0 = DramaSceneManager
l_0_1 = function(l_16_0)
	if l_16_0._conversation.old_volume_set_to_deactivate then
		managers.volume:deactivate_set(l_16_0._conversation.old_volume_set_to_deactivate)
		l_16_0._conversation.old_volume_set_to_deactivate = nil
	end
	if l_16_0._conversation.activate_volume_set then
		managers.volume:activate_set(l_16_0._conversation.volume_set)
		l_16_0._conversation.activate_volume_set = nil
	end
	if l_16_0._interrupt_finished == false then
		l_16_0._interrupt_finished = true
		return 
	end
	l_16_0._line_finished = false
	l_16_0._conversation_index = l_16_0._conversation_index + 1
	l_16_0._voice_line = l_16_0._conversation._lines[l_16_0._conversation_index]
	if not l_16_0._voice_line then
		l_16_0:_end_of_scene()
		return 
	end
	l_16_0._wait_time = l_16_0._voice_line.wait_time
	if l_16_0._options and l_16_0._options[l_16_0._voice_line.name] then
		l_16_0._wait_time = l_16_0._options[l_16_0._voice_line.name].delay
		l_16_0._interrupt_time = l_16_0._options[l_16_0._voice_line.name].interrupt or 0
	end
	local l_16_2 = l_16_0:actor_to_script_unit_name(l_16_0._voice_line.actor_name)
	if l_16_2 == nil then
		local l_16_1 = false
		l_16_1 = true
	end
	if not l_16_2 then
		cat_print("debug", "The character '" .. l_16_0._voice_line.actor_name .. "' is required but not spawned on the level")
		return 
	end
	l_16_0._speaker = managers.unit_scripting:get_unit_by_name(l_16_2)
	if not alive(l_16_0._speaker) then
		l_16_0._speaker = nil
		return 
	end
	assert(l_16_0._speaker, "The character '" .. l_16_2 .. "' is required but not spawned on the level")
	local l_16_3 = nil
	if l_16_3 == false then
		l_16_0._speaker:drama():say(l_16_0._voice_line.name, l_16_0._voice_line.scenario_id, l_16_0._speaker:drama().sound_actor_name)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	else
		l_16_0._speaker:drama():say_radio(l_16_0._voice_line.name, l_16_0._voice_line.scenario_id, l_16_0._speaker:drama().sound_actor_name)
	end
	if l_16_0._voice_line ~= nil then
		managers.scene_trigger:voice_line_started(l_16_0._voice_line.name)
	end
end

l_0_0._start_next_sound = l_0_1
l_0_0 = DramaSceneManager
l_0_1 = function(l_17_0, l_17_1, l_17_2, l_17_3)
	assert(l_17_1)
	local l_17_4 = {}
	l_17_4.name = l_17_1
	l_17_4.wait_time = 0.4
	l_17_4.conversation_id = l_17_1
	l_17_4.scenario_id = nil
	l_17_4.index = 1
	l_17_4.actor_name = l_17_2
	local l_17_5 = DramaSceneConversation:new()
	l_17_0._conversations[l_17_4.conversation_id] = l_17_5
	l_17_5.volume_set = l_17_3
	local l_17_6 = l_17_5._lines
	l_17_5._lines[1] = l_17_4
end

l_0_0.add_temporary_conversation = l_0_1
l_0_0 = DramaSceneManager
l_0_1 = function(l_18_0, l_18_1)
	l_18_0._conversations[l_18_1] = nil
end

l_0_0.remove_temporary_conversation = l_0_1
l_0_0 = DramaSceneManager
l_0_1 = function(l_19_0, l_19_1, l_19_2)
	l_19_0._unit_name_to_script_name[l_19_1] = l_19_2
end

l_0_0.set_unit_name_to_script_name = l_0_1
l_0_0 = DramaSceneManager
l_0_1 = function(l_20_0, l_20_1)
	return l_20_0._unit_name_to_script_name[l_20_1]
end

l_0_0.unit_name_to_script_name = l_0_1

