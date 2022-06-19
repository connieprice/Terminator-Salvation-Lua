if not Menu2DFadeOutAnimation then
	Menu2DFadeOutAnimation = class({})
end
Menu2DFadeOutAnimation.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	l_1_0._object = l_1_1
	l_1_0._fade_speed = l_1_3
	do
		l_1_0._wait_time = l_1_2 or 0
		l_1_0._end_alpha = l_1_4 or 0
		l_1_0._alpha_diff = l_1_1:color().alpha - l_1_4
		l_1_0._fade_speed_timer = 0
		l_1_0._wait_timer = 0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DFadeOutAnimation.update = function(l_2_0, l_2_1)
	if l_2_0._fade_speed_timer ~= 0 then
		l_2_0._wait_timer = l_2_0._wait_timer + l_2_1
		if l_2_0._wait_timer < l_2_0._wait_time then
			return 
		end
	end
	l_2_0._fade_speed_timer = l_2_0._fade_speed_timer + l_2_1
	if l_2_0._fade_speed_timer / l_2_0._fade_speed > 1 then
		local l_2_2 = 1
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_2_3 = nil
	if l_2_0._object then
		l_2_0._object:set_color(l_2_0._object:color():with_alpha((1 - l_2_2) * l_2_0._alpha_diff + l_2_0._end_alpha))
	if l_2_0._object:color().alpha == l_2_0._end_alpha then
		end
		return true
	end
	return false
end


