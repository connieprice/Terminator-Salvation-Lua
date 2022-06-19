if not FireLogicPowerUp then
	FireLogicPowerUp = class(FireLogic)
end
FireLogicPowerUp.init = function(l_1_0, l_1_1)
	FireLogic.init(l_1_0, l_1_1)
	l_1_0._trigger_down_time = 0
	l_1_0._delay = 0
	l_1_0._is_max = false
end

FireLogicPowerUp.fire = function(l_2_0, l_2_1)
end

FireLogicPowerUp.fire_end = function(l_3_0, l_3_1)
	if not l_3_0._only_fire_on_max_power or l_3_0._only_fire_on_max_power and l_3_0._time_to_max_power <= l_3_0._trigger_down_time then
		local l_3_2 = assert
		l_3_2(l_3_0._wdata._bullets_in_clip > 0)
		l_3_0._fire_time = l_3_1
		l_3_2 = l_3_0._wdata
		l_3_2._bullets_in_clip = l_3_0._wdata._bullets_in_clip - 1
		l_3_2 = math
		l_3_2 = l_3_2.max
		l_3_2 = l_3_2(l_3_0._burst_count - 1, 0)
		l_3_0._burst_count = l_3_2
		l_3_2 = l_3_0._wdata
		l_3_2._on_fire = true
		l_3_2 = l_3_0._unit
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_3_2 then
			l_3_2(l_3_2, l_3_1)
		end
		l_3_0._firing = false
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_3_2(l_3_0)
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_3_2._fire_end = true
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_3_2 then
			l_3_2(l_3_2, l_3_1)
		end
		l_3_0._trigger_down_time = 0
		l_3_0._delay = 0
	end
end

FireLogicPowerUp.update = function(l_4_0, l_4_1, l_4_2, l_4_3)
	FireLogic.update(l_4_0, l_4_1, l_4_2, l_4_3)
	l_4_0:_update_power_up(l_4_2, l_4_3)
end

FireLogicPowerUp._update_power_up = function(l_5_0, l_5_1, l_5_2)
	if l_5_0._firing and l_5_0._power_up_delay <= l_5_0._delay then
		l_5_0._trigger_down_time = l_5_0._trigger_down_time + l_5_2
	elseif not l_5_0._firing and l_5_0._trigger_down_time > 0 then
		l_5_0._trigger_down_time = l_5_0._trigger_down_time - l_5_2
	end
	if l_5_0._auto_fire_on_max_power and l_5_0._time_to_max_power <= l_5_0._trigger_down_time then
		l_5_0:fire_end(l_5_1)
		l_5_0._wdata._firing = l_5_0._firing
	end
	l_5_0._delay = l_5_0._delay + l_5_2
end

FireLogicPowerUp._draw_text = function(l_6_0, l_6_1, l_6_2)
	local l_6_3 = Draw:brush()
	l_6_3:set_blend_mode("add")
	l_6_3:set_font("editor_font", 48)
	l_6_3:set_color(Color(1, 1, 1, 1))
	l_6_3:text(l_6_1, l_6_2)
	l_6_3:text(l_6_1, l_6_2)
	l_6_3:text(l_6_1, l_6_2)
	l_6_3:text(l_6_1, l_6_2)
	l_6_3:text(l_6_1, l_6_2)
end

FireLogicPowerUp.get_power_up_percent = function(l_7_0)
	if l_7_0._trigger_down_time / l_7_0._time_to_max_power < 0 then
		return 0
	end
end

FireLogicPowerUp.destroy = function(l_8_0)
end


