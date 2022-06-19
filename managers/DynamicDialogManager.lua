require("shared/RandomTraversal")
require("shared/TableAlgorithms")
if not DynamicDialogManager then
	DynamicDialogManager = class()
end
DynamicDialogManager.PRIORITY_DRAMA = 1
DynamicDialogManager.PRIORITY_DIRECTION = 2
DynamicDialogManager.PRIORITY_REACTION = 3
DynamicDialogManager.init = function(l_1_0)
	l_1_0._priority_to_time = {}
	l_1_0._priority_to_time[l_1_0.PRIORITY_DRAMA] = 0
	l_1_0._priority_to_time[l_1_0.PRIORITY_DIRECTION] = 1
	l_1_0._priority_to_time[l_1_0.PRIORITY_REACTION] = 3
	l_1_0._action_level = 0
	l_1_0._dynamic_conversations = {}
	l_1_0:_scan_soundbanks()
	l_1_0:_randomize_variants()
	l_1_0._time_since_last_spoken = TimerManager:game():time()
	l_1_0._emitter = managers.action_event:create_emitter()
	l_1_0._idle_timer = 0
	l_1_0._banter_timer = 0
	l_1_0._random_player_traversal = RandomTraversal:new(0, true)
	l_1_0._before_time_in_story = true
end

DynamicDialogManager.destroy = function(l_2_0)
	l_2_0._emitter:destroy()
	l_2_0._emitter = nil
end

DynamicDialogManager._randomize_variants = function(l_3_0)
	local l_3_4, l_3_5, l_3_6, l_3_7 = nil
	for i_0,i_1 in pairs(l_3_0._dynamic_conversations) do
		i_1.variant_to_play = RandomTraversal:new(i_1.variation_count, true)
	end
end

DynamicDialogManager._scan_soundbanks = function(l_4_0)
	local l_4_6, l_4_7, l_4_8, l_4_9, l_4_10, l_4_11 = nil
	cat_print("dialog", "Welcome to the dynamic dialog scanner...parsing all the soundbanks now...")
	local l_4_1 = true
	local l_4_2 = Database:all(l_4_1, "soundbank")
	for i_0,i_1 in pairs(l_4_2) do
		if i_1:name():sub(0, 6) == "vc_cd_" then
			l_4_0:_read_sound_names(Database:load_node(i_1))
		end
	end
end

DynamicDialogManager._read_sound_names = function(l_5_0, l_5_1)
	local l_5_5, l_5_6, l_5_7 = nil
	for i_0 in l_5_1:children() do
		if i_0:name() == "group" then
			l_5_0:_read_sound_names(l_5_8)
		elseif i_0:name() == "sound" then
			local l_5_9 = nil
			l_5_0:_split_voice_line_id(l_5_8:parameter("name"):sub(4))
		end
	end
end

DynamicDialogManager._split_voice_line_id = function(l_6_0, l_6_1)
	local l_6_2 = l_6_1
	local l_6_3 = nil
	local l_6_4 = String.split(l_6_1, "[_%s]")
	local l_6_5 = assert
	l_6_5(#l_6_4 == 5, "Illegal sound name for:" .. l_6_1)
	l_6_5 = l_6_4[1]
	local l_6_8 = l_6_4[2]
	local l_6_9 = l_6_4[3]
	local l_6_10 = l_6_4[4]
	local l_6_11 = tonumber(l_6_4[5])
	local l_6_12 = (l_6_0:_build_dynamic_main_voice_id(l_6_5, l_6_8, l_6_9, l_6_10))
	local l_6_13 = nil
	if not l_6_0._dynamic_conversations[l_6_12] then
		l_6_0._dynamic_conversations[l_6_12] = {}
		l_6_13 = l_6_0._dynamic_conversations[l_6_12]
		l_6_13.variation_count = 0
	else
		l_6_13 = l_6_0._dynamic_conversations[l_6_12]
	end
	l_6_13.variation_count = l_6_13.variation_count + 1
end

DynamicDialogManager._build_dynamic_main_voice_id = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4)
	return l_7_1 .. "_" .. l_7_2 .. "_" .. l_7_3 .. "_" .. l_7_4
end

DynamicDialogManager.update = function(l_8_0, l_8_1)
	if not l_8_0._time_when_last_spoken or not managers.drama_scene:is_conversation_ongoing() then
		if l_8_0._playing_conversation_id then
			managers.drama_scene:remove_temporary_conversation(l_8_0._playing_conversation_id)
			l_8_0._playing_conversation_id = nil
		end
	if not l_8_0._time_when_last_spoken then
		end
		l_8_0:_conversation_done()
		l_8_0._time_when_last_spoken = TimerManager:game():time()
	end
	l_8_0:check_idle_for_main_human_character(l_8_1)
	l_8_0:check_combat_banter(l_8_1)
end

DynamicDialogManager._conversation_done = function(l_9_0)
end

DynamicDialogManager.check_combat_banter = function(l_10_0, l_10_1)
	if l_10_0:is_in_combat() then
		l_10_0._banter_timer = l_10_0._banter_timer + l_10_1
		if tweak_data.dynamic_dialog.COMBAT_BANTER_TIME_THRESHOLD < l_10_0._banter_timer then
			l_10_0._emitter:combat_banter()
			l_10_0._banter_timer = 0
		end
	else
		l_10_0._banter_timer = 0
	end
end

DynamicDialogManager.check_idle_for_main_human_character = function(l_11_0, l_11_1)
	if l_11_0:is_in_combat() then
		return 
	end
	if not managers.unit_scripting:unit_exists("character_slot1") then
		return 
	end
	local l_11_2 = managers.unit_scripting:get_unit_by_name("character_slot1")
	if dead(l_11_2) then
		return 
	end
	local l_11_3 = l_11_2:input()
	local l_11_4 = l_11_2:player_data()
	if l_11_3:movement_length() < 0.1 and not l_11_4.on_rail_vehicle then
		l_11_0._idle_timer = l_11_0._idle_timer + l_11_1
	else
		l_11_0._idle_timer = 0
	end
	if tweak_data.dynamic_dialog.IDLE_TIME_OUT < l_11_0._idle_timer then
		l_11_0._emitter:human_character_entered_idle(l_11_2)
		l_11_0._idle_timer = 0
	end
end

DynamicDialogManager.can_anyone_speak_this_priority = function(l_12_0, l_12_1)
	if not l_12_0._time_when_last_spoken then
		return false
	end
	local l_12_2 = TimerManager:game():time()
	local l_12_3 = l_12_0._priority_to_time[l_12_1]
	return l_12_0._time_when_last_spoken + l_12_3 < l_12_2
end

DynamicDialogManager.should_this_unit_speak = function(l_13_0, l_13_1, l_13_2)
	assert(l_13_0:can_anyone_speak_this_priority(l_13_2))
	return math.rand(1) < 0.421
end

DynamicDialogManager.set_before_time_in_story = function(l_14_0, l_14_1)
	l_14_0._before_time_in_story = l_14_1
end

DynamicDialogManager.find_a_conversation = function(l_15_0, l_15_1, l_15_2)
	local l_15_3 = nil
	if l_15_0:is_in_combat() then
		l_15_3 = "combat"
	else
		l_15_3 = "casual"
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_15_0._before_time_in_story then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_15_4, l_15_5 = nil, nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if nil or R6_PC33 or R6_PC33 or not l_15_5 then
		cat_print("dialog", "No dialog for combination:" .. l_15_1 .. " time:" .. l_15_4 .. " mood:" .. l_15_3 .. " event:" .. l_15_2)
	end
	return l_15_5, R6_PC33
end

DynamicDialogManager._build_conversation_id = function(l_16_0, l_16_1, l_16_2, l_16_3, l_16_4)
	local l_16_5 = l_16_0:_build_dynamic_main_voice_id(l_16_1, l_16_2, l_16_3, l_16_4)
	local l_16_6 = l_16_0._dynamic_conversations[l_16_5]
	if not l_16_6 then
		return 
	end
	local l_16_7 = string.format("%02d", l_16_6.variant_to_play:next_index())
	l_16_5 = l_16_5 .. "_" .. l_16_7
	return l_16_5, l_16_6
end

DynamicDialogManager._random_player = function(l_17_0)
	local l_17_1 = managers.player:players()
	local l_17_2 = (TableAlgorithms.count(l_17_1))
	local l_17_3 = nil
	local l_17_4 = 0
	l_17_0._random_player_traversal:set_count(l_17_2)
	while l_17_3 == nil and l_17_4 < l_17_2 do
		l_17_4 = l_17_4 + 1
		local l_17_5 = l_17_0._random_player_traversal:next_index()
		local l_17_6 = TableAlgorithms.value_at_offset(l_17_1, l_17_5)
		if not dead(l_17_6) then
			l_17_3 = l_17_6
			assert(l_17_3, "random index:" .. l_17_5 .. " player_count:" .. l_17_2)
		end
	end
	return l_17_3
end

DynamicDialogManager.say = function(l_18_0, l_18_1, l_18_2)
	local l_18_3 = managers.player:players()
	local l_18_4 = TableAlgorithms.count(l_18_3)
	for l_18_8 = 1, l_18_4 do
		local l_18_9 = l_18_0:_random_player()
		if not l_18_9 then
			return 
		end
		local l_18_10, l_18_11 = l_18_0:find_a_conversation_for_player(l_18_9, l_18_2)
		if l_18_10 then
			local l_18_12 = l_18_9:drama().actor_name
			assert(l_18_10, "couldn't find conversation for " .. l_18_9:name() .. " unit_actor_name " .. l_18_12 .. " event_name:" .. l_18_2)
			l_18_0:say_internal(l_18_10, l_18_12)
			return 
		end
	end
end

DynamicDialogManager.try_to_say = function(l_19_0, l_19_1, l_19_2, l_19_3)
	local l_19_9, l_19_10, l_19_11, l_19_12 = nil
	local l_19_4 = managers.player:human_players()
	local l_19_5 = false
	for i_0,i_1 in pairs(l_19_4) do
		if i_1:position() - l_19_1:position():length() < tweak_data.dynamic_dialog.MAX_DISTANCE_FROM_PLAYERS then
			l_19_5 = true
		end
	end
	if l_19_5 == false then
		return 
	end
	if l_19_2 ~= "help" and l_19_3 == nil and dead(l_19_1) then
		return 
	end
	if not l_19_0._time_when_last_spoken and l_19_3 == nil then
		return 
	end
	if managers.drama_scene:is_conversation_ongoing() then
		return 
	end
	assert(({inactive = DynamicDialogManager.PRIORITY_DIRECTION, banter = DynamicDialogManager.PRIORITY_DIRECTION, explosion = DynamicDialogManager.PRIORITY_REACTION, grunt = DynamicDialogManager.PRIORITY_REACTION, scream = DynamicDialogManager.PRIORITY_DRAMA, reload = DynamicDialogManager.PRIORITY_DIRECTION, ["low-ammo"] = DynamicDialogManager.PRIORITY_DIRECTION, ["give-ammo"] = DynamicDialogManager.PRIORITY_DIRECTION, grenade = DynamicDialogManager.PRIORITY_DIRECTION, score = DynamicDialogManager.PRIORITY_DIRECTION, thanks = DynamicDialogManager.PRIORITY_DIRECTION, help = DynamicDialogManager.PRIORITY_DIRECTION, stunned = DynamicDialogManager.PRIORITY_DIRECTION})[l_19_2], "event:" .. l_19_2 .. " hasn't got a priority!")
	if not l_19_0:can_anyone_speak_this_priority(DynamicDialogManager.PRIORITY_REACTION) then
		return 
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_19_2 ~= "thanks" and not l_19_0:should_this_unit_speak(l_19_0._unit, ({inactive = DynamicDialogManager.PRIORITY_DIRECTION, banter = DynamicDialogManager.PRIORITY_DIRECTION, explosion = DynamicDialogManager.PRIORITY_REACTION, grunt = DynamicDialogManager.PRIORITY_REACTION, scream = DynamicDialogManager.PRIORITY_DRAMA, reload = DynamicDialogManager.PRIORITY_DIRECTION, ["low-ammo"] = DynamicDialogManager.PRIORITY_DIRECTION, ["give-ammo"] = DynamicDialogManager.PRIORITY_DIRECTION, grenade = DynamicDialogManager.PRIORITY_DIRECTION, score = DynamicDialogManager.PRIORITY_DIRECTION, thanks = DynamicDialogManager.PRIORITY_DIRECTION, help = DynamicDialogManager.PRIORITY_DIRECTION, stunned = DynamicDialogManager.PRIORITY_DIRECTION})[l_19_2]) then
		cat_print("dialog", "...but it wasn't his/her turn to speak")
		return 
	end
	l_19_0:say_conversation_for_unit(l_19_1, l_19_2)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

DynamicDialogManager.say_conversation_for_unit = function(l_20_0, l_20_1, l_20_2)
	local l_20_3, l_20_4 = l_20_0:find_a_conversation_for_player(l_20_1, l_20_2)
	if not l_20_3 then
		return 
	end
	local l_20_5 = l_20_1:drama().actor_name
	l_20_0:say_internal(l_20_3, l_20_5)
end

DynamicDialogManager.find_a_conversation_for_player = function(l_21_0, l_21_1, l_21_2)
	assert(l_21_1:drama().actor_name, "unit " .. l_21_1:name() .. " must have an actor-name")
	local l_21_3 = l_21_1:drama().actor_name
	local l_21_4 = l_21_1:drama().sound_actor_name
	cat_print("dialog", "DynamicDialog: unit " .. l_21_3 .. " wanted to say:" .. l_21_2 .. " with voice:" .. l_21_4)
	local l_21_5, l_21_6 = l_21_0:find_a_conversation(l_21_4, l_21_2)
	if not l_21_5 then
		cat_print("dialog", "...but didn't have any dialog for it :(")
		return 
	end
	return l_21_5, l_21_6
end

DynamicDialogManager.say_internal = function(l_22_0, l_22_1, l_22_2)
	assert(l_22_1)
	l_22_0._playing_conversation_id = l_22_1
	local l_22_3 = nil
	if l_22_0:is_in_combat() then
		l_22_3 = "combat_dialogue"
	else
		l_22_3 = "ambient_dialogue"
	end
	if managers.drama_scene:is_conversation_ongoing() == false then
		managers.drama_scene:add_temporary_conversation(l_22_0._playing_conversation_id, l_22_2, l_22_3)
		managers.drama_scene:play_conversation(l_22_1, nil)
	end
	l_22_0._time_when_last_spoken = nil
end

DynamicDialogManager.set_action_level = function(l_23_0, l_23_1)
	l_23_0._action_level = l_23_1
end

DynamicDialogManager.is_in_combat = function(l_24_0)
	return l_24_0._action_level >= 0.9
end


