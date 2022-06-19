if not BodyDamageGroup then
	BodyDamageGroup = class()
end
BodyDamageGroup.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7, l_1_8, l_1_9)
	l_1_0.name = l_1_5
	l_1_0._unit = l_1_1
	l_1_0._unit_extension = l_1_2
	l_1_0._destroyed_sequence_name = l_1_3
	l_1_0._damaged_sequence_name = l_1_4
	l_1_0._damage = 0
	l_1_0._endurance = l_1_6
	l_1_0._destroyed = false
	l_1_0._group_destroyed_callback = l_1_7
	l_1_0._damage_steps = l_1_8
	l_1_0._can_recive_dmg = true
	l_1_0:get_next_damage_step()
	do
		l_1_0._damage_threshold = l_1_9 or 0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

BodyDamageGroup.add_damage = function(l_2_0, l_2_1)
	if l_2_0._can_recive_dmg == false or l_2_0._unit:damage_data().invulnerable then
		return 
	end
	if not l_2_0._destroyed then
		if l_2_0._endurance < l_2_0._damage then
			if l_2_0._destroyed_sequence_name and l_2_0._destroyed_sequence_name ~= "" then
				Application:debug("Running kill sequence: ", l_2_0._destroyed_sequence_name)
				managers.sequence:run_sequence_simple(l_2_0._destroyed_sequence_name, l_2_0._unit)
			end
		if l_2_0._group_destroyed_callback then
			end
			l_2_0._group_destroyed_callback(l_2_0)
		end
	elseif l_2_0._damage < l_2_0._endurance * l_2_0._damage_threshold and l_2_0._endurance * l_2_0._damage_threshold < l_2_0._damage and l_2_0._damaged_sequence_name ~= nil and l_2_0._damaged_sequence_name ~= "" then
		Application:debug("Running dmg sequence: ", l_2_0._damaged_sequence_name)
		managers.sequence:run_sequence_simple(l_2_0._damaged_sequence_name, l_2_0._unit)
	elseif l_2_0._next_damage_step ~= nil and l_2_0._next_damage_step.damage <= l_2_0._damage then
		managers.sequence:run_sequence_simple(l_2_0._next_damage_step.sequence_name, l_2_0._unit)
		l_2_0:get_next_damage_step()
	end
end

BodyDamageGroup.get_next_damage_step = function(l_3_0)
	if l_3_0._damage_steps ~= nil then
		l_3_0._next_damage_step = table.remove(l_3_0._damage_steps, 1)
	if l_3_0._next_damage_step then
		end
		l_3_0._next_damage_step.damage = l_3_0._next_damage_step.damage * l_3_0._endurance
	end
end

BodyDamageGroup.activate = function(l_4_0, l_4_1)
	l_4_0._can_recive_dmg = l_4_1
end

BodyDamageGroup.is_active = function(l_5_0)
	if l_5_0._can_recive_dmg then
		return not l_5_0._destroyed
	end
end


