require("shared/FiniteStateMachine")
BootState = BootState or class()
function BootState.init(A0_0)
	local L1_1
end
function BootState._set_up_textures(A0_2)
	A0_2._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	A0_2._tv_dot_texture = A0_2._hud_panel:panel():bitmap({
		name = "gui_machine_tv_dot",
		texture = "gui_machine_tv_dot"
	})
	A0_2._tv_dot_texture:set_color(A0_2._color:with_alpha(0))
	A0_2._tv_line_texture = {}
	A0_2._tv_line_texture.bottom = A0_2._hud_panel:panel():bitmap({
		name = "gui_machine_tv_line",
		texture = "gui_machine_tv_line"
	})
	A0_2._tv_line_texture.bottom:set_width(0)
	A0_2._tv_line_texture.bottom:set_color(A0_2._color)
	A0_2._tv_line_texture.top = A0_2._hud_panel:panel():bitmap({
		name = "gui_machine_tv_line",
		texture = "gui_machine_tv_line"
	})
	A0_2._tv_line_texture.top:set_width(0)
	A0_2._tv_line_texture.top:rotate(180)
	A0_2._tv_line_texture.top:set_color(A0_2._color)
	if A0_2._panel_width > 1000 then
		A0_2._tv_line_y_offset = 1
	else
		A0_2._tv_line_y_offset = 0.5
		A0_2._tv_line_texture.bottom:set_height(A0_2._tv_line_texture.bottom:height() / 2)
		A0_2._tv_line_texture.top:set_height(A0_2._tv_line_texture.bottom:height() / 2)
		A0_2._tv_dot_texture:set_height(A0_2._tv_dot_texture:height() / 2)
		A0_2._tv_dot_texture:set_width(A0_2._tv_dot_texture:width() / 2)
	end
	A0_2._tv_dot_texture:set_center(A0_2._target_x, A0_2._target_y)
	A0_2._tv_line_texture.bottom:set_center(A0_2._target_x, A0_2._target_y + A0_2._tv_line_y_offset)
	A0_2._tv_line_texture.top:set_center(A0_2._target_x, A0_2._target_y - A0_2._tv_line_y_offset)
end
function BootState._kill_textures(A0_3)
	local L1_4, L2_5
	L1_4 = A0_3._tv_dot_texture
	if L1_4 then
		L1_4 = A0_3._tv_dot_texture
		L2_5 = L1_4
		L1_4 = L1_4.set_color
		L1_4(L2_5, A0_3._color:with_alpha(0))
		A0_3._tv_dot_texture = nil
	end
	L1_4 = A0_3._tv_line_texture
	L1_4 = L1_4.top
	L2_5 = L1_4
	L1_4 = L1_4.set_color
	L1_4(L2_5, A0_3._color:with_alpha(0))
	L1_4 = A0_3._tv_line_texture
	L1_4 = L1_4.bottom
	L2_5 = L1_4
	L1_4 = L1_4.set_color
	L1_4(L2_5, A0_3._color:with_alpha(0))
	A0_3._tv_line_texture = nil
end
function BootState._hide_textures(A0_6)
	local L1_7, L2_8
	L1_7 = A0_6._tv_dot_texture
	if L1_7 then
		L1_7 = A0_6._tv_dot_texture
		L2_8 = L1_7
		L1_7 = L1_7.set_color
		L1_7(L2_8, A0_6._color:with_alpha(0))
	end
	L1_7 = A0_6._tv_line_texture
	L1_7 = L1_7.top
	L2_8 = L1_7
	L1_7 = L1_7.set_color
	L1_7(L2_8, A0_6._color:with_alpha(0))
	L1_7 = A0_6._tv_line_texture
	L1_7 = L1_7.bottom
	L2_8 = L1_7
	L1_7 = L1_7.set_color
	L1_7(L2_8, A0_6._color:with_alpha(0))
	A0_6._hidden = true
end
function BootState._show_textures(A0_9)
	local L1_10, L2_11
	L1_10 = A0_9._tv_dot_texture
	if L1_10 then
		L1_10 = A0_9._tv_dot_texture
		L2_11 = L1_10
		L1_10 = L1_10.set_color
		L1_10(L2_11, A0_9._color:with_alpha(1))
	end
	L1_10 = A0_9._tv_line_texture
	L1_10 = L1_10.top
	L2_11 = L1_10
	L1_10 = L1_10.set_color
	L1_10(L2_11, A0_9._color:with_alpha(1))
	L1_10 = A0_9._tv_line_texture
	L1_10 = L1_10.bottom
	L2_11 = L1_10
	L1_10 = L1_10.set_color
	L1_10(L2_11, A0_9._color:with_alpha(1))
	A0_9._hidden = false
end
BootIdleState = BootIdleState or class()
function BootIdleState.init(A0_12)
	local L1_13
end
function BootIdleState.transition(A0_14)
	if A0_14._hud_panel:wants_to_start_up() then
		return BootStartUpState
	elseif A0_14._hud_panel:wants_to_shut_down() then
		return BootShutDownState
	end
end
BootStartUpState = BootStartUpState or class(BootState)
function BootStartUpState.init(A0_15)
	A0_15._panel_width, A0_15._panel_height = A0_15._hud_panel:get_target_size()
	A0_15._target_x, A0_15._target_y = A0_15._hud_panel:get_target_position()
	if not A0_15._target_x or not A0_15._target_y then
		A0_15._target_x = A0_15._panel_width / 2
		A0_15._target_y = A0_15._panel_height / 2
	end
	A0_15:_set_up_textures()
	A0_15._size_x_interpolator = Interpolator:new(0, tweak_data.machine.hud.BOOT_LINE_SPEED)
	A0_15._size_y_interpolator = Interpolator:new(0, tweak_data.machine.hud.BOOT_STARTUP_SPEED)
	A0_15._size_x_interpolator:set_target(A0_15._panel_width)
	A0_15._size_y_interpolator:set_target(A0_15._panel_height)
	A0_15._start_time = A0_15._hud_panel:get_start_time()
	A0_15._dot_time = A0_15._start_time + A0_15._hud_panel:get_dot_time()
	A0_15._total_time = 0
end
function BootStartUpState.update(A0_16, A1_17)
	local L2_18, L3_19
	L2_18 = A0_16._hud_panel
	L2_18 = L2_18._disabled
	if L2_18 then
		L2_18 = A0_16._hud_panel
		L2_18 = L2_18.boot_idle
		L2_18(L3_19)
		L2_18 = A0_16._kill_textures
		L2_18(L3_19)
		return
	end
	L2_18 = A0_16._hud_panel
	L2_18 = L2_18._hidden
	if L2_18 then
		L2_18 = A0_16._hide_textures
		L2_18(L3_19)
		return
	else
		L2_18 = A0_16._hidden
		if L2_18 then
			L2_18 = A0_16._show_textures
			L2_18(L3_19)
		end
	end
	L2_18 = A0_16._total_time
	L2_18 = L2_18 + A1_17
	A0_16._total_time = L2_18
	L2_18 = A0_16._total_time
	if L2_18 < L3_19 then
		return
	end
	L2_18 = A0_16._total_time
	if L2_18 < L3_19 then
		L2_18 = A0_16._tv_dot_texture
		L2_18 = L2_18.set_color
		L2_18(L3_19, A0_16._color:with_alpha(1))
		return
	end
	L2_18 = A0_16._size_x_interpolator
	L2_18 = L2_18.update
	L2_18(L3_19, A1_17)
	L2_18 = A0_16._size_x_interpolator
	L2_18 = L2_18.value
	L2_18 = L2_18(L3_19)
	for 