if not MachineTutorialPanel then
	MachineTutorialPanel = class()
end
MachineTutorialPanel.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._parent_panel = l_1_1
	l_1_0._coop = l_1_2
	l_1_0._unit = l_1_3
	l_1_0._alpha_interpolator = Interpolator:new(0, tweak_data.player.new_hud.ammo_panel.FADE_IN_SPEED)
	l_1_0._alpha_interpolator:set_target(1)
	l_1_0._stay_visible_time = 11
	l_1_0._next_blink_time = 0
	l_1_0._blink_speed = 0.25
	l_1_0._overheat_blink_start = 6
	l_1_0._overheat_blink_end = 9
	l_1_0._powerup_blink_start = 2
	l_1_0._powerup_blink_end = 5
	l_1_0._blink_overheat = false
	l_1_0._blink_powerup = false
	local l_1_4, l_1_5 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_6 = {}
	l_1_6.name = "tutorial_panel"
	l_1_6.width = l_1_0._parent_panel:width()
	l_1_6.height = l_1_0._parent_panel:height()
	l_1_6.layer = 100
	l_1_4 = l_1_4(l_1_5, l_1_6)
	l_1_0._tutorial_panel = l_1_4
end

MachineTutorialPanel.panel = function(l_2_0)
	return l_2_0._tutorial_panel
end

MachineTutorialPanel._setup_tutorial_texts = function(l_3_0)
	l_3_0._tutorial_panel:set_width(l_3_0._parent_panel:width())
	local l_3_8, l_3_9 = l_3_0._tutorial_panel:set_height, l_3_0._tutorial_panel
	l_3_8(l_3_9, l_3_0._parent_panel:height())
	l_3_8 = l_3_0._overheat_tutorial_panel
	l_3_8, l_3_9 = l_3_8:panel, l_3_8
	l_3_8 = l_3_8(l_3_9)
	l_3_8, l_3_9 = l_3_8:x, l_3_8
	l_3_8 = l_3_8(l_3_9)
	local l_3_1 = nil
	l_3_9 = l_3_0._overheat_tutorial_panel
	l_3_9, l_3_1 = l_3_9:panel, l_3_9
	l_3_9 = l_3_9(l_3_1)
	l_3_9, l_3_1 = l_3_9:y, l_3_9
	l_3_9 = l_3_9(l_3_1)
	l_3_1 = l_3_0._overheat_tutorial_panel
	l_3_1 = l_3_1._size_modifier
	l_3_1 = 4 * l_3_1
	l_3_9 = l_3_9 - l_3_1
	l_3_1 = l_3_0._unit
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_3_1 == "player2_tank" then
		l_3_9 = l_3_9 + l_3_1
		local l_3_2 = nil
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_3_3 = nil
	l_3_3 = l_3_0._powerup_tutorial_panel
	l_3_3 = l_3_3._height
	l_3_3 = l_3_3 - 124 * l_3_0._powerup_tutorial_panel._size_modifier
	local l_3_4 = nil
	l_3_4 = l_3_0._tutorial_texts
	if l_3_4 then
		l_3_4 = pairs
		l_3_4 = l_3_4(l_3_0._tutorial_texts)
		for i_0,i_1 in l_3_4 do
			i_1:set_color(i_1:color():with_alpha(0))
		end
	end
	l_3_0._tutorial_texts = {}
	l_3_0._tutorial_texts.left_overheat = l_3_0._tutorial_panel:text({font = "faith_font_22", font_size = 22, text = managers.localization:text("machine_hud_right_bottom_tutorial", managers.localizer_mapping:get_localizer_mapping_by_unit(l_3_0._unit))})
	l_3_0._tutorial_texts.left_overheat:set_lefttop(l_3_8 + 80 * l_3_0._overheat_tutorial_panel._size_modifier, l_3_9 - 20 * l_3_0._overheat_tutorial_panel._size_modifier)
	l_3_0._tutorial_texts.left_overheat:set_color(l_3_0._tutorial_texts.left_overheat:color():with_alpha(0))
	l_3_0._tutorial_texts.left_overheat:set_font_scale(0.75)
	l_3_0._tutorial_texts.right_overheat = l_3_0._tutorial_panel:text({font = "faith_font_22", font_size = 22, text = managers.localization:text("machine_hud_right_bottom_tutorial", managers.localizer_mapping:get_localizer_mapping_by_unit(l_3_0._unit))})
	l_3_0._tutorial_texts.right_overheat:set_righttop(l_3_8 + l_3_1 - 80 * l_3_0._overheat_tutorial_panel._size_modifier, l_3_9 - 20 * l_3_0._overheat_tutorial_panel._size_modifier)
	l_3_0._tutorial_texts.right_overheat:set_align("right")
	l_3_0._tutorial_texts.right_overheat:set_color(l_3_0._tutorial_texts.right_overheat:color():with_alpha(0))
	l_3_0._tutorial_texts.right_overheat:set_font_scale(0.75)
	l_3_0._tutorial_texts.left_powerup = l_3_0._tutorial_panel:text({font = "faith_font_22", font_size = 22, text = managers.localization:text("machine_hud_right_top_tutorial", managers.localizer_mapping:get_localizer_mapping_by_unit(l_3_0._unit))})
	l_3_0._tutorial_texts.left_powerup:set_lefttop(85 * l_3_0._powerup_tutorial_panel._size_modifier, l_3_3)
	l_3_0._tutorial_texts.left_powerup:set_color(l_3_0._tutorial_texts.left_powerup:color():with_alpha(0))
	l_3_0._tutorial_texts.left_powerup:set_font_scale(0.75)
	l_3_0._tutorial_texts.right_powerup = l_3_0._tutorial_panel:text({font = "faith_font_22", font_size = 22, text = managers.localization:text("machine_hud_right_top_tutorial", managers.localizer_mapping:get_localizer_mapping_by_unit(l_3_0._unit))})
	l_3_0._tutorial_texts.right_powerup:set_lefttop(-85 * l_3_0._powerup_tutorial_panel._size_modifier, l_3_3)
	l_3_0._tutorial_texts.right_powerup:set_align("right")
	l_3_0._tutorial_texts.right_powerup:set_color(l_3_0._tutorial_texts.right_powerup:color():with_alpha(0))
	l_3_0._tutorial_texts.right_powerup:set_font_scale(0.75)
	l_3_0._setup_text_done = true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MachineTutorialPanel.update = function(l_4_0, l_4_1, l_4_2)
	if not l_4_0._start_time then
		return 
	end
	l_4_0._start_time = l_4_0._start_time - l_4_2
	if l_4_0._start_time > 0 then
		return 
	end
	l_4_0._tutorial_started = true
	l_4_0:_update_blink(l_4_1, l_4_2)
	l_4_0:_update_tutorial(l_4_2)
end

MachineTutorialPanel.set_alpha = function(l_5_0, l_5_1)
	if not l_5_0._tutorial_texts then
		return 
	end
	l_5_0._alpha = l_5_1
	l_5_0._overheat_alpha = l_5_1
	l_5_0._powerup_alpha = l_5_1
	if l_5_0._blink_overheat then
		l_5_0._overheat_alpha = l_5_1 * l_5_0._blink_alpha_modifier
	end
	if l_5_0._blink_powerup then
		l_5_0._powerup_alpha = l_5_1 * l_5_0._blink_alpha_modifier
	end
	l_5_0._tutorial_texts.left_overheat:set_color(l_5_0._tutorial_texts.left_overheat:color():with_alpha(l_5_0._overheat_alpha))
	l_5_0._tutorial_texts.right_overheat:set_color(l_5_0._tutorial_texts.right_overheat:color():with_alpha(l_5_0._overheat_alpha))
	l_5_0._tutorial_texts.left_powerup:set_color(l_5_0._tutorial_texts.left_powerup:color():with_alpha(l_5_0._powerup_alpha))
	l_5_0._tutorial_texts.right_powerup:set_color(l_5_0._tutorial_texts.right_powerup:color():with_alpha(l_5_0._powerup_alpha))
end

MachineTutorialPanel.show_tutorial = function(l_6_0, l_6_1, l_6_2, l_6_3)
	l_6_0:_clear()
	l_6_0._start_time = l_6_1
	l_6_0._powerup_tutorial_panel = l_6_2
	l_6_0._overheat_tutorial_panel = l_6_3
end

MachineTutorialPanel._clear = function(l_7_0)
	local l_7_4, l_7_5, l_7_6, l_7_7, l_7_8, l_7_9 = nil
	if l_7_0._tutorial_texts then
		for i_0,i_1 in pairs(l_7_0._tutorial_texts) do
			i_1:set_color(i_1:color():with_alpha(0))
		end
	end
	l_7_0._setup_text_done = false
end

MachineTutorialPanel._update_tutorial = function(l_8_0, l_8_1)
	if not l_8_0._setup_text_done then
		l_8_0:_setup_tutorial_texts()
	end
	l_8_0._stay_visible_time = l_8_0._stay_visible_time - l_8_1
	l_8_0._overheat_blink_start = l_8_0._overheat_blink_start - l_8_1
	l_8_0._overheat_blink_end = l_8_0._overheat_blink_end - l_8_1
	l_8_0._powerup_blink_start = l_8_0._powerup_blink_start - l_8_1
	l_8_0._powerup_blink_end = l_8_0._powerup_blink_end - l_8_1
	if l_8_0._stay_visible_time < 0 then
		l_8_0._alpha_interpolator:set_target(0)
		l_8_0._tutorial_finished = true
	end
	if l_8_0._overheat_blink_end < 0 then
		l_8_0._blink_overheat = false
	elseif l_8_0._overheat_blink_start < 0 then
		l_8_0._blink_overheat = true
	end
	if l_8_0._powerup_blink_end < 0 then
		l_8_0._blink_powerup = false
	elseif l_8_0._powerup_blink_start < 0 then
		l_8_0._blink_powerup = true
	end
	l_8_0._alpha_interpolator:update(l_8_1)
	local l_8_2 = l_8_0._alpha_interpolator:value()
	if l_8_0._alpha_interpolator:has_reached_target() then
		l_8_2 = l_8_0._alpha_interpolator:target()
	end
	l_8_0:set_alpha(l_8_2)
end

MachineTutorialPanel._update_blink = function(l_9_0, l_9_1, l_9_2)
	if l_9_0._next_blink_time < l_9_1 then
		if l_9_0._blink_alpha_modifier == 0 then
			l_9_0._blink_alpha_modifier = 1
		else
			l_9_0._blink_alpha_modifier = 0
		end
		l_9_0._next_blink_time = l_9_1 + l_9_0._blink_speed
	end
end

MachineTutorialPanel.tutorial_finished = function(l_10_0)
	return not l_10_0._tutorial_finished or l_10_0._alpha == 0
end

MachineTutorialPanel.show = function(l_11_0)
	do
		local l_11_1, l_11_2 = l_11_0._alpha_before_hide or 1
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_11_0:set_alpha(l_11_1)
end

MachineTutorialPanel.hide = function(l_12_0)
	l_12_0._alpha_before_hide = l_12_0._alpha
	l_12_0:set_alpha(0)
end


