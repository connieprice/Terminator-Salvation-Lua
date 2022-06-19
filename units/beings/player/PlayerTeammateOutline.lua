PlayerTeammateOutline = PlayerTeammateOutline or class()
function PlayerTeammateOutline.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._next_scan_time = 0
	A0_0._unit_outline_list = {}
	A0_0._player_data = A0_0._unit:player_data()
	A0_0._unit_highlighter = World:unit_manager():unit_highlighter()
	A0_0._unit_highlighter:add_config("t_contour_highlight", "t_contour_highlight", "t_contour_highlight_skinned_2w", "t_contour_highlight_skinned_3w", "t_contour_highlight_skinned_4w", "t_contour_highlight")
	A0_0._unit_highlighter:set_name_filter("t_contour_highlight", "g_*", "lod*")
end
function PlayerTeammateOutline.destroy(A0_2)
	A0_2:clean_up()
end
function PlayerTeammateOutline.clean_up(A0_3)
	local L1_4, L2_5, L3_6, L4_7
	for L4_7, 