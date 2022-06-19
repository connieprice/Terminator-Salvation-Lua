if not HudPanel then
	HudPanel = class()
end
HudPanel.init = function(l_1_0, l_1_1)
	l_1_0._panel = nil
	l_1_0._use_debug = l_1_1
	l_1_0._next_update = 0
	l_1_0._low_frequency_update = 0.2
	l_1_0._mid_frequency_update = 0.1
	l_1_0._frequency_update_time = l_1_0._low_frequency_update
	l_1_0._high_frequency_update = false
end

HudPanel.set_mid_frequency_update = function(l_2_0, l_2_1)
	l_2_0._mid_frequency_update = l_2_1
end

HudPanel.set_low_frequency_update = function(l_3_0, l_3_1)
	l_3_0._low_frequency_update = l_3_1
end

HudPanel.set_alpha = function(l_4_0, l_4_1)
	if not alive(l_4_0._panel) then
		return 
	end
	local l_4_2 = l_4_0._panel:visible()
	l_4_0._alpha = l_4_1
	if l_4_2 and not l_4_0._alpha > 0 then
		l_4_0._panel:set_visible(false)
		if l_4_0._use_debug then
			Application:debug(l_4_0._panel:name(), " visible = false")
		end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif not l_4_2 and l_4_0._alpha > 0 then
		l_4_0._panel:set_visible(true)
	if l_4_0._use_debug then
		end
		Application:debug(l_4_0._panel:name(), " visible = true")
	end
end

HudPanel.next_update = function(l_5_0, l_5_1)
	l_5_0._next_update = l_5_0._next_update + l_5_1
	if l_5_0._high_frequency_update or l_5_0._frequency_update_time < l_5_0._next_update then
		l_5_0._next_update = 0
		return true
	end
	return false
end

HudPanel.use_high_frequency_update = function(l_6_0)
	if l_6_0._use_debug and not l_6_0._high_frequency_update then
		Application:debug(l_6_0._panel:name(), "+++++++++++++++++++++++++ set high frequencey +++++++++++++++++++++++++++++")
	end
	l_6_0._high_frequency_update = true
end

HudPanel.use_low_frequency_update = function(l_7_0)
	if l_7_0._use_debug and (l_7_0._frequency_update_time ~= l_7_0._low_frequency_update or l_7_0._high_frequency_update) then
		Application:debug(l_7_0._panel:name(), "------------------------- set low frequencey -----------------------------", l_7_0._low_frequency_update)
	end
	l_7_0._frequency_update_time = l_7_0._low_frequency_update
	l_7_0._high_frequency_update = false
end

HudPanel.use_mid_frequency_update = function(l_8_0)
	if l_8_0._use_debug and (l_8_0._frequency_update_time ~= l_8_0._mid_frequency_update or l_8_0._high_frequency_update) then
		Application:debug(l_8_0._panel:name(), "======================= set mid frequencey ===============================", l_8_0._mid_frequency_update)
	end
	l_8_0._frequency_update_time = l_8_0._mid_frequency_update
	l_8_0._high_frequency_update = false
end


