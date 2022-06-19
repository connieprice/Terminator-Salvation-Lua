IoIconPanel = IoIconPanel or class(HudPanel)
function IoIconPanel.init(A0_0, A1_1, A2_2, A3_3)
	HudPanel.init(A0_0, false)
	A0_0._parent_panel = A1_1
	A0_0._width = tweak_data.player.new_hud.io_icon_panel.WIDTH
	A0_0._height = tweak_data.player.new_hud.io_icon_panel.HEIGHT
	A0_0._x = A1_1:width()
	A0_0._y = A1_1:height()
	A0_0._center_x = A0_0._width / 2
	A0_0._center_y = A0_0._height / 2
	A0_0._icon_offset = 8
	A0_0._panel = A0_0._parent_panel:panel({
		name = "io_icon_panel",
		width = A0_0._width,
		height = A0_0._height,
		valign = "bottom",
		halign = "right",
		layer = 200
	})
	A0_0._panel:set_rightbottom(A0_0._x, A0_0._y)
	A0_0._icons = {}
	A0_0._icons.main = A0_0._panel:bitmap({name = "icon_main", texture = A2_2})
	A0_0._icons.main:set_rightbottom(A0_0._panel:width() + A0_0._icon_offset, A0_0._panel:height() + A0_0._icon_offset)
	A0_0._icons.hilight = A0_0._panel:bitmap({
		name = "icon_hilight",
		texture = "gui_saving_hilight",
		blend_mode = "add",
		layer = 201
	})
	A0_0._icons.hilight:set_rightbottom(A0_0._panel:width() + A0_0._icon_offset, A0_0._panel:height() + A0_0._icon_offset)
	A0_0._spin_speed = A3_3
	A0_0._fade_out_time = nil
	A0_0._alpha_interpolator = Interpolator:new(0, tweak_data.player.new_hud.ammo_panel.FADE_IN_SPEED)
	A0_0._alpha_interpolator:set_target(0)
	A0_0._current_angle = 0
	A0_0:set_alpha(0)
end
function IoIconPanel.panel(A0_4)
	local L1_5
	L1_5 = A0_4._panel
	return L1_5
end
function IoIconPanel.show(A0_6)
	if not A0_6._fade_out_time then
		A0_6._fade_out_time = TimerManager:wall():time() + tweak_data.player.new_hud.io_icon_panel.TIME_BEFORE_FADE_OUT
		A0_6:use_high_frequency_update()
		if not A0_6._panel:visible() then
			A0_6._panel:show()
		end
	end
	A0_6._alpha_interpolator:set_target(1)
	A0_6._alpha_interpolator:set_speed(tweak_data.player.new_hud.io_icon_panel.FADE_IN_SPEED)
	A0_6._showing = true
end
function IoIconPanel.hide(A0_7)
	if A0_7._fade_out_time and TimerManager:wall():time() > A0_7._fade_out_time then
		A0_7._alpha_interpolator:set_target(0)
		A0_7._alpha_interpolator:set_speed(tweak_data.player.new_hud.io_icon_panel.FADE_OUT_SPEED)
		A0_7._fade_out_time = nil
		A0_7._showing = false
	end
end
function IoIconPanel.icon_width(A0_8)
	return A0_8._panel:width()
end
function IoIconPanel.visible(A0_9)
	return A0_9._alpha > 0 or A0_9._showing
end
function IoIconPanel.set_alpha(A0_10, A1_11)
	HudPanel.set_alpha(A0_10, A1_11)
	for 