require("shared/TableAlgorithms")
require("shared/FunctionUtilities")
CommonAiThreat = CommonAiThreat or class()
function CommonAiThreat.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._threat_constants = A3_3
	A0_0._time = nil
	A0_0._last_frame_time = 0
	A0_0._last_time = nil
	A0_0._last_damage_direction = nil
	A0_0._last_known_position = nil
	A0_0._last_seen_position = nil
	A0_0._buffered_event = nil
	A0_0._damage = 0
	A0_0._health_func = A1_1
	A0_0._position_func = A2_2
	A0_0._non_damage_agression = 0
	A0_0._unit = nil
	A0_0._unit_assigned = false
	A0_0._unit_line_of_sight = false
	A0_0._unit_line_of_fire = false
	A0_0._line_of_sight_delay_time = 0
	A0_0._unit_line_of_sight_value = 0
	A0_0._unit_line_of_fire_value = 0
	A0_0._primary_target_priority = 0
	A0_0._secondary_target_priority = 0
	A0_0._is_human_player = false
	A0_0._in_cover = false
	A0_0._is_valid = true
end
function CommonAiThreat.set_not_valid(A0_4)
	local L1_5
	A0_4._is_valid = false
end
function CommonAiThreat.is_valid(A0_6)
	local L1_7
	L1_7 = A0_6._is_valid
	return L1_7
end
function CommonAiThreat.merge(A0_8, A1_9)
	cat_print("ai", "merging threats")
	if A1_9._last_time > A0_8._last_time then
		A0_8._last_time = A1_9._last_time
		A0_8._last_damage_direction = A1_9._last_damage_direction
		A0_8._last_known_position = A1_9._last_known_position
	end
	A0_8._damage = A0_8._damage + A1_9._damage
	assert(A0_8._unit == A1_9._unit)
end
function CommonAiThreat.set_last_time(A0_10, A1_11)
	A0_10._time = A1_11
	A0_10._last_time = A1_11
end
function CommonAiThreat.last_time(A0_12)
	local L1_13
	L1_13 = A0_12._last_time
	return L1_13
end
function CommonAiThreat.set_last_damage_direction(A0_14, A1_15)
	A0_14._last_damage_direction = A1_15
end
function CommonAiThreat.set_last_known_position(A0_16, A1_17)
	A0_16._last_known_position = A1_17
end
function CommonAiThreat.last_known_position(A0_18)
	local L1_19
	L1_19 = A0_18._last_known_position
	return L1_19
end
function CommonAiThreat.set_last_seen_position(A0_20, A1_21)
	A0_20._last_seen_position = A1_21
end
function CommonAiThreat.last_seen_position(A0_22)
	local L1_23
	L1_23 = A0_22._last_seen_position
	return L1_23
end
function CommonAiThreat.last_known_direction(A0_24)
	if A0_24._last_known_position then
		return ((A0_24._last_known_position - A0_24._position_func()):normalized())
	else
		return A0_24._last_damage_direction
	end
end
function CommonAiThreat.associate_event(A0_25, A1_26)
	local L2_27, L3_28
	A0_25._buffered_event = A1_26
	L3_28 = A0_25
	L2_27 = A0_25.set_last_known_position
	L2_27(L3_28, A1_26.event:position())
end
function CommonAiThreat.associated_event(A0_29)
	local L1_30
	L1_30 = A0_29._buffered_event
	if L1_30 then
		L1_30 = A0_29._buffered_event
		L1_30 = L1_30.event
		return L1_30
	else
		L1_30 = nil
		return L1_30
	end
end
function CommonAiThreat.add_damage(A0_31, A1_32)
	local L2_33
	L2_33 = A0_31._damage
	L2_33 = L2_33 + A1_32
	A0_31._damage = L2_33
end
function CommonAiThreat.damage(A0_34)
	local L1_35
	L1_35 = A0_34._damage
	return L1_35
end
function CommonAiThreat.add_non_damage_agression(A0_36)
	local L1_37
	L1_37 = A0_36._non_damage_agression
	L1_37 = L1_37 + 0.01
	A0_36._non_damage_agression = L1_37
end
function CommonAiThreat.non_damage_agression(A0_38)
	local L1_39
	L1_39 = A0_38._non_damage_agression
	return L1_39
end
function CommonAiThreat.associate_unit(A0_40, A1_41)
	assert(not A0_40._unit_assigned)
	A0_40._unit = A1_41
	A0_40._unit_assigned = true
	if managers.player:is_unit_human_player(A1_41) then
		A0_40._is_human_player = true
	end
end
function CommonAiThreat.unit(A0_42)
	local L1_43
	L1_43 = A0_42._unit
	return L1_43
end
function CommonAiThreat.unit_associated(A0_44)
	local L1_45
	L1_45 = A0_44._unit_assigned
	return L1_45
end
function CommonAiThreat.set_unit_line_of_sight(A0_46, A1_47, A2_48)
	assert(type(A1_47) == "boolean")
	if A1_47 then
		assert(A2_48)
		if not A0_46._line_of_sight_delay_time or A2_48 < A0_46._line_of_sight_delay_time then
			A0_46._line_of_sight_delay_time = A2_48
		end
	else
		A0_46._line_of_sight_delay_time = nil
	end
	A0_46._unit_line_of_sight = A1_47
end
function CommonAiThreat.unit_line_of_sight(A0_49)
	local L1_50
	L1_50 = A0_49._unit_line_of_sight
	if L1_50 then
		L1_50 = A0_49._time
		if L1_50 < A0_49._line_of_sight_delay_time then
			L1_50 = false
			return L1_50
		end
	end
	L1_50 = A0_49._unit_line_of_sight
	return L1_50
end
function CommonAiThreat.set_unit_line_of_fire(A0_51, A1_52)
	assert(type(A1_52) == "boolean")
	A0_51._unit_line_of_fire = A1_52
end
function CommonAiThreat.unit_line_of_fire(A0_53)
	local L1_54
	L1_54 = A0_53._unit_line_of_fire
	return L1_54
end
function CommonAiThreat.set_cluster_info(A0_55, A1_56, A2_57)
	A0_55._cluster_size = A1_56
	A0_55._normalized_cluster_distance = A2_57
end
function CommonAiThreat.unit_dead(A0_58)
	if not A0_58._unit_assigned then
		return false
	end
	return not alive(A0_58._unit) or A0_58._unit:damage_data():is_fully_damaged()
end
function CommonAiThreat.threat_level(A0_59)
	return A0_59:damage() + A0_59:non_damage_agression()
end
function CommonAiThreat.primary_target_priority(A0_60)
	local L1_61
	L1_61 = A0_60._primary_target_priority
	return L1_61
end
function CommonAiThreat.secondary_target_priority(A0_62)
	local L1_63
	L1_63 = A0_62._secondary_target_priority
	return L1_63
end
function CommonAiThreat._recompute_target_priority(A0_64)
	local L1_65
	L1_65 = A0_64.unit_dead
	L1_65 = L1_65(A0_64)
	if L1_65 then
		A0_64._primary_target_priority = 0
		A0_64._secondary_target_priority = 0
		return
	end
	L1_65 = nil
	if A0_64:unit_line_of_sight() then
		L1_65 = mvector3.distance(A0_64._unit:position(), A0_64._position_func())
	end
	A0_64._primary_target_priority = A0_64:_calculate_target_priority(A0_64._threat_constants.primary_weights, L1_65)
	if A0_64._threat_constants.secondary_weights then
		A0_64._secondary_target_priority = A0_64:_calculate_target_priority(A0_64._threat_constants.secondary_weights, L1_65)
	end
end
function CommonAiThreat._calculate_target_priority(A0_66, A1_67, A2_68)
	local L3_69, L4_70, L5_71, L6_72, L7_73, L8_74
	L3_69 = math
	L3_69 = L3_69.lerp
	L4_70 = A1_67.MIN_DAMAGE_FACTOR
	L5_71 = A1_67.MAX_DAMAGE_FACTOR
	L6_72 = math
	L6_72 = L6_72.clamp
	L7_73 = A1_67.DAMAGE_SCALE
	L8_74 = A0_66.damage
	L8_74 = L8_74(A0_66)
	L7_73 = L7_73 * L8_74
	L8_74 = A0_66._health_func
	L8_74 = L8_74()
	L7_73 = L7_73 / L8_74
	L8_74 = 0
	L8_74 = L6_72(L7_73, L8_74, 1)
	L3_69 = L3_69(L4_70, L5_71, L6_72, L7_73, L8_74, L6_72(L7_73, L8_74, 1))
	L4_70 = iff
	L6_72 = A0_66
	L5_71 = A0_66.damage
	L5_71 = L5_71(L6_72)
	L5_71 = L5_71 > 0
	L6_72 = 1
	L7_73 = math
	L7_73 = L7_73.clamp
	L8_74 = A0_66.non_damage_agression
	L8_74 = L8_74(A0_66)
	L8_74 = L7_73(L8_74, A1_67.MIN_AGGRESSION_FACTOR, A1_67.MAX_AGGRESSION_FACTOR)
	L4_70 = L4_70(L5_71, L6_72, L7_73, L8_74, L7_73(L8_74, A1_67.MIN_AGGRESSION_FACTOR, A1_67.MAX_AGGRESSION_FACTOR))
	L5_71 = math
	L5_71 = L5_71.lerp
	L6_72 = A1_67.NO_LOS_FACTOR
	L7_73 = A1_67.HAS_LOS_FACTOR
	L8_74 = A0_66._unit_line_of_sight_value
	L5_71 = L5_71(L6_72, L7_73, L8_74)
	L6_72 = math
	L6_72 = L6_72.lerp
	L7_73 = A1_67.NO_LOF_FACTOR
	L8_74 = A1_67.HAS_LOF_FACTOR
	L6_72 = L6_72(L7_73, L8_74, A0_66._unit_line_of_fire_value)
	L7_73 = L4_70 * L3_69
	L7_73 = L7_73 * L5_71
	L7_73 = L7_73 * L6_72
	if A2_68 then
		L8_74 = A1_67.PROXIMITY_OVERRIDE_RANGE
		if A2_68 < L8_74 then
			L8_74 = 0.1 * L7_73
			L7_73 = 0.9 + L8_74
		end
	else
		L7_73 = 0.5 * L7_73
	end
	L8_74 = A0_66._threat_constants
	L8_74 = L8_74.ENABLE_UNIT_CLUSTERING
	if L8_74 then
		L8_74 = A0_66._cluster_size
		if L8_74 > 0 then
			L8_74 = nil
			if A0_66._cluster_size == 1 then
				L8_74 = A1_67.UNIT_CLUSTERING_ALONE_FACTOR
			else
				L8_74 = math.lerp(A1_67.UNIT_CLUSTERING_MIN_RADIUS_FACTOR, A1_67.UNIT_CLUSTERING_MAX_RADIUS_FACTOR, A0_66._normalized_cluster_distance)
			end
			L7_73 = L7_73 * L8_74
		end
	end
	L8_74 = A1_67.HUMAN_PLAYER_FACTOR
	if L8_74 then
		L8_74 = iff
		L8_74 = L8_74(A0_66._is_human_player, A1_67.HUMAN_PLAYER_FACTOR, A1_67.NON_HUMAN_PLAYER_FACTOR)
		L7_73 = L7_73 * L8_74
	end
	L8_74 = A1_67.IN_COVER_FACTOR
	if L8_74 then
		L8_74 = iff
		L8_74 = L8_74(A0_66._in_cover, A1_67.IN_COVER_FACTOR, A1_67.OUT_OF_COVER_FACTOR)
		L7_73 = L7_73 * L8_74
	end
	L8_74 = assert
	L8_74(L7_73 >= 0 and L7_73 <= 1)
	L8_74 = A0_66._unit
	if L8_74 then
		L8_74 = A0_66._unit
		L8_74 = L8_74.ai_data
		L8_74 = L8_74(L8_74)
		if L8_74 then
			L8_74 = A0_66._unit
			L8_74 = L8_74.ai_data
			L8_74 = L8_74(L8_74)
			if A0_66._unit_line_of_fire and A0_66:unit_line_of_sight() then
				L7_73 = math.max(L8_74._min_target_weight, L7_73)
			end
			L7_73 = math.min(L8_74._max_target_weight, L7_73)
		end
	end
	return L7_73
end
function CommonAiThreat._update_damage_declination(A0_75, A1_76)
	A0_75._damage = math.max(0, A0_75._damage - A0_75._damage * A0_75._threat_constants.DAMAGE_DECLINATION_FACTOR * A1_76)
end
function CommonAiThreat._update_los_declination(A0_77, A1_78)
	if A0_77:unit_line_of_sight() then
		A0_77._unit_line_of_sight_value = 1
	else
		A0_77._unit_line_of_sight_value = math.max(0, A0_77._unit_line_of_sight_value - A0_77._threat_constants.LOS_DECLINATION_FACTOR * A1_78)
	end
end
function CommonAiThreat._update_lof_declination(A0_79, A1_80)
	if A0_79:unit_line_of_fire() then
		A0_79._unit_line_of_fire_value = 1
	else
		A0_79._unit_line_of_fire_value = math.max(0, A0_79._unit_line_of_fire_value - A0_79._threat_constants.LOF_DECLINATION_FACTOR * A1_80)
	end
end
function CommonAiThreat._update_cover_state(A0_81)
	if not alive(A0_81._unit) then
		return
	end
	if not A0_81._unit:player_data() then
		return
	end
	A0_81._in_cover = A0_81._unit:player_data().in_cover
end
function CommonAiThreat.update(A0_82, A1_83)
	local L2_84, L3_85
	L2_84 = A0_82._last_frame_time
	L2_84 = A1_83 - L2_84
	A0_82._last_frame_time = A1_83
	A0_82._time = A1_83
	L3_85 = A0_82._update_damage_declination
	L3_85(A0_82, L2_84)
	L3_85 = A0_82._update_los_declination
	L3_85(A0_82, L2_84)
	L3_85 = A0_82._update_lof_declination
	L3_85(A0_82, L2_84)
	L3_85 = A0_82._update_cover_state
	L3_85(A0_82)
	L3_85 = A0_82.unit_line_of_sight
	L3_85 = L3_85(A0_82)
	if L3_85 then
		L3_85 = alive
		L3_85 = L3_85(A0_82._unit)
		if L3_85 then
			L3_85 = A0_82.set_last_time
			L3_85(A0_82, A1_83)
			L3_85 = A0_82._unit
			L3_85 = L3_85.position
			L3_85 = L3_85(L3_85)
			A0_82:set_last_known_position(L3_85)
			A0_82:set_last_seen_position(L3_85)
		end
	else
		L3_85 = A0_82._buffered_event
		if L3_85 then
			L3_85 = A0_82._buffered_event
			L3_85 = L3_85.event
			L3_85 = L3_85.valid
			L3_85 = L3_85(L3_85)
			if L3_85 then
				L3_85 = A0_82.set_last_time
				L3_85(A0_82, A1_83)
				L3_85 = A0_82.set_last_known_position
				L3_85(A0_82, A0_82._buffered_event.event:position())
			end
		end
	end
	L3_85 = A0_82._buffered_event
	if L3_85 then
		L3_85 = A0_82._buffered_event
		L3_85 = L3_85.has_ended
		if L3_85 then
			A0_82._buffered_event = nil
		end
	end
	L3_85 = A0_82._recompute_target_priority
	L3_85(A0_82)
end
