require("units/BodyDamage")
DestroyableBodyDamage = DestroyableBodyDamage or class(BodyDamage)
function DestroyableBodyDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7)
	BodyDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, "steel")
	A0_0._health = A5_5
	A0_0._give_unit_damage_while_destroyed = A6_6
	A0_0._destroyed_callback = A7_7
	A0_0._local_damage = 0
	A0_0._destroyed = false
end
function DestroyableBodyDamage.faith_damage(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13)
	local L6_14, L7_15
	L6_14 = A0_8._destroyed
	if L6_14 then
		L6_14 = A0_8._give_unit_damage_while_destroyed
		if not L6_14 then
			L6_14 = 0
			return L6_14
		end
	end
	L6_14 = BodyDamage
	L6_14 = L6_14.faith_damage
	L7_15 = A0_8
	L7_15 = L6_14(L7_15, A1_9, A2_10, A3_11, A4_12, A5_13)
	A0_8._local_damage = A0_8._local_damage + L7_15
	if not A0_8._destroyed and A0_8._local_damage >= A0_8._health then
		A0_8._destroyed = true
		A0_8:destroyed()
	end
	return L6_14, L7_15
end
function DestroyableBodyDamage.destroyed(A0_16)
	if A0_16._destroyed_callback then
		A0_16._destroyed_callback()
	end
end
