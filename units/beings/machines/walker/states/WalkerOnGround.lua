require("units/beings/machines/walker/states/WalkerState")
require("units/beings/machines/walker/states/WalkerReachingForTarget")
require("units/beings/machines/walker/states/WalkerRequestingStun")
require("units/beings/machines/walker/states/WalkerStrikeOfDeath")
require("units/beings/machines/states/StunState")
if not WalkerOnGround then
	WalkerOnGround = class(WalkerState)
end
WalkerOnGround.init = function(l_1_0)
	WalkerState.init(l_1_0)
	local l_1_1 = l_1_0._unit
	l_1_0._enemy_data = l_1_1:enemy_data()
	l_1_0._input = l_1_1:input()
end

WalkerOnGround.update = function(l_2_0, l_2_1)
	local l_2_2 = l_2_0._input
	local l_2_3 = l_2_0._base
	local l_2_4 = l_2_2:special_kill_target()
	if l_2_4 then
		local l_2_5 = l_2_2:special_kill_id()
		l_2_3:special_kill(l_2_5, l_2_4, l_2_2:special_kill_position(), l_2_2:special_kill_rotation())
		return 
	end
	local l_2_6 = l_2_2:strike_of_death_direction()
	if l_2_6 then
		local l_2_7 = l_2_2:strike_of_death_target()
		local l_2_8 = l_2_0:_strike_of_death_setup(l_2_6)
		l_2_0._unit:play_redirect(l_2_8.redirect)
		l_2_3._strike_of_death_setup = l_2_8
		l_2_3._strike_of_death_target = l_2_7
	end
end

WalkerOnGround.transition = function(l_3_0)
	local l_3_1 = l_3_0._base:check_fully_damaged()
	if l_3_1 then
		return l_3_1
	end
	local l_3_2 = l_3_0._enemy_data
	if l_3_2.reaching_for_target or l_3_2.reached_target then
		assert(l_3_0._base._special_kill_target)
		assert(l_3_0._base._special_kill_setup)
		return WalkerReachingForTarget
	elseif l_3_2.stun_requested then
		return WalkerRequestingStun
	elseif l_3_2.strike_of_death then
		return WalkerStrikeOfDeath
	end
end

WalkerOnGround._strike_of_death_setup = function(l_4_0, l_4_1)
	local l_4_8, l_4_9, l_4_10, l_4_11, l_4_12 = nil
	local l_4_2 = (l_4_1:to_polar_with_reference(l_4_0._unit:rotation():y(), math.UP))
	local l_4_3, l_4_4 = nil, nil
	for i_0,i_1 in pairs(WalkerBase._STRIKE_OF_DEATH_DIRECTIONS) do
		if not l_4_3 or math.abs(i_0 - l_4_2.spin) < l_4_4 then
			l_4_3 = i_1
			l_4_4 = math.abs(i_0 - l_4_2.spin)
		end
	end
	return l_4_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


