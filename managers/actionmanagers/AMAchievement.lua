AMAchievement = AMAchievement or class(CoreActionElement)
function AMAchievement.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMAchievement.activate_now(A0_3)
	local L1_4, L2_5, L3_6, L4_7, L5_8, L6_9
	L1_4 = SystemInfo
	L1_4 = L1_4.platform
	L1_4 = L1_4(L2_5)
	if L1_4 == "PS3" then
		L1_4 = managers
		L1_4 = L1_4.save
		L1_4 = L1_4.primary_user
		L1_4 = L1_4(L2_5)
		L2_5(L3_6, L4_7)
	else
		L1_4 = managers
		L1_4 = L1_4.local_user
		L1_4 = L1_4.users
		L1_4 = L1_4(L2_5)
		for L5_8, L6_9 in L2_5(L3_6) do
			if L6_9:wanted_player_slot_id() then
				A0_3:_check_award_achievement(L6_9)
			end
		end
	end
	L1_4 = A0_3.deactivate_now
	L1_4(L2_5)
end
function AMAchievement._check_award_achievement(A0_10, A1_11)
	local L2_12, L3_13
	L3_13 = A1_11
	L2_12 = A1_11.profile
	L2_12 = L2_12(L3_13)
	L3_13 = L2_12.difficulty_level
	if not A0_10.difficulties[L3_13] then
		cat_print("debug", "Achievement " .. A0_10.achievement_id .. " failed difficulty check for user " .. A1_11:user_index())
		return
	end
	if not A0_10:_check_difficulty(L2_12.levels, L2_12.current_level_id, L3_13) then
		cat_print("debug", "Achievement " .. A0_10.achievement_id .. " failed difficulty check 2 for user " .. A1_11:user_index())
		return
	end
	A0_10:_award_achievement(A1_11)
end
function AMAchievement._check_difficulty(A0_14, A1_15, A2_16, A3_17)
	local L4_18, L5_19, L6_20, L8_21, L9_22, L10_23, L11_24, L13_25
	for L8_21 = A2_16, 1, -1 do
		L9_22 = A1_15[L8_21]
		for _FORV_12_ = 1, L9_22.maximum_checkpoint_id do
			for 