if not WalkerTweakData then
	WalkerTweakData = class()
end
local l_0_0 = WalkerTweakData
local l_0_1 = {}
local l_0_2 = {}
l_0_2.id = "special_kill_1"
l_0_2.target_position = Vector3(0, 120, 0)
l_0_2.target_position_tolerance = Vector3(20, 20, 20)
l_0_2.target_yaw = 180
l_0_2.target_yaw_tolerance = 90
l_0_2.reach_redirect = "reach_for_target"
l_0_2.redirect = "special_kill_1"
l_0_2.target_redirect = "walker_special_kill_1"
l_0_2.target_object_name = "a_neck_grip"
l_0_2.target_in_cover = false
local l_0_3 = {}
l_0_3.id = "special_kill_in_cover"
l_0_3.target_position = Vector3(0, 120, 0)
l_0_3.target_position_tolerance = Vector3(20, 20, 20)
l_0_3.target_yaw = 180
l_0_3.target_yaw_tolerance = 90
l_0_3.reach_redirect = "reach_for_target_in_cover"
l_0_3.redirect = "special_kill_in_cover"
l_0_3.target_redirect = "walker_special_kill_in_cover"
l_0_3.target_object_name = "a_neck_grip"
l_0_3.target_in_cover = true
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

l_0_0.SPECIAL_KILL_SETUPS = l_0_1
l_0_0 = WalkerTweakData
l_0_0.DOWN_TIME = 1
l_0_0 = WalkerTweakData
l_0_0.MAGCHARGE_DETACH_TIME = 10
l_0_0 = WalkerTweakData
l_0_0.MOVEMENT_SPEED = 2
l_0_0 = WalkerTweakData
l_0_0.STUN_TIME = 3
l_0_0 = WalkerTweakData
l_0_0.HEAD_STUN_MAX_HEALTH = 30
l_0_0 = WalkerTweakData
l_0_0.HEAD_STUN_HEALTH_PER_SECOND = 5
l_0_0 = WalkerTweakData
l_0_0.CHEST_STUN_MAX_HEALTH = 250
l_0_0 = WalkerTweakData
l_0_0.CHEST_STUN_HEALTH_PER_SECOND = 2
l_0_0 = WalkerTweakData
l_0_0.EXECUTION_ATTACKER_TO_TARGET_DISTANCE = 2000
l_0_0 = WalkerTweakData
l_0_0.EXECUTION_MAX_CLUSTER_DISTANCE = 1500
l_0_0 = WalkerTweakData
l_0_0.EXECUTION_TARGET_TO_FRIENDS_DISTANCE = 500
l_0_0 = WalkerTweakData
l_0_0.EXECUTION_TARGET_TO_FRIENDS_NUMBER_OF_FRIENDS = 2
l_0_0 = WalkerTweakData
l_0_0.EXECUTION_MAX_DEPTH = 160
l_0_0 = WalkerTweakData
l_0_0.EXECUTION_MAX_HEIGHT_DIFFERENCE = 50
l_0_0 = WalkerTweakData
l_0_0.EXECUTION_MAX_DESTINATION_OFFSET = 50
l_0_0 = WalkerTweakData
l_0_0.EXECUTION_MIN_TIME = 2
l_0_0 = WalkerTweakData
l_0_0.EXECUTION_MAX_TRAVEL_LENGTH = 3000
l_0_0 = WalkerTweakData
l_0_1 = WalkerTweakData
l_0_1 = l_0_1.EXECUTION_MAX_DEPTH
l_0_1 = l_0_1 + 110
l_0_0.EXECUTION_MAX_DISTANCE = l_0_1
l_0_0 = WalkerTweakData
l_0_0.EXECUTION_MIN_DISTANCE = 120
l_0_0 = WalkerTweakData
l_0_1 = WalkerTweakData
l_0_1 = l_0_1.EXECUTION_MAX_DISTANCE
l_0_1 = l_0_1 + 300
l_0_0.EXECUTION_BEGIN_AIMING_DISTANCE = l_0_1
l_0_0 = WalkerTweakData
l_0_0.EXECUTION_UPDATE_PATH_DISTANCE = 50
l_0_0 = WalkerTweakData
l_0_0.EXECUTION_TIMEOUT = 30
l_0_0 = WalkerTweakData
l_0_0.EXECUTION_BEHIND_COVER_DISTANCE = 100
l_0_0 = WalkerTweakData
l_0_0.MIN_EXECUTION_AREA_FIRE_DOT = 0.8
l_0_0 = WalkerTweakData
l_0_0.MOVE_TO_LOOK_AT_HEIGHT = 150
l_0_0 = WalkerTweakData
l_0_0.STRIKE_OF_DEATH_DISTANCE = 150
l_0_0 = WalkerTweakData
l_0_0.SECONDARY_WEAPON_MIN_FIRING_DISTANCE = 500
l_0_0 = WalkerTweakData
l_0_1 = function(l_1_0, l_1_1)
	local l_1_5, l_1_6, l_1_7, l_1_8 = nil
	for i_0,i_1 in pairs(l_1_0.SPECIAL_KILL_SETUPS) do
		if i_1.id == l_1_1 then
			return i_1
		end
	end
end

l_0_0.special_kill_setup = l_0_1
l_0_0 = WalkerTweakData
l_0_0, l_0_1 = l_0_0:new, l_0_0
l_0_0 = l_0_0(l_0_1)
walker_tweak_data = l_0_0

