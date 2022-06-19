if not CoreDOFManager then
	CoreDOFManager = class()
end
CoreDOFManager.init = function(l_1_0)
	l_1_0._queued_effects = {}
	l_1_0._last_id = 0
	l_1_0._current_effect = nil
	l_1_0._current_lerp = 0
	l_1_0._prev_aim_dis = 0
	l_1_0._max_visual_range = 20000
	l_1_0._over_shoot_dis = nil
	l_1_0._over_shoot_return_threshold = nil
	l_1_0._over_shoot_start_dis = nil
	l_1_0._enabled = true
end

CoreDOFManager.save = function(l_2_0, l_2_1)
	if next(l_2_0._queued_effects) then
		local l_2_2 = {}
		l_2_2.queued_effects = clone(l_2_0._queued_effects)
		l_2_1.CoreDOFManager = l_2_2
	end
end

CoreDOFManager.load = function(l_3_0, l_3_1)
	local l_3_2 = l_3_1.CoreDOFManager
	if l_3_2 then
		if l_3_2.queued_effects then
			l_3_0._queued_effects = clone(l_3_2.queued_effects)
		end
	else
		l_3_0._queued_effects = {}
	end
end

CoreDOFManager.set_max_visual_range = function(l_4_0, l_4_1)
	l_4_0._max_visual_range = l_4_1
end

CoreDOFManager.update = function(l_5_0, l_5_1, l_5_2)
end

CoreDOFManager.paused_update = function(l_6_0, l_6_1, l_6_2)
	l_6_0:update(l_6_1, l_6_2)
end

CoreDOFManager.set_dof = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4, l_7_5, l_7_6)
	if not alive(l_7_1.__dof_mat) then
		l_7_1.__dof_mat = l_7_1._vp:get_post_processor_effect(l_7_1._render_params[1], "hdr_post_processor", "default"):modifier("dof"):material()
	end
	l_7_0._dof_mat = l_7_1.__dof_mat
	l_7_0._dof_mat:set_variable("near_focus_distance_min", l_7_3)
	l_7_0._dof_mat:set_variable("near_focus_distance_max", l_7_4)
	l_7_0._dof_mat:set_variable("far_focus_distance_min", l_7_5)
	l_7_0._dof_mat:set_variable("far_focus_distance_max", l_7_6)
	l_7_0._dof_mat:set_variable("clamp", l_7_2)
end


