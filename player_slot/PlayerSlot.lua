if not PlayerSlot then
	PlayerSlot = class()
end
PlayerSlot.init = function(l_1_0, l_1_1)
	if l_1_1.user_index then
		l_1_0._user = managers.local_user:user_from_user_index(l_1_1.user_index)
	end
end

PlayerSlot.default_data = function(l_2_0)
	l_2_0.user_index = nil
end

PlayerSlot.save = function(l_3_0, l_3_1)
	if not l_3_0._user then
		return 
	end
	l_3_1.user_index = l_3_0._user:user_index()
end

PlayerSlot.set_user = function(l_4_0, l_4_1, l_4_2)
	assert(l_4_1)
	assert(not l_4_0._user)
	l_4_0._user = l_4_1
	l_4_0._is_primary_user = l_4_2
	if not l_4_0._is_primary_user then
		l_4_0._user:profile().difficulty_level = managers.save:profile().difficulty_level
	end
	l_4_0:update_control()
end

PlayerSlot.release_user = function(l_5_0)
	assert(l_5_0._user)
	l_5_0._user = nil
	l_5_0._is_primary_user = false
	l_5_0:update_control()
end

PlayerSlot.is_occupied = function(l_6_0)
	return l_6_0._user ~= nil
end

PlayerSlot.user = function(l_7_0)
	return l_7_0._user
end

PlayerSlot.set_unit = function(l_8_0, l_8_1, l_8_2, l_8_3, l_8_4, l_8_5, l_8_6)
	assert(l_8_1)
	assert(not l_8_0._unit)
	l_8_0._ai_controllable = l_8_5
	l_8_0._human_controllable = l_8_6
	l_8_0._unit = l_8_1
	l_8_0:update_control()
end

PlayerSlot.set_spawn_point = function(l_9_0, l_9_1, l_9_2, l_9_3, l_9_4, l_9_5, l_9_6, l_9_7, l_9_8)
	l_9_0._ai_controllable = l_9_4
	l_9_0._human_controllable = l_9_5
	if not alive(l_9_0._unit) then
		l_9_0._unit = nil
	end
	if not l_9_0._unit or l_9_0._unit:name() ~= l_9_1 then
		if l_9_0._unit then
			if l_9_0._user then
				l_9_0._user:release_assigned_unit()
			end
			l_9_0._unit:set_slot(0)
		end
		l_9_0._unit = World:spawn_unit(l_9_1, l_9_2, l_9_3)
		if l_9_0._ai_controllable then
			l_9_0._unit:ai_nerve_system():setup(l_9_6)
		end
		l_9_0:update_control()
	end
	if l_9_7 then
		local l_9_9 = l_9_2 - l_9_0._unit:position():length()
	if l_9_8 < l_9_9 then
		end
		UnitSpawnUtility.warp_to(l_9_0._unit, l_9_3, l_9_2)
	end
end

PlayerSlot.update = function(l_10_0)
	if not alive(l_10_0._unit) then
		l_10_0._unit = nil
	end
end

PlayerSlot.update_control = function(l_11_0)
	if not alive(l_11_0._unit) then
		l_11_0._unit = nil
	end
	if not l_11_0._unit then
		return 
	end
	if l_11_0._human_controllable and l_11_0._user then
		assert(l_11_0._unit)
		if l_11_0._user:assigned_unit() ~= l_11_0._unit then
			l_11_0._user:set_assigned_unit(l_11_0._unit)
			local l_11_1 = l_11_0._user:profile()
			local l_11_2 = managers.save:profile()
			local l_11_3 = l_11_2.current_checkpoint_id
			local l_11_4 = l_11_2.current_level_id
			local l_11_5 = l_11_1.levels[l_11_4]
			local l_11_6 = false
			if l_11_5 and l_11_3 <= l_11_5.maximum_checkpoint_id then
				local l_11_7 = l_11_5.checkpoints[l_11_3]
			if l_11_7.inventory.items[1].name ~= "" then
				end
				l_11_0._unit:base():spawn_weapon_state(l_11_7.inventory.items)
				l_11_6 = true
			end
		if not l_11_6 then
			end
			l_11_0._unit:base():spawn_human_controllable_weapons()
		end
	elseif l_11_0._ai_controllable then
		l_11_0._unit:control():set_ai_controlled()
	else
		l_11_0._unit:control():set_no_control()
	end
end

PlayerSlot.spawned_unit = function(l_12_0)
	return l_12_0._unit
end


