local L0_0, L1_1, L2_2
L0_0 = require
L1_1 = "units/beings/WeaponMounting/WeaponMounting"
L0_0(L1_1)
L0_0 = require
L1_1 = "units/beings/WeaponMounting/WeaponMountingPointSetup"
L0_0(L1_1)
L0_0 = require
L1_1 = "units/beings/machines/walker/states/WalkerOnGround"
L0_0(L1_1)
L0_0 = require
L1_1 = "units/beings/machines/walker/states/WalkerFullyDamagedState"
L0_0(L1_1)
L0_0 = require
L1_1 = "units/beings/WeaponLogic/WeaponLogicFactory"
L0_0(L1_1)
L0_0 = require
L1_1 = "shared/FiniteStateMachine"
L0_0(L1_1)
L0_0 = require
L1_1 = "shared/updatescheduler/UpdateSchedulerDtMethod"
L0_0(L1_1)
function L0_0(A0_3, A1_4, A2_5)
	local L3_6, L4_7, L5_8, L6_9, L7_10, L8_11
	L3_6 = World
	L4_7 = L3_6
	L3_6 = L3_6.spawn_unit
	L3_6 = L3_6(L4_7, L5_8, L6_9, L7_10)
	L4_7 = L3_6.num_bodies
	L4_7 = L4_7(L5_8)
	for L8_11 = 0, L4_7 - 1 do
		L3_6:body(L8_11):set_enabled(false)
	end
	return L3_6
end
L1_1 = WalkerBase
if not L1_1 then
	L1_1 = class
	L1_1 = L1_1()
end
WalkerBase = L1_1
L1_1 = WalkerBase
L1_1._CONNECT_ALIGN_NAME = "a_weapon_left_front"
L1_1 = WalkerBase
L2_2 = {}
L2_2[Polar(1, 0, 0)] = {
	redirect = "strike_of_death_forward",
	impact_object_name = "LeftHand",
	impact_direction = Vector3(1, 0, 0)
}
L2_2[Polar(1, 0, 90)] = {
	redirect = "strike_of_death_left",
	impact_object_name = "LeftHand",
	impact_direction = Vector3(0, -1, 0)
}
L2_2[Polar(1, 0, 180)] = {
	redirect = "strike_of_death_backward",
	impact_object_name = "LeftHand",
	impact_direction = Vector3(1, 0, 0)
}
L2_2[Polar(1, 0, 270)] = {
	redirect = "strike_of_death_right",
	impact_object_name = "RightHand",
	impact_direction = Vector3(0, -1, 0)
}
L1_1._STRIKE_OF_DEATH_DIRECTIONS = L2_2
L1_1 = 0.01
L2_2 = {}
L2_2[1] = {
	min = 240,
	max = 120,
	redirects = {
		"walk_forward",
		"walk_forward_aim"
	},
	turn_redirects = {
		"walk_forward_turn",
		"walk_forward_turn_aim"
	}
}
L2_2[2] = {
	min = 135,
	max = 225,
	redirects = {
		"walk_backward",
		"walk_backward_aim"
	},
	turn_redirects = {
		"walk_backward_turn",
		"walk_backward_turn_aim"
	}
}
L2_2[3] = {
	min = 30,
	max = 150,
	redirects = {
		"walk_left",
		"walk_left_aim"
	},
	turn_redirects = {
		"walk_left_turn",
		"walk_left_turn_aim"
	}
}
L2_2[4] = {
	min = 210,
	max = 330,
	redirects = {
		"walk_right",
		"walk_right_aim"
	},
	turn_redirects = {
		"walk_right_turn",
		"walk_right_turn_aim"
	}
}
for 