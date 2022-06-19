require("shared/AverageOverTime")
if not DynamicMusicManager then
	DynamicMusicManager = class()
end
DynamicMusicManager.init = function(l_1_0)
	l_1_0._average_level = AverageOverTime:new(70)
	l_1_0._action_level = 0
	l_1_0.LEVEL_NONE = 0
	l_1_0.LEVEL_AMBIENCE = 1
	l_1_0.LEVEL_ACTION = 2
	l_1_0.LEVEL_INTENSE = 3
	l_1_0._level = l_1_0.LEVEL_NONE
	l_1_0._use_action_level = false
end

DynamicMusicManager.update = function(l_2_0, l_2_1)
	if not l_2_0._use_action_level then
		return 
	end
	l_2_0._average_level:add(l_2_0._action_level * l_2_1, l_2_1)
	if not l_2_0._average_level:is_complete() then
		return 
	end
	if l_2_0._average_level:value() > 0.8 then
		l_2_0:select_if_stable(l_2_0.LEVEL_INTENSE)
	else
		if l_2_0._average_level:value() > 0.5 then
			l_2_0:select_if_stable(l_2_0.LEVEL_ACTION)
		end
	else
		l_2_0:select_if_stable(l_2_0.LEVEL_AMBIENCE)
	end
end

DynamicMusicManager.select_if_stable = function(l_3_0, l_3_1)
	local l_3_2 = nil
	if l_3_1 == l_3_0._level then
		return 
	end
	l_3_0._level = l_3_1
	if l_3_1 == l_3_0.LEVEL_AMBIENCE then
		l_3_2 = "normal"
	elseif l_3_1 == l_3_0.LEVEL_ACTION then
		l_3_2 = "action"
	elseif l_3_1 == l_3_0.LEVEL_INTENSE then
		l_3_2 = "panic"
	end
	managers.music2:set_mode(l_3_2)
end

DynamicMusicManager.set_action_level = function(l_4_0, l_4_1)
	local l_4_2 = assert
	l_4_2(l_4_1 >= 0 and l_4_1 <= 1)
	l_4_0._action_level = l_4_1
	l_4_0._use_action_level = true
end


