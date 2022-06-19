require("units/beings/player/new_gui/HudPanel")
if not MissionObjectivePanel then
	MissionObjectivePanel = class(HudPanel)
end
MissionObjectivePanel.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	HudPanel.init(l_1_0, false)
	l_1_0._parent_panel = l_1_1
	l_1_0._safe_panel = l_1_2
	l_1_0._unit = l_1_3
	l_1_0._width = l_1_0._safe_panel:width()
	l_1_0._height = tweak_data.player.new_hud.mission_objectives.HEIGHT
	l_1_0._start_x = -l_1_0._width / 2
	l_1_0._y = l_1_0._safe_panel:top() + tweak_data.player.new_hud.mission_objectives.Y
	Localizer:load("data/strings/mission_objectives.xml")
	local l_1_4, l_1_5 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_6 = {}
	l_1_6.name = "mission_objective_panel"
	l_1_6.width = l_1_0._width
	l_1_6.height = l_1_0._height
	l_1_6.valign = "top"
	l_1_6.halign = "center"
	l_1_6.layer = tweak_data.player.new_hud.mission_objectives.LAYER
	l_1_4 = l_1_4(l_1_5, l_1_6)
	l_1_0._panel = l_1_4
	l_1_4 = l_1_0._panel
	l_1_4, l_1_5 = l_1_4:set_center_x, l_1_4
	l_1_6 = l_1_0._start_x
	l_1_4(l_1_5, l_1_6)
	l_1_4 = l_1_0._panel
	l_1_4, l_1_5 = l_1_4:set_top, l_1_4
	l_1_6 = l_1_0._y
	l_1_4(l_1_5, l_1_6)
	l_1_4 = Interpolator
	l_1_4, l_1_5 = l_1_4:new, l_1_4
	l_1_6 = 0
	l_1_4 = l_1_4(l_1_5, l_1_6, tweak_data.player.new_hud.mission_objectives.FADE_OUT_SPEED)
	l_1_0._alpha_interpolator = l_1_4
	l_1_4 = l_1_0._alpha_interpolator
	l_1_4, l_1_5 = l_1_4:set_target, l_1_4
	l_1_6 = 1
	l_1_4(l_1_5, l_1_6)
	l_1_4 = tweak_data
	l_1_4 = l_1_4.player
	l_1_4 = l_1_4.new_hud
	l_1_4 = l_1_4.mission_objectives
	l_1_4 = l_1_4.ICON_PULSE_TARGET
	l_1_0._pulse_target = l_1_4
	l_1_4 = Interpolator
	l_1_4, l_1_5 = l_1_4:new, l_1_4
	l_1_6 = 1
	l_1_4 = l_1_4(l_1_5, l_1_6, tweak_data.player.new_hud.mission_objectives.ICON_PULSE_SPEED_NOT_COMPLETE)
	l_1_0._pulse_interpolator = l_1_4
	l_1_4 = l_1_0._pulse_interpolator
	l_1_4, l_1_5 = l_1_4:set_target, l_1_4
	l_1_6 = l_1_0._pulse_target
	l_1_4(l_1_5, l_1_6)
	l_1_0._time_before_fade_out = 0
	l_1_4, l_1_5 = l_1_0:_set_alpha, l_1_0
	l_1_6 = 0
	l_1_4(l_1_5, l_1_6)
	l_1_4 = Sound
	l_1_4, l_1_5 = l_1_4:make_bank, l_1_4
	l_1_6 = "stingers_sound"
	l_1_4 = l_1_4(l_1_5, l_1_6, "objectives_exit")
	l_1_0._hide_current_objective_sound = l_1_4
	l_1_4 = Sound
	l_1_4, l_1_5 = l_1_4:make_bank, l_1_4
	l_1_6 = "stingers_sound"
	l_1_4 = l_1_4(l_1_5, l_1_6, "objectives_enter")
	l_1_0._show_current_objective_sound = l_1_4
	l_1_4 = Sound
	l_1_4, l_1_5 = l_1_4:make_bank, l_1_4
	l_1_6 = "stingers_sound"
	l_1_4 = l_1_4(l_1_5, l_1_6, "stinger_objective_complete")
	l_1_0._objective_complete_sound = l_1_4
	l_1_4 = Sound
	l_1_4, l_1_5 = l_1_4:make_bank, l_1_4
	l_1_6 = "stingers_sound"
	l_1_4 = l_1_4(l_1_5, l_1_6, "stinger_new_objective")
	l_1_0._new_objective_sound = l_1_4
end

MissionObjectivePanel.panel = function(l_2_0)
	return l_2_0._panel
end

MissionObjectivePanel.show = function(l_3_0, l_3_1)
	if l_3_0._current_mission_objective == l_3_1 then
		return 
	end
	l_3_0:_set_alpha(0)
	l_3_0._completed_shown = false
	l_3_0._current_mission_objective = l_3_1
	if not l_3_1:is_completed() then
		l_3_0:_show(false)
		l_3_0._new_objective_sound:play()
	else
		l_3_0:_show(true)
		l_3_0._objective_complete_sound:play()
	end
end

MissionObjectivePanel.show_current_mission_objective = function(l_4_0)
	if not l_4_0._current_mission_objective then
		return 
	end
	if not l_4_0._alpha == 0 then
		return 
	end
	l_4_0:use_high_frequency_update()
	if l_4_0._showing_current_mission_object then
		l_4_0._time_before_fade_out = 1
		return 
	end
	if not l_4_0._current_mission_objective:is_completed() then
		l_4_0._panel:set_center_x(l_4_0._parent_panel:center_x())
		l_4_0._alpha_interpolator:set_target(1)
		l_4_0._time_before_fade_out = 1
		if l_4_0._hide_current_objective_sound:is_playing() then
			l_4_0._hide_current_objective_sound:stop()
		end
		if not l_4_0._show_current_objective_sound:is_playing() then
			l_4_0._show_current_objective_sound:play()
		end
		l_4_0._showing_current_mission_object = true
	end
end

MissionObjectivePanel.hide_current_mission_objective = function(l_5_0)
	if not l_5_0._showing_current_mission_object then
		return 
	end
	if l_5_0._current_mission_objective:is_completed() then
		l_5_0._showing_current_mission_object = false
		return 
	end
	if l_5_0._show_current_objective_sound:is_playing() then
		l_5_0._show_current_objective_sound:stop()
	end
	if not l_5_0._hide_current_objective_sound:is_playing() then
		l_5_0._hide_current_objective_sound:play()
	end
	l_5_0._time_before_fade_out = 0
	l_5_0._showing_current_mission_object = false
end

MissionObjectivePanel.current_mission_objective_is_showing = function(l_6_0)
	return l_6_0._showing_current_mission_object or false
end

MissionObjectivePanel._show = function(l_7_0, l_7_1)
	l_7_0:use_high_frequency_update()
	l_7_0:_set_alpha(0)
	l_7_0._panel:set_w(l_7_0._safe_panel:width())
	l_7_0._time_before_fade_out = tweak_data.player.new_hud.mission_objectives.TIME_BEFORE_FADE_OUT
	local l_7_2 = l_7_0._current_mission_objective:objective():text_id()
	if l_7_1 then
		local l_7_3, l_7_4 = l_7_0._panel:bitmap, l_7_0._panel
		local l_7_5 = {}
		l_7_5.name = "mission_objective_completed_texture"
		l_7_5.texture = "gui_mission_objectivebox_completed"
		l_7_3 = l_7_3(l_7_4, l_7_5)
		l_7_0._mission_objective_texture = l_7_3
		l_7_3 = l_7_2
		l_7_4 = "_completed"
		l_7_2 = l_7_3 .. l_7_4
	else
		local l_7_6, l_7_7 = l_7_0._panel:bitmap, l_7_0._panel
		local l_7_8 = {}
		l_7_8.name = "mission_objective_texture"
		l_7_8.texture = "gui_mission_objectivebox_not_completed"
		l_7_6 = l_7_6(l_7_7, l_7_8)
		l_7_0._mission_objective_texture = l_7_6
		l_7_6 = l_7_2
		l_7_7 = "_started"
		l_7_2 = l_7_6 .. l_7_7
	end
	l_7_0._mission_objective_texture:set_left(0)
	l_7_0._mission_objective_texture:set_center_y(l_7_0._height / 2)
	local l_7_9 = Localizer:lookup(l_7_2)
	local l_7_10, l_7_11 = l_7_0._panel:text, l_7_0._panel
	local l_7_12 = {}
	l_7_12.text = l_7_9
	l_7_12.font = tweak_data.player.new_hud.mission_objectives.TEXT_FONT
	l_7_12.font_size = tweak_data.player.new_hud.mission_objectives.TEXT_FONT_SIZE
	l_7_12.valign = "bottom"
	l_7_12.color = tweak_data.player.new_hud.mission_objectives.TEXT_FONT_COLOR
	l_7_10 = l_7_10(l_7_11, l_7_12)
	l_7_0._mission_objective_text = l_7_10
	l_7_10 = l_7_0._mission_objective_text
	l_7_10, l_7_11 = l_7_10:set_width, l_7_10
	l_7_12 = l_7_0._width
	l_7_12 = l_7_12 - l_7_0._mission_objective_texture:width()
	l_7_10(l_7_11, l_7_12)
	l_7_10 = l_7_0._mission_objective_text
	l_7_10, l_7_11 = l_7_10:set_wrap, l_7_10
	l_7_12 = true
	l_7_10(l_7_11, l_7_12)
	l_7_10 = l_7_0._mission_objective_text
	l_7_10, l_7_11 = l_7_10:set_left, l_7_10
	l_7_12 = l_7_0._mission_objective_texture
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_10(l_7_11, l_7_12)
	l_7_10 = l_7_0._mission_objective_text
	l_7_10, l_7_11 = l_7_10:set_center_y, l_7_10
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_10(l_7_11, l_7_12)
	l_7_10 = l_7_0._mission_objective_text
	l_7_10, l_7_11 = l_7_10:set_vertical, l_7_10
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_10(l_7_11, l_7_12)
	l_7_10 = l_7_0._mission_objective_text
	l_7_10, l_7_11 = l_7_10:set_align, l_7_10
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_10(l_7_11, l_7_12)
	l_7_10 = l_7_0._mission_objective_text
	l_7_10, l_7_11 = l_7_10:text_rect, l_7_10
	l_7_10 = l_7_10(l_7_11)
	local l_7_13 = nil
	l_7_0._panel:set_w(l_7_0._mission_objective_texture:width() + l_7_12)
	l_7_0._panel:set_center_x(l_7_0._start_x)
	l_7_0._slide_interpolator = Interpolator:new(l_7_0._start_x, tweak_data.player.new_hud.mission_objectives.SLIDE_IN_SPEED)
	l_7_0._slide_interpolator:set_target(l_7_0._parent_panel:center_x())
	l_7_0._slide_done = false
	l_7_0:_set_alpha(1)
	l_7_0._alpha_interpolator:set_target(1)
	l_7_0._alpha_interpolator:set_value(1)
	l_7_0._completed_shown = l_7_1
end

MissionObjectivePanel.hide = function(l_8_0)
	l_8_0._alpha_interpolator:set_target(0)
	l_8_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.mission_objectives.FADE_OUT_SPEED)
	l_8_0._slide_interpolator = nil
end

MissionObjectivePanel.visible = function(l_9_0)
	return l_9_0._alpha > 0 or l_9_0._alpha_interpolator:target() == 1
end

MissionObjectivePanel.have_mission_objective = function(l_10_0)
	return l_10_0._current_mission_objective
end

MissionObjectivePanel._set_alpha = function(l_11_0, l_11_1)
	l_11_0._alpha = l_11_1
	HudPanel.set_alpha(l_11_0, l_11_1)
	if l_11_0._mission_objective_text then
		l_11_0._mission_objective_text:set_color(l_11_0._mission_objective_text:color():with_alpha(l_11_0._alpha))
	end
	if l_11_0._mission_objective_texture then
		l_11_0._mission_objective_texture:set_color(l_11_0._mission_objective_texture:color():with_alpha(l_11_0._alpha))
	end
end

MissionObjectivePanel.update = function(l_12_0, l_12_1)
	l_12_0._time_before_fade_out = l_12_0._time_before_fade_out - l_12_1
	if l_12_0._time_before_fade_out < 0 then
		l_12_0:hide()
	end
	l_12_0._alpha_interpolator:update(l_12_1)
	local l_12_2 = l_12_0._alpha_interpolator:value()
	l_12_0:_set_alpha(l_12_2)
	if l_12_0._slide_interpolator then
		l_12_0:_update_slide(l_12_1)
	end
	if l_12_0._alpha > 0 then
		l_12_0:_update_pulse(l_12_1)
	end
	if l_12_0._current_mission_objective and l_12_0._current_mission_objective:is_completed() and not l_12_0._completed_shown then
		l_12_0:_show(true)
		l_12_0._objective_complete_sound:play()
	end
	if l_12_0._completed_shown and l_12_0._alpha == 0 then
		l_12_0._current_mission_objective = nil
	end
end

MissionObjectivePanel._update_slide = function(l_13_0, l_13_1)
	l_13_0._slide_interpolator:update(l_13_1)
	l_13_0._x = l_13_0._slide_interpolator:value()
	if l_13_0._slide_interpolator:has_reached_target() then
		l_13_0._x = l_13_0._slide_interpolator:target()
		l_13_0._panel:set_center_x(l_13_0._x)
		l_13_0._slide_done = true
		l_13_0._slide_interpolator = nil
	end
	if not l_13_0._slide_done then
		l_13_0._panel:set_center_x(l_13_0._x)
	end
end

MissionObjectivePanel.use_splitscreen_position = function(l_14_0)
	local l_14_1 = l_14_0._parent_panel:height() / 2
	if l_14_0._y == l_14_1 then
		return 
	end
	l_14_0._y = l_14_1
	l_14_0._panel:set_center(l_14_0._x, l_14_0._y)
end

MissionObjectivePanel.use_single_player_position = function(l_15_0)
	if l_15_0._y == l_15_0._safe_panel:top() + tweak_data.player.new_hud.mission_objectives.Y then
		return 
	end
	l_15_0._y = l_15_0._safe_panel:top() + tweak_data.player.new_hud.mission_objectives.Y
	l_15_0._panel:set_center(l_15_0._x, l_15_0._y)
end

MissionObjectivePanel._update_pulse = function(l_16_0, l_16_1)
	if not l_16_0._mission_objective_texture then
		return 
	end
	l_16_0._pulse_interpolator:update(l_16_1)
	local l_16_2 = l_16_0._pulse_interpolator:value()
	if l_16_0._pulse_interpolator:has_reached_target() then
		l_16_2 = l_16_0._pulse_interpolator:target()
	end
	if l_16_2 == l_16_0._pulse_target then
		l_16_0._pulse_interpolator:set_target(1)
	elseif l_16_2 == 1 then
		l_16_0._pulse_interpolator:set_target(l_16_0._pulse_target)
	end
	local l_16_3 = l_16_0._mission_objective_texture:center_x()
	local l_16_4 = l_16_0._mission_objective_texture:center_y()
	l_16_0._mission_objective_texture:set_size(64 * l_16_2, 64 * l_16_2)
	l_16_0._mission_objective_texture:set_center(l_16_3, l_16_4)
end


