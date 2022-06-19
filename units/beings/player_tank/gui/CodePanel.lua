require("units/beings/player_tank/gui/MachineHudPanel")
require("units/beings/player_tank/gui/MachineText")
CodePanel = CodePanel or class(MachineHudPanel)
function CodePanel.init(A0_0, A1_1)
	MachineHudPanel.init(A0_0, A1_1)
	A0_0._parent_panel = A1_1
	A0_0._x = A0_0._parent_panel:width() / 2 + tweak_data.machine.hud.CENTER_SPACE / 2
	A0_0._y = A0_0._parent_panel:height()
	A0_0._width = A0_0._parent_panel:width() / 2 - tweak_data.machine.hud.CENTER_SPACE / 2
	A0_0._height = tweak_data.machine.hud.TURRET_PANEL_HEIGHT
	A0_0._code_panel = A0_0._parent_panel:panel({
		name = "code_panel",
		width = A0_0._width,
		height = A0_0._height,
		layer = 100
	})
	A0_0._code_panel:set_leftbottom(A0_0._x, A0_0._y)
	A0_0._code_texts = {}
	A0_0._code_texts[1] = Localizer:lookup("machine_hud_trajectory_logging")
	A0_0._code_texts[2] = Localizer:lookup("machine_hud_status_column_1")
	A0_0._code_texts[3] = Localizer:lookup("machine_hud_status_column_2")
	A0_0._code_text_index = 1
	A0_0._code_text = MachineText:new(A0_0._code_panel, 0, 0, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	A0_0._next_update = 0
	A0_0._next_alpha_update_time = 0
	A0_0._dt_since_last_alpha_update = 0
end
function CodePanel.panel(A0_2)
	local L1_3
	L1_3 = A0_2._code_panel
	return L1_3
end
function CodePanel.update(A0_4, A1_5, A2_6)
	if A0_4._need_boot_update then
		MachineHudPanel.update(A0_4, A2_6)
	end
	A0_4._need_boot_update = A0_4._wants_to_shut_down or A0_4._wants_to_start_up
	if not A0_4.startup_done or A0_4._shuting_down then
		return
	end
	if A1_5 > A0_4._next_update then
		A0_4._code_text:set_text(A0_4._code_texts[A0_4._code_text_index], false, 12)
		A0_4._code_text_index = A0_4._code_text_index + 1
		if A0_4._code_text_index > #A0_4._code_texts then
			A0_4._code_text_index = 1
		end
		A0_4._next_update = A0_4._next_update + 3
	end
	A0_4._dt_since_last_alpha_update = A0_4._dt_since_last_alpha_update + A2_6
	if A1_5 > A0_4._next_alpha_update_time then
		A0_4._code_text:update(A0_4._dt_since_last_alpha_update)
		A0_4._next_alpha_update_time = A1_5 + tweak_data.machine.hud.TEXT_UPDATE_FREQUENCY
		A0_4._dt_since_last_alpha_update = 0
	end
end
function CodePanel.get_target_size(A0_7)
	local L1_8, L2_9
	L1_8 = A0_7._width
	L2_9 = A0_7._height
	return L1_8, L2_9
end
function CodePanel.set_size_y(A0_10, A1_11)
end
function CodePanel.shutdown(A0_12, A1_13, A2_14)
	A0_12._code_text:set_text_alpha(0)
	A0_12._shuting_down = true
	MachineHudPanel.shutdown(A0_12, A1_13, A2_14)
end
function CodePanel.enable(A0_15, A1_16)
	if A1_16 <= 0.25 then
	else
	end
	A0_15._height = tweak_data.machine.hud.TURRET_PANEL_HEIGHT * A1_16
	A0_15._code_panel:set_height(A0_15._height)
	A0_15._code_panel:set_leftbottom(A0_15._x, A0_15._y)
end
function CodePanel.disable(A0_17)
	A0_17._disable = true
	A0_17._code_panel:set_height(0)
	A0_17._code_panel:set_leftbottom(A0_17._x, A0_17._y)
end
function CodePanel.show(A0_18)
	MachineHudPanel.show(A0_18)
	A0_18._code_text:set_text_alpha(1)
end
function CodePanel.hide(A0_19)
	MachineHudPanel.hide(A0_19)
	A0_19._code_text:set_text_alpha(0)
end
