require("units/damage/StunDamageBody")
if not StunDamage then
	StunDamage = class()
end
StunDamage.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._unit = l_1_1
	l_1_0._unit_damage = l_1_2
	l_1_0._enemy_data = l_1_1:enemy_data()
	l_1_0:_setup_stun_bodies(l_1_3)
	l_1_0._was_stunned = l_1_0._enemy_data.is_stunned
end

StunDamage.destroy = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7 = nil
	for i_0,i_1 in pairs(l_2_0._stun_damage_bodies) do
		i_1:destroy()
	end
end

StunDamage.update = function(l_3_0, l_3_1)
	local l_3_8, l_3_9, l_3_10, l_3_11, l_3_12, l_3_13, l_3_14, l_3_15, l_3_16, l_3_17 = nil
	local l_3_2 = l_3_0._enemy_data
	local l_3_3 = l_3_2.is_stunned
	local l_3_4 = false
	for i_0,i_1 in pairs(l_3_0._stun_damage_bodies) do
		i_1:update(l_3_1)
		if l_3_3 then
			i_1:reset()
		elseif not l_3_4 then
			l_3_4 = i_1:stunned()
		end
	end
	if l_3_2.can_be_stunned then
		l_3_2.stun_requested = l_3_4
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

StunDamage._setup_stun_bodies = function(l_4_0, l_4_1)
	local l_4_8, l_4_9, l_4_10, l_4_11 = nil
	local l_4_2 = l_4_0._unit
	local l_4_3 = l_4_0._unit_damage
	local l_4_4 = {}
	for i_0,i_1 in pairs(l_4_1) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		assert(l_4_2:body(i_1.body_name), i_1.body_name)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_4_14 = nil
		if not l_4_2:body(i_1.body_name):extension() then
			l_4_2:body(i_1.body_name):set_extension({})
		end
		l_4_2:body(i_1.body_name):extension().damage = StunDamageBody:new(l_4_2, l_4_3, l_4_2:body(i_1.body_name), l_4_3._unit_element:get_body_element(i_1.body_name), l_4_13.damage_unit, l_4_13.max_health, l_4_13.health_per_second)
		table.insert(l_4_4, StunDamageBody:new(l_4_2, l_4_3, l_4_2:body(i_1.body_name), l_4_3._unit_element:get_body_element(i_1.body_name), l_4_13.damage_unit, l_4_13.max_health, l_4_13.health_per_second))
	end
	l_4_0._stun_damage_bodies = l_4_4
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


