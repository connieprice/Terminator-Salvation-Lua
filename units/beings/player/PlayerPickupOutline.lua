if not PlayerPickupOutline then
	PlayerPickupOutline = class()
end
PlayerPickupOutline.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._next_scan_time = 0
	l_1_0._unit_outline_list = {}
	l_1_0._unit_highlighter = World:unit_manager():unit_highlighter()
	l_1_0._unit_highlighter:add_config("p_contour_highlight", "p_contour_highlight", "p_contour_highlight_skinned_2w", "p_contour_highlight_skinned_3w", "p_contour_highlight_skinned_4w", "p_contour_highlight")
	l_1_0._unit_highlighter:set_name_filter("p_contour_highlight", "g_*")
end

PlayerPickupOutline.destroy = function(l_2_0)
	l_2_0:clean_up()
end

PlayerPickupOutline.clean_up = function(l_3_0)
	local l_3_4, l_3_5, l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11 = nil
	for i_0,i_1 in pairs(l_3_0._unit_outline_list) do
		if alive(i_0) and alive(i_1.vp) then
			l_3_0._unit_highlighter:remove_unit(i_0, i_1.vp)
		end
	end
end

PlayerPickupOutline.update = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_7, l_4_8, l_4_9 = nil
	if not tweak_data.player.pickup_outline.active then
		return 
	end
	if l_4_0._next_scan_time < l_4_2 then
		for i_0,i_1 in pairs(l_4_0._unit_outline_list) do
			l_4_0._unit_outline_list[i_0].show = false
		end
		local l_4_12 = l_4_0._unit:position()
		local l_4_13 = tweak_data.player.pickup_outline.max_range
		 -- DECOMPILER ERROR: Overwrote pending register.

		if managers.user_viewport:get_engine_viewport_for_unit(l_4_12) then
			for i_0,i_1 in pairs(l_4_12) do
				if alive(l_4_11) and l_4_11:interact() and l_4_11:interact():can_interact_with_player(l_4_0._unit) then
					local l_4_14 = l_4_11:position() - l_4_0._unit:position():length()
				if tweak_data.player.pickup_outline.min_range < l_4_14 then
					end
				if not l_4_0._unit_outline_list[l_4_11] or not l_4_0._unit_outline_list[l_4_11].show then
					end
					local l_4_15 = l_4_0._unit_outline_list
					local l_4_16 = {}
					l_4_16.show = true
					l_4_16.vp = managers.user_viewport:get_engine_viewport_for_unit(l_4_12)
					l_4_15[l_4_11] = l_4_16
					l_4_15 = l_4_0._unit_highlighter
					l_4_15, l_4_16 = l_4_15:add_unit, l_4_15
					l_4_15(l_4_16, l_4_11, "p_contour_highlight", managers.user_viewport:get_engine_viewport_for_unit(l_4_12))
				end
			end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0,i_1 in pairs(l_4_12) do
			if i_1.show == false then
				if alive(i_0) then
					l_4_0._unit_highlighter:remove_unit(i_0, i_1.vp)
				end
				l_4_0._unit_outline_list[i_0] = nil
			end
		end
		l_4_0._next_scan_time = l_4_2 + tweak_data.player.pickup_outline.update_frequency
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


