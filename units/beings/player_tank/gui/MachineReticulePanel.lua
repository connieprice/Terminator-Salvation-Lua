require("units/beings/player_tank/gui/MachineHudPanel")
require("units/beings/player_tank/gui/MachineText")
require("units/beings/player_tank/gui/ReticuleArrow")
require("units/beings/player_tank/gui/ReticuleAngularArrow")
if not MachineReticulePanel then
	MachineReticulePanel = class(MachineHudPanel)
end
MachineReticulePanel.init = function(l_1_0, l_1_1)
	MachineHudPanel.init(l_1_0, l_1_1)
	l_1_0._parent_panel = l_1_1
	l_1_0._width = l_1_0._parent_panel:width()
	l_1_0._height = l_1_0._parent_panel:height()
	l_1_0._center_x = l_1_0._width / 2
	l_1_0._center_y = l_1_0._height / 2
	l_1_0._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	local l_1_2, l_1_3 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_4 = {}
	l_1_4.name = "reticule_panel"
	l_1_4.width = l_1_0._width
	l_1_4.height = l_1_0._height
	l_1_4.valign = "center"
	l_1_4.halign = "center"
	l_1_4.layer = 100
	l_1_2 = l_1_2(l_1_3, l_1_4)
	l_1_0._reticule_panel = l_1_2
	l_1_0._reticule_radius = 60
	l_1_0._size_modifier = 1
	l_1_2, l_1_3 = l_1_0:_setup_reticule, l_1_0
	l_1_2(l_1_3)
	l_1_2, l_1_3 = l_1_0:set_size_y, l_1_0
	l_1_4 = 0
	l_1_2(l_1_3, l_1_4)
end

MachineReticulePanel.panel = function(l_2_0)
	return l_2_0._reticule_panel
end

MachineReticulePanel._setup_reticule = function(l_3_0)
	local l_3_5, l_3_6 = nil
	l_3_0._reticule_aim_circle = {}
	local l_3_1 = l_3_0._reticule_aim_circle
	local l_3_2, l_3_3 = l_3_0._reticule_panel:bitmap, l_3_0._reticule_panel
	local l_3_4 = {}
	l_3_4.name = "reticule_aim_circle"
	l_3_4.texture = "gui_machinie_aim_circle"
	l_3_2 = l_3_2(l_3_3, l_3_4)
	l_3_1.right_top = l_3_2
	l_3_1 = l_3_0._reticule_aim_circle
	l_3_1 = l_3_1.right_top
	l_3_1, l_3_2 = l_3_1:set_size, l_3_1
	l_3_3 = l_3_0._size_modifier
	l_3_3 = 64 * l_3_3
	l_3_4 = l_3_0._size_modifier
	l_3_4 = 64 * l_3_4
	l_3_1(l_3_2, l_3_3, l_3_4)
	l_3_1 = l_3_0._reticule_aim_circle
	l_3_1 = l_3_1.right_top
	l_3_1, l_3_2 = l_3_1:set_leftbottom, l_3_1
	l_3_3 = l_3_0._width
	l_3_3 = l_3_3 / 2
	l_3_4 = l_3_0._height
	l_3_4 = l_3_4 / 2
	l_3_1(l_3_2, l_3_3, l_3_4)
	l_3_1 = l_3_0._reticule_aim_circle
	l_3_2 = l_3_0._reticule_panel
	l_3_2, l_3_3 = l_3_2:bitmap, l_3_2
	l_3_2, l_3_4 = l_3_2(l_3_3, l_3_4), {name = "reticule_aim_circle", texture = "gui_machinie_aim_circle"}
	l_3_1.left_top = l_3_2
	l_3_1 = l_3_0._reticule_aim_circle
	l_3_1 = l_3_1.left_top
	l_3_1, l_3_2 = l_3_1:set_size, l_3_1
	l_3_3 = l_3_0._size_modifier
	l_3_3 = 64 * l_3_3
	l_3_4 = l_3_0._size_modifier
	l_3_4 = 64 * l_3_4
	l_3_1(l_3_2, l_3_3, l_3_4)
	l_3_1 = l_3_0._reticule_aim_circle
	l_3_1 = l_3_1.left_top
	l_3_1, l_3_2 = l_3_1:set_rightbottom, l_3_1
	l_3_3 = l_3_0._width
	l_3_3 = l_3_3 / 2
	l_3_4 = l_3_0._height
	l_3_4 = l_3_4 / 2
	l_3_1(l_3_2, l_3_3, l_3_4)
	l_3_1 = l_3_0._reticule_aim_circle
	l_3_1 = l_3_1.left_top
	l_3_1, l_3_2 = l_3_1:rotate, l_3_1
	l_3_3 = 270
	l_3_1(l_3_2, l_3_3)
	l_3_1 = l_3_0._reticule_aim_circle
	l_3_2 = l_3_0._reticule_panel
	l_3_2, l_3_3 = l_3_2:bitmap, l_3_2
	l_3_2, l_3_4 = l_3_2(l_3_3, l_3_4), {name = "reticule_aim_circle", texture = "gui_machinie_aim_circle"}
	l_3_1.right_bottom = l_3_2
	l_3_1 = l_3_0._reticule_aim_circle
	l_3_1 = l_3_1.right_bottom
	l_3_1, l_3_2 = l_3_1:set_size, l_3_1
	l_3_3 = l_3_0._size_modifier
	l_3_3 = 64 * l_3_3
	l_3_4 = l_3_0._size_modifier
	l_3_4 = 64 * l_3_4
	l_3_1(l_3_2, l_3_3, l_3_4)
	l_3_1 = l_3_0._reticule_aim_circle
	l_3_1 = l_3_1.right_bottom
	l_3_1, l_3_2 = l_3_1:set_lefttop, l_3_1
	l_3_3 = l_3_0._width
	l_3_3 = l_3_3 / 2
	l_3_4 = l_3_0._height
	l_3_4 = l_3_4 / 2
	l_3_1(l_3_2, l_3_3, l_3_4)
	l_3_1 = l_3_0._reticule_aim_circle
	l_3_1 = l_3_1.right_bottom
	l_3_1, l_3_2 = l_3_1:rotate, l_3_1
	l_3_3 = 90
	l_3_1(l_3_2, l_3_3)
	l_3_1 = l_3_0._reticule_aim_circle
	l_3_2 = l_3_0._reticule_panel
	l_3_2, l_3_3 = l_3_2:bitmap, l_3_2
	l_3_2, l_3_4 = l_3_2(l_3_3, l_3_4), {name = "reticule_aim_circle", texture = "gui_machinie_aim_circle"}
	l_3_1.left_bottom = l_3_2
	l_3_1 = l_3_0._reticule_aim_circle
	l_3_1 = l_3_1.left_bottom
	l_3_1, l_3_2 = l_3_1:set_size, l_3_1
	l_3_3 = l_3_0._size_modifier
	l_3_3 = 64 * l_3_3
	l_3_4 = l_3_0._size_modifier
	l_3_4 = 64 * l_3_4
	l_3_1(l_3_2, l_3_3, l_3_4)
	l_3_1 = l_3_0._reticule_aim_circle
	l_3_1 = l_3_1.left_bottom
	l_3_1, l_3_2 = l_3_1:set_righttop, l_3_1
	l_3_3 = l_3_0._width
	l_3_3 = l_3_3 / 2
	l_3_4 = l_3_0._height
	l_3_4 = l_3_4 / 2
	l_3_1(l_3_2, l_3_3, l_3_4)
	l_3_1 = l_3_0._reticule_aim_circle
	l_3_1 = l_3_1.left_bottom
	l_3_1, l_3_2 = l_3_1:rotate, l_3_1
	l_3_3 = 180
	l_3_1(l_3_2, l_3_3)
	l_3_1 = pairs
	l_3_2 = l_3_0._reticule_aim_circle
	l_3_1 = l_3_1(l_3_2)
	for l_3_4,i_1 in l_3_1 do
		i_1:set_color(l_3_0._color:with_alpha(tweak_data.machine.hud.MAIN_ALPHA))
	end
	l_3_0._reticule_aim_circle_height = l_3_0._reticule_aim_circle.right_top:height()
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_3_0._reticule_aim_big_arrow.right:set_move_in_end_position(-(80 * l_3_0._size_modifier), 0)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_3_0._reticule_aim_big_arrow.left:set_move_in_end_position(80 * l_3_0._size_modifier, 0)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_3_0._reticule_aim_big_arrow.bottom:set_move_in_end_position(0, -(80 * l_3_0._size_modifier))
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_3_0._reticule_aim_big_arrow.top:set_move_in_end_position(0, 80 * l_3_0._size_modifier)
	l_3_0._reticule_aim_small_arrow = {}
	l_3_0._reticule_aim_small_arrow.right_top = ReticuleAngularArrow:new(l_3_0._reticule_panel, "gui_machine_aim_small_arrow", l_3_0._width / 2, l_3_0._height / 2, l_3_0._reticule_radius, 45, 90, l_3_0._size_modifier)
	l_3_0._reticule_aim_small_arrow.right_bottom = ReticuleAngularArrow:new(l_3_0._reticule_panel, "gui_machine_aim_small_arrow", l_3_0._width / 2, l_3_0._height / 2, l_3_0._reticule_radius, 135, 180, l_3_0._size_modifier)
	l_3_0._reticule_aim_small_arrow.left_bottom = ReticuleAngularArrow:new(l_3_0._reticule_panel, "gui_machine_aim_small_arrow", l_3_0._width / 2, l_3_0._height / 2, l_3_0._reticule_radius, 225, 270, l_3_0._size_modifier)
	l_3_0._reticule_aim_small_arrow.left_top = ReticuleAngularArrow:new(l_3_0._reticule_panel, "gui_machine_aim_small_arrow", l_3_0._width / 2, l_3_0._height / 2, l_3_0._reticule_radius, 315, 360, l_3_0._size_modifier)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MachineReticulePanel.update = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_7, l_4_8, l_4_9, l_4_10, l_4_11, l_4_12, l_4_13, l_4_14, l_4_15, l_4_16, l_4_17, l_4_18, l_4_19, l_4_20, l_4_21, l_4_22, l_4_23, l_4_24, l_4_25, l_4_26, l_4_27, l_4_28, l_4_29, l_4_30, l_4_31, l_4_32, l_4_33, l_4_34, l_4_35, l_4_36, l_4_37, l_4_38, l_4_39, l_4_40, l_4_41, l_4_42, l_4_43, l_4_44, l_4_45, l_4_46 = nil
	if l_4_0._need_boot_update then
		MachineHudPanel.update(l_4_0, l_4_2)
	end
	if not l_4_0._wants_to_shut_down then
		l_4_0._need_boot_update = l_4_0._wants_to_start_up
	end
	if not l_4_0.startup_done or l_4_0._wants_to_shut_down then
		return 
	end
	for i_0,i_1 in pairs(l_4_0._reticule_aim_big_arrow) do
		if l_4_3 and not i_1:at_end_position() then
			i_1:move_in()
			i_1:update(l_4_1, l_4_2)
		elseif not l_4_3 and not i_1:at_start_position() then
			i_1:move_out()
			i_1:update(l_4_1, l_4_2)
		end
	end
	for i_0,i_1 in pairs(l_4_0._reticule_aim_small_arrow) do
		if l_4_3 and not i_1:at_end_position() then
			i_1:rotate_right()
			i_1:update(l_4_1, l_4_2)
		elseif not l_4_3 and not i_1:at_start_position() then
			i_1:rotate_left()
			i_1:update(l_4_1, l_4_2)
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MachineReticulePanel.get_target_size = function(l_5_0)
	return 200, 200
end

MachineReticulePanel.get_target_position = function(l_6_0)
	return l_6_0._center_x, l_6_0._center_y
end

MachineReticulePanel.set_size_y = function(l_7_0, l_7_1)
	local l_7_6, l_7_7, l_7_8, l_7_9, l_7_10, l_7_11, l_7_12, l_7_13, l_7_15, l_7_16, l_7_17, l_7_18, l_7_19, l_7_20 = nil
	local l_7_2 = l_7_1 / 200
	for i_0,i_1 in pairs(l_7_0._reticule_aim_circle) do
		do
			i_1:set_height(l_7_0._reticule_aim_circle_height * l_7_2)
			i_1:set_width(l_7_0._reticule_aim_circle_height * l_7_2)
		end
		l_7_0._reticule_aim_circle.right_top:set_leftbottom(l_7_0._width / 2, l_7_0._height / 2)
		l_7_0._reticule_aim_circle.left_top:set_rightbottom(l_7_0._width / 2, l_7_0._height / 2)
		l_7_0._reticule_aim_circle.right_bottom:set_lefttop(l_7_0._width / 2, l_7_0._height / 2)
		local l_7_14 = l_7_0._height / 2
		l_7_0._reticule_aim_circle.left_bottom:set_righttop(l_7_0._width / 2, l_7_14)
		for l_7_14,i_1 in pairs(l_7_0._reticule_aim_small_arrow) do
			i_1:set_alpha(l_7_2)
			i_1:set_radius(l_7_0._reticule_radius * l_7_2)
		end
		for i_0,i_1 in pairs(l_7_0._reticule_aim_big_arrow) do
			i_1:set_alpha(0)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MachineReticulePanel.set_startup_done = function(l_8_0)
	if not l_8_0._startup_done then
		l_8_0:set_size_y(200)
	end
	MachineHudPanel.set_startup_done(l_8_0)
end

MachineReticulePanel.set_alpha = function(l_9_0, l_9_1)
	local l_9_5, l_9_6, l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_12, l_9_13, l_9_14, l_9_15, l_9_16, l_9_17, l_9_18, l_9_19, l_9_20, l_9_21, l_9_22, l_9_23, l_9_24 = nil
	l_9_0._alpha = l_9_1
	for i_0,i_1 in pairs(l_9_0._reticule_aim_circle) do
		i_1:set_color(i_1:color():with_alpha(l_9_1))
	end
	for i_0,i_1 in pairs(l_9_0._reticule_aim_big_arrow) do
		if l_9_1 == 1 and i_1:at_start_position() then
			i_1:set_alpha(0)
		else
			i_1:set_alpha(l_9_1)
		end
	end
	for i_0,i_1 in pairs(l_9_0._reticule_aim_small_arrow) do
		i_1:set_alpha(l_9_1)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MachineReticulePanel.use_size = function(l_10_0, l_10_1)
	l_10_0._size_modifier = l_10_1
	l_10_0:set_alpha(0)
	l_10_0:_setup_reticule()
	if not l_10_0._startup_done then
		l_10_0:set_size_y(0)
	end
end

MachineReticulePanel.show = function(l_11_0)
	MachineHudPanel.show(l_11_0)
	l_11_0:set_alpha(1)
end

MachineReticulePanel.hide = function(l_12_0)
	MachineHudPanel.hide(l_12_0)
	l_12_0:set_alpha(0)
end


