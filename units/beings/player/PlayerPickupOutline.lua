PlayerPickupOutline = PlayerPickupOutline or class()
function PlayerPickupOutline.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._next_scan_time = 0
	A0_0._unit_outline_list = {}
	A0_0._unit_highlighter = World:unit_manager():unit_highlighter()
	A0_0._unit_highlighter:add_config("p_contour_highlight", "p_contour_highlight", "p_contour_highlight_skinned_2w", "p_contour_highlight_skinned_3w", "p_contour_highlight_skinned_4w", "p_contour_highlight")
	A0_0._unit_highlighter:set_name_filter("p_contour_highlight", "g_*")
end
function PlayerPickupOutline.destroy(A0_2)
	A0_2:clean_up()
end
function PlayerPickupOutline.clean_up(A0_3)
	local L1_4, L2_5, L3_6, L4_7
	for L4_7, 