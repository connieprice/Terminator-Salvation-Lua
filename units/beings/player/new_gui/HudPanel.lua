HudPanel = HudPanel or class()
function HudPanel.init(A0_0, A1_1)
	A0_0._panel = nil
	A0_0._use_debug = A1_1
	A0_0._next_update = 0
	A0_0._low_frequency_update = 0.2
	A0_0._mid_frequency_update = 0.1
	A0_0._frequency_update_time = A0_0._low_frequency_update
	A0_0._high_frequency_update = false
end
function HudPanel.set_mid_frequency_update(A0_2, A1_3)
	A0_2._mid_frequency_update = A1_3
end
function HudPanel.set_low_frequency_update(A0_4, A1_5)
	A0_4._low_frequency_update = A1_5
end
function HudPanel.set_alpha(A0_6, A1_7)
	if not alive(A0_6._panel) then
		return
	end
	A0_6._alpha = A1_7
	if A0_6._panel:visible() and not (A0_6._alpha > 0) then
		A0_6._panel:set_visible(false)
		if A0_6._use_debug then
			Application:debug(A0_6._panel:name(), " visible = false")
		end
	elseif not A0_6._panel:visible() and A0_6._alpha > 0 then
		A0_6._panel:set_visible(true)
		if A0_6._use_debug then
			Application:debug(A0_6._panel:name(), " visible = true")
		end
	end
end
function HudPanel.next_update(A0_8, A1_9)
	local L2_10
	L2_10 = A0_8._next_update
	L2_10 = L2_10 + A1_9
	A0_8._next_update = L2_10
	L2_10 = A0_8._high_frequency_update
	if not L2_10 then
		L2_10 = A0_8._next_update
	elseif L2_10 > A0_8._frequency_update_time then
		A0_8._next_update = 0
		L2_10 = true
		return L2_10
	end
	L2_10 = false
	return L2_10
end
function HudPanel.use_high_frequency_update(A0_11)
	if A0_11._use_debug and not A0_11._high_frequency_update then
		Application:debug(A0_11._panel:name(), "+++++++++++++++++++++++++ set high frequencey +++++++++++++++++++++++++++++")
	end
	A0_11._high_frequency_update = true
end
function HudPanel.use_low_frequency_update(A0_12)
	if A0_12._use_debug and (A0_12._frequency_update_time ~= A0_12._low_frequency_update or A0_12._high_frequency_update) then
		Application:debug(A0_12._panel:name(), "------------------------- set low frequencey -----------------------------", A0_12._low_frequency_update)
	end
	A0_12._frequency_update_time = A0_12._low_frequency_update
	A0_12._high_frequency_update = false
end
function HudPanel.use_mid_frequency_update(A0_13)
	if A0_13._use_debug and (A0_13._frequency_update_time ~= A0_13._mid_frequency_update or A0_13._high_frequency_update) then
		Application:debug(A0_13._panel:name(), "======================= set mid frequencey ===============================", A0_13._mid_frequency_update)
	end
	A0_13._frequency_update_time = A0_13._mid_frequency_update
	A0_13._high_frequency_update = false
end
