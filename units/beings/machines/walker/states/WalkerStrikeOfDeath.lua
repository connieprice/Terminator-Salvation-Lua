if not WalkerStrikeOfDeath then
	WalkerStrikeOfDeath = class(WalkerState)
end
WalkerStrikeOfDeath.init = function(l_1_0)
	WalkerState.init(l_1_0)
	l_1_0._enemy_data = l_1_0._base._enemy_data
end

WalkerStrikeOfDeath.transition = function(l_2_0)
	if not l_2_0._enemy_data.strike_of_death then
		return WalkerOnGround
	end
end


