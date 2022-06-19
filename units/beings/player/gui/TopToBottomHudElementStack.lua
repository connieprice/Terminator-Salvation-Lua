require("units/beings/player/gui/HudElementStack")
if not TopToBottomSubtitlesHudElementStack then
	TopToBottomSubtitlesHudElementStack = class(HudElementStack)
end
TopToBottomSubtitlesHudElementStack._recalculate_target_positions = function(l_1_0, l_1_1)
	local l_1_6, l_1_7, l_1_8, l_1_9, l_1_10, l_1_11, l_1_12 = nil
	if TableAlgorithms.count(l_1_0._hud_elements) > 2 then
		local l_1_2 = 2
	end
	for i_0,i_1 in ipairs(l_1_0._hud_elements) do
		local l_1_3 = nil
		if not i_1:is_fading_out() and l_1_14 <= l_1_0._maximum_messages_shown then
			i_1:mark_should_show()
			i_1:set_y(l_1_0._panel:height() - (i_1._panel:height() + i_1._panel:height() * (l_1_3 - i_0)) - l_1_0._spacing)
		end
	end
end

if not TopToBottomHudElementStack then
	TopToBottomHudElementStack = class(HudElementStack)
end
TopToBottomHudElementStack._recalculate_target_positions = function(l_2_0, l_2_1)
	local l_2_7, l_2_8, l_2_9, l_2_10, l_2_11, l_2_12, l_2_13, l_2_14, l_2_15, l_2_16, l_2_17, l_2_18 = nil
	local l_2_2 = l_2_0._panel:height() * 0.05
	do
		local l_2_3 = 1
		for i_0,i_1 in ipairs(l_2_0._hud_elements) do
			if not i_1:is_fading_out() then
				l_2_2 = l_2_2 + i_1._panel:height() - l_2_0._spacing
				if i_1:y_has_been_set() then
					if l_2_2 < i_1:y() then
						local l_2_21 = nil
						local l_2_22 = nil
						 -- DECOMPILER ERROR: Confused about usage of registers!

						if 20 < i_1:y() - (l_2_2) then
							l_2_2 = l_2_20:y() - 20 * l_2_1
						end
						 -- DECOMPILER ERROR: Confused about usage of registers!

					if l_2_19 <= l_2_0._maximum_messages_shown then
						end
						l_2_20:mark_should_show()
					end
					 -- DECOMPILER ERROR: Confused about usage of registers!

					l_2_20:set_y(l_2_2)
				end
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 36 
end


