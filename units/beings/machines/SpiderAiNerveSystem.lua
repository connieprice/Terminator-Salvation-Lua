require("units/beings/AiNerveSystem")
require("shared/updatescheduler/UpdateSchedulerDtMethod")
SpiderAiNerveSystem = SpiderAiNerveSystem or class(AiNerveSystem)
function SpiderAiNerveSystem.init(A0_0, A1_1)
	AiNerveSystem.init(A0_0, A1_1)
	A0_0._num_scans = -1
	A0_0._low_frequency = UpdateSchedulerDtMethod:new(managers.update_scheduler:add_function(A0_0.low_frequency_update, "spider_nervesystem"))
end
function SpiderAiNerveSystem.destroy(A0_2)
	A0_2._low_frequency:remove()
	AiNerveSystem.destroy(A0_2)
end
function SpiderAiNerveSystem.update(A0_3, A1_4, A2_5, A3_6)
	if not AiNerveSystem.update(A0_3, A1_4, A2_5, A3_6) then
		A1_4:input():clear()
		return
	end
	A0_3._low_frequency:update(A0_3, A3_6, A1_4, A2_5)
end
function SpiderAiNerveSystem.low_frequency_update(A0_7, A1_8, A2_9, A3_10)
	local L4_11, L5_12, L6_13, L7_14, L8_15, L9_16, L10_17, L11_18, L12_19, L13_20
	L4_11 = AiNerveSystem
	L4_11 = L4_11.low_frequency_update
	L5_12 = A0_7
	L6_13 = A2_9
	L7_14 = A3_10
	L8_15 = A1_8
	L4_11(L5_12, L6_13, L7_14, L8_15)
	L4_11, L5_12 = nil, nil
	L6_13 = A0_7._ai_data
	L6_13 = L6_13.output
	L6_13 = L6_13.attack_mode
	L7_14 = nil
	L8_15 = false
	L9_16 = nil
	L10_17 = A0_7._ai_data
	L11_18 = L10_17
	L10_17 = L10_17.is_scan_requested
	L10_17 = L10_17(L11_18)
	L12_19 = A2_9
	L11_18 = A2_9.enemy_data
	L11_18 = L11_18(L12_19)
	L12_19 = A0_7._ai_data
	L12_19 = L12_19.output
	L13_20 = A0_7._move_to_position
	if L13_20 then
		L13_20 = A0_7._movement_blocked
		if not L13_20 then
			L13_20 = nil
			if A0_7._waypoint_options and A0_7._waypoint_options.speed and A0_7._ai_data.SPEEDS then
				L13_20 = A0_7._ai_data.SPEEDS[A0_7._waypoint_options.speed]
				assert(L13_20)
			else
				L13_20 = L12_19.move_speed
			end
			L5_12 = L13_20 * (A0_7._move_to_position - A0_7._unit_position):normalized()
		end
	end
	L13_20 = L12_19.allowed_to_fire
	if L13_20 then
		L13_20 = alive
		L13_20 = L13_20(L12_19.firing_target)
		if L13_20 then
			L13_20 = L12_19.firing_target
			L13_20 = L13_20.targeting_info
			L13_20 = L13_20(L13_20)
			if L13_20 then
				L4_11 = L13_20:primary_target_position()
			else
				L4_11 = L12_19.firing_target:oobb():center()
			end
			L9_16 = L12_19.firing_target
			if mvector3.distance(L9_16:position(), A0_7._unit_position) < tweak_data.ai.machines.spider.CHARGE_MAX_DISTANCE and NavigationGraphUtilities.ai_check_can_move_there(A2_9, L9_16:position(), {L9_16}, A0_7._area_restriction_shapes) then
				L8_15 = true
				L7_14 = false
			else
				L7_14 = true
			end
		else
			L13_20 = L12_19.firing_target_position
			if L13_20 then
				L4_11 = L12_19.firing_target_position
				L9_16 = nil
				L7_14 = true
			end
		end
		if L7_14 then
			L13_20 = IntelUtilities
			L13_20 = L13_20.ai_friendly_fire
			L13_20 = L13_20(A2_9, L4_11)
			if L13_20 then
				L7_14 = false
			end
		end
	else
		L13_20 = L12_19.look_at_position
		if L13_20 then
			L4_11 = L12_19.look_at_position
		else
			L4_11 = A0_7._waypoint_rotation_look_at_position
		end
	end
	L13_20 = A0_7._burst_fire
	L13_20 = L13_20(A0_7, A3_10, L7_14, L11_18.firing)
	L7_14 = L13_20
	L13_20 = A0_7._ai_data
	L13_20 = L13_20.set_is_scanning
	L13_20(L13_20, L11_18.scanning or L10_17)
	L13_20 = A2_9.input
	L13_20 = L13_20(A2_9)
	L13_20:clear()
	L13_20:set_aim_target_position(L4_11)
	L13_20:set_eye_target_position(L4_11)
	L13_20:set_aim_target_unit(L9_16)
	L13_20:set_attack_mode(L6_13)
	L13_20:set_is_scanning(L10_17)
	if L5_12 then
		L13_20:set_movement(L5_12)
	end
	if L7_14 then
		L13_20:set_fire()
		L13_20:set_miss_dispersion(A0_7:_update_weapons_dispersions(A2_9, {L9_16}, A1_8)[1])
	elseif L8_15 then
		L13_20:set_charge_direction((L9_16:position() - A0_7._unit_position):normalized())
	end
	for 