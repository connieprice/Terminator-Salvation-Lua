AiData = AiData or class()
function AiData.init(A0_0)
	local L1_1
	A0_0.brain = nil
	A0_0.brain_infos = nil
	A0_0.stay_on_ground = true
	A0_0.group_name = nil
	L1_1 = {}
	A0_0.input = L1_1
	L1_1 = A0_0.input
	L1_1.brain = nil
	L1_1 = A0_0.input
	L1_1.is_dead = false
	L1_1 = A0_0.input
	L1_1.is_down = false
	L1_1 = A0_0.input
	L1_1.collision_slotmask = nil
	L1_1 = A0_0.input
	L1_1.moving_to_position = nil
	L1_1 = A0_0.input
	L1_1.passed_last_waypoint = false
	L1_1 = A0_0.input
	L1_1.buffered_events = {}
	L1_1 = A0_0.input
	L1_1.buffered_damages = {}
	L1_1 = {}
	A0_0.output = L1_1
	L1_1 = A0_0.output
	L1_1.look_at_position = nil
	L1_1 = A0_0.output
	L1_1.currently_targeted_threat = nil
	L1_1 = {}
	A0_0.external = L1_1
	A0_0.human_player_priority_target = true
	A0_0.max_slope_angle = 30
	A0_0._latest_target_position = nil
	A0_0._path = nil
	A0_0._path_out_counter = 0
	A0_0._path_in_counter = 0
	A0_0._path_completed_counter = -1
	A0_0._loop_path = false
	A0_0._waypoints = nil
	A0_0._min_target_weight = 0
	A0_0._max_target_weight = 1
	L1_1 = {0, 0}
	A0_0.PATROL_MOVE_TIMERS = L1_1
	L1_1 = {0, 0}
	A0_0.AGGRESIVE_MOVE_TIMERS = L1_1
	L1_1 = {0, 0}
	A0_0.HIDE_TIMERS = L1_1
end
function AiData.set_new_path(A0_2, A1_3, A2_4)
	local L3_5
	L3_5 = A0_2._path
	if A1_3 == L3_5 then
		return
	end
	A0_2._path = A1_3
	A0_2._loop_path = A2_4
	L3_5 = A0_2._path_in_counter
	L3_5 = L3_5 + 1
	A0_2._path_out_counter = L3_5
end
function AiData.path(A0_6)
	local L1_7
	L1_7 = A0_6._path
	return L1_7
end
function AiData.request_new_path(A0_8)
	local L1_9
	L1_9 = A0_8._path_out_counter
	L1_9 = L1_9 + 1
	A0_8._path_in_counter = L1_9
end
function AiData.accept_new_path(A0_10)
	A0_10._path_in_counter = A0_10._path_out_counter
end
function AiData.abort_new_path_request(A0_11)
	A0_11._path_in_counter = A0_11._path_out_counter
end
function AiData.new_path_requested(A0_12)
	return A0_12._path_in_counter > A0_12._path_out_counter
end
function AiData.new_path_received(A0_13)
	return A0_13._path_in_counter < A0_13._path_out_counter
end
function AiData.set_current_path_completed(A0_14)
	A0_14._path_completed_counter = A0_14._path_out_counter
end
function AiData.current_path_completed(A0_15)
	return A0_15._path_completed_counter == A0_15._path_out_counter
end
function AiData.set_waypoints(A0_16, A1_17)
	if not A1_17 then
		A0_16._waypoints = nil
		return
	end
	A0_16._waypoints = {}
	for 