if not Menu2DEffects then
	Menu2DEffects = class()
end
Menu2DEffects.init = function(l_1_0)
	l_1_0._dof_fade_time = 0.25
	l_1_0._goal_dof = {}
	l_1_0._goal_dof.amount = 1
	l_1_0._goal_dof.near_min = 190000
	l_1_0._goal_dof.near_max = 180000
	l_1_0._goal_dof.far_min = 200000
	l_1_0._goal_dof.far_max = 210000
	l_1_0._dof_fade_done = true
end

Menu2DEffects.fade_in_pause = function(l_2_0)
	if alive(l_2_0._bg) then
		l_2_0._bg:stop()
		l_2_0._bg:set_color(l_2_0._bg:color():with_alpha(0))
		l_2_0._bg:animate(Menu2DAnimations.fade_in, 0, l_2_0._dof_fade_time, 0.25)
	end
	l_2_0._fade_in_timer = 0
	l_2_0._dof_fade_done = false
	local l_2_4, l_2_5 = pairs, managers.user_viewport:viewports()
	l_2_4 = l_2_4(l_2_5)
	for i_0,i_1 in l_2_4 do
		l_2_3:set_dof_updator(callback(l_2_0, l_2_0, "update_dof", true))
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DEffects.fade_out_pause = function(l_3_0)
	if alive(l_3_0._bg) then
		l_3_0._bg:stop()
		l_3_0._bg:animate(Menu2DAnimations.fade_out, 0, l_3_0._dof_fade_time, 0)
	end
	l_3_0._fade_in_timer = 0
	l_3_0._dof_fade_done = false
	local l_3_4, l_3_5 = pairs, managers.user_viewport:viewports()
	l_3_4 = l_3_4(l_3_5)
	for i_0,i_1 in l_3_4 do
		l_3_3:set_dof_updator(callback(l_3_0, l_3_0, "update_dof", false))
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DEffects.update_dof = function(l_4_0, l_4_1, l_4_2)
	if l_4_1 then
		local l_4_3, l_4_4, l_4_5, l_4_6 = math.clamp(1 - l_4_0._fade_in_timer / l_4_0._dof_fade_time, 0, 1)
	end
	local l_4_7 = nil
	if not l_4_2 then
		l_4_2 = {}
		l_4_2.amount = 0
		l_4_2.near_min = 0
		l_4_2.near_max = 0
		l_4_2.far_min = 0
		l_4_2.far_max = 0
	end
	local l_4_11, l_4_12 = {amount = math.lerp(l_4_0._goal_dof.amount, l_4_2.amount, l_4_7), near_min = math.lerp(l_4_0._goal_dof.near_min, l_4_2.near_min, l_4_7), near_max = math.lerp(l_4_0._goal_dof.near_max, l_4_2.near_max, l_4_7), far_min = math.lerp(l_4_0._goal_dof.far_min, l_4_2.far_min, l_4_7), far_max = math.lerp(l_4_0._goal_dof.far_max, l_4_2.far_max, l_4_7)}, ipairs
	l_4_12 = l_4_12(managers.viewport:active_viewports())
	for i_0,i_1 in l_4_12 do
		i_1:set_dof(l_4_11.amount, l_4_11.near_min, l_4_11.near_max, l_4_11.far_min, l_4_11.far_max)
	end
	l_4_0._fade_in_timer = l_4_0._fade_in_timer + TimerManager:main():delta_time()
	if (l_4_1 and l_4_7 <= 0) or not l_4_1 and l_4_7 >= 1 then
		l_4_0._dof_fade_done = true
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Menu2DEffects.dof_fade_done = function(l_5_0)
	return l_5_0._dof_fade_done
end

Menu2DEffects.fade_down = function(l_6_0, l_6_1, l_6_2)
	if l_6_2 then
		managers.menu:ingame_gui():fade_down_with_speed(l_6_2)
	elseif l_6_1 then
		managers.menu:ingame_gui():fade_down_slow()
	else
		managers.menu:ingame_gui():fade_down()
	end
end

Menu2DEffects.is_fade_down_done = function(l_7_0)
	local l_7_1, l_7_2 = managers.menu:ingame_gui():is_faded_down, managers.menu:ingame_gui()
	return l_7_1(l_7_2)
end


