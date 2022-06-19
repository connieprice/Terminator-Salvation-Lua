if not PlayerDifficultyLevel then
	PlayerDifficultyLevel = class()
end
PlayerDifficultyLevel.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._unmounted_rail_vehicles = {}
end

PlayerDifficultyLevel.set_difficulty_level = function(l_2_0, l_2_1)
	local l_2_2 = cat_print
	local l_2_3 = "debug"
	local l_2_4 = "Playing at difficulty level "
	do
		l_2_4 = l_2_4 .. (l_2_1 or "nil")
		l_2_2(l_2_3, l_2_4)
		l_2_0._difficulty_level = l_2_1
		l_2_2, l_2_3 = l_2_0:_apply_difficulty_level, l_2_0
		l_2_2(l_2_3)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PlayerDifficultyLevel._apply_difficulty_level = function(l_3_0)
	if l_3_0._difficulty_level == 1 then
		tweak_data:setup_easy_difficulty()
	elseif l_3_0._difficulty_level == 2 then
		tweak_data:setup_medium_difficulty()
	else
		tweak_data:setup_hard_difficulty()
	end
	if not tweak_data.difficulty[l_3_0._difficulty_level] then
		local l_3_1, l_3_2, l_3_3 = tweak_data.difficulty.default
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_3_0:_apply_damage_settings(l_3_0._unit:damage(), l_3_1)
	do
		local l_3_4 = nil
		if alive(l_3_0._unit:player_data().on_rail_vehicle) then
			if not tweak_data.rail_difficulty[l_3_0._difficulty_level] then
				local l_3_5, l_3_6 = , tweak_data.rail_difficulty.default
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			local l_3_10, l_3_12, l_3_14, l_3_17 = , l_3_5.on_rail_vehicle:base():apply_damage_settings, l_3_5.on_rail_vehicle:base()
			local l_3_11, l_3_13, l_3_15, l_3_18 = l_3_0._unit, l_3_12
			l_3_14(l_3_17, l_3_11, l_3_13)
		end
		for i_0,i_1 in pairs(l_3_0._unmounted_rail_vehicles) do
			local l_3_7 = nil
			end
			if alive(i_1) and l_3_0._unit == managers.unit_scripting:get_unit_by_name("character_slot1") then
				if not tweak_data.rail_difficulty[l_3_0._difficulty_level] then
					i_1:base():apply_damage_settings(l_3_0._unit, tweak_data.rail_difficulty.default)
				end
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 83 
end

PlayerDifficultyLevel._apply_damage_settings = function(l_4_0, l_4_1, l_4_2)
	l_4_1:set_damage_multiplier(l_4_2.DAMAGE_MULTIPLIER)
	l_4_1:set_health_regen_multiplier(l_4_2.HEALTH_REGEN_MULTIPLIER)
end

PlayerDifficultyLevel.enter_rail = function(l_5_0)
	l_5_0:_apply_difficulty_level()
end

PlayerDifficultyLevel.exit_rail = function(l_6_0)
	local l_6_1 = tweak_data.rail_difficulty.default
	local l_6_2 = l_6_0._unit:player_data()
	if alive(l_6_2.on_rail_vehicle) then
		l_6_0:_apply_damage_settings(l_6_2.on_rail_vehicle:damage(), l_6_1)
	end
end

PlayerDifficultyLevel.register_unmounted_rail_vehicle = function(l_7_0, l_7_1)
	if not TableAlgorithms.find_value(l_7_1, l_7_0._unmounted_rail_vehicles) then
		table.insert(l_7_0._unmounted_rail_vehicles, l_7_1)
		l_7_0:_apply_difficulty_level()
	end
end


