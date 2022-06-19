WalkerTweakData = WalkerTweakData or class()
WalkerTweakData.SPECIAL_KILL_SETUPS = {
	{
		id = "special_kill_1",
		target_position = Vector3(0, 120, 0),
		target_position_tolerance = Vector3(20, 20, 20),
		target_yaw = 180,
		target_yaw_tolerance = 90,
		reach_redirect = "reach_for_target",
		redirect = "special_kill_1",
		target_redirect = "walker_special_kill_1",
		target_object_name = "a_neck_grip",
		target_in_cover = false
	},
	{
		id = "special_kill_in_cover",
		target_position = Vector3(0, 120, 0),
		target_position_tolerance = Vector3(20, 20, 20),
		target_yaw = 180,
		target_yaw_tolerance = 90,
		reach_redirect = "reach_for_target_in_cover",
		redirect = "special_kill_in_cover",
		target_redirect = "walker_special_kill_in_cover",
		target_object_name = "a_neck_grip",
		target_in_cover = true
	}
}
WalkerTweakData.DOWN_TIME = 1
WalkerTweakData.MAGCHARGE_DETACH_TIME = 10
WalkerTweakData.MOVEMENT_SPEED = 2
WalkerTweakData.STUN_TIME = 3
WalkerTweakData.HEAD_STUN_MAX_HEALTH = 30
WalkerTweakData.HEAD_STUN_HEALTH_PER_SECOND = 5
WalkerTweakData.CHEST_STUN_MAX_HEALTH = 250
WalkerTweakData.CHEST_STUN_HEALTH_PER_SECOND = 2
WalkerTweakData.EXECUTION_ATTACKER_TO_TARGET_DISTANCE = 2000
WalkerTweakData.EXECUTION_MAX_CLUSTER_DISTANCE = 1500
WalkerTweakData.EXECUTION_TARGET_TO_FRIENDS_DISTANCE = 500
WalkerTweakData.EXECUTION_TARGET_TO_FRIENDS_NUMBER_OF_FRIENDS = 2
WalkerTweakData.EXECUTION_MAX_DEPTH = 160
WalkerTweakData.EXECUTION_MAX_HEIGHT_DIFFERENCE = 50
WalkerTweakData.EXECUTION_MAX_DESTINATION_OFFSET = 50
WalkerTweakData.EXECUTION_MIN_TIME = 2
WalkerTweakData.EXECUTION_MAX_TRAVEL_LENGTH = 3000
WalkerTweakData.EXECUTION_MAX_DISTANCE = WalkerTweakData.EXECUTION_MAX_DEPTH + 110
WalkerTweakData.EXECUTION_MIN_DISTANCE = 120
WalkerTweakData.EXECUTION_BEGIN_AIMING_DISTANCE = WalkerTweakData.EXECUTION_MAX_DISTANCE + 300
WalkerTweakData.EXECUTION_UPDATE_PATH_DISTANCE = 50
WalkerTweakData.EXECUTION_TIMEOUT = 30
WalkerTweakData.EXECUTION_BEHIND_COVER_DISTANCE = 100
WalkerTweakData.MIN_EXECUTION_AREA_FIRE_DOT = 0.8
WalkerTweakData.MOVE_TO_LOOK_AT_HEIGHT = 150
WalkerTweakData.STRIKE_OF_DEATH_DISTANCE = 150
WalkerTweakData.SECONDARY_WEAPON_MIN_FIRING_DISTANCE = 500
function WalkerTweakData.special_kill_setup(A0_0, A1_1)
	for 