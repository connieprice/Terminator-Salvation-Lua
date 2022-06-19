require("shared/FiniteStateMachine")
require("units/beings/player/gui/SubtitlePanelStates")
SubtitlePanel = SubtitlePanel or class()
function SubtitlePanel.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	A0_0._use_small_font = A4_4
	A0_0._parent_panel = A1_1
	A0_0._panel = A1_1:panel({
		height = 100,
		width = A1_1:width()
	})
	A0_0._wall_timer = TimerManager:wall()
	A0_0._state = FiniteStateMachine:new(A0_0, "subtitle", SubtitlePanelStateFadeIn)
	A0_0._panel:set_world_center_x(A1_1:world_center_x())
	A0_0._y = 0
	A0_0._text_panel1 = A0_0:create_text(A2_2)
	A0_0._text_panel2 = A0_0:create_text(A3_3)
	A0_0._panel:set_y(A1_1:height() - A0_0._y)
end
function SubtitlePanel.destroy(A0_5)
	A0_5._state:destroy()
	A0_5._parent_panel:remove(A0_5._panel)
end
function SubtitlePanel.create_text(A0_6, A1_7)
	local L2_8, L3_9
	L2_8 = tweak_data
	L2_8 = L2_8.player
	L2_8 = L2_8.new_hud
	L2_8 = L2_8.subtitles_panel
	L2_8 = L2_8.TEXT_COLOR
	L3_9 = tweak_data
	L3_9 = L3_9.player
	L3_9 = L3_9.new_hud
	L3_9 = L3_9.TEXTPANEL_CREATOR_FONT
	A0_6._y = A0_6._y + tweak_data.player.new_hud.subtitles_panel.TEXT_FONT_SIZE + tweak_data.player.new_hud.subtitles_panel.TEXT_SPACING
	return (A0_6._panel:text({
		y = A0_6._y,
		font = L3_9,
		font_factor = tweak_data.player.new_hud.TEXTPANEL_SMALL_FONT_FACTOR,
		align = "center",
		color = L2_8,
		text = A1_7
	}))
end
function SubtitlePanel.update(A0_10)
	local L1_11
	L1_11 = A0_10._wall_timer
	L1_11 = L1_11.delta_time
	L1_11 = L1_11(L1_11)
	A0_10._state:update(L1_11)
end
function SubtitlePanel.dismiss_lines(A0_12)
	local L1_13
	A0_12._lines_are_dismissed = true
end
function SubtitlePanel.lines_are_dismissed(A0_14)
	local L1_15
	L1_15 = A0_14._lines_are_dismissed
	return L1_15
end
function SubtitlePanel.set_fade_is_done(A0_16)
	local L1_17
	A0_16._fade_is_done = true
end
function SubtitlePanel.wants_to_destroy(A0_18)
	local L1_19
	L1_19 = A0_18._fade_is_done
	return L1_19
end
function SubtitlePanel.panel(A0_20)
	local L1_21
	L1_21 = A0_20._panel
	return L1_21
end
