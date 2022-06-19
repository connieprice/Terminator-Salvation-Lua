require("units/beings/AiNerveSystem")
BikerAiNerveSystem = BikerAiNerveSystem or class(AiNerveSystem)
function BikerAiNerveSystem.init(A0_0, A1_1)
	AiNerveSystem.init(A0_0, A1_1)
	A0_0._locked_firing_target = nil
	A0_0._input_history = {}
	A0_0._input_history.forced_target_units = 0
	A0_0._input_history.forced_attack_ranges = 0
	A0_0._input_history.forced_attack_fov = 0
	A0_0._input_history.target_range = 0
end
function BikerAiNerveSystem.init_default_ai_data(A0_2)
	if A0_2._unit:ai_data().default_forced_target_units and #A0_2._unit:ai_data().default_forced_target_units > 0 then
		A0_2._unit:ai_data().input.forced_target_units = A0_2._unit:ai_data().default_forced_target_units
		A0_2._input_history.forced_target_units = A0_2._input_history.forced_target_units + 1
	end
	if A0_2._unit:ai_data().default_forced_attack_ranges and #A0_2._unit:ai_data().default_forced_attack_ranges == 4 then
		A0_2._unit:ai_data().input.forced_attack_ranges = A0_2._unit:ai_data().default_forced_attack_ranges
		A0_2._input_history.forced_attack_ranges = A0_2._input_history.forced_attack_ranges + 1
	end
	if A0_2._unit:ai_data().default_forced_attack_fov and #A0_2._unit:ai_data().default_forced_attack_fov == 3 then
		A0_2._unit:ai_data().input.forced_attack_fov = A0_2._unit:ai_data().default_forced_attack_fov
		A0_2._input_history.forced_attack_fov = A0_2._input_history.forced_attack_fov + 1
	end
	if A0_2._unit:ai_data().default_ai_target_range and A0_2._unit:ai_data().default_ai_target_range ~= "" and A0_2._unit:ai_data().input.forced_attack_ranges then
		if A0_2._unit:ai_data().default_ai_target_range == "near" then
		elseif A0_2._unit:ai_data().default_ai_target_range == "medium" then
		elseif A0_2._unit:ai_data().default_ai_target_range == "far" then
		elseif A0_2._unit:ai_data().default_ai_target_range == "approach" then
		end
		A0_2._unit:ai_data().input.target_range = A0_2._unit:ai_data().input.forced_attack_ranges[4]
		A0_2._input_history.target_range = A0_2._input_history.target_range + 1
	end
end
function BikerAiNerveSystem.update(A0_3, A1_4, A2_5, A3_6)
	local L4_7
	L4_7 = A1_4.damage_data
	L4_7 = L4_7(A1_4)
	L4_7 = L4_7.is_fully_damaged
	L4_7 = L4_7(L4_7)
	if L4_7 then
		L4_7 = A0_3._update_dead
		L4_7(A0_3, A1_4, A2_5, A3_6)
		return
	end
	L4_7 = AiNerveSystem
	L4_7 = L4_7.update
	L4_7 = L4_7(A0_3, A1_4, A2_5, A3_6)
	if not L4_7 then
		return
	end
	L4_7 = A1_4.ai_data
	L4_7 = L4_7(A1_4)
	A1_4:input():clear()
	if L4_7.output.allowed_to_fire then
		if L4_7.output.attack_type == 1 then
			A1_4:input():set_secondary_damage(tweak_data.rail.biker.NEAR_RANGE_DAMAGE)
			A1_4:input():set_secondary_fire()
		elseif L4_7.output.attack_type == 2 then
			A1_4:input():set_primary_damage(tweak_data.rail.biker.MEDIUM_RANGE_DAMAGE)
			A1_4:input():set_primary_fire()
		elseif L4_7.output.attack_type == 3 then
			A1_4:input():set_primary_damage(tweak_data.rail.biker.FAR_RANGE_DAMAGE)
			A1_4:input():set_primary_fire()
		end
	end
	if L4_7.output.attack_type == 5 and L4_7.output.closest_target and not A0_3._warped then
		A1_4:input():set_target_unit(L4_7.output.closest_target)
		A1_4:input():set_warp_distance(L4_7.input.forced_attack_ranges[4])
		A1_4:input():set_warp()
		A0_3._warped = true
	end
	if L4_7.output.speed then
		A1_4:input():set_speed(L4_7.output.speed)
	end
	if Global.category_debug_render.rail_biker then
		A0_3:_debug(L4_7)
	end
end
function BikerAiNerveSystem._register(A0_8)
	local L1_9
	A0_8._registered = true
end
function BikerAiNerveSystem._unregister(A0_10)
	local L1_11
	A0_10._registered = false
end
function BikerAiNerveSystem._is_dead(A0_12)
	return A0_12._unit:enemy_data().dead
end
function BikerAiNerveSystem._update_dead(A0_13, A1_14, A2_15, A3_16)
	if not A0_13._braindead then
		A0_13:_kill_brain()
	end
	AiNerveSystem.update(A0_13, A1_14, A2_15, A3_16)
	A1_14:input():clear()
end
function BikerAiNerveSystem._debug(A0_17)
	local L1_18, L2_19, L3_20
	L1_18 = A0_17._unit
	L2_19 = L1_18
	L1_18 = L1_18.ai_data
	L1_18 = L1_18(L2_19)
	L2_19 = BikerAiCombat
	L2_19 = L2_19.attack_types
	L3_20 = L1_18._combat
	L3_20 = L3_20.current_attack_type
	L2_19 = L2_19[L3_20]
	L3_20 = A0_17._unit
	L3_20 = L3_20.position
	L3_20 = L3_20(L3_20)
	L3_20 = L3_20 + Vector3(0, 0, 400)
	A0_17:_draw_text(L3_20, L2_19)
	L2_19 = "targets " .. A0_17._input_history.forced_target_units
	L3_20 = A0_17._unit:position() + Vector3(0, 0, 350)
	A0_17:_draw_text(L3_20, L2_19)
	L2_19 = "ranges " .. A0_17._input_history.forced_attack_ranges
	L3_20 = A0_17._unit:position() + Vector3(0, 0, 300)
	A0_17:_draw_text(L3_20, L2_19)
	L2_19 = "fov " .. A0_17._input_history.forced_attack_fov
	L3_20 = A0_17._unit:position() + Vector3(0, 0, 250)
	A0_17:_draw_text(L3_20, L2_19)
	L2_19 = "range " .. A0_17._input_history.target_range
	L3_20 = A0_17._unit:position() + Vector3(0, 0, 200)
	A0_17:_draw_text(L3_20, L2_19)
end
function BikerAiNerveSystem._draw_text(A0_21, A1_22, A2_23)
	Draw:brush():set_blend_mode("add")
	Draw:brush():set_font("editor_font", 48)
	Draw:brush():set_color(Color(1, 1, 1, 1))
	Draw:brush():text(A1_22, A2_23)
	Draw:brush():text(A1_22, A2_23)
	Draw:brush():text(A1_22, A2_23)
	Draw:brush():text(A1_22, A2_23)
	Draw:brush():text(A1_22, A2_23)
end
