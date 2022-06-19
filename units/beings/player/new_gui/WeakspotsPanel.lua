require("units/beings/player/new_gui/ReticulePiece")
if not WeakspotsPanel then
	WeakspotsPanel = class()
end
WeakspotsPanel.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._parent_panel = l_1_1
	l_1_0._player_unit = l_1_2
	l_1_0._player_data = l_1_2:player_data()
	l_1_0._user_viewport = l_1_3
	l_1_0._camera = l_1_0._user_viewport:engine_camera()
	l_1_0._width = l_1_1:width()
	l_1_0._height = l_1_1:height()
	l_1_0._size_modifier = 1
	l_1_0._weakspots = {}
	local l_1_4, l_1_5 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_6 = {}
	l_1_6.name = "weakspots_panel"
	l_1_6.width = l_1_0._width
	l_1_6.height = l_1_0._height
	l_1_6.valign = "center"
	l_1_6.halign = "center"
	l_1_4 = l_1_4(l_1_5, l_1_6)
	l_1_0._weakspots_panel = l_1_4
	l_1_0._damage_listeners, l_1_4 = l_1_4, {}
	l_1_0._weakspot_color_interpolators, l_1_4 = l_1_4, {}
end

WeakspotsPanel.panel = function(l_2_0)
	return l_2_0._weakspots_panel
end

WeakspotsPanel.update = function(l_3_0, l_3_1)
	local l_3_5, l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_18, l_3_19, l_3_20, l_3_21 = nil
	l_3_0:_update_color_interpolator(l_3_1)
	for i_0,i_1 in pairs(l_3_0._player_data.weakspot_unit_list) do
		if alive(i_1) then
			local l_3_13, l_3_14 = {}, i_1:damage():get_weakspots()
			if l_3_14 then
				for i_0,i_1 in pairs(l_3_14) do
					local l_3_15, l_3_16 = nil
					l_3_0:_draw_weakspot(l_3_11, l_3_45, l_3_16, l_3_12)
				end
				do
					if not l_3_0._damage_listeners[l_3_12] then
						local l_3_38, l_3_40, l_3_42, l_3_44 = managers.action_event:register_listener, managers.action_event, l_3_0, l_3_12
						l_3_0._damage_listeners[l_3_12] = l_3_38
					end
					 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

				end
			else
				local l_3_25, l_3_27, l_3_29, l_3_31, l_3_33 = table.insert, l_3_38
				l_3_27 = l_3_13
				local l_3_26, l_3_28, l_3_30, l_3_32, l_3_34 = nil
				l_3_29 = l_3_11
				l_3_25(l_3_27, l_3_29)
			end
		else
			table.insert(l_3_13, l_3_11)
		end
		if #l_3_13 > 0 then
			for i_0,i_1 in ipairs(l_3_13) do
				table.remove(l_3_13, i_1)
				if l_3_0._weakspots[i_1] then
					for i_0,i_1 in pairs(l_3_0._weakspots[i_1]) do
						i_1:set_color(i_1:color():with_alpha(0))
						l_3_0._weakspots[l_3_36][i_0] = nil
					end
				end
			end
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

WeakspotsPanel._update_color_interpolator = function(l_4_0, l_4_1)
	local l_4_5, l_4_6, l_4_7, l_4_8, l_4_9, l_4_10 = nil
	for i_0,i_1 in pairs(l_4_0._weakspot_color_interpolators) do
		if i_1.color_interpolator:has_reached_target() then
			l_4_0._weakspot_color_interpolators[l_4_11] = nil
			TableAlgorithms.restore_indices(l_4_0._weakspot_color_interpolators)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		elseif i_1.life_time <= 0 then
			i_1.color_interpolator:update(l_4_1)
		end
	end
end

WeakspotsPanel.unit_damaged = function(l_5_0, l_5_1, l_5_2, l_5_3)
	local l_5_7, l_5_8, l_5_9, l_5_10, l_5_11, l_5_12, l_5_19, l_5_20, l_5_21, l_5_22, l_5_23, l_5_24 = nil
	for i_0,i_1 in pairs(l_5_0._player_data.weakspot_unit_list) do
		if alive(i_1) and i_1 == l_5_1 then
			local l_5_15 = l_5_1:damage():get_weakspots()
		if l_5_15 then
			end
			for i_0,i_1 in pairs(l_5_15) do
				local l_5_16, l_5_17 = nil
				if l_5_2:name() == i_1.body_name then
					if l_5_0:_get_weakspot_color_interpolator(l_5_1, i_1.name) then
						l_5_0._weakspot_color_interpolators[l_5_0] = nil
						TableAlgorithms.restore_indices(l_5_0._weakspot_color_interpolators)
					end
					Interpolator:new(0, tweak_data.player.new_hud.weakspot_panel.DAMAGE_INDICATION_FADE_SPEED):set_target(1)
					local l_5_29 = nil
					table.insert(l_5_0._weakspot_color_interpolators, {unit = l_5_1, name = l_5_28.name, color_interpolator = l_5_29, life_time = tweak_data.player.new_hud.weakspot_panel.DAMAGE_INDICATION_LIFE_TIME})
				end
			end
		end
	end
end

WeakspotsPanel._get_weakspot_color_interpolator = function(l_6_0, l_6_1, l_6_2)
	local l_6_6, l_6_7, l_6_8, l_6_9, l_6_10, l_6_11, l_6_12 = nil
	for i_0,i_1 in pairs(l_6_0._weakspot_color_interpolators) do
		if i_1.unit == l_6_1 and i_1.name == l_6_2 then
			return i_1.color_interpolator, i_0
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

WeakspotsPanel._draw_weakspot = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4)
	if not l_7_0._weakspots[l_7_1] then
		l_7_0._weakspots[l_7_1] = {}
	end
	if not l_7_0._weakspots[l_7_1][l_7_2.name] then
		local l_7_5 = l_7_0._weakspots[l_7_1]
		local l_7_6 = l_7_2.name
		local l_7_7, l_7_8 = l_7_0._parent_panel:bitmap, l_7_0._parent_panel
		local l_7_9 = {}
		l_7_9.name = "gui_weakspot_marker"
		l_7_9.texture = "gui_weakspot_marker"
		l_7_7 = l_7_7(l_7_8, l_7_9)
		l_7_5[l_7_6] = l_7_7
		l_7_5 = l_7_0._texture_init_color
		if not l_7_5 then
			l_7_5 = l_7_0._weakspots
			l_7_5 = l_7_5[l_7_1]
			l_7_6 = l_7_2.name
			l_7_5 = l_7_5[l_7_6]
			l_7_5, l_7_6 = l_7_5:color, l_7_5
			l_7_5 = l_7_5(l_7_6)
			l_7_0._texture_init_color = l_7_5
		end
		l_7_5 = l_7_0._weakspots
		l_7_5 = l_7_5[l_7_1]
		l_7_6 = l_7_2.name
		l_7_5 = l_7_5[l_7_6]
		l_7_5, l_7_6 = l_7_5:set_size, l_7_5
		l_7_7 = l_7_0._size_modifier
		l_7_7 = 64 * l_7_7
		l_7_8 = l_7_0._size_modifier
		l_7_8 = 64 * l_7_8
		l_7_5(l_7_6, l_7_7, l_7_8)
	end
	if alive(l_7_0._camera) then
		if l_7_2.active and l_7_0:_weakspot_is_in_range(l_7_2, l_7_3) and l_7_0._player_unit:base():player_has_control() then
			local l_7_10 = l_7_0._camera:world_to_screen(l_7_2.pos)
			local l_7_11, l_7_12 = l_7_0:_screen_to_resolution(l_7_10)
			l_7_0._weakspots[l_7_1][l_7_2.name]:set_center(l_7_11, l_7_12)
			local l_7_13 = l_7_0:_get_weakspot_color_interpolator(l_7_4, l_7_2.name)
			if not l_7_13 then
				l_7_0._weakspots[l_7_1][l_7_2.name]:set_color(l_7_0._weakspots[l_7_1][l_7_2.name]:color():with_alpha(1))
			end
		else
			local l_7_14 = Color(1, l_7_13:value(), l_7_13:value()) * l_7_0._texture_init_color
			l_7_0._weakspots[l_7_1][l_7_2.name]:set_color(l_7_14)
		end
	else
		l_7_0._weakspots[l_7_1][l_7_2.name]:set_color(l_7_0._weakspots[l_7_1][l_7_2.name]:color():with_alpha(0))
	end
end

WeakspotsPanel._weakspot_is_in_range = function(l_8_0, l_8_1, l_8_2)
	local l_8_3 = l_8_1.pos - l_8_0._player_unit:position()
	if l_8_3:length() < l_8_2 then
		return true
	else
		return false
	end
end

WeakspotsPanel._screen_to_resolution = function(l_9_0, l_9_1)
	local l_9_2 = l_9_0._parent_panel:width() / 2 + l_9_0._parent_panel:width() / 2 * l_9_1.x
	local l_9_3 = l_9_0._parent_panel:height() / 2 + l_9_0._parent_panel:height() / 2 * l_9_1.y
	return l_9_2, l_9_3
end

WeakspotsPanel.show = function(l_10_0)
end

WeakspotsPanel.hide = function(l_11_0)
	local l_11_4, l_11_5, l_11_6, l_11_7, l_11_11, l_11_12, l_11_13, l_11_14, l_11_15, l_11_16 = nil
	for i_0,i_1 in pairs(l_11_0._weakspots) do
		for i_0,i_1 in pairs(i_1) do
			i_1:set_color(i_1:color():with_alpha(0))
			i_1 = nil
		end
		l_11_9 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

WeakspotsPanel.visible = function(l_12_0)
	return #l_12_0._weakspots > 0
end

WeakspotsPanel.use_size = function(l_13_0, l_13_1)
	l_13_0._size_modifier = l_13_1
end


