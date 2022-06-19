WalkerStrikeOfDeath = WalkerStrikeOfDeath or class(WalkerState)
function WalkerStrikeOfDeath.init(A0_0)
	WalkerState.init(A0_0)
	A0_0._enemy_data = A0_0._base._enemy_data
end
function WalkerStrikeOfDeath.transition(A0_1)
	if not A0_1._enemy_data.strike_of_death then
		return WalkerOnGround
	end
end
