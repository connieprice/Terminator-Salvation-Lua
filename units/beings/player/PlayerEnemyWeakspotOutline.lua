PlayerEnemyWeakspotOutline = PlayerEnemyWeakspotOutline or class()
function PlayerEnemyWeakspotOutline.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._outlined_unit = nil
	A0_0._outlined_obj = nil
	A0_0._outlined_vp = nil
	A0_0._slotmask_enemies = managers.slot:get_mask("enemies")
	A0_0._damage_weakspot_objs = nil
	A0_0._next_scan_time = 0
	A0_0._player_data = A0_0._unit:player_data()
	A0_0._unit_highlighter = World:unit_manager():unit_highlighter()
	A0_0._unit_highlighter:add_config("e_contour_highlight", "e_contour_highlight", "e_contour_highlight_skinned_2w", "e_contour_highlight_skinned_3w", "e_contour_highlight_skinned_4w", "e_contour_highlight")
	A0_0._unit_highlighter:set_config_name_filter("e_contour_highlight", "g_outline*")
	A0_0._full_name_filter = false
	A0_0._enemy = nil
end
function PlayerEnemyWeakspotOutline.destroy(A0_2)
	A0_2:clean_up()
end
function PlayerEnemyWeakspotOutline.clean_up(A0_3)
	if alive(A0_3._outlined_unit) and A0_3._outlined_vp then
		A0_3._unit_highlighter:remove_unit(A0_3._outlined_unit, A0_3._outlined_vp)
	end
	if A0_3._damage_weakspot_objs then
		for 