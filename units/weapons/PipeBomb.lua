require("units/weapons/PipeBombDamage.lua")
PipeBomb = PipeBomb or class()
function PipeBomb.init(A0_0, A1_1)
	A1_1:push(A1_1:mass(), A1_1:rotation():y() * 2 * A0_0._initial_velocity)
	A0_0._unit = A1_1
	A0_0._detonation_time = 5
	A0_0._explode_when_dead = true
end
function PipeBomb.update(A0_2, A1_3, A2_4, A3_5)
	A0_2._detonation_time = A0_2._detonation_time - A3_5
	if A0_2._detonation_time <= 0 or A0_2._unit:damage_data() and A0_2._unit:damage_data():is_fully_damaged() and A0_2._explode_when_dead then
		World:spawn_unit("explosion", A0_2._unit:position())
		World:effect_manager():spawn({
			effect = "weapon_m79_explosion",
			position = A0_2._unit:position(),
			rotation = A0_2._unit:rotation()
		})
		A0_2._unit:set_slot(0)
	end
end
function PipeBomb.bullet_hit(A0_6)
	World:spawn_unit("explosion", A0_6._unit:position())
	World:effect_manager():spawn({
		effect = "weapon_m79_explosion",
		position = A0_6._unit:position(),
		rotation = A0_6._unit:rotation()
	})
	A0_6._unit:set_slot(0)
end
