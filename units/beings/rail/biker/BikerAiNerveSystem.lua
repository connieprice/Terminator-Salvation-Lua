require("units/beings/AiNerveSystem")
if not BikerAiNerveSystem then
	BikerAiNerveSystem = class(AiNerveSystem)
end
BikerAiNerveSystem.init = function(l_1_0, l_1_1)
	AiNerveSystem.init(l_1_0, l_1_1)
	l_1_0._locked_firing_target = nil
	l_1_0._input_history = {}
	l_1_0._input_history.forced_target_units = 0
	l_1_0._input_history.forced_attack_ranges = 0
	l_1_0._input_history.forced_attack_fov = 0
	l_1_0._input_history.target_range = 0
end

BikerAiNerveSystem.init_default_ai_data = function(l_2_0)
	local l_2_1 = l_2_0._unit:ai_data()
	if l_2_1.default_forced_target_units and #l_2_1.default_forced_target_units > 0 then
		l_2_1.input.forced_target_units = l_2_1.default_forced_target_units
		l_2_0._input_history.forced_target_units = l_2_0._input_history.forced_target_units + 1
	end
	if l_2_1.default_forced_attack_ranges and #l_2_1.default_forced_attack_ranges == 4 then
		l_2_1.input.forced_attack_ranges = l_2_1.default_forced_attack_ranges
		l_2_0._input_history.forced_attack_ranges = l_2_0._input_history.forced_attack_ranges + 1
	end
	if l_2_1.default_forced_attack_fov and #l_2_1.default_forced_attack_fov == 3 then
		l_2_1.input.forced_attack_fov = l_2_1.default_forced_attack_fov
		l_2_0._input_history.forced_attack_fov = l_2_0._input_history.forced_attack_fov + 1
	end
	if l_2_1.default_ai_target_range and l_2_1.default_ai_target_range ~= "" and l_2_1.input.forced_attack_ranges then
		local l_2_2 = nil
		if l_2_1.default_ai_target_range == "near" then
			l_2_2 = l_2_1.input.forced_attack_ranges[1]
		elseif l_2_1.default_ai_target_range == "medium" then
			l_2_2 = l_2_1.input.forced_attack_ranges[2]
		elseif l_2_1.default_ai_target_range == "far" then
			l_2_2 = l_2_1.input.forced_attack_ranges[3]
		elseif l_2_1.default_ai_target_range == "approach" then
			l_2_2 = l_2_1.input.forced_attack_ranges[4]
		end
		l_2_1.input.target_range = l_2_2
		l_2_0._input_history.target_range = l_2_0._input_history.target_range + 1
	end
end

BikerAiNerveSystem.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	if l_3_1:damage_data():is_fully_damaged() then
		l_3_0:_update_dead(l_3_1, l_3_2, l_3_3)
		return 
	end
	if not AiNerveSystem.update(l_3_0, l_3_1, l_3_2, l_3_3) then
		return 
	end
	local l_3_4 = l_3_1:ai_data()
	local l_3_5 = l_3_1:input()
	l_3_5:clear()
	if l_3_4.output.allowed_to_fire then
		if l_3_4.output.attack_type == 1 then
			l_3_5:set_secondary_damage(tweak_data.rail.biker.NEAR_RANGE_DAMAGE)
			l_3_5:set_secondary_fire()
		end
	else
		if l_3_4.output.attack_type == 2 then
			l_3_5:set_primary_damage(tweak_data.rail.biker.MEDIUM_RANGE_DAMAGE)
			l_3_5:set_primary_fire()
		end
	else
		if l_3_4.output.attack_type == 3 then
			l_3_5:set_primary_damage(tweak_data.rail.biker.FAR_RANGE_DAMAGE)
			l_3_5:set_primary_fire()
		end
	end
	if l_3_4.output.attack_type == 5 and l_3_4.output.closest_target and not l_3_0._warped then
		l_3_5:set_target_unit(l_3_4.output.closest_target)
		l_3_5:set_warp_distance(l_3_4.input.forced_attack_ranges[4])
		l_3_5:set_warp()
		l_3_0._warped = true
	end
	if l_3_4.output.speed then
		l_3_5:set_speed(l_3_4.output.speed)
	end
	if Global.category_debug_render.rail_biker then
		l_3_0:_debug(l_3_4)
	end
end

BikerAiNerveSystem._register = function(l_4_0)
	l_4_0._registered = true
end

BikerAiNerveSystem._unregister = function(l_5_0)
	l_5_0._registered = false
end

BikerAiNerveSystem._is_dead = function(l_6_0)
	return l_6_0._unit:enemy_data().dead
end

BikerAiNerveSystem._update_dead = function(l_7_0, l_7_1, l_7_2, l_7_3)
	if not l_7_0._braindead then
		l_7_0:_kill_brain()
	end
	AiNerveSystem.update(l_7_0, l_7_1, l_7_2, l_7_3)
	local l_7_4 = l_7_1:input()
	l_7_4:clear()
end

BikerAiNerveSystem._debug = function(l_8_0)
	local l_8_1 = l_8_0._unit:ai_data()
	local l_8_2 = BikerAiCombat.attack_types[l_8_1._combat.current_attack_type]
	local l_8_3 = l_8_0._unit:position() + Vector3(0, 0, 400)
	l_8_0:_draw_text(l_8_3, l_8_2)
	l_8_2 = "targets " .. l_8_0._input_history.forced_target_units
	l_8_3 = l_8_0._unit:position() + Vector3(0, 0, 350)
	l_8_0:_draw_text(l_8_3, l_8_2)
	l_8_2 = "ranges " .. l_8_0._input_history.forced_attack_ranges
	l_8_3 = l_8_0._unit:position() + Vector3(0, 0, 300)
	l_8_0:_draw_text(l_8_3, l_8_2)
	l_8_2 = "fov " .. l_8_0._input_history.forced_attack_fov
	l_8_3 = l_8_0._unit:position() + Vector3(0, 0, 250)
	l_8_0:_draw_text(l_8_3, l_8_2)
	l_8_2 = "range " .. l_8_0._input_history.target_range
	l_8_3 = l_8_0._unit:position() + Vector3(0, 0, 200)
	l_8_0:_draw_text(l_8_3, l_8_2)
end

BikerAiNerveSystem._draw_text = function(l_9_0, l_9_1, l_9_2)
	local l_9_3 = Draw:brush()
	l_9_3:set_blend_mode("add")
	l_9_3:set_font("editor_font", 48)
	l_9_3:set_color(Color(1, 1, 1, 1))
	l_9_3:text(l_9_1, l_9_2)
	l_9_3:text(l_9_1, l_9_2)
	l_9_3:text(l_9_1, l_9_2)
	l_9_3:text(l_9_1, l_9_2)
	l_9_3:text(l_9_1, l_9_2)
end


