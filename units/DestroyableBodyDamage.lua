require("units/BodyDamage")
if not DestroyableBodyDamage then
	DestroyableBodyDamage = class(BodyDamage)
end
DestroyableBodyDamage.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7)
	BodyDamage.init(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, "steel")
	l_1_0._health = l_1_5
	l_1_0._give_unit_damage_while_destroyed = l_1_6
	l_1_0._destroyed_callback = l_1_7
	l_1_0._local_damage = 0
	l_1_0._destroyed = false
end

DestroyableBodyDamage.faith_damage = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5)
	if l_2_0._destroyed and not l_2_0._give_unit_damage_while_destroyed then
		return 0
	end
	local l_2_6, l_2_7 = BodyDamage.faith_damage(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5)
	l_2_0._local_damage = l_2_0._local_damage + l_2_7
	if not l_2_0._destroyed and l_2_0._health <= l_2_0._local_damage then
		l_2_0._destroyed = true
		l_2_0:destroyed()
	end
	return l_2_6, l_2_7
end

DestroyableBodyDamage.destroyed = function(l_3_0)
	if l_3_0._destroyed_callback then
		l_3_0._destroyed_callback()
	end
end


