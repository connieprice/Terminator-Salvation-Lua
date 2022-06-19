EnemyData = EnemyData or class()
function EnemyData.init(A0_0, A1_1)
	A0_0.is_firing = false
	A0_0.is_reloading = false
	A0_0.preparing_to_fire = false
	A0_0.dead = false
	A0_0.can_be_stunned = true
	A0_0.stun_request = false
	A0_0.is_stunned = false
	A0_0.num_scans = 0
	A0_0.full_outline_by_deafult = false
	A0_0.full_outline_by_full_weapon = true
	A0_0.only_outline_by_full_weapon = false
end
