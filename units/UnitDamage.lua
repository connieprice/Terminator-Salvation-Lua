if not UnitDamage then
	UnitDamage = class(CoreUnitDamage)
end
UnitDamage.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	local l_1_7 = CoreUnitDamage.init
	local l_1_8 = l_1_0
	local l_1_9 = l_1_1
	do
		l_1_7(l_1_8, l_1_9, l_1_2 or BodyDamage, l_1_3, l_1_4, l_1_5, l_1_6)
		l_1_0._callbacks, l_1_7 = l_1_7, {}
		l_1_0._can_die = true
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UnitDamage.destroy = function(l_2_0)
	CoreUnitDamage:destroy()
end

UnitDamage.set_damage_multiplier = function(l_3_0, l_3_1)
	local l_3_5, l_3_6, l_3_7, l_3_8 = nil
	for i_0,i_1 in pairs(l_3_0._unit_element._bodies) do
		if l_3_0._unit:body(i_1._name) then
			assert(l_3_0._unit:body(i_1._name):extension().damage)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			assert(l_3_0._unit:body(i_1._name):extension().damage.set_damage_multiplier, "Body " .. l_3_10._name .. " damage type is not derived from BodyDamage")
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_3_0._unit:body(i_1._name):extension().damage:set_damage_multiplier(l_3_1)
		end
	end
end

UnitDamage.set_immune_to_damage = function(l_4_0, l_4_1)
	l_4_0._immune_to_damage = l_4_1
end

UnitDamage.immune_to_damage = function(l_5_0)
	return l_5_0._immune_to_damage
end

UnitDamage.set_can_die = function(l_6_0, l_6_1)
	l_6_0._can_die = l_6_1
end

UnitDamage.can_die = function(l_7_0)
	if l_7_0._can_die then
		return not l_7_0._immune_to_damage
	end
end

UnitDamage.set_fully_damaged = function(l_8_0)
	local l_8_1 = l_8_0._unit:damage_data()
	l_8_1.damage = l_8_1.health
	l_8_0._has_reported_fully_damaged = true
	l_8_0:fully_damaged()
end

UnitDamage.revive = function(l_9_0)
	l_9_0._has_reported_fully_damaged = false
	l_9_0._unit:damage_data():revive()
end

UnitDamage.outside_worlds_bounding_box = function(l_10_0)
	CoreUnitDamage.outside_worlds_bounding_box(l_10_0)
	if alive(l_10_0._unit) then
		if l_10_0._unit:player_data() ~= nil then
			managers.user_viewport:pause_all_sounds()
			managers.game_transition:game_over()
		end
	else
		managers.unit_scripting:unit_dead(l_10_0._unit)
		l_10_0._unit:set_slot(0)
	end
end

UnitDamage.add_damage = function(l_11_0, l_11_1, l_11_2, l_11_3, l_11_4, l_11_5, l_11_6, l_11_7, l_11_8)
	if alive(l_11_2) and l_11_2:slot() == l_11_0._unit:slot() then
		return 
	end
	local l_11_9 = l_11_0._unit:damage_data()
	if l_11_9 then
		if l_11_0._immune_to_damage then
			return 
		end
		if l_11_0._can_die or l_11_0._unit:control():is_human_controlled() then
			l_11_9.damage = l_11_9.damage + l_11_7
		end
		local l_11_10 = assert
		l_11_10(l_11_7 >= 0)
		l_11_10 = l_11_0._has_reported_fully_damaged
	if not l_11_10 then
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

	if l_11_10 then
		end
		l_11_0._has_reported_fully_damaged = true
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_11_16, l_11_18 = l_11_0, l_11_2
		local l_11_17, l_11_19 = l_11_1, l_11_3
		l_11_10(l_11_16, l_11_18, l_11_17, l_11_19, l_11_4, l_11_5, l_11_6, l_11_7, l_11_8)
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_11_16 = l_11_2
		l_11_10(l_11_16)
		l_11_0._attack_unit = l_11_2
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0,i_1 in l_11_10(l_11_0._callbacks) do
		i_1(l_11_7, l_11_5, l_11_6, l_11_1, l_11_2, l_11_3)
	end
	local l_11_20 = l_11_2
	local l_11_21 = l_11_3
	local l_11_22 = l_11_4
	local l_11_23 = l_11_5
	local l_11_24 = l_11_6
	local l_11_25 = l_11_7
	do
		local l_11_26 = l_11_8
		return CoreUnitDamage.add_damage(l_11_0, l_11_1, l_11_20, l_11_21, l_11_22, l_11_23, l_11_24, l_11_25, l_11_26)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UnitDamage.fully_damaged_inflictor = function(l_12_0)
	return l_12_0._attack_unit
end

UnitDamage.register_damage_callback = function(l_13_0, l_13_1)
	l_13_0._callbacks[l_13_1] = l_13_1
end

UnitDamage.unregister_damage_callback = function(l_14_0, l_14_1)
	l_14_0._callbacks[l_14_1] = nil
end

UnitDamage.fully_damaged = function(l_15_0, l_15_1)
	print("Killing unit " .. l_15_0._unit:name())
	l_15_0._unit:set_slot(0)
end

UnitDamage.get_weakspots = function(l_16_0)
	if not l_16_0._show_weakspots_time or l_16_0._show_weakspots_time <= Application:time() then
		return nil
	end
	if l_16_0._weak_spot_name and l_16_0._weak_spot_type then
		local l_16_1 = {}
		local l_16_2 = nil
		local l_16_5 = l_16_0._unit:damage_data().damage < l_16_0._unit:damage_data().health
		if l_16_0._weak_spot_type == "object3d" then
			local l_16_6 = nil
			l_16_2 = l_16_0._unit:get_object(l_16_0._weak_spot_name):position()
		elseif l_16_0._weak_spot_type == "body" then
			local l_16_7 = nil
			l_16_2 = l_16_0._unit:body(l_16_0._weak_spot_name):center_of_mass()
			l_16_7 = l_16_0._unit:body(l_16_0._weak_spot_name):name()
		else
			assert(false)
		end
		if l_16_2 then
			local l_16_8 = nil
			local l_16_9 = table.insert
			local l_16_10 = l_16_1
			l_16_9(l_16_10, {name = l_16_0._weak_spot_name, pos = l_16_2, active = l_16_5, body_name = l_16_8})
		end
		return l_16_1, l_16_0._show_weakspots_time, l_16_0._show_weakspots_range
	else
		return nil
	end
end

UnitDamage.set_show_weakspots = function(l_17_0, l_17_1, l_17_2)
	l_17_0._show_weakspots_time = Application:time() + l_17_1
	l_17_0._show_weakspots_range = l_17_2
end

UnitDamage.get_outline_weakspots = function(l_18_0)
end

UnitDamage.check_outline_weakspot = function(l_19_0)
end

UnitDamage.hide_all_outline_weakspots = function(l_20_0)
end


