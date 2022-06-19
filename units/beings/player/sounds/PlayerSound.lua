require("units/sound/FootstepSound")
if not PlayerSound then
	PlayerSound = class()
end
PlayerSound.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	local l_1_2 = {}
	l_1_2.left = "LeftToeBase"
	l_1_2.right = "RightToeBase"
	l_1_0._footstep_sound = FootstepSound:new(l_1_1, l_1_2)
	managers.action_event:register_listener(l_1_0, l_1_1, l_1_1)
end

PlayerSound.destroy = function(l_2_0)
	managers.action_event:unregister_listener(l_2_0)
end

PlayerSound.unit_footstep = function(l_3_0, l_3_1, l_3_2, l_3_3)
	l_3_0._footstep_sound:footstep(l_3_2, l_3_3)
end


