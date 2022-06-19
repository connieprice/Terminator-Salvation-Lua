HunterKillerDamageData = HunterKillerDamageData or class(DamageData)
function HunterKillerDamageData.init(A0_0, A1_1)
	DamageData.init(A0_0, A1_1)
	A0_0.last_damage_taken = 0
end
function HunterKillerDamageData.scale_health(A0_2, A1_3)
end
