PlayerDifficultyLevel = PlayerDifficultyLevel or class()
function PlayerDifficultyLevel.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._unmounted_rail_vehicles = {}
end
function PlayerDifficultyLevel.set_difficulty_level(A0_2, A1_3)
	cat_print("debug", "Playing at difficulty level " .. (A1_3 or "nil"))
	A0_2._difficulty_level = A1_3
	A0_2:_apply_difficulty_level()
end
function PlayerDifficultyLevel._apply_difficulty_level(A0_4)
	local L1_5, L2_6, L3_7, L4_8, L5_9, L6_10, L7_11, L8_12
	L1_5 = A0_4._difficulty_level
	if L1_5 == 1 then
		L1_5 = tweak_data
		L2_6 = L1_5
		L1_5 = L1_5.setup_easy_difficulty
		L1_5(L2_6)
	else
		L1_5 = A0_4._difficulty_level
		if L1_5 == 2 then
			L1_5 = tweak_data
			L2_6 = L1_5
			L1_5 = L1_5.setup_medium_difficulty
			L1_5(L2_6)
		else
			L1_5 = tweak_data
			L2_6 = L1_5
			L1_5 = L1_5.setup_hard_difficulty
			L1_5(L2_6)
		end
	end
	L1_5 = tweak_data
	L1_5 = L1_5.difficulty
	L2_6 = A0_4._difficulty_level
	L1_5 = L1_5[L2_6]
	if not L1_5 then
		L1_5 = tweak_data
		L1_5 = L1_5.difficulty
		L1_5 = L1_5.default
	end
	L2_6 = A0_4._apply_damage_settings
	L2_6(L3_7, L4_8, L5_9)
	L2_6 = A0_4._unit
	L2_6 = L2_6.player_data
	L2_6 = L2_6(L3_7)
	if L3_7 then
		L6_10 = A0_4._unit
		L7_11 = L3_7
		L4_8(L5_9, L6_10, L7_11)
	end
	for L6_10, L7_11 in L3_7(L4_8) do
		L8_12 = alive
		L8_12 = L8_12(L7_11)
		if L8_12 then
			L8_12 = A0_4._unit
			if L8_12 == managers.unit_scripting:get_unit_by_name("character_slot1") then
				L8_12 = tweak_data
				L8_12 = L8_12.rail_difficulty
				L8_12 = L8_12[A0_4._difficulty_level]
				if not L8_12 then
					L8_12 = tweak_data
					L8_12 = L8_12.rail_difficulty
					L8_12 = L8_12.default
				end
				L7_11:base():apply_damage_settings(A0_4._unit, L8_12)
			end
		end
	end
end
function PlayerDifficultyLevel._apply_damage_settings(A0_13, A1_14, A2_15)
	A1_14:set_damage_multiplier(A2_15.DAMAGE_MULTIPLIER)
	A1_14:set_health_regen_multiplier(A2_15.HEALTH_REGEN_MULTIPLIER)
end
function PlayerDifficultyLevel.enter_rail(A0_16)
	A0_16:_apply_difficulty_level()
end
function PlayerDifficultyLevel.exit_rail(A0_17)
	local L1_18
	L1_18 = tweak_data
	L1_18 = L1_18.rail_difficulty
	L1_18 = L1_18.default
	if alive(A0_17._unit:player_data().on_rail_vehicle) then
		A0_17:_apply_damage_settings(A0_17._unit:player_data().on_rail_vehicle:damage(), L1_18)
	end
end
function PlayerDifficultyLevel.register_unmounted_rail_vehicle(A0_19, A1_20)
	if not TableAlgorithms.find_value(A1_20, A0_19._unmounted_rail_vehicles) then
		table.insert(A0_19._unmounted_rail_vehicles, A1_20)
		A0_19:_apply_difficulty_level()
	end
end
