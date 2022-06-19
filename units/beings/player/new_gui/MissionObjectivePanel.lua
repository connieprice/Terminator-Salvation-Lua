require("units/beings/player/new_gui/HudPanel")
MissionObjectivePanel = MissionObjectivePanel or class(HudPanel)
function MissionObjectivePanel.init(A0_0, A1_1, A2_2, A3_3)
	HudPanel.init(A0_0, false)
	A0_0._parent_panel = A1_1
	A0_0._safe_panel = A2_2
	A0_0._unit = A3_3
	A0_0._width = A0_0._safe_panel:width()
	A0_0._height = tweak_data.player.new_hud.mission_objectives.HEIGHT
	A0_0._start_x = -A0_0._width / 2
	A0_0._y = A0_0._safe_panel:top() + tweak_data.player.new_hud.mission_objectives.Y
	Localizer:load("data/strings/mission_objectives.xml")
	A0_0._panel = A0_0._parent_panel:panel({
		name = "mission_objective_panel",
		width = A0_0._width,
		height = A0_0._height,
		valign = "top",
		halign = "center",
		layer = tweak_data.player.new_hud.mission_objectives.LAYER
	})
	A0_0._panel:set_center_x(A0_0._start_x)
	A0_0._panel:set_top(A0_0._y)
	A0_0._alpha_interpolator = Interpolator:new(0, tweak_data.player.new_hud.mission_objectives.FADE_OUT_SPEED)
	A0_0._alpha_interpolator:set_target(1)
	A0_0._pulse_target = tweak_data.player.new_hud.mission_objectives.ICON_PULSE_TARGET
	A0_0._pulse_interpolator = Interpolator:new(1, tweak_data.player.new_hud.mission_objectives.ICON_PULSE_SPEED_NOT_COMPLETE)
	A0_0._pulse_interpolator:set_target(A0_0._pulse_target)
	A0_0._time_before_fade_out = 0
	A0_0:_set_alpha(0)
	A0_0._hide_current_objective_sound = Sound:make_bank("stingers_sound", "objectives_exit")
	A0_0._show_current_objective_sound = Sound:make_bank("stingers_sound", "objectives_enter")
	A0_0._objective_complete_sound = Sound:make_bank("stingers_sound", "stinger_objective_complete")
	A0_0._new_objective_sound = Sound:make_bank("stingers_sound", "stinger_new_objective")
end
function MissionObjectivePanel.panel(A0_4)
	local L1_5
	L1_5 = A0_4._panel
	return L1_5
end
function MissionObjectivePanel.show(A0_6, A1_7)
	if A0_6._current_mission_objective == A1_7 then
		return
	end
	A0_6:_set_alpha(0)
	A0_6._completed_shown = false
	A0_6._current_mission_objective = A1_7
	if not A1_7:is_completed() then
		A0_6:_show(false)
		A0_6._new_objective_sound:play()
	else
		A0_6:_show(true)
		A0_6._objective_complete_sound:play()
	end
end
function MissionObjectivePanel.show_current_mission_objective(A0_8)
	if not A0_8._current_mission_objective then
		return
	end
	if not A0_8._alpha == 0 then
		return
	end
	A0_8:use_high_frequency_update()
	if A0_8._showing_current_mission_object then
		A0_8._time_before_fade_out = 1
		return
	end
	if not A0_8._current_mission_objective:is_completed() then
		A0_8._panel:set_center_x(A0_8._parent_panel:center_x())
		A0_8._alpha_interpolator:set_target(1)
		A0_8._time_before_fade_out = 1
		if A0_8._hide_current_objective_sound:is_playing() then
			A0_8._hide_current_objective_sound:stop()
		end
		if not A0_8._show_current_objective_sound:is_playing() then
			A0_8._show_current_objective_sound:play()
		end
		A0_8._showing_current_mission_object = true
	end
end
function MissionObjectivePanel.hide_current_mission_objective(A0_9)
	if not A0_9._showing_current_mission_object then
		return
	end
	if A0_9._current_mission_objective:is_completed() then
		A0_9._showing_current_mission_object = false
		return
	end
	if A0_9._show_current_objective_sound:is_playing() then
		A0_9._show_current_objective_sound:stop()
	end
	if not A0_9._hide_current_objective_sound:is_playing() then
		A0_9._hide_current_objective_sound:play()
	end
	A0_9._time_before_fade_out = 0
	A0_9._showing_current_mission_object = false
end
function MissionObjectivePanel.current_mission_objective_is_showing(A0_10)
	return A0_10._showing_current_mission_object or false
end
function MissionObjectivePanel._show(A0_11, A1_12)
	local L2_13
	L2_13 = A0_11.use_high_frequency_update
	L2_13(A0_11)
	L2_13 = A0_11._set_alpha
	L2_13(A0_11, 0)
	L2_13 = A0_11._panel
	L2_13 = L2_13.set_w
	L2_13(L2_13, A0_11._safe_panel:width())
	L2_13 = tweak_data
	L2_13 = L2_13.player
	L2_13 = L2_13.new_hud
	L2_13 = L2_13.mission_objectives
	L2_13 = L2_13.TIME_BEFORE_FADE_OUT
	A0_11._time_before_fade_out = L2_13
	L2_13 = A0_11._current_mission_objective
	L2_13 = L2_13.objective
	L2_13 = L2_13(L2_13)
	L2_13 = L2_13.text_id
	L2_13 = L2_13(L2_13)
	if A1_12 then
		A0_11._mission_objective_texture = A0_11._panel:bitmap({
			name = "mission_objective_completed_texture",
			texture = "gui_mission_objectivebox_completed"
		})
		L2_13 = L2_13 .. "_completed"
	else
		A0_11._mission_objective_texture = A0_11._panel:bitmap({
			name = "mission_objective_texture",
			texture = "gui_mission_objectivebox_not_completed"
		})
		L2_13 = L2_13 .. "_started"
	end
	A0_11._mission_objective_texture:set_left(0)
	A0_11._mission_objective_texture:set_center_y(A0_11._height / 2)
	A0_11._mission_objective_text = A0_11._panel:text({
		text = Localizer:lookup(L2_13),
		font = tweak_data.player.new_hud.mission_objectives.TEXT_FONT,
		font_size = tweak_data.player.new_hud.mission_objectives.TEXT_FONT_SIZE,
		valign = "bottom",
		color = tweak_data.player.new_hud.mission_objectives.TEXT_FONT_COLOR
	})
	A0_11._mission_objective_text:set_width(A0_11._width - A0_11._mission_objective_texture:width())
	A0_11._mission_objective_text:set_wrap(true)
	A0_11._mission_objective_text:set_left(A0_11._mission_objective_texture:width())
	A0_11._mission_objective_text:set_center_y(A0_11._height / 2)
	A0_11._mission_objective_text:set_vertical("center")
	A0_11._mission_objective_text:set_align("left")
	A0_11._panel:set_w(A0_11._mission_objective_texture:width() + A0_11._mission_objective_text:text_rect())
	A0_11._panel:set_center_x(A0_11._start_x)
	A0_11._slide_interpolator = Interpolator:new(A0_11._start_x, tweak_data.player.new_hud.mission_objectives.SLIDE_IN_SPEED)
	A0_11._slide_interpolator:set_target(A0_11._parent_panel:center_x())
	A0_11._slide_done = false
	A0_11:_set_alpha(1)
	A0_11._alpha_interpolator:set_target(1)
	A0_11._alpha_interpolator:set_value(1)
	A0_11._completed_shown = A1_12
end
function MissionObjectivePanel.hide(A0_14)
	A0_14._alpha_interpolator:set_target(0)
	A0_14._alpha_interpolator:set_speed(tweak_data.player.new_hud.mission_objectives.FADE_OUT_SPEED)
	A0_14._slide_interpolator = nil
end
function MissionObjectivePanel.visible(A0_15)
	return A0_15._alpha > 0 or A0_15._alpha_interpolator:target() == 1
end
function MissionObjectivePanel.have_mission_objective(A0_16)
	local L1_17
	L1_17 = A0_16._current_mission_objective
	return L1_17
end
function MissionObjectivePanel._set_alpha(A0_18, A1_19)
	A0_18._alpha = A1_19
	HudPanel.set_alpha(A0_18, A1_19)
	if A0_18._mission_objective_text then
		A0_18._mission_objective_text:set_color(A0_18._mission_objective_text:color():with_alpha(A0_18._alpha))
	end
	if A0_18._mission_objective_texture then
		A0_18._mission_objective_texture:set_color(A0_18._mission_objective_texture:color():with_alpha(A0_18._alpha))
	end
end
function MissionObjectivePanel.update(A0_20, A1_21)
	local L2_22
	L2_22 = A0_20._time_before_fade_out
	L2_22 = L2_22 - A1_21
	A0_20._time_before_fade_out = L2_22
	L2_22 = A0_20._time_before_fade_out
	if L2_22 < 0 then
		L2_22 = A0_20.hide
		L2_22(A0_20)
	end
	L2_22 = A0_20._alpha_interpolator
	L2_22 = L2_22.update
	L2_22(L2_22, A1_21)
	L2_22 = A0_20._alpha_interpolator
	L2_22 = L2_22.value
	L2_22 = L2_22(L2_22)
	A0_20:_set_alpha(L2_22)
	if A0_20._slide_interpolator then
		A0_20:_update_slide(A1_21)
	end
	if 0 < A0_20._alpha then
		A0_20:_update_pulse(A1_21)
	end
	if A0_20._current_mission_objective and A0_20._current_mission_objective:is_completed() and not A0_20._completed_shown then
		A0_20:_show(true)
		A0_20._objective_complete_sound:play()
	end
	if A0_20._completed_shown and A0_20._alpha == 0 then
		A0_20._current_mission_objective = nil
	end
end
function MissionObjectivePanel._update_slide(A0_23, A1_24)
	A0_23._slide_interpolator:update(A1_24)
	A0_23._x = A0_23._slide_interpolator:value()
	if A0_23._slide_interpolator:has_reached_target() then
		A0_23._x = A0_23._slide_interpolator:target()
		A0_23._panel:set_center_x(A0_23._x)
		A0_23._slide_done = true
		A0_23._slide_interpolator = nil
	end
	if not A0_23._slide_done then
		A0_23._panel:set_center_x(A0_23._x)
	end
end
function MissionObjectivePanel.use_splitscreen_position(A0_25)
	if A0_25._y == A0_25._parent_panel:height() / 2 then
		return
	end
	A0_25._y = A0_25._parent_panel:height() / 2
	A0_25._panel:set_center(A0_25._x, A0_25._y)
end
function MissionObjectivePanel.use_single_player_position(A0_26)
	if A0_26._y == A0_26._safe_panel:top() + tweak_data.player.new_hud.mission_objectives.Y then
		return
	end
	A0_26._y = A0_26._safe_panel:top() + tweak_data.player.new_hud.mission_objectives.Y
	A0_26._panel:set_center(A0_26._x, A0_26._y)
end
function MissionObjectivePanel._update_pulse(A0_27, A1_28)
	local L2_29, L3_30, L4_31
	L2_29 = A0_27._mission_objective_texture
	if not L2_29 then
		return
	end
	L2_29 = A0_27._pulse_interpolator
	L3_30 = L2_29
	L2_29 = L2_29.update
	L4_31 = A1_28
	L2_29(L3_30, L4_31)
	L2_29 = A0_27._pulse_interpolator
	L3_30 = L2_29
	L2_29 = L2_29.value
	L2_29 = L2_29(L3_30)
	L3_30 = A0_27._pulse_interpolator
	L4_31 = L3_30
	L3_30 = L3_30.has_reached_target
	L3_30 = L3_30(L4_31)
	if L3_30 then
		L3_30 = A0_27._pulse_interpolator
		L4_31 = L3_30
		L3_30 = L3_30.target
		L3_30 = L3_30(L4_31)
		L2_29 = L3_30
	end
	L3_30 = A0_27._pulse_target
	if L2_29 == L3_30 then
		L3_30 = A0_27._pulse_interpolator
		L4_31 = L3_30
		L3_30 = L3_30.set_target
		L3_30(L4_31, 1)
	elseif L2_29 == 1 then
		L3_30 = A0_27._pulse_interpolator
		L4_31 = L3_30
		L3_30 = L3_30.set_target
		L3_30(L4_31, A0_27._pulse_target)
	end
	L3_30 = A0_27._mission_objective_texture
	L4_31 = L3_30
	L3_30 = L3_30.center_x
	L3_30 = L3_30(L4_31)
	L4_31 = A0_27._mission_objective_texture
	L4_31 = L4_31.center_y
	L4_31 = L4_31(L4_31)
	A0_27._mission_objective_texture:set_size(64 * L2_29, 64 * L2_29)
	A0_27._mission_objective_texture:set_center(L3_30, L4_31)
end
