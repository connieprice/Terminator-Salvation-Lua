require("units/beings/player_tank/gui/MachineHudPanel")
require("units/beings/player_tank/gui/MachineText")
require("units/beings/player_tank/gui/StatusItem")
StatusPanel = StatusPanel or class(MachineHudPanel)
function StatusPanel.init(A0_0, A1_1, A2_2)
	MachineHudPanel.init(A0_0, A1_1)
	A0_0._parent_panel = A1_1
	A0_0._unit = A2_2
	A0_0._player_data = A0_0._unit:player_data()
	A0_0._x = 10
	A0_0._y = A0_0._parent_panel:height()
	A0_0._width = A0_0._parent_panel:width() * 0.3
	A0_0._height = tweak_data.machine.hud.TURRET_PANEL_HEIGHT
	A0_0._status_panel = A0_0._parent_panel:panel({
		name = "status_panel",
		width = A0_0._width,
		height = A0_0._height,
		layer = 100
	})
	A0_0._status_panel:set_leftbottom(A0_0._x, A0_0._y)
	A0_0:_set_up_status_items()
	A0_0:_set_up_hit_zones()
	A0_0._damage = 0
	A0_0._next_update_time = 0
	A0_0._next_alpha_update_time = 0
	A0_0._dt_since_last_update = 0
	A0_0._dt_since_last_alpha_update = 0
	A0_0._need_boot_update = true
	A0_0._time_since_damage = nil
	A0_0:show_page("status")
end
function StatusPanel.panel(A0_3)
	local L1_4
	L1_4 = A0_3._status_panel
	return L1_4
end
function StatusPanel._set_up_status_items(A0_5)
	local L1_6
	L1_6 = MachineText
	L1_6 = L1_6.new
	L1_6 = L1_6(L1_6, A0_5._status_panel, 0, 0, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	A0_5._items_text = L1_6
	L1_6 = MachineText
	L1_6 = L1_6.new
	L1_6 = L1_6(L1_6, A0_5._status_panel, -5, 0, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	A0_5._status_text = L1_6
	L1_6 = A0_5._status_text
	L1_6 = L1_6.set_alignment
	L1_6(L1_6, "right", "top")
	L1_6 = {}
	A0_5._status_items = L1_6
	L1_6 = A0_5._status_items
	L1_6.overall_status = StatusItem:new(Localizer:lookup("machine_hud_overall_status"), 100, 1, "status")
	L1_6 = A0_5._status_items
	L1_6.hull = StatusItem:new(Localizer:lookup("machine_hud_hull_status"), 100, 3, "status")
	L1_6 = A0_5._status_items
	L1_6.turret = StatusItem:new(Localizer:lookup("machine_hud_turret_status"), 100, 4, "status")
	L1_6 = A0_5._status_items
	L1_6.engine = StatusItem:new(Localizer:lookup("machine_hud_engine_status"), 100, 5, "status")
	L1_6 = A0_5._status_items
	L1_6.l_gatling = StatusItem:new(Localizer:lookup("machine_hud_left_plasma_gatling_status"), 100, 7, "status")
	L1_6 = A0_5._status_items
	L1_6.r_gatling = StatusItem:new(Localizer:lookup("machine_hud_right_plasma_gatling_status"), 100, 8, "status")
	L1_6 = A0_5._status_items
	L1_6.l_cannon = StatusItem:new(Localizer:lookup("machine_hud_left_plasma_cannon_status"), 100, 10, "status")
	L1_6 = A0_5._status_items
	L1_6.r_cannon = StatusItem:new(Localizer:lookup("machine_hud_right_plasma_cannon_status"), 100, 11, "status")
	L1_6 = A0_5._status_items
	L1_6.l_track = StatusItem:new(Localizer:lookup("machine_hud_left_track_status"), 100, 15, "status")
	L1_6 = A0_5._status_items
	L1_6.r_track = StatusItem:new(Localizer:lookup("machine_hud_right_track_status"), 100, 16, "status")
	L1_6 = A0_5._status_items
	L1_6.reactor = StatusItem:new(Localizer:lookup("machine_hud_reactor_status"), 100, 6, "system")
	L1_6 = A0_5._status_items
	L1_6.hull_struct = StatusItem:new(Localizer:lookup("machine_hud_hull_structural_integrity_status"), 100, 7, "system")
	L1_6 = A0_5._status_items
	L1_6.passive_sensor = StatusItem:new(Localizer:lookup("machine_hud_passive_sensor_suite_status"), 100, 8, "system")
	L1_6 = A0_5._status_items
	L1_6.active_sensor = StatusItem:new(Localizer:lookup("machine_hud_active_sensor_suite_status"), 100, 9, "system")
	L1_6 = A0_5._status_items
	L1_6 = L1_6.reactor
	L1_6 = L1_6.set_fluctuation
	L1_6(L1_6, 96, 100, 0.5)
	L1_6 = A0_5._status_items
	L1_6 = L1_6.hull_struct
	L1_6 = L1_6.set_fluctuation
	L1_6(L1_6, 96, 100, 0.5)
	L1_6 = A0_5._status_items
	L1_6 = L1_6.passive_sensor
	L1_6 = L1_6.set_fluctuation
	L1_6(L1_6, 96, 100, 0.5)
	L1_6 = A0_5._status_items
	L1_6 = L1_6.active_sensor
	L1_6 = L1_6.set_fluctuation
	L1_6(L1_6, 96, 100, 0.5)
	L1_6 = A0_5._status_items
	L1_6.com = StatusItem:new(Localizer:lookup("machine_hud_communication_system"), 1, 1, "system")
	L1_6 = A0_5._status_items
	L1_6.radar = StatusItem:new(Localizer:lookup("machine_hud_radar_system"), 1, 2, "system")
	L1_6 = A0_5._status_items
	L1_6.gps = StatusItem:new(Localizer:lookup("machine_hud_gps_system"), 1, 3, "system")
	L1_6 = A0_5._status_items
	L1_6.fire = StatusItem:new(Localizer:lookup("machine_hud_fire_control_system"), 1, 4, "system")
	L1_6 = {}
	L1_6[0] = "0 %"
	L1_6[1] = "100 %"
	A0_5._status_items.com:use_status_enums(L1_6)
	A0_5._status_items.radar:use_status_enums(L1_6)
	A0_5._status_items.gps:use_status_enums(L1_6)
	A0_5._status_items.fire:use_status_enums(L1_6)
	A0_5._last_row = {}
	A0_5._last_row.status = A0_5:_get_nr_of_rows("status")
	A0_5._last_row.system = A0_5:_get_nr_of_rows("system")
end
function StatusPanel._set_up_hit_zones(A0_7)
	A0_7._hit_zones = {}
	A0_7._hit_zones.hull = {
		name = "hull",
		left = true,
		right = true,
		back = true,
		front = true,
		hit_size = 500
	}
	A0_7._hit_zones.turret = {
		name = "turret",
		left = true,
		right = true,
		back = true,
		front = true,
		hit_size = 100
	}
	A0_7._hit_zones.engine = {
		name = "engine",
		left = true,
		right = true,
		back = true,
		front = true,
		hit_size = 20
	}
	A0_7._hit_zones.l_gatling = {
		name = "l_gatling",
		left = true,
		back = true,
		front = true,
		hit_size = 20
	}
	A0_7._hit_zones.r_gatling = {
		name = "r_gatling",
		right = true,
		back = true,
		front = true,
		hit_size = 20
	}
	A0_7._hit_zones.l_cannon = {
		name = "l_cannon",
		left = true,
		back = true,
		front = true,
		hit_size = 40
	}
	A0_7._hit_zones.r_cannon = {
		name = "r_cannon",
		right = true,
		back = true,
		front = true,
		hit_size = 40
	}
	A0_7._hit_zones.l_track = {
		name = "l_track",
		left = true,
		back = true,
		front = true,
		hit_size = 80
	}
	A0_7._hit_zones.r_track = {
		name = "r_track",
		right = true,
		back = true,
		front = true,
		hit_size = 80
	}
	A0_7._total_hit_size = 0
	for 