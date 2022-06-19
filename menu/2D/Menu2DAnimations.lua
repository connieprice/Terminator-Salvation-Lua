if not Menu2DAnimations then
	Menu2DAnimations = {}
end
Menu2DAnimations.fade_out = function(l_1_0, l_1_1, l_1_2, l_1_3)
	local l_1_4 = wait
	do
		l_1_4(l_1_1 or 0)
		if not l_1_3 then
			l_1_3 = 0
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		over(l_1_2, function(l_2_0)
		-- upvalues: l_1_0 , l_1_4 , l_1_3
		l_1_0:set_color(l_1_0:color():with_alpha((1 - l_2_0) * l_1_4 + l_1_3))
  end)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DAnimations.fade_in = function(l_2_0, l_2_1, l_2_2, l_2_3)
	local l_2_4 = l_2_0:color().a
	if not l_2_3 then
		l_2_3 = 1
	end
	local l_2_5 = l_2_3 - l_2_4
	wait(l_2_1)
	over(l_2_2, function(l_3_0)
		-- upvalues: l_2_0 , l_2_5 , l_2_4
		l_2_0:set_color(l_2_0:color():with_alpha(l_3_0 * l_2_5 + l_2_4))
  end)
end

Menu2DAnimations.pulse = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
	if not l_3_4 then
		l_3_4 = 0
	end
	do
		while 1 do
			local l_3_5 = l_3_3 - l_3_2
			while 1 do
				over(l_3_1 * 0.5, function(l_4_0)
				-- upvalues: l_3_0 , l_3_5 , l_3_2
				l_3_0:set_color(l_3_0:color():with_alpha((1 - l_4_0) * l_3_5 + l_3_2))
      end)
				wait(l_3_4)
				over(l_3_1 * 0.5, function(l_5_0)
				-- upvalues: l_3_0 , l_3_5 , l_3_2
				l_3_0:set_color(l_3_0:color():with_alpha(l_5_0 * l_3_5 + l_3_2))
      end)
				wait(l_3_4)
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

Menu2DAnimations.panel_shrink = function(l_4_0, l_4_1, l_4_2)
	do
		over(l_4_1, function(l_5_0, l_5_1)
		-- upvalues: l_4_0 , l_4_2
		l_4_0:set_w(l_4_2 * (1 - l_5_0))
		local l_5_2 = l_4_0:x()
		l_4_0:set_x(l_4_2 - l_4_0:w())
		l_5_2 = l_4_0:x() - l_5_2
		local l_5_6, l_5_7 = ipairs, l_4_0:children()
		l_5_6 = l_5_6(l_5_7)
		for i_0,i_1 in l_5_6 do
			l_5_5:set_x(l_5_5:x() - (l_5_2))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DAnimations.panel_grow = function(l_5_0, l_5_1, l_5_2)
	do
		over(l_5_1, function(l_6_0, l_6_1)
		-- upvalues: l_5_0 , l_5_2
		l_5_0:set_w(l_5_2 * l_6_0)
		local l_6_2 = l_5_0:x()
		l_5_0:set_x(l_5_2 - l_5_0:w())
		l_6_2 = l_5_0:x() - l_6_2
		local l_6_6, l_6_7 = ipairs, l_5_0:children()
		l_6_6 = l_6_6(l_6_7)
		for i_0,i_1 in l_6_6 do
			l_6_5:set_x(l_6_5:x() - (l_6_2))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DAnimations.move_text = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4, l_6_5)
	wait(l_6_1)
	do
		over(l_6_2, function(l_7_0, l_7_1)
		-- upvalues: l_6_3 , l_6_4 , l_6_0
		local l_7_2 = math.lerp(l_6_3, l_6_4, l_7_0)
		l_6_0:set_x(l_7_2.x)
		l_6_0:set_y(l_7_2.y)
  end)
		if l_6_5 then
			l_6_0:parent():remove(l_6_0)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Menu2DAnimations.move_text_down_and_replace = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4, l_7_5)
	do
		over(l_7_2, function(l_8_0, l_8_1)
		-- upvalues: l_7_3 , l_7_4 , l_7_0
		local l_8_2 = math.lerp(l_7_3, l_7_4, l_8_0)
		l_7_0:set_x(l_8_2.x)
		l_7_0:set_y(l_8_2.y)
  end)
		l_7_0:parent():remove(l_7_0)
		l_7_5:show()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DAnimations.slide_out = function(l_8_0, l_8_1, l_8_2, l_8_3)
	local l_8_4 = 0
	local l_8_5 = l_8_0:parent():w() - l_8_0:x()
	do
		over(l_8_1, function(l_9_0, l_9_1)
		-- upvalues: l_8_0 , l_8_2 , l_8_5
		l_8_0:set_x(l_8_2 + l_8_5 * l_9_0)
  end)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DAnimations.slide_in = function(l_9_0, l_9_1, l_9_2, l_9_3)
	local l_9_4 = 0
	local l_9_5 = l_9_0:parent():w() - l_9_0:x()
	do
		over(l_9_1, function(l_10_0, l_10_1)
		-- upvalues: l_9_0 , l_9_2 , l_9_5
		l_9_0:set_x(l_9_2 + l_9_5 * (1 - l_10_0))
  end)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DAnimations.flash = function(l_10_0, l_10_1, l_10_2, l_10_3, l_10_4, l_10_5)
	if l_10_5 then
		l_10_4 = l_10_3
	end
	local l_10_6 = l_10_4 - l_10_3
	local l_10_7 = l_10_1 / (l_10_2 * 2)
	do
		for l_10_13 = 1, l_10_2 do
			local l_10_10, l_10_11 = function(l_11_0, l_11_1)
		-- upvalues: l_10_0 , l_10_6 , l_10_3
		l_10_0:set_color(l_10_0:color():with_alpha((1 - l_11_0) * l_10_6 + l_10_3))
  end, function(l_12_0, l_12_1)
		-- upvalues: l_10_0 , l_10_6 , l_10_3
		l_10_0:set_color(l_10_0:color():with_alpha(l_12_0 * l_10_6 + l_10_3))
  end
			over(l_10_7, l_10_10)
			over(l_10_7, l_10_11)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DAnimations.grow = function(l_11_0, l_11_1, l_11_2, l_11_3, l_11_4)
	local l_11_5 = l_11_0:x()
	local l_11_6 = l_11_0:y()
	local l_11_7 = l_11_0:w()
	local l_11_8 = l_11_0:h()
	local l_11_9 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	do
		 -- DECOMPILER ERROR: Overwrote pending register.

		.end(l_11_1, l_11_0:center())
		if not l_11_4 then
			l_11_4 = 0
		end
		wait(l_11_4)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DAnimations.flash_distortion = function(l_12_0, l_12_1, l_12_2, l_12_3, l_12_4, l_12_5)
	if l_12_5 then
		l_12_4 = l_12_3
	end
	if not l_12_4 then
		l_12_4 = l_12_0:color().a
	end
	local l_12_6 = l_12_1 / 2
	for l_12_10 = 1, l_12_2 do
		l_12_0:set_color(l_12_0:color():with_alpha(l_12_3))
		wait(l_12_6)
		l_12_0:set_color(l_12_0:color():with_alpha(l_12_4))
		wait(l_12_6)
	end
end

Menu2DAnimations.idle = function(l_13_0, l_13_1)
	local l_13_2 = wait
	do
		l_13_2(l_13_1 or 0)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DAnimations.twitch = function(l_14_0, l_14_1, l_14_2, l_14_3, l_14_4)
	if not l_14_4 then
		l_14_4 = l_14_3
	end
	local l_14_5, l_14_6, l_14_7 = nil, nil, nil
	for l_14_11 = 1, l_14_1 do
		l_14_7 = math.rand(l_14_3, l_14_4)
		wait(l_14_7)
		l_14_5 = math.random(-l_14_2, l_14_2)
		l_14_6 = math.random(-l_14_2, l_14_2)
		l_14_0:move(l_14_5, l_14_6)
		wait(l_14_7)
		l_14_0:move(-l_14_5, -l_14_6)
	end
end

Menu2DAnimations.twitch2 = function(l_15_0, l_15_1, l_15_2, l_15_3, l_15_4)
	local l_15_5, l_15_6, l_15_7 = nil, nil, nil
	for i = 1, l_15_1 do
		wait(l_15_4[i])
		l_15_0:move(l_15_2[i], l_15_3[i])
		wait(l_15_4[i])
		l_15_0:move(-l_15_2[i], -l_15_3[i])
	end
end

Menu2DAnimations.fullscreen = function(l_16_0, l_16_1)
	l_16_0:set_size(l_16_0:parent():size())
	wait(l_16_1)
end


