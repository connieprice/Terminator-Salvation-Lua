require("units/beings/player/states/PlayerMovementState.lua")
require("shared/InterpolatorLinear")
require("shared/Angle")
if not PlayerConnected then
	PlayerConnected = class(PlayerMovementState)
end
PlayerConnected.init = function(l_1_0, l_1_1)
	PlayerMovementState.init(l_1_0, l_1_1, "PlayerDead")
	l_1_0._unit = l_1_1
	l_1_1:kill_mover()
	l_1_0._unit:anim_state_machine():play("weapon_pose/idle")
	managers.drama_scene:stop_scene()
end

PlayerConnected.update = function(l_2_0, l_2_1, l_2_2)
	if l_2_0._unit:player_data().kill then
		l_2_0._unit:damage():set_fully_damaged()
		local l_2_3, l_2_4 = PlayerDead:new, PlayerDead
		local l_2_5 = l_2_0._unit
		return l_2_3(l_2_4, l_2_5)
	end
end


