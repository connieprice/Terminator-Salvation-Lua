if not PlayerEnemyWeakspotOutline then
	PlayerEnemyWeakspotOutline = class()
end
PlayerEnemyWeakspotOutline.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._outlined_unit = nil
	l_1_0._outlined_obj = nil
	l_1_0._outlined_vp = nil
	l_1_0._slotmask_enemies = managers.slot:get_mask("enemies")
	l_1_0._damage_weakspot_objs = nil
	l_1_0._next_scan_time = 0
	l_1_0._player_data = l_1_0._unit:player_data()
	l_1_0._unit_highlighter = World:unit_manager():unit_highlighter()
	l_1_0._unit_highlighter:add_config("e_contour_highlight", "e_contour_highlight", "e_contour_highlight_skinned_2w", "e_contour_highlight_skinned_3w", "e_contour_highlight_skinned_4w", "e_contour_highlight")
	l_1_0._unit_highlighter:set_config_name_filter("e_contour_highlight", "g_outline*")
	l_1_0._full_name_filter = false
	l_1_0._enemy = nil
end

PlayerEnemyWeakspotOutline.destroy = function(l_2_0)
	l_2_0:clean_up()
end

PlayerEnemyWeakspotOutline.clean_up = function(l_3_0)
	local l_3_5, l_3_7 = nil
	if alive(l_3_0._outlined_unit) and l_3_0._outlined_vp then
		local l_3_4, l_3_6 = l_3_0._unit_highlighter:remove_unit, l_3_0._unit_highlighter
		l_3_4(l_3_6, l_3_0._outlined_unit, l_3_0._outlined_vp)
	end
	if l_3_0._damage_weakspot_objs then
		for i_0,i_1 in pairs(l_3_0._damage_weakspot_objs) do
			i_1:set_visibility(false)
		end
	end
end

PlayerEnemyWeakspotOutline.update = function(l_4_0, l_4_1, l_4_2, l_4_3)
	if not tweak_data.player.enemy_outline.active then
		return 
	end
	if l_4_0._enemy then
		local l_4_4, l_4_6, l_4_7, l_4_9 = not alive(l_4_0._enemy)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_4_0._next_scan_time < l_4_2 or l_4_4 or l_4_0._enemy ~= l_4_0._player_data.aim_target_unit then
		l_4_0._damage_weakspot_objs = nil
		l_4_0._enemy = nil
		local l_4_11, l_4_12 = nil
		local l_4_13 = nil
		local l_4_14 = nil
		if alive(l_4_0._unit:base():current_weapon()) then
			local l_4_15 = false
		end
		do
			local l_4_16 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if ((not l_4_0._player_data.is_precision_aiming and not l_4_0._player_data.on_rail_vehicle and not l_4_0._player_data._in_stationary_weapon) or not alive(l_4_0._player_data.aim_target_unit) or not l_4_0._player_data.aim_target_unit:in_slot(l_4_0._slotmask_enemies) or not l_4_0._player_data.aim_target_unit:enemy_data() or (l_4_0._player_data.aim_target_unit:enemy_data().only_outline_by_full_weapon and l_4_0._player_data.aim_target_unit:enemy_data().only_outline_by_full_weapon and not l_4_0._unit:base():current_weapon():weapon_data()._full_outline_weapon) or (not l_4_0._player_data.aim_target_unit:damage() or l_4_0._player_data.aim_target_unit:damage():can_die())) then
				l_4_0._enemy = l_4_0._player_data.aim_target_unit
				local l_4_17 = nil
				 -- DECOMPILER ERROR: Confused about usage of registers!

				local l_4_18 = nil
				if (l_4_0._player_data.aim_target_unit:enemy_data() and l_4_0._player_data.aim_target_unit:enemy_data().full_outline_by_deafult) or l_4_16 then
					if not l_4_0._full_name_filter then
						l_4_0._unit_highlighter:set_config_name_filter("e_contour_highlight", "g_*")
					end
					 -- DECOMPILER ERROR: Confused about usage of registers!

				end
			elseif l_4_0._full_name_filter then
				l_4_0._unit_highlighter:set_config_name_filter("e_contour_highlight", "g_outline*")
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if alive(l_4_0._player_data.aim_target_body) then
				local l_4_19 = nil
				 -- DECOMPILER ERROR: Confused about usage of registers!

				if not l_4_16 and tweak_data.player.enemy_outline.min_dist < l_4_0._player_data.aim_target_body:position() - l_4_0._unit:position():length() and l_4_0._player_data.aim_target_body:position() - l_4_0._unit:position():length() < tweak_data.player.enemy_outline.max_dist and l_4_19:damage() then
					local l_4_52, l_4_53, l_4_54, l_4_55, l_4_56, l_4_57 = , l_4_19:damage():check_outline_weakspot, l_4_19:damage()
					l_4_56 = l_4_56(l_4_57, l_4_0._player_data.aim_target_body:name())
				end
				end
				l_4_0._damage_weakspot_objs = l_4_56
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Overwrote pending register.

			if l_4_0._damage_weakspot_objs then
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

			if #l_4_0._damage_weakspot_objs > 1 then
				end
			else
				l_4_14 = l_4_0._damage_weakspot_objs[1]
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if not alive(l_4_13) or not alive(l_4_0._outlined_unit) or l_4_13 ~= l_4_0._outlined_unit or not l_4_16 and not alive(l_4_14) or not alive(l_4_0._outlined_obj) or l_4_14 ~= l_4_0._outlined_obj then
				if l_4_0._damage_weakspot_objs then
					for i_0,i_1 in pairs(l_4_0._damage_weakspot_objs) do
						local l_4_49, l_4_50, l_4_51 = nil
						if alive(i_1) then
							i_1:set_visibility(false)
						end
					end
				end
				if alive(l_4_0._outlined_unit) and l_4_0._outlined_vp then
					l_4_0._unit_highlighter:remove_unit(l_4_0._outlined_unit, l_4_0._outlined_vp)
				end
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if not alive(l_4_13) or not alive(l_4_0._outlined_unit) or l_4_13 ~= l_4_0._outlined_unit and (l_4_51 or not alive(l_4_14) or not alive(l_4_0._outlined_obj) or l_4_14 ~= l_4_0._outlined_obj) then
				local l_4_69 = nil
			if managers.user_viewport:get_engine_viewport_for_unit(l_4_0._unit) then
				end
				local l_4_73 = nil
				local l_4_74 = nil
				l_4_0._unit_highlighter:add_unit(l_4_69, "e_contour_highlight", managers.user_viewport:get_engine_viewport_for_unit(l_4_0._unit))
				if l_4_0._damage_weakspot_objs then
					for i_0,i_1 in pairs(l_4_0._damage_weakspot_objs) do
						local l_4_70, l_4_71, l_4_72 = nil
						i_1:set_visibility(true)
					end
				end
				l_4_0._outlined_unit = l_4_69
				l_4_0._outlined_obj = (not l_4_74 and l_4_73)
				l_4_0._outlined_vp = managers.user_viewport:get_engine_viewport_for_unit(l_4_0._unit)
			end
			if alive(l_4_0._outlined_unit) then
				l_4_0._player_data.weakspot_outline_object = l_4_0._outlined_unit
			end
			l_4_0._next_scan_time = l_4_2 + tweak_data.player.enemy_outline.update_frequency
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


