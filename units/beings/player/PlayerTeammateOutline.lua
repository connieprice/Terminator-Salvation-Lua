if not PlayerTeammateOutline then
	PlayerTeammateOutline = class()
end
PlayerTeammateOutline.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._next_scan_time = 0
	l_1_0._unit_outline_list = {}
	l_1_0._player_data = l_1_0._unit:player_data()
	l_1_0._unit_highlighter = World:unit_manager():unit_highlighter()
	l_1_0._unit_highlighter:add_config("t_contour_highlight", "t_contour_highlight", "t_contour_highlight_skinned_2w", "t_contour_highlight_skinned_3w", "t_contour_highlight_skinned_4w", "t_contour_highlight")
	l_1_0._unit_highlighter:set_name_filter("t_contour_highlight", "g_*", "lod*")
end

PlayerTeammateOutline.destroy = function(l_2_0)
	l_2_0:clean_up()
end

PlayerTeammateOutline.clean_up = function(l_3_0)
	local l_3_4, l_3_5, l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11 = nil
	for i_0,i_1 in pairs(l_3_0._unit_outline_list) do
		if alive(i_0) and alive(i_1.vp) then
			l_3_0._unit_highlighter:remove_unit(i_0, i_1.vp)
		end
	end
end

PlayerTeammateOutline.update = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_7, l_4_8, l_4_9, l_4_13, l_4_15, l_4_17, l_4_38, l_4_42, l_4_44, l_4_46 = nil
	if not tweak_data.player.teammate_outline.active then
		return 
	end
	if l_4_0._next_scan_time < l_4_2 then
		for i_0,i_1 in pairs(l_4_0._unit_outline_list) do
			local l_4_16, l_4_37, l_4_39, l_4_40, l_4_41, l_4_43, l_4_45 = l_4_0._unit_outline_list[i_0]
			l_4_16.show = false
		end
		l_4_0._player_data.teammate_with_visible_names = {}
		if managers.user_viewport:get_engine_viewport_for_unit(l_4_0._unit) then
			for i_0,i_1 in pairs(managers.player:players()) do
				if (tweak_data.player.teammate_outline.min_dist < i_1:position() - l_4_0._unit:position():length() and i_1:position() - l_4_0._unit:position():length() < tweak_data.player.teammate_outline.max_dist) or i_1:drama() then
					local l_4_25, l_4_27, l_4_30 = , not alive(i_1), i_1:drama():is_speaking()
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				local l_4_32 = nil
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				if alive(l_4_32) and l_4_32 ~= l_4_0._unit and l_4_27 and (l_4_30 or not l_4_0._player_data.is_precision_aiming or not alive(l_4_0._player_data.aim_target_unit) or l_4_0._player_data.aim_target_unit == l_4_21 or managers.player:is_human_player(l_4_21)) and (not l_4_0._unit_outline_list[l_4_32] or not l_4_0._unit_outline_list[l_4_32].show) then
					local l_4_33 = nil
					local l_4_34 = nil
					l_4_0._unit_outline_list[l_4_32] = {show = true, vp = managers.user_viewport:get_engine_viewport_for_unit(l_4_0._unit)}
					l_4_0._unit_highlighter:add_unit(l_4_32, "t_contour_highlight", managers.user_viewport:get_engine_viewport_for_unit(l_4_0._unit))
					l_4_0._player_data.teammate_with_visible_names[l_4_32] = true
				end
			end
		end
		for i_0,i_1 in pairs(l_4_0._unit_outline_list) do
			if i_1.show == false then
				if alive(i_0) then
					l_4_0._unit_highlighter:remove_unit(i_0, i_1.vp)
				end
				l_4_0._unit_outline_list[i_0] = nil
			end
		end
		l_4_0._next_scan_time = l_4_2 + tweak_data.player.teammate_outline.update_frequency
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


