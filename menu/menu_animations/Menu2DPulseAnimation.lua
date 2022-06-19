if not Menu2DPulseAnimation then
	Menu2DPulseAnimation = class({})
end
Menu2DPulseAnimation.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5)
	l_1_0._object = l_1_1
	do
		l_1_0._pulse_time = l_1_2 or 0
		l_1_0._wait_time = l_1_5 or 0
		l_1_0._min_alpha = l_1_3
		l_1_0._alpha_diff = l_1_4 - l_1_3
		l_1_0._fade_down = true
		l_1_0._pulse_timer = 0
		l_1_0._wait_timer = 0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPulseAnimation.update = function(l_2_0, l_2_1)
	if l_2_0._pulse_timer ~= 0 then
		l_2_0._wait_timer = l_2_0._wait_timer + l_2_1
		if l_2_0._wait_timer < l_2_0._wait_time then
			return 
		end
	end
	l_2_0._pulse_timer = l_2_0._pulse_timer + l_2_1
	local l_2_2 = nil
	if l_2_0._pulse_timer / l_2_0._pulse_time > 1 then
		local l_2_3, l_2_4, l_2_5, l_2_6 = 1
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_2_0._fade_down == true then
		l_2_2 = (1 - l_2_3) * l_2_0._alpha_diff + l_2_0._min_alpha
	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif l_2_0._fade_down == false then
		l_2_2 = l_2_3 * l_2_0._alpha_diff + l_2_0._min_alpha
	end
	if l_2_0._object then
		l_2_0._object:set_color(l_2_0._object:color():with_alpha(l_2_2))
		 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_2_3 == 1 then
		end
		l_2_0._pulse_timer = 0
		l_2_0._fade_down = not l_2_0._fade_down
	end
	return false
end


