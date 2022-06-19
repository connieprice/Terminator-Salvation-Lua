require("units/beings/player_tank/gui/MachineHudPanel")
require("units/beings/player_tank/gui/MachineText")
if not CodePanel then
	CodePanel = class(MachineHudPanel)
end
CodePanel.init = function(l_1_0, l_1_1)
	MachineHudPanel.init(l_1_0, l_1_1)
	l_1_0._parent_panel = l_1_1
	l_1_0._x = l_1_0._parent_panel:width() / 2 + tweak_data.machine.hud.CENTER_SPACE / 2
	l_1_0._y = l_1_0._parent_panel:height()
	l_1_0._width = l_1_0._parent_panel:width() / 2 - tweak_data.machine.hud.CENTER_SPACE / 2
	l_1_0._height = tweak_data.machine.hud.TURRET_PANEL_HEIGHT
	local l_1_2, l_1_3 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_4 = {}
	l_1_4.name = "code_panel"
	l_1_4.width = l_1_0._width
	l_1_4.height = l_1_0._height
	l_1_4.layer = 100
	l_1_2 = l_1_2(l_1_3, l_1_4)
	l_1_0._code_panel = l_1_2
	l_1_2 = l_1_0._code_panel
	l_1_2, l_1_3 = l_1_2:set_leftbottom, l_1_2
	l_1_4 = l_1_0._x
	l_1_2(l_1_3, l_1_4, l_1_0._y)
	l_1_0._code_texts, l_1_2 = l_1_2, {}
	l_1_2 = l_1_0._code_texts
	l_1_3 = Localizer
	l_1_3, l_1_4 = l_1_3:lookup, l_1_3
	l_1_3 = l_1_3(l_1_4, "machine_hud_trajectory_logging")
	l_1_2[1] = l_1_3
	l_1_2 = l_1_0._code_texts
	l_1_3 = Localizer
	l_1_3, l_1_4 = l_1_3:lookup, l_1_3
	l_1_3 = l_1_3(l_1_4, "machine_hud_status_column_1")
	l_1_2[2] = l_1_3
	l_1_2 = l_1_0._code_texts
	l_1_3 = Localizer
	l_1_3, l_1_4 = l_1_3:lookup, l_1_3
	l_1_3 = l_1_3(l_1_4, "machine_hud_status_column_2")
	l_1_2[3] = l_1_3
	l_1_0._code_text_index = 1
	l_1_2 = MachineText
	l_1_2, l_1_3 = l_1_2:new, l_1_2
	l_1_4 = l_1_0._code_panel
	l_1_2 = l_1_2(l_1_3, l_1_4, 0, 0, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	l_1_0._code_text = l_1_2
	l_1_0._next_update = 0
	l_1_0._next_alpha_update_time = 0
	l_1_0._dt_since_last_alpha_update = 0
end

CodePanel.panel = function(l_2_0)
	return l_2_0._code_panel
end

CodePanel.update = function(l_3_0, l_3_1, l_3_2)
	if l_3_0._need_boot_update then
		MachineHudPanel.update(l_3_0, l_3_2)
	end
	if not l_3_0._wants_to_shut_down then
		l_3_0._need_boot_update = l_3_0._wants_to_start_up
	end
	if not l_3_0.startup_done or l_3_0._shuting_down then
		return 
	end
	if l_3_0._next_update < l_3_1 then
		l_3_0._code_text:set_text(l_3_0._code_texts[l_3_0._code_text_index], false, 12)
		l_3_0._code_text_index = l_3_0._code_text_index + 1
		if #l_3_0._code_texts < l_3_0._code_text_index then
			l_3_0._code_text_index = 1
		end
		l_3_0._next_update = l_3_0._next_update + 3
	end
	l_3_0._dt_since_last_alpha_update = l_3_0._dt_since_last_alpha_update + l_3_2
	if l_3_0._next_alpha_update_time < l_3_1 then
		l_3_0._code_text:update(l_3_0._dt_since_last_alpha_update)
		l_3_0._next_alpha_update_time = l_3_1 + tweak_data.machine.hud.TEXT_UPDATE_FREQUENCY
		l_3_0._dt_since_last_alpha_update = 0
	end
end

CodePanel.get_target_size = function(l_4_0)
	return l_4_0._width, l_4_0._height
end

CodePanel.set_size_y = function(l_5_0, l_5_1)
end

CodePanel.shutdown = function(l_6_0, l_6_1, l_6_2)
	l_6_0._code_text:set_text_alpha(0)
	l_6_0._shuting_down = true
	MachineHudPanel.shutdown(l_6_0, l_6_1, l_6_2)
end

CodePanel.enable = function(l_7_0, l_7_1)
	if l_7_1 <= 0.25 then
		l_7_0._height = tweak_data.machine.hud.TURRET_PANEL_HEIGHT * l_7_1
		l_7_0._code_panel:set_height(l_7_0._height)
		l_7_0._code_panel:set_leftbottom(l_7_0._x, l_7_0._y)
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 4 
end

CodePanel.disable = function(l_8_0)
	l_8_0._disable = true
	l_8_0._code_panel:set_height(0)
	l_8_0._code_panel:set_leftbottom(l_8_0._x, l_8_0._y)
end

CodePanel.show = function(l_9_0)
	MachineHudPanel.show(l_9_0)
	l_9_0._code_text:set_text_alpha(1)
end

CodePanel.hide = function(l_10_0)
	MachineHudPanel.hide(l_10_0)
	l_10_0._code_text:set_text_alpha(0)
end


