if not HunterKillerAiDefence then
	HunterKillerAiDefence = class()
end
HunterKillerAiDefence.init_data = function(l_1_0, l_1_1)
	l_1_1._defence = {}
	l_1_1._defence.forced_flares = {}
	l_1_1._defence.forced_flare_cnt = nil
	l_1_1._defence.forced_flare_start = nil
end

HunterKillerAiDefence.logic_hk_defence_init = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
	return 0
end

HunterKillerAiDefence.logic_hk_defence_passive = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7)
	local l_3_8 = l_3_2:ai_data()
	if #l_3_8.input.forced_flares > 0 then
		l_3_8._defence.forced_flares = l_3_8.input.forced_flares
		l_3_8._defence.forced_flare_cnt = 1
		return 0
	end
	l_3_8.output.allowed_to_release_flare = false
	return nil
end

HunterKillerAiDefence.logic_hk_defence_forced_flare = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5, l_4_6, l_4_7)
	local l_4_8 = l_4_2:ai_data()
	if #l_4_8.input.forced_flares > 0 then
		l_4_0:_hk_defence_forced_flare(l_4_2, l_4_1, 1)
	end
	if #l_4_8.input.forced_flares == 0 then
		l_4_8.output.allowed_to_release_flare = false
		return 0
	end
	return nil
end

HunterKillerAiDefence.logic_hk_defence_flare = function(l_5_0, l_5_1, l_5_2, l_5_3, l_5_4, l_5_5, l_5_6, l_5_7)
	return nil
	 -- WARNING: undefined locals caused missing assignments!
end

HunterKillerAiDefence._hk_defence_forced_flare = function(l_6_0, l_6_1, l_6_2)
	local l_6_3 = l_6_1:ai_data()
	l_6_0:_update_forced_flare_rounds(l_6_1, l_6_2)
	if #l_6_3.input.forced_flares == 0 then
		l_6_3.output.allowed_to_release_flare = false
		return 
	end
	if l_6_3._defence.forced_flare_cnt % 2 == 0 then
		l_6_3.output.allowed_to_release_flare = false
		return 
	end
	if #l_6_3._defence.forced_flares > 0 then
		l_6_3.output.allowed_to_release_flare = true
	else
		l_6_3.output.allowed_to_release_flare = false
	end
end

HunterKillerAiDefence._update_forced_flare_rounds = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = l_7_1:ai_data()
	if l_7_3._defence.forced_flare_cnt <= #l_7_3._defence.forced_flares then
		if not l_7_3._defence.forced_flare_start then
			l_7_3._defence.forced_flare_start = l_7_2
		end
		local l_7_4 = tonumber(l_7_3._defence.forced_flares[l_7_3._defence.forced_flare_cnt])
		local l_7_5 = l_7_3._defence.forced_flare_start + l_7_4
	if l_7_5 < l_7_2 then
		end
		l_7_3._defence.forced_flare_cnt = l_7_3._defence.forced_flare_cnt + 1
		l_7_3._defence.forced_flare_start = nil
	if #l_7_3._defence.forced_flares < l_7_3._defence.forced_flare_cnt then
		end
		l_7_3.input.forced_flares = {}
	end
end


