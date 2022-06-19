require("units/sound/FootstepSound")
PlayerSound = PlayerSound or class()
function PlayerSound.init(A0_0, A1_1)
	local L2_2
	A0_0._unit = A1_1
	L2_2 = {}
	L2_2.left = "LeftToeBase"
	L2_2.right = "RightToeBase"
	A0_0._footstep_sound = FootstepSound:new(A1_1, L2_2)
	managers.action_event:register_listener(A0_0, A1_1, A1_1)
end
function PlayerSound.destroy(A0_3)
	managers.action_event:unregister_listener(A0_3)
end
function PlayerSound.unit_footstep(A0_4, A1_5, A2_6, A3_7)
	A0_4._footstep_sound:footstep(A2_6, A3_7)
end
