AiCoverManager = AiCoverManager or class()
AI_DISTANCE_TO_COVER = tweak_data.player.cover.DISTANCE_TO
function AiCoverManager.init(A0_0)
	local L1_1
	L1_1 = {}
	A0_0._reserved_world = L1_1
	L1_1 = {}
	A0_0._reserved_covers = L1_1
	L1_1 = {}
	A0_0._player_reserved_covers = L1_1
	A0_0._all_covers = nil
end
function AiCoverManager.reserve_cover(A0_2, A1_3, A2_4, A3_5)
	local L4_6
	L4_6 = {}
	L4_6.position = A2_4
	L4_6.radius = A3_5
	if A0_2._reserved_world[A1_3] then
		A0_2:_release_cover_space(A1_3)
	end
	A0_2._reserved_world[A1_3] = L4_6
	A0_2:_reserve_cover_space(A1_3, L4_6)
	A0_2:_sort_reserved_cover_infos()
end
function AiCoverManager.release_cover(A0_7, A1_8)
	if A0_7._reserved_world[A1_8] then
		A0_7:_release_cover_space(A1_8)
		A0_7._reserved_world[A1_8] = nil
	end
end
function AiCoverManager.get_reserved_position(A0_9, A1_10)
	local L2_11, L3_12
	L2_11 = A0_9._reserved_world
	L2_11 = L2_11[A1_10]
	if L2_11 then
		L3_12 = L2_11.position
		return L3_12
	end
	L3_12 = nil
	return L3_12
end
function AiCoverManager.anyone_else_at_cover(A0_13, A1_14, A2_15)
	local L3_16
	L3_16 = A0_13._reserved_covers
	L3_16 = L3_16[A2_15:key()]
	if not L3_16 then
		return false
	end
	for 