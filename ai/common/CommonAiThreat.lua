require("shared/TableAlgorithms")
require("shared/FunctionUtilities")
if not CommonAiThreat then
	CommonAiThreat = class()
end
CommonAiThreat.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._threat_constants = l_1_3
	l_1_0._time = nil
	l_1_0._last_frame_time = 0
	l_1_0._last_time = nil
	l_1_0._last_damage_direction = nil
	l_1_0._last_known_position = nil
	l_1_0._last_seen_position = nil
	l_1_0._buffered_event = nil
	l_1_0._damage = 0
	l_1_0._health_func = l_1_1
	l_1_0._position_func = l_1_2
	l_1_0._non_damage_agression = 0
	l_1_0._unit = nil
	l_1_0._unit_assigned = false
	l_1_0._unit_line_of_sight = false
	l_1_0._unit_line_of_fire = false
	l_1_0._line_of_sight_delay_time = 0
	l_1_0._unit_line_of_sight_value = 0
	l_1_0._unit_line_of_fire_value = 0
	l_1_0._primary_target_priority = 0
	l_1_0._secondary_target_priority = 0
	l_1_0._is_human_player = false
	l_1_0._in_cover = false
	l_1_0._is_valid = true
end

CommonAiThreat.set_not_valid = function(l_2_0)
	l_2_0._is_valid = false
end

CommonAiThreat.is_valid = function(l_3_0)
	return l_3_0._is_valid
end

CommonAiThreat.merge = function(l_4_0, l_4_1)
	cat_print("ai", "merging threats")
	if l_4_0._last_time < l_4_1._last_time then
		l_4_0._last_time = l_4_1._last_time
		l_4_0._last_damage_direction = l_4_1._last_damage_direction
		l_4_0._last_known_position = l_4_1._last_known_position
	end
	l_4_0._damage = l_4_0._damage + l_4_1._damage
	local l_4_2 = assert
	l_4_2(l_4_0._unit == l_4_1._unit)
end

CommonAiThreat.set_last_time = function(l_5_0, l_5_1)
	l_5_0._time = l_5_1
	l_5_0._last_time = l_5_1
end

CommonAiThreat.last_time = function(l_6_0)
	return l_6_0._last_time
end

CommonAiThreat.set_last_damage_direction = function(l_7_0, l_7_1)
	l_7_0._last_damage_direction = l_7_1
end

CommonAiThreat.set_last_known_position = function(l_8_0, l_8_1)
	l_8_0._last_known_position = l_8_1
end

CommonAiThreat.last_known_position = function(l_9_0)
	return l_9_0._last_known_position
end

CommonAiThreat.set_last_seen_position = function(l_10_0, l_10_1)
	l_10_0._last_seen_position = l_10_1
end

CommonAiThreat.last_seen_position = function(l_11_0)
	return l_11_0._last_seen_position
end

CommonAiThreat.last_known_direction = function(l_12_0)
	if l_12_0._last_known_position then
		return l_12_0._last_known_position - l_12_0._position_func():normalized()
	else
		return l_12_0._last_damage_direction
	end
end

CommonAiThreat.associate_event = function(l_13_0, l_13_1)
	l_13_0._buffered_event = l_13_1
	l_13_0:set_last_known_position(l_13_1.event:position())
end

CommonAiThreat.associated_event = function(l_14_0)
	if l_14_0._buffered_event then
		return l_14_0._buffered_event.event
	else
		return nil
	end
end

CommonAiThreat.add_damage = function(l_15_0, l_15_1)
	l_15_0._damage = l_15_0._damage + l_15_1
end

CommonAiThreat.damage = function(l_16_0)
	return l_16_0._damage
end

CommonAiThreat.add_non_damage_agression = function(l_17_0)
	l_17_0._non_damage_agression = l_17_0._non_damage_agression + 0.01
end

CommonAiThreat.non_damage_agression = function(l_18_0)
	return l_18_0._non_damage_agression
end

CommonAiThreat.associate_unit = function(l_19_0, l_19_1)
	assert(not l_19_0._unit_assigned)
	l_19_0._unit = l_19_1
	l_19_0._unit_assigned = true
	if managers.player:is_unit_human_player(l_19_1) then
		l_19_0._is_human_player = true
	end
end

CommonAiThreat.unit = function(l_20_0)
	return l_20_0._unit
end

CommonAiThreat.unit_associated = function(l_21_0)
	return l_21_0._unit_assigned
end

CommonAiThreat.set_unit_line_of_sight = function(l_22_0, l_22_1, l_22_2)
	local l_22_3 = assert
	l_22_3(type(l_22_1) == "boolean")
	if l_22_1 then
		l_22_3 = assert
		l_22_3(l_22_2)
		l_22_3 = l_22_0._line_of_sight_delay_time
		if l_22_3 then
			l_22_3 = l_22_0._line_of_sight_delay_time
		if l_22_2 < l_22_3 then
			end
		end
		l_22_0._line_of_sight_delay_time = l_22_2
	else
		l_22_0._line_of_sight_delay_time = nil
	end
	l_22_0._unit_line_of_sight = l_22_1
end

CommonAiThreat.unit_line_of_sight = function(l_23_0)
	if l_23_0._unit_line_of_sight and l_23_0._time < l_23_0._line_of_sight_delay_time then
		return false
	end
	return l_23_0._unit_line_of_sight
end

CommonAiThreat.set_unit_line_of_fire = function(l_24_0, l_24_1)
	local l_24_2 = assert
	l_24_2(type(l_24_1) == "boolean")
	l_24_0._unit_line_of_fire = l_24_1
end

CommonAiThreat.unit_line_of_fire = function(l_25_0)
	return l_25_0._unit_line_of_fire
end

CommonAiThreat.set_cluster_info = function(l_26_0, l_26_1, l_26_2)
	l_26_0._cluster_size = l_26_1
	l_26_0._normalized_cluster_distance = l_26_2
end

CommonAiThreat.unit_dead = function(l_27_0)
	if not l_27_0._unit_assigned then
		return false
	end
	if alive(l_27_0._unit) then
		local l_27_1 = l_27_0._unit:damage_data():is_fully_damaged()
		l_27_1 = l_27_1
		return l_27_1
	end
end

CommonAiThreat.threat_level = function(l_28_0)
	return l_28_0:damage() + l_28_0:non_damage_agression()
end

CommonAiThreat.primary_target_priority = function(l_29_0)
	return l_29_0._primary_target_priority
end

CommonAiThreat.secondary_target_priority = function(l_30_0)
	return l_30_0._secondary_target_priority
end

CommonAiThreat._recompute_target_priority = function(l_31_0)
	if l_31_0:unit_dead() then
		l_31_0._primary_target_priority = 0
		l_31_0._secondary_target_priority = 0
		return 
	end
	local l_31_1 = nil
	if l_31_0:unit_line_of_sight() then
		l_31_1 = mvector3.distance(l_31_0._unit:position(), l_31_0._position_func())
	end
	l_31_0._primary_target_priority = l_31_0:_calculate_target_priority(l_31_0._threat_constants.primary_weights, l_31_1)
	if l_31_0._threat_constants.secondary_weights then
		l_31_0._secondary_target_priority = l_31_0:_calculate_target_priority(l_31_0._threat_constants.secondary_weights, l_31_1)
	end
end

CommonAiThreat._calculate_target_priority = function(l_32_0, l_32_1, l_32_2)
	local l_32_3 = math.lerp(l_32_1.MIN_DAMAGE_FACTOR, l_32_1.MAX_DAMAGE_FACTOR, math.clamp(l_32_1.DAMAGE_SCALE * l_32_0:damage() / l_32_0._health_func(), 0, 1))
	local l_32_4 = iff
	l_32_4 = l_32_4(l_32_0:damage() > 0, 1, math.clamp(l_32_0:non_damage_agression(), l_32_1.MIN_AGGRESSION_FACTOR, l_32_1.MAX_AGGRESSION_FACTOR))
	local l_32_7 = math.lerp(l_32_1.NO_LOS_FACTOR, l_32_1.HAS_LOS_FACTOR, l_32_0._unit_line_of_sight_value)
	local l_32_8 = math.lerp(l_32_1.NO_LOF_FACTOR, l_32_1.HAS_LOF_FACTOR, l_32_0._unit_line_of_fire_value)
	if l_32_2 and l_32_2 < l_32_1.PROXIMITY_OVERRIDE_RANGE then
		do return end
	end
	do
		local l_32_9 = 0.5 * (0.9 + 0.1 * (l_32_4 * l_32_3 * l_32_7 * l_32_8))
	end
	if l_32_0._threat_constants.ENABLE_UNIT_CLUSTERING and l_32_0._cluster_size > 0 then
		local l_32_10 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_32_0._cluster_size == 1 then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_32_10 = l_32_10 * nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_32_1.HUMAN_PLAYER_FACTOR or l_32_1.IN_COVER_FACTOR then
		local l_32_11, l_32_12, l_32_13 = l_32_10 * iff(l_32_0._is_human_player, l_32_1.HUMAN_PLAYER_FACTOR, l_32_1.NON_HUMAN_PLAYER_FACTOR) * iff(l_32_0._in_cover, l_32_1.IN_COVER_FACTOR, l_32_1.OUT_OF_COVER_FACTOR)
	end
	local l_32_14 = nil
	assert(l_32_14 >= 0 and l_32_14 <= 1)
	if l_32_0._unit and l_32_0._unit:ai_data() then
		if l_32_0._unit_line_of_fire and l_32_0:unit_line_of_sight() then
			l_32_14 = math.max(l_32_0._unit:ai_data()._min_target_weight, l_32_14)
		end
		l_32_14 = math.min(l_32_0._unit:ai_data()._max_target_weight, l_32_14)
	end
	return l_32_14
end

CommonAiThreat._update_damage_declination = function(l_33_0, l_33_1)
	l_33_0._damage = math.max(0, l_33_0._damage - l_33_0._damage * l_33_0._threat_constants.DAMAGE_DECLINATION_FACTOR * l_33_1)
end

CommonAiThreat._update_los_declination = function(l_34_0, l_34_1)
	if l_34_0:unit_line_of_sight() then
		l_34_0._unit_line_of_sight_value = 1
	else
		l_34_0._unit_line_of_sight_value = math.max(0, l_34_0._unit_line_of_sight_value - l_34_0._threat_constants.LOS_DECLINATION_FACTOR * l_34_1)
	end
end

CommonAiThreat._update_lof_declination = function(l_35_0, l_35_1)
	if l_35_0:unit_line_of_fire() then
		l_35_0._unit_line_of_fire_value = 1
	else
		l_35_0._unit_line_of_fire_value = math.max(0, l_35_0._unit_line_of_fire_value - l_35_0._threat_constants.LOF_DECLINATION_FACTOR * l_35_1)
	end
end

CommonAiThreat._update_cover_state = function(l_36_0)
	if not alive(l_36_0._unit) then
		return 
	end
	local l_36_1 = l_36_0._unit:player_data()
	if not l_36_1 then
		return 
	end
	l_36_0._in_cover = l_36_1.in_cover
end

CommonAiThreat.update = function(l_37_0, l_37_1)
	local l_37_2 = l_37_1 - l_37_0._last_frame_time
	l_37_0._last_frame_time = l_37_1
	l_37_0._time = l_37_1
	l_37_0:_update_damage_declination(l_37_2)
	l_37_0:_update_los_declination(l_37_2)
	l_37_0:_update_lof_declination(l_37_2)
	l_37_0:_update_cover_state()
	if l_37_0:unit_line_of_sight() and alive(l_37_0._unit) then
		l_37_0:set_last_time(l_37_1)
		local l_37_3 = l_37_0._unit:position()
		l_37_0:set_last_known_position(l_37_3)
		l_37_0:set_last_seen_position(l_37_3)
	elseif l_37_0._buffered_event and l_37_0._buffered_event.event:valid() then
		l_37_0:set_last_time(l_37_1)
		l_37_0:set_last_known_position(l_37_0._buffered_event.event:position())
	end
	if l_37_0._buffered_event and l_37_0._buffered_event.has_ended then
		l_37_0._buffered_event = nil
	end
	l_37_0:_recompute_target_priority()
end


