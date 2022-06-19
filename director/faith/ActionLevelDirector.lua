if not ActionLevelDirector then
	ActionLevelDirector = class()
end
ActionLevelDirector.init = function(l_1_0)
	l_1_0._units = {}
	l_1_0._last_time_local_player_threatened = -tweak_data.directors.music_director.PLAYER_THREATENED_MEMORY_TIME
end

ActionLevelDirector.add_ai_unit = function(l_2_0, l_2_1)
	l_2_0._units[l_2_1] = l_2_1
end

ActionLevelDirector.remove_ai_unit = function(l_3_0, l_3_1)
	l_3_0._units[l_3_1] = nil
end

ActionLevelDirector.update = function(l_4_0, l_4_1, l_4_2)
	local l_4_11, l_4_12, l_4_13, l_4_14, l_4_18, l_4_19 = nil
	local l_4_3 = false
	local l_4_4 = false
	local l_4_5, l_4_6, l_4_7 = nil, nil, nil
	for i_0,i_1 in pairs(l_4_0._units) do
		l_4_5 = i_1:ai_data()
		if not l_4_3 then
			l_4_6 = l_4_5._threat_tracking
			for i_0,i_1 in pairs(l_4_6._threats) do
				if alive(i_1:unit()) then
					l_4_3 = true
				end
		else
			end
		end
		if l_4_5.output.currently_targeted_threat then
			l_4_7 = l_4_5.output.currently_targeted_threat:unit()
		if alive(l_4_7) then
			end
		if l_4_7:local_player() then
			end
		if l_4_5.output.allowed_to_fire then
			end
			l_4_4 = true
	else
		end
	end
	if l_4_4 then
		l_4_0._last_time_local_player_threatened = l_4_1
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_4_3 and l_4_1 - l_4_0._last_time_local_player_threatened < tweak_data.directors.music_director.PLAYER_THREATENED_MEMORY_TIME then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_4_3 then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	managers.dynamic_music:set_action_level(0)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	managers.dynamic_dialog:set_action_level(0)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


