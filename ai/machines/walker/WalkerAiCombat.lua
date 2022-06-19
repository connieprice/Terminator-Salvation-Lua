if not WalkerAiCombat then
	WalkerAiCombat = class(CommonAiCombat)
end
WalkerAiCombat.init_data = function(l_1_0, l_1_1)
	CommonAiCombat.init_data(l_1_0, l_1_1)
	l_1_1._combat._select_firing_targets = WalkerAiCombat._select_firing_targets
	l_1_1._combat._primary_fire_timer = 0
	l_1_1._combat._secondary_fire_timer = 0
end

WalkerAiCombat._select_firing_targets = function(l_2_0, l_2_1, l_2_2, l_2_3)
	if l_2_1._targeting.current_secondary_threats then
		local l_2_4, l_2_5 = not TableAlgorithms.is_empty(l_2_1._targeting.current_secondary_threats)
	end
	l_2_1._combat._last_time = l_2_1._combat._last_time or l_2_2
	local l_2_6 = nil
	WalkerAiCombat._update_firing_timers(l_2_1, l_2_2 - l_2_1._combat._last_time)
	local l_2_7 = nil
	local l_2_15 = l_2_1._targeting.currently_targeted_threat
	if l_2_3 then
		if l_2_1._combat._primary_fire_timer <= 0 then
			WalkerAiCombat._secondary_weapon_primary_target({
primary_weapon = {}, 
secondary_weapon = {}, primary_weapon = WalkerAiCombat._weapon_target(l_2_0, l_2_15)}, l_2_0, l_2_1)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		elseif l_2_1._combat._secondary_fire_timer <= 0 and l_2_1._targeting.current_secondary_threats[2] then
			WalkerAiCombat._secondary_weapon_secondary_target({
primary_weapon = {}, 
secondary_weapon = {}, primary_weapon = WalkerAiCombat._weapon_target(l_2_0, l_2_15)}, l_2_0, l_2_1)
		end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	else
		if l_2_1._targeting.current_secondary_threats[1] then
			{
primary_weapon = {}, 
secondary_weapon = {}, primary_weapon = WalkerAiCombat._weapon_target(l_2_0, l_2_15)}.primary_weapon = WalkerAiCombat._weapon_target(l_2_0, l_2_1._targeting.current_secondary_threats[1])
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			{
primary_weapon = {}, 
secondary_weapon = {}, primary_weapon = WalkerAiCombat._weapon_target(l_2_0, l_2_15)}.primary_weapon = WalkerAiCombat._weapon_target(l_2_0, l_2_15)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_2_1._combat._secondary_fire_timer <= 0 and l_2_1._targeting.current_secondary_threats[2] and l_2_1._targeting.current_secondary_threats[2] == l_2_1._targeting.current_secondary_threats[1] then
			WalkerAiCombat._secondary_weapon_secondary_target({
primary_weapon = {}, 
secondary_weapon = {}, primary_weapon = WalkerAiCombat._weapon_target(l_2_0, l_2_15)}, l_2_0, l_2_1)
		end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif l_2_1._combat._primary_fire_timer <= 0 then
		WalkerAiCombat._secondary_weapon_primary_target({
primary_weapon = {}, 
secondary_weapon = {}, primary_weapon = WalkerAiCombat._weapon_target(l_2_0, l_2_15)}, l_2_0, l_2_1)
	end
	local l_2_16 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_2_1.output.firing_target = ({
primary_weapon = {}, 
secondary_weapon = {}, primary_weapon = WalkerAiCombat._weapon_target(l_2_0, l_2_15)}).primary_weapon.target_unit
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_2_1.output.firing_target_position = ({
primary_weapon = {}, 
secondary_weapon = {}, primary_weapon = WalkerAiCombat._weapon_target(l_2_0, l_2_15)}).primary_weapon.target_position
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_2_1.output.allowed_to_fire = ({
primary_weapon = {}, 
secondary_weapon = {}, primary_weapon = WalkerAiCombat._weapon_target(l_2_0, l_2_15)}).primary_weapon.allowed_to_fire
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_2_1.output.secondary_weapon_firing_target = ({
primary_weapon = {}, 
secondary_weapon = {}, primary_weapon = WalkerAiCombat._weapon_target(l_2_0, l_2_15)}).secondary_weapon.target_unit
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_2_1.output.secondary_weapon_firing_target_position = ({
primary_weapon = {}, 
secondary_weapon = {}, primary_weapon = WalkerAiCombat._weapon_target(l_2_0, l_2_15)}).secondary_weapon.target_position
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_2_1.output.secondary_weapon_allowed_to_fire = ({
primary_weapon = {}, 
secondary_weapon = {}, primary_weapon = WalkerAiCombat._weapon_target(l_2_0, l_2_15)}).secondary_weapon.allowed_to_fire
end

WalkerAiCombat._update_firing_timers = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0._targeting.currently_targeted_threat
	if l_3_0._combat._primary_fire_timer > 0 then
		l_3_0._combat._primary_fire_timer = l_3_0._combat._primary_fire_timer - l_3_1
	end
	if l_3_0._combat._secondary_fire_timer > 0 then
		l_3_0._combat._secondary_fire_timer = l_3_0._combat._secondary_fire_timer - l_3_1
	end
	local l_3_3 = WalkerAiCombat._is_unit_quickmoving(l_3_2:unit())
	if l_3_3 and not l_3_0._combat._last_primary_target_quickmove_state then
		l_3_0._combat._primary_fire_timer = 0
	end
	l_3_0._combat._last_primary_target_quickmove_state = l_3_3
	local l_3_4 = false
	if l_3_0._targeting.current_secondary_threats[2] then
		l_3_4 = WalkerAiCombat._is_unit_quickmoving(l_3_0._targeting.current_secondary_threats[2]:unit())
	end
	if l_3_4 and not l_3_0._combat._last_secondary_target_quickmove_state then
		l_3_0._combat._secondary_fire_timer = 0
	end
	l_3_0._combat._last_secondary_target_quickmove_state = l_3_4
end

WalkerAiCombat._is_threat_quickmoving = function(l_4_0)
	local l_4_1 = l_4_0:unit()
	if not alive(l_4_1) then
		return false
	end
	local l_4_2 = WalkerAiCombat._is_unit_quickmoving
	local l_4_3 = l_4_1
	return l_4_2(l_4_3)
end

WalkerAiCombat._is_unit_quickmoving = function(l_5_0)
	if alive(l_5_0) then
		local l_5_1 = l_5_0:player_data()
	if l_5_1 then
		end
	if l_5_1.quickmove then
		end
		return true
	end
	return false
end

WalkerAiCombat._secondary_weapon_primary_target = function(l_6_0, l_6_1, l_6_2)
	local l_6_3 = l_6_2._targeting.currently_targeted_threat
	local l_6_4 = not WalkerAiCombat._is_threat_quickmoving(l_6_3)
	l_6_0.secondary_weapon = WalkerAiCombat._weapon_target(l_6_1, l_6_3, l_6_4)
	local l_6_5 = (l_6_1:ai_data())
	local l_6_6 = nil
	local l_6_7 = WalkerAiCombat._threat_in_cover(l_6_3)
	if l_6_3:unit_line_of_sight() and not l_6_7 then
		l_6_6 = tweak_data.ai.machines.walker.SECONDARY_WEAPON_ON_PRIMARY_TARGET_OUT_OF_COVER_TIME
	else
		l_6_6 = tweak_data.ai.machines.walker.SECONDARY_WEAPON_ON_PRIMARY_TARGET_TIME
	end
	l_6_5._combat._primary_fire_timer = math.random(l_6_6.min, l_6_6.max)
end

WalkerAiCombat._secondary_weapon_secondary_target = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = l_7_2._targeting.current_secondary_threats[2]
	local l_7_4 = not WalkerAiCombat._is_threat_quickmoving(l_7_3)
	l_7_0.secondary_weapon = WalkerAiCombat._weapon_target(l_7_1, l_7_3, l_7_4)
	local l_7_5 = l_7_1:ai_data()
	local l_7_6 = tweak_data.ai.machines.walker.SECONDARY_WEAPON_ON_SECONDARY_TARGET_TIME
	l_7_5._combat._secondary_fire_timer = math.random(l_7_6.min, l_7_6.max)
end

WalkerAiCombat._threat_in_cover = function(l_8_0)
	if not alive(l_8_0:unit()) then
		return false
	end
	local l_8_1 = l_8_0:unit():player_data()
	if not l_8_1 then
		return false
	end
	return l_8_1.in_cover
end

WalkerAiCombat._weapon_target = function(l_9_0, l_9_1, l_9_2)
	local l_9_3 = {}
	if not alive(l_9_1:unit()) then
		return l_9_3
	end
	local l_9_4 = l_9_1:unit_line_of_fire()
	if l_9_2 and WalkerAiCombat._threat_in_cover(l_9_1) then
		l_9_4 = false
	end
	if l_9_4 then
		l_9_3.target_unit = l_9_1:unit()
		l_9_3.allowed_to_fire = true
	else
		local l_9_5 = nil
		local l_9_6 = l_9_1:last_known_position()
		if l_9_6 and l_9_2 then
			local l_9_7 = l_9_0:position() - l_9_6
			if tweak_data.ai.machines.walker.SECONDARY_WEAPON_AVOID_DIRECT_FIRE_DISTANCE < l_9_7:length() then
				l_9_5 = l_9_1:last_known_position() + l_9_7:normalized() * tweak_data.ai.machines.walker.SECONDARY_WEAPON_AVOID_DIRECT_FIRE_DISTANCE
			end
		else
			l_9_5 = WalkerAiCombat._threat_firing_position(l_9_0:position(), l_9_1)
		end
	if l_9_5 then
		end
		l_9_3.target_position = l_9_5
		l_9_3.allowed_to_fire = IntelUtilities.ai_have_position_line_of_fire(l_9_0, l_9_5, nil, 200)
	end
	return l_9_3
end


