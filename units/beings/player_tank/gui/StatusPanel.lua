require("units/beings/player_tank/gui/MachineHudPanel")
require("units/beings/player_tank/gui/MachineText")
require("units/beings/player_tank/gui/StatusItem")
if not StatusPanel then
	StatusPanel = class(MachineHudPanel)
end
StatusPanel.init = function(l_1_0, l_1_1, l_1_2)
	MachineHudPanel.init(l_1_0, l_1_1)
	l_1_0._parent_panel = l_1_1
	l_1_0._unit = l_1_2
	l_1_0._player_data = l_1_0._unit:player_data()
	l_1_0._x = 10
	l_1_0._y = l_1_0._parent_panel:height()
	l_1_0._width = l_1_0._parent_panel:width() * 0.3
	l_1_0._height = tweak_data.machine.hud.TURRET_PANEL_HEIGHT
	local l_1_3, l_1_4 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_5 = {}
	l_1_5.name = "status_panel"
	l_1_5.width = l_1_0._width
	l_1_5.height = l_1_0._height
	l_1_5.layer = 100
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._status_panel = l_1_3
	l_1_3 = l_1_0._status_panel
	l_1_3, l_1_4 = l_1_3:set_leftbottom, l_1_3
	l_1_5 = l_1_0._x
	l_1_3(l_1_4, l_1_5, l_1_0._y)
	l_1_3, l_1_4 = l_1_0:_set_up_status_items, l_1_0
	l_1_3(l_1_4)
	l_1_3, l_1_4 = l_1_0:_set_up_hit_zones, l_1_0
	l_1_3(l_1_4)
	l_1_0._damage = 0
	l_1_0._next_update_time = 0
	l_1_0._next_alpha_update_time = 0
	l_1_0._dt_since_last_update = 0
	l_1_0._dt_since_last_alpha_update = 0
	l_1_0._need_boot_update = true
	l_1_0._time_since_damage = nil
	l_1_3, l_1_4 = l_1_0:show_page, l_1_0
	l_1_5 = "status"
	l_1_3(l_1_4, l_1_5)
end

StatusPanel.panel = function(l_2_0)
	return l_2_0._status_panel
end

StatusPanel._set_up_status_items = function(l_3_0)
	l_3_0._items_text = MachineText:new(l_3_0._status_panel, 0, 0, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	l_3_0._status_text = MachineText:new(l_3_0._status_panel, -5, 0, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	l_3_0._status_text:set_alignment("right", "top")
	l_3_0._status_items = {}
	l_3_0._status_items.overall_status = StatusItem:new(Localizer:lookup("machine_hud_overall_status"), 100, 1, "status")
	l_3_0._status_items.hull = StatusItem:new(Localizer:lookup("machine_hud_hull_status"), 100, 3, "status")
	l_3_0._status_items.turret = StatusItem:new(Localizer:lookup("machine_hud_turret_status"), 100, 4, "status")
	l_3_0._status_items.engine = StatusItem:new(Localizer:lookup("machine_hud_engine_status"), 100, 5, "status")
	l_3_0._status_items.l_gatling = StatusItem:new(Localizer:lookup("machine_hud_left_plasma_gatling_status"), 100, 7, "status")
	l_3_0._status_items.r_gatling = StatusItem:new(Localizer:lookup("machine_hud_right_plasma_gatling_status"), 100, 8, "status")
	l_3_0._status_items.l_cannon = StatusItem:new(Localizer:lookup("machine_hud_left_plasma_cannon_status"), 100, 10, "status")
	l_3_0._status_items.r_cannon = StatusItem:new(Localizer:lookup("machine_hud_right_plasma_cannon_status"), 100, 11, "status")
	l_3_0._status_items.l_track = StatusItem:new(Localizer:lookup("machine_hud_left_track_status"), 100, 15, "status")
	l_3_0._status_items.r_track = StatusItem:new(Localizer:lookup("machine_hud_right_track_status"), 100, 16, "status")
	l_3_0._status_items.reactor = StatusItem:new(Localizer:lookup("machine_hud_reactor_status"), 100, 6, "system")
	l_3_0._status_items.hull_struct = StatusItem:new(Localizer:lookup("machine_hud_hull_structural_integrity_status"), 100, 7, "system")
	l_3_0._status_items.passive_sensor = StatusItem:new(Localizer:lookup("machine_hud_passive_sensor_suite_status"), 100, 8, "system")
	l_3_0._status_items.active_sensor = StatusItem:new(Localizer:lookup("machine_hud_active_sensor_suite_status"), 100, 9, "system")
	l_3_0._status_items.reactor:set_fluctuation(96, 100, 0.5)
	l_3_0._status_items.hull_struct:set_fluctuation(96, 100, 0.5)
	l_3_0._status_items.passive_sensor:set_fluctuation(96, 100, 0.5)
	l_3_0._status_items.active_sensor:set_fluctuation(96, 100, 0.5)
	l_3_0._status_items.com = StatusItem:new(Localizer:lookup("machine_hud_communication_system"), 1, 1, "system")
	l_3_0._status_items.radar = StatusItem:new(Localizer:lookup("machine_hud_radar_system"), 1, 2, "system")
	l_3_0._status_items.gps = StatusItem:new(Localizer:lookup("machine_hud_gps_system"), 1, 3, "system")
	l_3_0._status_items.fire = StatusItem:new(Localizer:lookup("machine_hud_fire_control_system"), 1, 4, "system")
	local l_3_1 = {}
	l_3_1[0] = "0 %"
	l_3_1[1] = "100 %"
	l_3_0._status_items.com:use_status_enums(l_3_1)
	l_3_0._status_items.radar:use_status_enums(l_3_1)
	l_3_0._status_items.gps:use_status_enums(l_3_1)
	l_3_0._status_items.fire:use_status_enums(l_3_1)
	l_3_0._last_row = {}
	l_3_0._last_row.status = l_3_0:_get_nr_of_rows("status")
	l_3_0._last_row.system = l_3_0:_get_nr_of_rows("system")
end

StatusPanel._set_up_hit_zones = function(l_4_0)
	local l_4_4, l_4_5, l_4_6, l_4_7 = nil
	l_4_0._hit_zones = {}
	local l_4_1 = l_4_0._hit_zones
	local l_4_2 = {}
	l_4_2.name = "hull"
	l_4_2.left = true
	l_4_2.right = true
	l_4_2.back = true
	l_4_2.front = true
	l_4_2.hit_size = 500
	l_4_1.hull = l_4_2
	l_4_1 = l_4_0._hit_zones
	l_4_1.turret, l_4_2 = l_4_2, {name = "turret", left = true, right = true, back = true, front = true, hit_size = 100}
	l_4_1 = l_4_0._hit_zones
	l_4_1.engine, l_4_2 = l_4_2, {name = "engine", left = true, right = true, back = true, front = true, hit_size = 20}
	l_4_1 = l_4_0._hit_zones
	l_4_1.l_gatling, l_4_2 = l_4_2, {name = "l_gatling", left = true, back = true, front = true, hit_size = 20}
	l_4_1 = l_4_0._hit_zones
	l_4_1.r_gatling, l_4_2 = l_4_2, {name = "r_gatling", right = true, back = true, front = true, hit_size = 20}
	l_4_1 = l_4_0._hit_zones
	l_4_1.l_cannon, l_4_2 = l_4_2, {name = "l_cannon", left = true, back = true, front = true, hit_size = 40}
	l_4_1 = l_4_0._hit_zones
	l_4_1.r_cannon, l_4_2 = l_4_2, {name = "r_cannon", right = true, back = true, front = true, hit_size = 40}
	l_4_1 = l_4_0._hit_zones
	l_4_1.l_track, l_4_2 = l_4_2, {name = "l_track", left = true, back = true, front = true, hit_size = 80}
	l_4_1 = l_4_0._hit_zones
	l_4_1.r_track, l_4_2 = l_4_2, {name = "r_track", right = true, back = true, front = true, hit_size = 80}
	l_4_0._total_hit_size = 0
	l_4_1 = pairs
	l_4_2 = l_4_0._hit_zones
	l_4_1 = l_4_1(l_4_2)
	for i_0,i_1 in l_4_1 do
		l_4_0._total_hit_size = l_4_0._total_hit_size + i_1.hit_size
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

StatusPanel.update = function(l_5_0, l_5_1, l_5_2)
	if l_5_0._need_boot_update then
		MachineHudPanel.update(l_5_0, l_5_2)
	end
	if not l_5_0._wants_to_shut_down then
		l_5_0._need_boot_update = l_5_0._wants_to_start_up
	end
	if not l_5_0.startup_done or l_5_0._shuting_down then
		return 
	end
	l_5_0._dt_since_last_update = l_5_0._dt_since_last_update + l_5_2
	l_5_0._dt_since_last_alpha_update = l_5_0._dt_since_last_alpha_update + l_5_2
	if l_5_0._next_update_time < l_5_1 then
		l_5_0:_update_values(l_5_0._dt_since_last_update)
		l_5_0:_update_page(l_5_0._dt_since_last_update)
		l_5_0._next_update_time = l_5_1 + tweak_data.machine.hud.UPDATE_FREQUENCY
		l_5_0._dt_since_last_update = 0
	end
	if l_5_0._next_alpha_update_time < l_5_1 then
		l_5_0._items_text:update(l_5_0._dt_since_last_alpha_update)
		l_5_0._status_text:update(l_5_0._dt_since_last_alpha_update)
		l_5_0._next_alpha_update_time = l_5_1 + tweak_data.machine.hud.TEXT_UPDATE_FREQUENCY
		l_5_0._dt_since_last_alpha_update = 0
	end
end

StatusPanel.show_page = function(l_6_0, l_6_1)
	l_6_0._current_page = l_6_1
	l_6_0._current_page_time = 5
	local l_6_2, l_6_3 = l_6_0:_make_strings(l_6_1)
	l_6_0._items_text:set_text(l_6_2)
	l_6_0._status_text:set_text(l_6_3)
end

StatusPanel._update_page = function(l_7_0, l_7_1)
	l_7_0._current_page_time = l_7_0._current_page_time - l_7_1
	if l_7_0._time_since_damage and l_7_0._time_since_damage < 1 then
		if l_7_0._current_page == "status" then
			l_7_0._current_page_time = 5
		end
	else
		l_7_0:show_page("status")
	end
	if l_7_0._current_page_time < 0 then
		if l_7_0._current_page == "status" then
			l_7_0:show_page("system")
		else
			l_7_0:show_page("status")
		end
	else
		local l_7_2, l_7_3 = l_7_0:_make_strings(l_7_0._current_page)
	if l_7_3 ~= l_7_0._status_text:get_text() then
		end
		l_7_0._status_text:update_text(l_7_3)
	end
end

StatusPanel._get_nr_of_rows = function(l_8_0, l_8_1)
	local l_8_6, l_8_7, l_8_8, l_8_9 = nil
	local l_8_2 = 0
	for i_0,i_1 in pairs(l_8_0._status_items) do
		if i_1:get_page() == l_8_1 then
			l_8_2 = math.max(l_8_2, i_1:get_row())
		end
	end
	return l_8_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

StatusPanel._make_strings = function(l_9_0, l_9_1)
	local l_9_2 = ""
	local l_9_3 = ""
	local l_9_4 = 0
	for l_9_8 = 1, l_9_0._last_row[l_9_1] do
		local l_9_9 = l_9_0:_get_item_on_row(l_9_8, l_9_1)
		if l_9_9 then
			l_9_2 = l_9_2 .. l_9_9:get_item_string()
			l_9_3 = l_9_3 .. l_9_9:get_status_string(l_9_0.show_only_health)
		else
			l_9_2 = l_9_2 .. "\n"
			l_9_3 = l_9_3 .. "\n"
		end
	end
	return l_9_2, l_9_3
end

StatusPanel._get_item_on_row = function(l_10_0, l_10_1, l_10_2)
	local l_10_6, l_10_7, l_10_8, l_10_9, l_10_10, l_10_11 = nil
	for i_0,i_1 in pairs(l_10_0._status_items) do
		if i_1:get_row() == l_10_1 and i_1:get_page() == l_10_2 then
			return i_1
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

StatusPanel._update_values = function(l_11_0, l_11_1)
	local l_11_7, l_11_8, l_11_9, l_11_10, l_11_11, l_11_12, l_11_13, l_11_14 = nil
	local l_11_2 = l_11_0._player_data.on_rail_vehicle:damage_data()
	local l_11_3 = l_11_2.damage / l_11_2.health
	if l_11_0._time_since_damage then
		l_11_0._time_since_damage = l_11_0._time_since_damage + l_11_1
	end
	if l_11_2.dead then
		for i_0,i_1 in pairs(l_11_0._status_items) do
			i_1:set_status_target(0)
			i_1:remove_fluctuation()
		end
	elseif l_11_0._damage < l_11_3 then
		l_11_0._time_since_damage = 0
		local l_11_15 = l_11_0:_get_hit_zone()
		if l_11_15 and l_11_0._status_items[l_11_15.name] then
			local l_11_16 = l_11_0:_get_damage(l_11_15, l_11_3)
			local l_11_23, l_11_29, l_11_31 = l_11_0._status_items[l_11_15.name]:add_damage, l_11_0._status_items[l_11_15.name], l_11_16
			l_11_23(l_11_29, l_11_31)
		end
		local l_11_20, l_11_21, l_11_22, l_11_28, l_11_30 = l_11_0._status_items.overall_status:set_damage, l_11_0._status_items.overall_status, l_11_3
		l_11_20(l_11_21, l_11_22)
		l_11_0._damage = l_11_3
	elseif l_11_3 < l_11_0._damage then
		l_11_0._status_items.overall_status:set_damage(l_11_3)
		l_11_0._damage = l_11_3
		for i_0,i_1 in pairs(l_11_0._hit_zones) do
			if l_11_3 < (100 - l_11_0._status_items[i_0]._status) / 100 then
				l_11_0._status_items[l_11_24]:set_damage(l_11_3)
			end
		end
	end
	for i_0,i_1 in pairs(l_11_0._status_items) do
		i_1:update(l_11_1)
	end
end

StatusPanel._get_hit_zone = function(l_12_0)
	local l_12_6, l_12_7, l_12_8, l_12_9 = nil
	local l_12_1 = math.rand(l_12_0._total_hit_size)
	local l_12_2 = 0
	for i_0,i_1 in pairs(l_12_0._hit_zones) do
		l_12_2 = l_12_2 + i_1.hit_size
		if l_12_1 < l_12_2 then
			return i_1
		end
	end
end

StatusPanel._get_damage = function(l_13_0, l_13_1, l_13_2)
	l_13_2 = math.round((l_13_2 - l_13_0._damage) * l_13_0._total_hit_size / l_13_1.hit_size * 100)
	return l_13_2
end

StatusPanel.get_target_size = function(l_14_0)
	return l_14_0._width, l_14_0._height
end

StatusPanel.set_size_y = function(l_15_0, l_15_1)
end

StatusPanel.shutdown = function(l_16_0, l_16_1, l_16_2)
	l_16_0._items_text:set_text_alpha(0)
	l_16_0._status_text:set_text_alpha(0)
	l_16_0._shuting_down = true
	MachineHudPanel.shutdown(l_16_0, l_16_1, l_16_2)
end

StatusPanel.enable = function(l_17_0, l_17_1)
	l_17_0._height = tweak_data.machine.hud.TURRET_PANEL_HEIGHT * l_17_1
	l_17_0._status_text:set_text_alpha(0)
	l_17_0._status_text = MachineText:new(l_17_0._status_panel, -5, 0, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	l_17_0._status_text:set_alignment("right", "top")
	if l_17_1 <= 0.25 then
		l_17_0._status_panel:set_width(l_17_0._width + 50)
		l_17_0._status_text._machine_text:set_x(20)
	elseif l_17_1 <= 0.5 then
		l_17_0._status_panel:set_width(l_17_0._width + 100)
		l_17_0._status_text._machine_text:set_x(30)
	else
		l_17_0._status_panel:set_width(l_17_0._width)
		l_17_0._status_text._machine_text:set_x(0)
	end
	l_17_0._status_text:set_alignment("right", "top")
	l_17_0._status_panel:set_height(l_17_0._height)
	l_17_0._y = l_17_0._parent_panel:height()
	l_17_0._status_panel:set_leftbottom(l_17_0._x, l_17_0._y)
end

StatusPanel.disable = function(l_18_0)
	l_18_0._status_panel:set_height(0)
	l_18_0._status_panel:set_leftbottom(l_18_0._x, l_18_0._y)
	l_18_0._disabled = true
end

StatusPanel.show = function(l_19_0)
	if l_19_0._disabled then
		return 
	end
	MachineHudPanel.show(l_19_0)
	l_19_0._status_text:set_text_alpha(1)
	l_19_0._items_text:set_text_alpha(1)
end

StatusPanel.hide = function(l_20_0)
	MachineHudPanel.hide(l_20_0)
	l_20_0._status_text:set_text_alpha(0)
	l_20_0._items_text:set_text_alpha(0)
end


