require("units/beings/player_tank/gui/MachineHudPanel")
OutlineHandler = OutlineHandler or class(MachineHudPanel)
function OutlineHandler.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._outline_units = {}
	A0_0._unit_highlighter = World:unit_manager():unit_highlighter()
	A0_0._unit_highlighter:set_name_filter("g_*", "gfx_*")
	A0_0._unit_highlighter:add_config("contour_highlight", "contour_highlight", "contour_highlight_skinned_2w", "contour_highlight_skinned_3w", "contour_highlight_skinned_4w", "contour_highlight")
	A0_0._startup_time = Application:time() + 3
	A0_0._viewport = managers.user_viewport:get_engine_viewport_for_unit(A0_0._unit)
	A0_0._dt_since_last_update = 0
	A0_0._next_update_time = 0
end
function OutlineHandler.shutdown(A0_2, A1_3, A2_4)
	local L3_5, L4_6, L5_7, L6_8
	for L6_8, 