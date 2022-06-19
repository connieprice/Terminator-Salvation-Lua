require("units/damage/StunDamageBody")
StunDamage = StunDamage or class()
function StunDamage.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._unit = A1_1
	A0_0._unit_damage = A2_2
	A0_0._enemy_data = A1_1:enemy_data()
	A0_0:_setup_stun_bodies(A3_3)
	A0_0._was_stunned = A0_0._enemy_data.is_stunned
end
function StunDamage.destroy(A0_4)
	for 