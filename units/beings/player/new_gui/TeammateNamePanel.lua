require("units/beings/player/new_gui/TeammateName")
if not TeammateNamePanel then
	TeammateNamePanel = class()
end
TeammateNamePanel.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._parent_panel = l_1_1
	l_1_0._player_unit = l_1_2
	l_1_0._player_data = l_1_2:player_data()
	l_1_0._width = l_1_0._parent_panel:width()
	l_1_0._height = l_1_0._parent_panel:height()
	l_1_0._user_viewport = l_1_3
	l_1_0._camera = l_1_0._user_viewport:engine_camera()
	local l_1_4, l_1_5 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_6 = {}
	l_1_6.name = "teammate_name_panel"
	l_1_6.width = l_1_0._width
	l_1_6.height = l_1_0._height
	l_1_6.valign = "grow"
	l_1_6.halign = "grow"
	l_1_6.layer = tweak_data.player.new_hud.teammate_name_panel.LAYER
	l_1_4 = l_1_4(l_1_5, l_1_6)
	l_1_0._teammate_name_panel = l_1_4
	l_1_4 = l_1_0._teammate_name_panel
	l_1_4, l_1_5 = l_1_4:set_lefttop, l_1_4
	l_1_6 = 0
	l_1_4(l_1_5, l_1_6, 0)
	l_1_4 = l_1_0._player_data
	l_1_4.teammate_with_visible_names, l_1_5 = l_1_5, {}
	l_1_0._displayed_units, l_1_4 = l_1_4, {}
	l_1_0._t = 0
	l_1_0._next_scan_time = 0
end

TeammateNamePanel.panel = function(l_2_0)
	return l_2_0._teammate_name_panel
end

TeammateNamePanel.update = function(l_3_0, l_3_1)
	local l_3_5, l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11, l_3_12, l_3_13, l_3_14, l_3_15, l_3_16, l_3_17, l_3_18, l_3_19, l_3_20, l_3_21, l_3_22, l_3_23, l_3_24, l_3_28, l_3_29, l_3_30, l_3_31 = nil
	l_3_0._t = l_3_0._t + l_3_1
	if l_3_0._next_scan_time < l_3_0._t then
		for i_0,i_1 in pairs(l_3_0._displayed_units) do
			if not l_3_0._player_data.teammate_with_visible_names[i_0] then
				l_3_0._displayed_units[i_0]:hide()
			if not l_3_0._displayed_units[i_0]:visible() then
				end
				l_3_0._displayed_units[i_0]:remove()
				l_3_0._displayed_units[i_0] = nil
			end
		end
		for i_0,i_1 in pairs(l_3_0._player_data.teammate_with_visible_names) do
			if not l_3_0._displayed_units[i_0] and alive(i_0) and i_0:hud() and i_0:hud().teammate_name then
				l_3_0._displayed_units[i_0] = TeammateName:new(l_3_0._teammate_name_panel, l_3_0._player_unit, i_0, l_3_0._camera)
			end
			for i_0,i_1 in pairs(l_3_0._player_data.teammate_with_visible_names) do
				l_3_0._displayed_units[i_0]:show()
			end
			l_3_0._next_scan_time = l_3_0._t + tweak_data.player.new_hud.teammate_name_panel.UPDATE_FREQUENCY
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		for i_0,i_1 in pairs(l_3_0._displayed_units) do
			l_3_27:update(l_3_1)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
end

TeammateNamePanel.instant_hide = function(l_4_0)
	local l_4_4, l_4_5, l_4_6, l_4_7, l_4_8 = nil
	for i_0,i_1 in pairs(l_4_0._displayed_units) do
		l_4_0._displayed_units[i_0]:remove()
		l_4_0._displayed_units[i_0] = nil
	end
end


