PlayerManager = PlayerManager or class()
function PlayerManager.init(A0_0)
	A0_0._player_units = {}
end
function PlayerManager.players(A0_1)
	local L1_2
	L1_2 = A0_1._player_units
	return L1_2
end
function PlayerManager.is_unit_human_player(A0_3, A1_4)
	local L2_5
	L2_5 = A0_3.is_player
	L2_5 = L2_5(A0_3, A1_4)
	if not L2_5 then
		L2_5 = false
		return L2_5
	end
	L2_5 = A1_4
	return A0_3:is_human_player(L2_5)
end
function PlayerManager.is_player(A0_6, A1_7)
	local L2_8
	L2_8 = A0_6._player_units
	L2_8 = L2_8[A1_7:key()]
	L2_8 = L2_8 ~= nil
	return L2_8
end
function PlayerManager.is_human_player(A0_9, A1_10)
	assert(A0_9._player_units[A1_10:key()])
	return A1_10:control():is_human_controlled()
end
function PlayerManager.human_players(A0_11)
	return (TableAlgorithms.copy_if(A0_11._player_units, function(A0_12)
		return _UPVALUE0_:is_human_player(A0_12)
	end))
end
function PlayerManager.register_player_unit(A0_13, A1_14)
	A0_13._player_units[A1_14:key()] = A1_14
end
function PlayerManager.unregister_player_unit(A0_15, A1_16)
	A0_15._player_units[A1_16:key()] = nil
end
function PlayerManager.distance_to_closest_human_player(A0_17, A1_18)
	return A0_17:closest_player_info(A0_17:human_players(), A1_18).distance
end
function PlayerManager.distance_to_closest_player(A0_19, A1_20)
	return A0_19:closest_player_info(A0_19:players(), A1_20).distance
end
function PlayerManager.closest_human_player(A0_21, A1_22)
	return A0_21:closest_player_info(A0_21:human_players(), A1_22).player
end
function PlayerManager.closest_player(A0_23, A1_24)
	return A0_23:closest_player_info(A0_23:players(), A1_24).player
end
function PlayerManager.closest_human_player_info(A0_25, A1_26)
end
function PlayerManager.closest_player_info(A0_27, A1_28, A2_29)
	local L3_30, L4_31
	L3_30 = assert
	L4_31 = A2_29
	L3_30(L4_31)
	L3_30, L4_31 = nil, nil
	for 