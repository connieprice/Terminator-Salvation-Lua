if not AMAchievement then
	AMAchievement = class(CoreActionElement)
end
AMAchievement.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMAchievement.activate_now = function(l_2_0)
	local l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_11 = nil
	if SystemInfo:platform() == "PS3" then
		local l_2_1 = managers.save:primary_user()
		l_2_0:_check_award_achievement(l_2_1)
	else
		local l_2_2 = managers.local_user:users()
		for i_0,i_1 in pairs(l_2_2) do
			if i_1:wanted_player_slot_id() then
				l_2_0:_check_award_achievement(i_1)
			end
		end
	end
	l_2_0:deactivate_now()
end

AMAchievement._check_award_achievement = function(l_3_0, l_3_1)
	local l_3_2 = l_3_1:profile()
	local l_3_3 = l_3_2.difficulty_level
	if not l_3_0.difficulties[l_3_3] then
		cat_print("debug", "Achievement " .. l_3_0.achievement_id .. " failed difficulty check for user " .. l_3_1:user_index())
		return 
	end
	if not l_3_0:_check_difficulty(l_3_2.levels, l_3_2.current_level_id, l_3_3) then
		cat_print("debug", "Achievement " .. l_3_0.achievement_id .. " failed difficulty check 2 for user " .. l_3_1:user_index())
		return 
	end
	l_3_0:_award_achievement(l_3_1)
end

AMAchievement._check_difficulty = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_18, l_4_19, l_4_20 = nil
	for l_4_7 = l_4_2, 1, -1 do
		local l_4_8 = l_4_1[l_4_7]
		for l_4_12 = 1, l_4_8.maximum_checkpoint_id do
			local l_4_13 = l_4_8.checkpoints[l_4_12]
			local l_4_14 = false
			for i_0,i_1 in ipairs(l_4_0.difficulties) do
				if i_1 and l_4_13.difficulty_levels[i_0] then
					l_4_14 = true
				end
			end
			if not l_4_14 then
				return false
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	return true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AMAchievement._award_achievement = function(l_5_0, l_5_1)
	if SystemInfo:platform() == "X360" and l_5_0.achievement_id then
		cat_print("debug", "Awarding achievement " .. l_5_0.achievement_id .. " to user " .. l_5_1:user_index())
		XboxLive:award_achievement(l_5_1:user_index(), l_5_0.achievement_id, function(l_6_0)
    end)
	end
	do return end
	if SystemInfo:platform() == "WIN32" then
		cat_print("debug", "Achievement awarded")
	else
		if SystemInfo:platform() == "PS3" then
			local l_5_2 = l_5_0.trophy_id
		if l_5_2 then
			end
			Trophies:unlock_id(l_5_2, nil)
		end
	else
		assert(false, "Unknown platform")
	end
end


