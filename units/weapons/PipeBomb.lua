require("units/weapons/PipeBombDamage.lua")
if not PipeBomb then
	PipeBomb = class()
end
PipeBomb.init = function(l_1_0, l_1_1)
	l_1_1:push(l_1_1:mass(), l_1_1:rotation():y() * 2 * l_1_0._initial_velocity)
	l_1_0._unit = l_1_1
	l_1_0._detonation_time = 5
	l_1_0._explode_when_dead = true
end

PipeBomb.update = function(l_2_0, l_2_1, l_2_2, l_2_3)
	l_2_0._detonation_time = l_2_0._detonation_time - l_2_3
	if l_2_0._detonation_time <= 0 or l_2_0._unit:damage_data() and l_2_0._unit:damage_data():is_fully_damaged() and l_2_0._explode_when_dead then
		World:spawn_unit("explosion", l_2_0._unit:position())
		local l_2_4, l_2_5 = World:effect_manager():spawn, World:effect_manager()
		local l_2_6 = {}
		l_2_6.effect = "weapon_m79_explosion"
		l_2_6.position = l_2_0._unit:position()
		l_2_6.rotation = l_2_0._unit:rotation()
		l_2_4(l_2_5, l_2_6)
		l_2_4 = l_2_0._unit
		l_2_4, l_2_5 = l_2_4:set_slot, l_2_4
		l_2_6 = 0
		l_2_4(l_2_5, l_2_6)
	end
end

PipeBomb.bullet_hit = function(l_3_0)
	World:spawn_unit("explosion", l_3_0._unit:position())
	local l_3_1, l_3_2 = World:effect_manager():spawn, World:effect_manager()
	local l_3_3 = {}
	l_3_3.effect = "weapon_m79_explosion"
	l_3_3.position = l_3_0._unit:position()
	l_3_3.rotation = l_3_0._unit:rotation()
	l_3_1(l_3_2, l_3_3)
	l_3_1 = l_3_0._unit
	l_3_1, l_3_2 = l_3_1:set_slot, l_3_1
	l_3_3 = 0
	l_3_1(l_3_2, l_3_3)
end


