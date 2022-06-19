if not AiPositioningDirector then
	AiPositioningDirector = class()
end
AiPositioningDirector.init = function(l_1_0)
	l_1_0._units = {}
end

AiPositioningDirector.add_ai_unit = function(l_2_0, l_2_1)
	l_2_0._units[l_2_1] = l_2_1
end

AiPositioningDirector.remove_ai_unit = function(l_3_0, l_3_1)
	l_3_0._units[l_3_1] = nil
end

AiPositioningDirector.update = function(l_4_0, l_4_1, l_4_2)
	l_4_0:_update_covers(l_4_1, l_4_2)
end

AiPositioningDirector._update_covers = function(l_5_0, l_5_1, l_5_2)
	local l_5_3, l_5_4, l_5_5, l_5_6, l_5_7, l_5_8, l_5_9, l_5_13, l_5_14, l_5_15, l_5_16, l_5_17, l_5_18 = nil, nil, nil
	for i_0,i_1 in pairs(l_5_0._units) do
		l_5_3 = i_1:ai_data()
		if l_5_3._behavior.use_covers and l_5_3._cover and not l_5_0:_ignore_threats(l_5_3) then
			l_5_4 = l_5_3._threat_tracking._threats
			l_5_5 = nil
			for i_0,i_1 in pairs(l_5_4) do
				if i_1 and (not l_5_5 or l_5_5:threat_level() < i_1:threat_level()) then
					l_5_5 = i_1
				end
			end
			l_5_3._cover.threat = l_5_5
		end
	end
end

AiPositioningDirector._ignore_threats = function(l_6_0, l_6_1)
	if not l_6_1._cover.navigation_target then
		return false
	end
	if l_6_1._behavior.navigation_target_reached then
		return false
	end
	if not l_6_1._behavior.navigation_target_options or not l_6_1._behavior.navigation_target_options.ignore_threats then
		return false
	end
	return true
end


