require("shared/FiniteStateMachine")
require("units/beings/player/gui/SubtitlePanelStates")
if not SubtitlePanel then
	SubtitlePanel = class()
end
SubtitlePanel.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	l_1_0._use_small_font = l_1_4
	l_1_0._parent_panel = l_1_1
	local l_1_5, l_1_6 = l_1_1:panel, l_1_1
	local l_1_7 = {}
	l_1_7.height = 100
	l_1_7.width = l_1_1:width()
	l_1_5 = l_1_5(l_1_6, l_1_7)
	l_1_0._panel = l_1_5
	l_1_5 = TimerManager
	l_1_5, l_1_6 = l_1_5:wall, l_1_5
	l_1_5 = l_1_5(l_1_6)
	l_1_0._wall_timer = l_1_5
	l_1_5 = FiniteStateMachine
	l_1_5, l_1_6 = l_1_5:new, l_1_5
	l_1_7 = l_1_0
	l_1_5 = l_1_5(l_1_6, l_1_7, "subtitle", SubtitlePanelStateFadeIn)
	l_1_0._state = l_1_5
	l_1_5 = l_1_0._panel
	l_1_5, l_1_6 = l_1_5:set_world_center_x, l_1_5
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_5(l_1_6, l_1_7)
	l_1_0._y = 0
	l_1_5, l_1_6 = l_1_0:create_text, l_1_0
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_5 = l_1_5(l_1_6, l_1_7)
	l_1_0._text_panel1 = l_1_5
	l_1_5, l_1_6 = l_1_0:create_text, l_1_0
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_5 = l_1_5(l_1_6, l_1_7)
	l_1_0._text_panel2 = l_1_5
	l_1_5 = l_1_0._panel
	l_1_5, l_1_6 = l_1_5:set_y, l_1_5
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_5(l_1_6, l_1_7)
end

SubtitlePanel.destroy = function(l_2_0)
	l_2_0._state:destroy()
	l_2_0._parent_panel:remove(l_2_0._panel)
end

SubtitlePanel.create_text = function(l_3_0, l_3_1)
	local l_3_2 = tweak_data.player.new_hud.subtitles_panel.TEXT_COLOR
	local l_3_3 = tweak_data.player.new_hud.TEXTPANEL_CREATOR_FONT
	local l_3_4 = 1
	if l_3_0._use_small_font then
		l_3_4 = tweak_data.player.new_hud.TEXTPANEL_SMALL_FONT_FACTOR
	end
	local l_3_5, l_3_6 = l_3_0._panel:text, l_3_0._panel
	local l_3_7 = {}
	l_3_7.y = l_3_0._y
	l_3_7.font = l_3_3
	l_3_7.font_factor = l_3_4
	l_3_7.align = "center"
	l_3_7.color = l_3_2
	l_3_7.text = l_3_1
	l_3_5 = l_3_5(l_3_6, l_3_7)
	l_3_6 = l_3_0._y
	l_3_7 = tweak_data
	l_3_7 = l_3_7.player
	l_3_7 = l_3_7.new_hud
	l_3_7 = l_3_7.subtitles_panel
	l_3_7 = l_3_7.TEXT_FONT_SIZE
	l_3_6 = l_3_6 + l_3_7
	l_3_7 = tweak_data
	l_3_7 = l_3_7.player
	l_3_7 = l_3_7.new_hud
	l_3_7 = l_3_7.subtitles_panel
	l_3_7 = l_3_7.TEXT_SPACING
	l_3_6 = l_3_6 + l_3_7
	l_3_0._y = l_3_6
	return l_3_5
end

SubtitlePanel.update = function(l_4_0)
	local l_4_1 = l_4_0._wall_timer:delta_time()
	l_4_0._state:update(l_4_1)
end

SubtitlePanel.dismiss_lines = function(l_5_0)
	l_5_0._lines_are_dismissed = true
end

SubtitlePanel.lines_are_dismissed = function(l_6_0)
	return l_6_0._lines_are_dismissed
end

SubtitlePanel.set_fade_is_done = function(l_7_0)
	l_7_0._fade_is_done = true
end

SubtitlePanel.wants_to_destroy = function(l_8_0)
	return l_8_0._fade_is_done
end

SubtitlePanel.panel = function(l_9_0)
	return l_9_0._panel
end


