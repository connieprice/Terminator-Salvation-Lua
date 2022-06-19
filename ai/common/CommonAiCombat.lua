CommonAiCombat = CommonAiCombat or class()
function CommonAiCombat.init_data(A0_0, A1_1)
	local L2_2, L3_3
	L2_2 = {}
	A1_1._combat = L2_2
	L2_2 = A1_1.output
	L2_2.secondary_weapon_firing_target = nil
	L2_2 = A1_1.output
	L2_2.secondary_weapon_firing_target_position = nil
	L2_2 = A1_1.output
	L2_2.secondary_weapon_allowed_to_fire = nil
	L2_2 = A1_1._combat
	L3_3 = CommonAiCombat
	L3_3 = L3_3._standard_select_firing_targets
	L2_2._select_firing_targets = L3_3
end
function CommonAiCombat.logic_common_combat_passive_enter(A0_4, A1_5, A2_6, A3_7)
	A2_6:ai_data().output.detected_threat = false
end
function CommonAiCombat.logic_common_combat_passive(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13, A6_14, A7_15)
	local L8_16
	L8_16 = A2_10.ai_data
	L8_16 = L8_16(A2_10)
	if A0_8:_has_threat(L8_16) then
		L8_16.output.detected_threat = true
		return 0
	end
	L8_16.output.allowed_to_fire = false
	L8_16.output.firing_target = nil
	L8_16.output.firing_target_position = nil
	L8_16.output.currently_targeted_threat = nil
	A0_8:_check_hide_in_cover(L8_16, false)
	return nil, true
end
function CommonAiCombat.logic_common_combat_alerted(A0_17, A1_18, A2_19, A3_20, A4_21, A5_22, A6_23, A7_24)
	local L8_25, L9_26
	L9_26 = A2_19
	L8_25 = A2_19.ai_data
	L8_25 = L8_25(L9_26)
	L9_26 = A0_17._has_threat
	L9_26 = L9_26(A0_17, L8_25)
	if not L9_26 then
		L9_26 = 0
		return L9_26
	end
	L9_26 = L8_25._behavior
	L9_26 = L9_26.allowed_to_fire
	if L9_26 then
		L9_26 = A0_17._direct_fire_possible
		L9_26 = L9_26(A0_17, L8_25)
		if L9_26 then
			L9_26 = 1
			return L9_26
		end
	end
	L9_26 = L8_25._behavior
	L9_26 = L9_26.allowed_to_fire
	if L9_26 then
		L9_26 = L8_25._combat
		L9_26 = L9_26._select_firing_targets
		L9_26(A2_19, L8_25, A1_18, false)
	else
		L9_26 = L8_25.output
		L9_26.firing_target = nil
		L9_26.firing_target_position = nil
		L9_26.allowed_to_fire = false
		L9_26.secondary_weapon_firing_target = nil
		L9_26.secondary_weapon_firing_target_position = nil
		L9_26.secondary_weapon_allowed_to_fire = false
	end
	L9_26 = L8_25.output
	L9_26.currently_targeted_threat = L8_25._targeting.currently_targeted_threat
	L9_26 = L8_25.output
	L9_26 = L9_26.firing_target
	if alive(L9_26) and L9_26:ai_data() and L9_26:ai_data().output.unaware then
		ai_data_output.allowed_to_fire = false
	end
	A0_17:_check_hide_in_cover(L8_25, false)
	return nil, true
end
function CommonAiCombat._standard_select_firing_targets(A0_27, A1_28, A2_29, A3_30)
	local L4_31, L5_32, L6_33, L7_34, L8_35, L9_36
	L4_31 = A1_28.output
	L5_32 = A1_28._targeting
	L5_32 = L5_32.currently_targeted_threat
	if not A3_30 then
		L7_34 = L5_32
		L6_33 = L5_32.last_seen_position
		L6_33 = L6_33(L7_34)
		L7_34 = false
		if L6_33 then
			L8_35 = A1_28._targeting
			L8_35 = L8_35.current_secondary_threats
			if L8_35 then
				L8_35 = A1_28._targeting
				L8_35 = L8_35.current_secondary_threats
				L8_35 = #L8_35
				if L8_35 > 0 then
					L8_35 = IntelUtilities
					L9_36 = L8_35
					L8_35 = L8_35.within_eye_fov
					L8_35 = L8_35(L9_36, A1_28.current_unit_eyes[1], L6_33)
					L7_34 = L8_35
				end
			end
		end
		if L7_34 then
			L8_35 = A1_28._targeting
			L8_35 = L8_35.current_secondary_threats
			L8_35 = L8_35[1]
			L9_36 = L8_35.unit_line_of_fire
			L9_36 = L9_36(L8_35)
			if L9_36 then
				L9_36 = L8_35.unit
				L9_36 = L9_36(L8_35)
				L4_31.firing_target = L9_36
				L4_31.firing_target_position = nil
				L4_31.allowed_to_fire = true
			else
				L9_36 = CommonAiCombat
				L9_36 = L9_36._threat_firing_position
				L9_36 = L9_36(A0_27:position(), L8_35)
				L4_31.firing_target = nil
				L4_31.firing_target_position = L9_36
				L4_31.allowed_to_fire = IntelUtilities.ai_have_position_line_of_fire(A0_27, L9_36, nil, 200)
			end
		else
			L8_35 = CommonAiCombat
			L8_35 = L8_35._threat_firing_position
			L9_36 = A0_27.position
			L9_36 = L9_36(A0_27)
			L8_35 = L8_35(L9_36, L5_32)
			if L8_35 then
				L4_31.firing_target = nil
				L4_31.firing_target_position = L8_35
				L9_36 = IntelUtilities
				L9_36 = L9_36.ai_have_position_line_of_fire
				L9_36 = L9_36(A0_27, L8_35, nil, 200)
				L4_31.allowed_to_fire = L9_36
			end
		end
	else
		L7_34 = L5_32
		L6_33 = L5_32.unit
		L6_33 = L6_33(L7_34)
		L4_31.firing_target = L6_33
		L4_31.firing_target_position = nil
		L4_31.allowed_to_fire = true
	end
end
function CommonAiCombat._threat_firing_position(A0_37, A1_38)
	local L2_39
	if A1_38:last_seen_position() then
		L2_39 = A1_38:last_seen_position()
		L2_39 = L2_39 + math.UP * 120
	elseif A1_38:last_known_position() then
		L2_39 = A1_38:last_known_position()
	else
		L2_39 = A0_37 + A1_38:last_known_direction():with_z(0) * 500
	end
	return L2_39
end
function CommonAiCombat.logic_common_combat_fighting(A0_40, A1_41, A2_42, A3_43, A4_44, A5_45, A6_46, A7_47)
	local L8_48, L9_49
	L9_49 = A2_42
	L8_48 = A2_42.ai_data
	L8_48 = L8_48(L9_49)
	L9_49 = L8_48._behavior
	L9_49 = L9_49.allowed_to_fire
	if not L9_49 then
		L9_49 = 0
		return L9_49
	end
	L9_49 = A0_40._has_threat
	L9_49 = L9_49(A0_40, L8_48)
	if not L9_49 then
		L9_49 = 0
		return L9_49
	end
	L9_49 = A0_40._direct_fire_possible
	L9_49 = L9_49(A0_40, L8_48)
	if not L9_49 then
		L9_49 = 0
		return L9_49
	end
	L9_49 = L8_48._combat
	L9_49 = L9_49._select_firing_targets
	L9_49(A2_42, L8_48, A1_41, true)
	L9_49 = L8_48.output
	L9_49.currently_targeted_threat = L8_48._targeting.currently_targeted_threat
	L9_49 = L8_48.output
	L9_49 = L9_49.firing_target
	if alive(L9_49) and L9_49:ai_data() and L9_49:ai_data().output.unaware then
		L8_48.output.allowed_to_fire = false
	end
	A0_40:_check_hide_in_cover(L8_48, true)
	return nil, true
end
function CommonAiCombat._direct_fire_possible(A0_50, A1_51)
	return A1_51._targeting.currently_targeted_threat:unit_line_of_sight() and A1_51._targeting.currently_targeted_threat:unit_line_of_fire()
end
function CommonAiCombat._check_hide_in_cover(A0_52, A1_53, A2_54)
	local L3_55
	L3_55 = A1_53._behavior
	L3_55 = L3_55.use_covers
	if not L3_55 then
		L3_55 = A1_53.output
		L3_55.hide_in_cover = false
		L3_55 = A1_53._combat
		L3_55.hide_in_cover_time = nil
		L3_55 = A1_53._combat
		L3_55.time_until_hide_in_cover = nil
		return
	end
	L3_55 = A1_53._movement
	L3_55 = L3_55._current_go_to
	if L3_55 then
		L3_55 = A1_53.output
		L3_55.hide_in_cover = true
		return
	end
	L3_55 = A1_53._behavior
	L3_55 = L3_55.arrive_orders
	if L3_55 then
		L3_55 = A1_53._behavior
		L3_55 = L3_55.arrive_orders
		L3_55 = L3_55.threat_mode
		if L3_55 == "ignore" then
			L3_55 = A1_53.output
			L3_55.hide_in_cover = true
			return
		end
	end
	L3_55 = A1_53.output
	L3_55 = L3_55.currently_targeted_threat
	if A1_53.input.time_since_incoming_fire > 5 and L3_55 and alive(L3_55:unit()) and L3_55:unit():ai_data() and L3_55:unit():ai_data().output.unaware then
		A1_53.output.hide_in_cover = true
		return
	end
	if A1_53.output.hide_in_cover then
		if A1_53.input.time_since_incoming_fire > 0 then
			if not A1_53._combat.hide_in_cover_time then
				A1_53._combat.hide_in_cover_time = math.rand(iff(A2_54, tweak_data.ai.humans.ai_player.TIME_HIDING_IN_COVER_AFTER_FIRED_ON_WITH_TARGET, tweak_data.ai.humans.ai_player.TIME_HIDING_IN_COVER_AFTER_FIRED_ON_WITHOUT_TARGET)[1], iff(A2_54, tweak_data.ai.humans.ai_player.TIME_HIDING_IN_COVER_AFTER_FIRED_ON_WITH_TARGET, tweak_data.ai.humans.ai_player.TIME_HIDING_IN_COVER_AFTER_FIRED_ON_WITHOUT_TARGET)[2])
			end
			if A1_53.input.time_since_incoming_fire > A1_53._combat.hide_in_cover_time then
				A1_53.output.hide_in_cover = false
				A1_53._combat.hide_in_cover_time = nil
			end
		end
	elseif 0 < A1_53.input.time_under_incoming_fire then
		if not A1_53._combat.time_until_hide_in_cover then
			A1_53._combat.time_until_hide_in_cover = math.rand(iff(A2_54, tweak_data.ai.humans.ai_player.TIME_UNTIL_HIDING_IN_COVER_WHEN_FIRED_ON, {0, 0})[1], iff(A2_54, tweak_data.ai.humans.ai_player.TIME_UNTIL_HIDING_IN_COVER_WHEN_FIRED_ON, {0, 0})[2])
		end
		if A1_53.input.time_under_incoming_fire > A1_53._combat.time_until_hide_in_cover then
			A1_53.output.hide_in_cover = true
			A1_53._combat.time_until_hide_in_cover = nil
		end
	end
end
function CommonAiCombat._has_threat(A0_56, A1_57)
	local L2_58
	L2_58 = A1_57._behavior
	L2_58 = L2_58.allowed_to_target
	if L2_58 then
		L2_58 = A1_57._targeting
		L2_58 = L2_58.currently_targeted_threat
	end
	return L2_58
end
function CommonAiCombat._debug_render(A0_59, A1_60)
	local L2_61, L3_62, L4_63
	L3_62 = A1_60
	L2_61 = A1_60.ai_data
	L2_61 = L2_61(L3_62)
	L3_62 = Draw
	L4_63 = L3_62
	L3_62 = L3_62.brush
	L3_62 = L3_62(L4_63)
	L4_63 = L3_62.set_persistance
	L4_63(L3_62, 0.5)
	L4_63 = nil
	if alive(L2_61.output.firing_target) then
		L4_63 = L2_61.output.firing_target:position()
	elseif L2_61.output.firing_target_position then
		L4_63 = L2_61.output.firing_target_position
	elseif L2_61._targeting.currently_targeted_threat then
		L4_63 = L2_61._targeting.currently_targeted_threat:last_known_position()
		L3_62:line(L4_63, A1_60:position() + Vector3(0, 0, 200), 10, Vector3(1, 0, 0))
		L3_62:line(L4_63, A1_60:position() + Vector3(0, 0, 200), 10, Vector3(0, 1, 0))
		return
	else
		return
	end
	if L2_61.output.allowed_to_fire then
		L3_62:set(Color(0, 1, 0))
	else
		L3_62:set(Color(1, 0, 0))
	end
	L3_62:line(L4_63, A1_60:position() + Vector3(0, 0, 200), 50, Vector3(1, 0, 0))
	L3_62:line(L4_63, A1_60:position() + Vector3(0, 0, 200), 50, Vector3(0, 1, 0))
end
