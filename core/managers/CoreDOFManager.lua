CoreDOFManager = CoreDOFManager or class()
function CoreDOFManager.init(A0_0)
	A0_0._queued_effects = {}
	A0_0._last_id = 0
	A0_0._current_effect = nil
	A0_0._current_lerp = 0
	A0_0._prev_aim_dis = 0
	A0_0._max_visual_range = 20000
	A0_0._over_shoot_dis = nil
	A0_0._over_shoot_return_threshold = nil
	A0_0._over_shoot_start_dis = nil
	A0_0._enabled = true
end
function CoreDOFManager.save(A0_1, A1_2)
	if next(A0_1._queued_effects) then
		A1_2.CoreDOFManager, ({}).queued_effects = {}, clone(A0_1._queued_effects)
	end
end
function CoreDOFManager.load(A0_3, A1_4)
	local L2_5
	L2_5 = A1_4.CoreDOFManager
	if L2_5 then
		if L2_5.queued_effects then
			A0_3._queued_effects = clone(L2_5.queued_effects)
		else
			A0_3._queued_effects = {}
		end
	end
end
function CoreDOFManager.set_max_visual_range(A0_6, A1_7)
	A0_6._max_visual_range = A1_7
end
function CoreDOFManager.update(A0_8, A1_9, A2_10)
end
function CoreDOFManager.paused_update(A0_11, A1_12, A2_13)
	A0_11:update(A1_12, A2_13)
end
function CoreDOFManager.set_dof(A0_14, A1_15, A2_16, A3_17, A4_18, A5_19, A6_20)
	if not alive(A1_15.__dof_mat) then
		A1_15.__dof_mat = A1_15._vp:get_post_processor_effect(A1_15._render_params[1], "hdr_post_processor", "default"):modifier("dof"):material()
	end
	A0_14._dof_mat = A1_15.__dof_mat
	A0_14._dof_mat:set_variable("near_focus_distance_min", A3_17)
	A0_14._dof_mat:set_variable("near_focus_distance_max", A4_18)
	A0_14._dof_mat:set_variable("far_focus_distance_min", A5_19)
	A0_14._dof_mat:set_variable("far_focus_distance_max", A6_20)
	A0_14._dof_mat:set_variable("clamp", A2_16)
end
