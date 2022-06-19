if not PlayerManager then
	PlayerManager = class()
end
PlayerManager.init = function(l_1_0)
	l_1_0._player_units = {}
end

PlayerManager.players = function(l_2_0)
	return l_2_0._player_units
end

PlayerManager.is_unit_human_player = function(l_3_0, l_3_1)
	if not l_3_0:is_player(l_3_1) then
		return false
	end
	local l_3_2 = l_3_1
	local l_3_3, l_3_4 = l_3_0:is_human_player, l_3_0
	local l_3_5 = l_3_2
	return l_3_3(l_3_4, l_3_5)
end

PlayerManager.is_player = function(l_4_0, l_4_1)
	return l_4_0._player_units[l_4_1:key()] ~= nil
end

PlayerManager.is_human_player = function(l_5_0, l_5_1)
	local l_5_5 = assert
	local l_5_4 = l_5_0._player_units
	l_5_4 = l_5_4[l_5_1:key()]
	l_5_5(l_5_4)
	l_5_5, l_5_4 = l_5_1:control, l_5_1
	l_5_5 = l_5_5(l_5_4)
	l_5_5, l_5_4 = l_5_5:is_human_controlled, l_5_5
	local l_5_2, l_5_3 = nil
	return l_5_5(l_5_4)
end

PlayerManager.human_players = function(l_6_0)
	return TableAlgorithms.copy_if(l_6_0._player_units, function(l_7_0)
		-- upvalues: l_6_0
		local l_7_1, l_7_2 = l_6_0:is_human_player, l_6_0
		local l_7_3 = l_7_0
		return l_7_1(l_7_2, l_7_3)
  end)
end

PlayerManager.register_player_unit = function(l_7_0, l_7_1)
	l_7_0._player_units[l_7_1:key()] = l_7_1
end

PlayerManager.unregister_player_unit = function(l_8_0, l_8_1)
	l_8_0._player_units[l_8_1:key()] = nil
end

PlayerManager.distance_to_closest_human_player = function(l_9_0, l_9_1)
	return l_9_0:closest_player_info(l_9_0:human_players(), l_9_1).distance
end

PlayerManager.distance_to_closest_player = function(l_10_0, l_10_1)
	return l_10_0:closest_player_info(l_10_0:players(), l_10_1).distance
end

PlayerManager.closest_human_player = function(l_11_0, l_11_1)
	return l_11_0:closest_player_info(l_11_0:human_players(), l_11_1).player
end

PlayerManager.closest_player = function(l_12_0, l_12_1)
	return l_12_0:closest_player_info(l_12_0:players(), l_12_1).player
end

PlayerManager.closest_human_player_info = function(l_13_0, l_13_1)
	 -- WARNING: undefined locals caused missing assignments!
end

PlayerManager.closest_player_info = function(l_14_0, l_14_1, l_14_2)
	local l_14_8, l_14_9, l_14_10, l_14_11 = nil
	assert(l_14_2)
	local l_14_3, l_14_4 = nil, nil
	for i_0,i_1 in pairs(l_14_1) do
		if not l_14_3 or mvector3.distance(l_14_2, i_1:position()) < l_14_3 then
			l_14_3 = mvector3.distance(l_14_2, i_1:position())
			l_14_4 = i_1
		end
	end
	return {distance = l_14_3, player = l_14_4}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


