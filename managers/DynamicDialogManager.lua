require("shared/RandomTraversal")
require("shared/TableAlgorithms")
DynamicDialogManager = DynamicDialogManager or class()
DynamicDialogManager.PRIORITY_DRAMA = 1
DynamicDialogManager.PRIORITY_DIRECTION = 2
DynamicDialogManager.PRIORITY_REACTION = 3
function DynamicDialogManager.init(A0_0)
	A0_0._priority_to_time = {}
	A0_0._priority_to_time[A0_0.PRIORITY_DRAMA] = 0
	A0_0._priority_to_time[A0_0.PRIORITY_DIRECTION] = 1
	A0_0._priority_to_time[A0_0.PRIORITY_REACTION] = 3
	A0_0._action_level = 0
	A0_0._dynamic_conversations = {}
	A0_0:_scan_soundbanks()
	A0_0:_randomize_variants()
	A0_0._time_since_last_spoken = TimerManager:game():time()
	A0_0._emitter = managers.action_event:create_emitter()
	A0_0._idle_timer = 0
	A0_0._banter_timer = 0
	A0_0._random_player_traversal = RandomTraversal:new(0, true)
	A0_0._before_time_in_story = true
end
function DynamicDialogManager.destroy(A0_1)
	A0_1._emitter:destroy()
	A0_1._emitter = nil
end
function DynamicDialogManager._randomize_variants(A0_2)
	for 