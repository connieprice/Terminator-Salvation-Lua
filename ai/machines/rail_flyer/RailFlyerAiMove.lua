RailFlyerAiMove = RailFlyerAiMove or class()
function RailFlyerAiMove.init_data(A0_0, A1_1)
	local L2_2
	L2_2 = {}
	A1_1._move = L2_2
	L2_2 = A1_1._move
	L2_2.fire_locked = true
	L2_2 = A1_1._move
	L2_2.behavior_locked = true
	L2_2 = A1_1._move
	L2_2.looking_locked = true
	L2_2 = A1_1._move
	L2_2.allowed_to_fire = false
	L2_2 = A1_1._move
	L2_2.latest_approach_time = 0
	A1_1.default_waypoint_pause_time = 0
	L2_2 = A1_1._move
	L2_2.target_from_behind = true
	L2_2 = tweak_data
	L2_2 = L2_2.rail
	L2_2 = L2_2.flyer
	L2_2 = L2_2.ARRIVED_RADIUS
	A1_1.arrived_radius = L2_2
	L2_2 = A1_1._move
	L2_2.path_info = {}
	L2_2 = A1_1._move
	L2_2 = L2_2.path_info
	L2_2.path = nil
	L2_2 = A1_1._move
	L2_2.normalized_speed_factor = 1000
	L2_2 = A1_1.input
	L2_2 = L2_2.target_range
	if L2_2 == nil then
		L2_2 = A1_1.input
		L2_2.target_range = tweak_data.rail.flyer.DEFAULT_TARGET_RANGE
	end
	L2_2 = A1_1.input
	L2_2.collision_slotmask = managers.slot:get_mask("rail_vehicles")
end
function RailFlyerAiMove.logic_rail_flyer_move_init(A0_3, A1_4, A2_5, A3_6, A4_7, A5_8, A6_9, A7_10)
	local L8_11
	L8_11 = 0
	return L8_11
end
function RailFlyerAiMove.logic_rail_flyer_move_start(A0_12, A1_13, A2_14, A3_15, A4_16, A5_17, A6_18, A7_19)
	local L8_20
	L8_20 = A2_14.ai_data
	L8_20 = L8_20(A2_14)
	if L8_20:new_path_requested() then
		A0_12:_find_path(A2_14, L8_20)
	end
	if L8_20._move.path ~= nil then
		A0_12:_set_path(A2_14, L8_20)
		L8_20._move.path = nil
	end
	if L8_20._behavior.target ~= nil and alive(L8_20._behavior.target) then
		if L8_20.input.moving_to_position ~= nil and mvector3.distance(L8_20.input.moving_to_position, L8_20._behavior.target:position()) > tweak_data.rail.flyer.LOST_DISTANCE then
			A0_12:_set_path(A2_14, L8_20)
		end
		L8_20.output.move_speed = A0_12:_get_pursuit_speed(A2_14, L8_20._behavior.target, L8_20)
	end
	return nil
end
function RailFlyerAiMove._flyer_is_behind_target_vehicle(A0_21, A1_22, A2_23, A3_24)
	local L4_25
	L4_25 = A2_23 - A1_22
	return mvector3.dot(A3_24, L4_25) >= 0
end
function RailFlyerAiMove._waypoint_is_behind_target_vehicle(A0_26, A1_27, A2_28, A3_29)
	local L4_30, L5_31
	L4_30 = A1_27.input
	L4_30 = L4_30.moving_to_position
	if L4_30 ~= nil then
		L4_30 = A3_29
		L5_31 = A1_27.input
		L5_31 = L5_31.moving_to_position
		L5_31 = A2_28 - L5_31
		return mvector3.dot(L4_30, L5_31) >= 0
	else
		L4_30 = true
		return L4_30
	end
end
function RailFlyerAiMove._allowed_to_fire(A0_32, A1_33, A2_34, A3_35)
	A1_33.output.firing_target_position = A1_33._behavior.target:position()
	A1_33.output.firing_target = A1_33._behavior.target
	A1_33._move.allowed_to_fire = mvector3.distance(A2_34, A3_35) < A1_33.input.target_range + tweak_data.rail.flyer.RANGE_SPREAD
end
function RailFlyerAiMove._get_pursuit_speed(A0_36, A1_37, A2_38, A3_39)
	local L4_40, L5_41, L6_42, L7_43, L8_44, L9_45, L10_46, L11_47, L12_48, L13_49, L14_50, L15_51
	L15_51 = A1_37
	L14_50 = A1_37.position
	L14_50 = L14_50(L15_51)
	L4_40 = L14_50
	L15_51 = A2_38
	L14_50 = A2_38.position
	L14_50 = L14_50(L15_51)
	L5_41 = L14_50
	L14_50 = mvector3
	L14_50 = L14_50.distance
	L15_51 = L5_41.with_z
	L15_51 = L15_51(L5_41, 0)
	L14_50 = L14_50(L15_51, L4_40:with_z(0))
	L6_42 = L14_50
	L15_51 = A2_38
	L14_50 = A2_38.rotation
	L14_50 = L14_50(L15_51)
	L15_51 = L14_50
	L14_50 = L14_50.y
	L14_50 = L14_50(L15_51)
	L7_43 = L14_50
	L15_51 = A2_38
	L14_50 = A2_38.base
	L14_50 = L14_50(L15_51)
	L15_51 = L14_50
	L14_50 = L14_50.get_speed_vector
	L14_50 = L14_50(L15_51)
	L8_44 = L14_50
	L14_50 = mvector3
	L14_50 = L14_50.dot
	L15_51 = L7_43
	L14_50 = L14_50(L15_51, L8_44)
	L9_45 = L14_50
	L15_51 = A0_36
	L14_50 = A0_36._flyer_is_behind_target_vehicle
	L14_50 = L14_50(L15_51, L4_40, L5_41, L7_43)
	L15_51 = A3_39._move
	L15_51 = L15_51.target_from_behind
	if L15_51 then
		L15_51 = A3_39.input
		L15_51 = L15_51.target_range
		if L6_42 > L15_51 then
			L15_51 = math
			L15_51 = L15_51.max
			L15_51 = L15_51(tweak_data.rail.flyer.SPEED_CORRECTION, L9_45)
			L12_48 = L15_51 * (L6_42 / A3_39.input.target_range)
		else
			L15_51 = A3_39.input
			L15_51 = L15_51.target_range
			L15_51 = L6_42 / L15_51
			L12_48 = L9_45 * L15_51
		end
	elseif not L14_50 then
		L15_51 = A3_39.input
		L15_51 = L15_51.target_range
		if L6_42 > L15_51 then
			L15_51 = math
			L15_51 = L15_51.max
			L15_51 = L15_51(tweak_data.rail.flyer.SPEED_CORRECTION, L9_45)
			L12_48 = L15_51 * (L6_42 / A3_39.input.target_range)
		else
			L15_51 = A3_39.input
			L15_51 = L15_51.target_range
			L15_51 = 2 * L15_51
			L15_51 = L15_51 - L6_42
			L15_51 = L15_51 / A3_39.input.target_range
			L12_48 = L9_45 * L15_51
		end
	else
		L15_51 = tweak_data
		L15_51 = L15_51.rail
		L15_51 = L15_51.flyer
		L15_51 = L15_51.RETARDATION_DISTANCE
		L12_48 = L9_45 * (1 + (L6_42 + L15_51) / L15_51)
	end
	L15_51 = A3_39.input
	L15_51 = L15_51.moving_to_position
	if L15_51 ~= nil then
		A3_39._combat.target_from_here = L5_41 - A3_39.input.target_range * L7_43
		mvector3.set_z(A3_39._combat.target_from_here, mvector3.z(L15_51))
	end
	L13_49 = math.clamp(L12_48, tweak_data.rail.flyer.MIN_SPEED, tweak_data.rail.flyer.MAX_SPEED) / A3_39._move.normalized_speed_factor
	A0_36:_allowed_to_fire(A3_39, L4_40, L5_41)
	return L13_49
end
function RailFlyerAiMove._find_and_set_closest_waypoint(A0_52, A1_53, A2_54)
	local L3_55
	L3_55 = A1_53.ai_data
	L3_55 = L3_55(A1_53)
	A0_52:_set_path(A2_54, L3_55)
end
function RailFlyerAiMove._get_closest_waypoint(A0_56, A1_57, A2_58)
	local L3_59, L4_60, L5_61, L6_62
	L5_61 = A1_57
	L4_60 = A1_57.ai_data
	L4_60 = L4_60(L5_61)
	L5_61 = L4_60
	L4_60 = L4_60.path
	L4_60 = L4_60(L5_61)
	if L4_60 ~= nil then
		L5_61, L6_62 = nil, nil
		for 