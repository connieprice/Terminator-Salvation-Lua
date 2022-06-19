if not WeaponLogic then
	WeaponLogic = class()
end
WeaponLogic.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._unit = l_1_1
	l_1_0._weapon = l_1_2
	l_1_0._weapon_data = l_1_2:weapon_data()
	l_1_0._fire_object = l_1_2:get_object("fire")
	assert(l_1_0._fire_object)
end

WeaponLogic.update = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6)
end

WeaponLogic._update_weapon_data = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
	local l_3_5 = l_3_0._weapon_data
	l_3_5.prepare_fire = l_3_1
	l_3_5.fire_input = l_3_2
	l_3_5.aim_target_position = l_3_3
	l_3_5.miss_dispersion = l_3_4
	if l_3_5._reload_ready and l_3_5._reload_required then
		l_3_5._reload_request = true
	end
end

WeaponLogic._aiming_at_target = function(l_4_0, l_4_1, l_4_2)
	if not l_4_1 then
		return false
	end
	local l_4_3 = l_4_0._fire_object
	assert(l_4_3)
	local l_4_4 = l_4_3:position()
	mvector3.negate(l_4_4)
	mvector3.add(l_4_4, l_4_1)
	local l_4_5 = mvector3.normalize(l_4_4)
	if l_4_5 > 0 then
		local l_4_6 = l_4_3:rotation():y()
		local l_4_7 = mvector3.angle(l_4_4, l_4_6)
		return l_4_7 <= l_4_2
	else
		return false
	end
end


