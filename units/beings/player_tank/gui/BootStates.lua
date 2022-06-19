require("shared/FiniteStateMachine")
if not BootState then
	BootState = class()
end
BootState.init = function(l_1_0)
end

BootState._set_up_textures = function(l_2_0)
	l_2_0._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	local l_2_1, l_2_2 = l_2_0._hud_panel:panel():bitmap, l_2_0._hud_panel:panel()
	local l_2_3 = {}
	l_2_3.name = "gui_machine_tv_dot"
	l_2_3.texture = "gui_machine_tv_dot"
	l_2_1 = l_2_1(l_2_2, l_2_3)
	l_2_0._tv_dot_texture = l_2_1
	l_2_1 = l_2_0._tv_dot_texture
	l_2_1, l_2_2 = l_2_1:set_color, l_2_1
	l_2_3 = l_2_0._color
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_1(l_2_2, l_2_3)
	l_2_0._tv_line_texture, l_2_1 = l_2_1, {}
	l_2_1 = l_2_0._tv_line_texture
	l_2_2 = l_2_0._hud_panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_2 = l_2_2:panel
	l_2_2 = l_2_2(l_2_3)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_2 = l_2_2:bitmap
	local l_2_4 = {}
	l_2_4.name = "gui_machine_tv_line"
	l_2_4.texture = "gui_machine_tv_line"
	l_2_2 = l_2_2(l_2_3, l_2_4)
	l_2_1.bottom = l_2_2
	l_2_1 = l_2_0._tv_line_texture
	l_2_1 = l_2_1.bottom
	l_2_1, l_2_2 = l_2_1:set_width, l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_1(l_2_2, l_2_3)
	l_2_1 = l_2_0._tv_line_texture
	l_2_1 = l_2_1.bottom
	l_2_1, l_2_2 = l_2_1:set_color, l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_1(l_2_2, l_2_3)
	l_2_1 = l_2_0._tv_line_texture
	l_2_2 = l_2_0._hud_panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_2 = l_2_2:panel
	l_2_2 = l_2_2(l_2_3)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_2 = l_2_2:bitmap
	l_2_2, l_2_4 = l_2_2(l_2_3, l_2_4), {name = "gui_machine_tv_line", texture = "gui_machine_tv_line"}
	l_2_1.top = l_2_2
	l_2_1 = l_2_0._tv_line_texture
	l_2_1 = l_2_1.top
	l_2_1, l_2_2 = l_2_1:set_width, l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_1(l_2_2, l_2_3)
	l_2_1 = l_2_0._tv_line_texture
	l_2_1 = l_2_1.top
	l_2_1, l_2_2 = l_2_1:rotate, l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_1(l_2_2, l_2_3)
	l_2_1 = l_2_0._tv_line_texture
	l_2_1 = l_2_1.top
	l_2_1, l_2_2 = l_2_1:set_color, l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_1(l_2_2, l_2_3)
	l_2_1 = l_2_0._panel_width
	if l_2_1 > 1000 then
		l_2_0._tv_line_y_offset = 1
	else
		l_2_0._tv_line_y_offset = 0.5
		l_2_1 = l_2_0._tv_line_texture
		l_2_1 = l_2_1.bottom
		l_2_1, l_2_2 = l_2_1:set_height, l_2_1
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_4 = l_2_3
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_1(l_2_2, l_2_3)
		l_2_1 = l_2_0._tv_line_texture
		l_2_1 = l_2_1.top
		l_2_1, l_2_2 = l_2_1:set_height, l_2_1
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_4 = l_2_3
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_1(l_2_2, l_2_3)
		l_2_1 = l_2_0._tv_dot_texture
		l_2_1, l_2_2 = l_2_1:set_height, l_2_1
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_4 = l_2_3
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_1(l_2_2, l_2_3)
		l_2_1 = l_2_0._tv_dot_texture
		l_2_1, l_2_2 = l_2_1:set_width, l_2_1
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_4 = l_2_3
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_1(l_2_2, l_2_3)
	end
	l_2_1 = l_2_0._tv_dot_texture
	l_2_1, l_2_2 = l_2_1:set_center, l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_4 = l_2_0._target_y
	l_2_1(l_2_2, l_2_3, l_2_4)
	l_2_1 = l_2_0._tv_line_texture
	l_2_1 = l_2_1.bottom
	l_2_1, l_2_2 = l_2_1:set_center, l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_4 = l_2_0._target_y
	l_2_4 = l_2_4 + l_2_0._tv_line_y_offset
	l_2_1(l_2_2, l_2_3, l_2_4)
	l_2_1 = l_2_0._tv_line_texture
	l_2_1 = l_2_1.top
	l_2_1, l_2_2 = l_2_1:set_center, l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_4 = l_2_0._target_y
	l_2_4 = l_2_4 - l_2_0._tv_line_y_offset
	l_2_1(l_2_2, l_2_3, l_2_4)
end

BootState._kill_textures = function(l_3_0)
	if l_3_0._tv_dot_texture then
		l_3_0._tv_dot_texture:set_color(l_3_0._color:with_alpha(0))
		l_3_0._tv_dot_texture = nil
	end
	l_3_0._tv_line_texture.top:set_color(l_3_0._color:with_alpha(0))
	l_3_0._tv_line_texture.bottom:set_color(l_3_0._color:with_alpha(0))
	l_3_0._tv_line_texture = nil
end

BootState._hide_textures = function(l_4_0)
	if l_4_0._tv_dot_texture then
		l_4_0._tv_dot_texture:set_color(l_4_0._color:with_alpha(0))
	end
	l_4_0._tv_line_texture.top:set_color(l_4_0._color:with_alpha(0))
	l_4_0._tv_line_texture.bottom:set_color(l_4_0._color:with_alpha(0))
	l_4_0._hidden = true
end

BootState._show_textures = function(l_5_0)
	if l_5_0._tv_dot_texture then
		l_5_0._tv_dot_texture:set_color(l_5_0._color:with_alpha(1))
	end
	l_5_0._tv_line_texture.top:set_color(l_5_0._color:with_alpha(1))
	l_5_0._tv_line_texture.bottom:set_color(l_5_0._color:with_alpha(1))
	l_5_0._hidden = false
end

if not BootIdleState then
	BootIdleState = class()
end
BootIdleState.init = function(l_6_0)
end

BootIdleState.transition = function(l_7_0)
	if l_7_0._hud_panel:wants_to_start_up() then
		return BootStartUpState
	else
		if l_7_0._hud_panel:wants_to_shut_down() then
			return BootShutDownState
		end
	end
end

if not BootStartUpState then
	BootStartUpState = class(BootState)
end
BootStartUpState.init = function(l_8_0)
	local l_8_1 = l_8_0._hud_panel:get_target_size()
	l_8_0._panel_height = l_8_0._hud_panel
	l_8_0._panel_width = l_8_1
	l_8_1 = l_8_0._hud_panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_8_0._target_y = l_8_1
	l_8_0._target_x = l_8_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if not l_8_1 or not l_8_1 then
		l_8_0._target_x = l_8_1
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_8_0._target_y = l_8_1
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_8_1(l_8_0)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_8_0._size_x_interpolator = l_8_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_8_0._size_y_interpolator = l_8_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_8_1(l_8_1, l_8_0._panel_width)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_8_1(l_8_1, l_8_0._panel_height)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_8_0._start_time = l_8_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_8_0._dot_time = l_8_1
	l_8_0._total_time = 0
end

BootStartUpState.update = function(l_9_0, l_9_1)
	if l_9_0._hud_panel._disabled then
		l_9_0._hud_panel:boot_idle()
		l_9_0:_kill_textures()
		return 
	end
	if l_9_0._hud_panel._hidden then
		l_9_0:_hide_textures()
		return 
	elseif l_9_0._hidden then
		l_9_0:_show_textures()
	end
	l_9_0._total_time = l_9_0._total_time + l_9_1
	if l_9_0._total_time < l_9_0._start_time then
		return 
	end
	if l_9_0._total_time < l_9_0._dot_time then
		local l_9_6, l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_12, l_9_13 = l_9_0._tv_dot_texture:set_color, l_9_0._tv_dot_texture, l_9_0._color:with_alpha(1), .end
		l_9_6(l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_12, l_9_13)
		return 
	end
	l_9_0._size_x_interpolator:update(l_9_1)
	local l_9_2 = l_9_0._size_x_interpolator:value()
	for i_0,i_1 in pairs(l_9_0._tv_line_texture) do
		i_1:set_width(l_9_2)
		i_1:set_center_x(l_9_0._target_x)
	end
	l_9_0._tv_dot_texture:set_color(l_9_0._color:with_alpha(1 - l_9_2 / l_9_0._panel_width))
	if math.abs(l_9_0._panel_width - l_9_2) < l_9_0._panel_width / 100 then
		l_9_0._size_y_interpolator:update(l_9_1)
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if math.abs(l_9_0._panel_height - l_9_0._size_y_interpolator:value()) >= l_9_0._panel_height / 10 or math.abs(l_9_0._panel_height - l_9_0._size_y_interpolator:value()) < l_9_0._panel_height / 100 then
			l_9_0._hud_panel:set_startup_done()
			l_9_0._hud_panel:boot_idle()
			l_9_0:_kill_textures()
		end
		if l_9_0._tv_line_texture then
			l_9_0._tv_line_texture.top:set_center_y(l_9_0._target_y - l_9_0._panel_height / 2 - l_9_0._tv_line_y_offset)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_9_0._tv_line_texture.bottom:set_center_y(l_9_0._target_y + l_9_0._panel_height / 2 + l_9_0._tv_line_y_offset)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_9_0._tv_line_texture.top:set_color(l_9_0._color:with_alpha(1 - l_9_0._panel_height / l_9_0._panel_height))
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_9_0._tv_line_texture.bottom:set_color(l_9_0._color:with_alpha(1 - l_9_0._panel_height / l_9_0._panel_height))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_9_0._hud_panel:set_size_y(l_9_0._panel_height)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

BootStartUpState.transition = function(l_10_0)
	if l_10_0._hud_panel:wants_to_boot_idle() then
		return BootIdleState
	else
		if l_10_0._hud_panel:wants_to_shut_down() then
			return BootShutDownState
		end
	end
end

if not BootShutDownState then
	BootShutDownState = class(BootState)
end
BootShutDownState.init = function(l_11_0)
	local l_11_4, l_11_5, l_11_6, l_11_7, l_11_8, l_11_9, l_11_10, l_11_11, l_11_12, l_11_13, l_11_14, l_11_15 = nil
	local l_11_1 = l_11_0._hud_panel:get_target_position()
	l_11_0._target_y = l_11_0._hud_panel
	l_11_0._target_x = l_11_1
	l_11_1 = l_11_0._hud_panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_11_0._panel_height = l_11_1
	l_11_0._panel_width = l_11_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if not l_11_1 or not l_11_1 then
		l_11_0._target_x = l_11_1
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_11_0._target_y = l_11_1
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_11_1(l_11_0)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0,i_1 in l_11_1 do
		i_1:set_width(l_11_0._panel_width)
		i_1:set_center_x(l_11_0._target_x)
		i_1:set_color(l_11_0._color:with_alpha(0))
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_11_0._size_x_interpolator = l_11_1:new(l_11_0._panel_width, tweak_data.machine.hud.BOOT_LINE_SPEED)
	l_11_0._size_y_interpolator = Interpolator:new(l_11_0._panel_height, tweak_data.machine.hud.BOOT_SHUTDOWN_SPEED)
	l_11_0._size_x_interpolator:set_target(0)
	l_11_0._size_y_interpolator:set_target(0)
	l_11_0._start_time = l_11_0._hud_panel:get_start_time()
	l_11_0._dot_time = l_11_0._start_time + l_11_0._hud_panel:get_dot_time()
	l_11_0._total_time = 0
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

BootShutDownState.update = function(l_12_0, l_12_1)
	local l_12_7, l_12_8, l_12_9, l_12_10, l_12_11, l_12_12, l_12_13, l_12_14 = nil
	l_12_0._total_time = l_12_0._total_time + l_12_1
	if l_12_0._total_time < l_12_0._start_time then
		return 
	end
	l_12_0._size_y_interpolator:update(l_12_1)
	local l_12_2 = l_12_0._size_y_interpolator:value()
	if math.abs(l_12_2) < l_12_0._panel_height / 100 then
		l_12_2 = 0
		l_12_0._size_x_interpolator:update(l_12_1)
		local l_12_3 = l_12_0._size_x_interpolator:value()
		for i_0,i_1 in pairs(l_12_0._tv_line_texture) do
			i_1:set_width(l_12_3)
			i_1:set_center_x(l_12_0._target_x)
		end
	if math.abs(l_12_3) < l_12_0._panel_width / 100 then
		end
		l_12_0._hud_panel:boot_idle()
		l_12_0:_kill_textures()
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_12_3 = l_12_0._hud_panel
	l_12_3(l_12_3, l_12_2)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_12_3 then
		l_12_3(l_12_3, l_12_0._target_y - l_12_2 / 2 - l_12_0._tv_line_y_offset)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_12_3(l_12_3, l_12_0._target_y + l_12_2 / 2 + l_12_0._tv_line_y_offset)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_12_3(l_12_3, l_12_0._color:with_alpha(1 - l_12_2 / l_12_0._panel_height))
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_12_3(l_12_3, l_12_0._color:with_alpha(1 - l_12_2 / l_12_0._panel_height))
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

BootShutDownState.transition = function(l_13_0)
	if l_13_0._hud_panel:wants_to_boot_idle() then
		return BootIdleState
	else
		if l_13_0._hud_panel:wants_to_start_up() then
			return BootStartUpState
		end
	end
end


