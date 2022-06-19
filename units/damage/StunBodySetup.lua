StunBodySetup = StunBodySetup or class()
function StunBodySetup.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	assert(A1_1)
	assert(A2_2)
	assert(A3_3)
	A0_0.body_name = A1_1
	A0_0.max_health = A2_2
	A0_0.health_per_second = A3_3
	A0_0.damage_unit = A4_4
end
