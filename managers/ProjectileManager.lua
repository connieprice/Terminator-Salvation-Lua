ProjectileManager = ProjectileManager or class()
function ProjectileManager.init(A0_0)
	local L1_1
	L1_1 = {}
	A0_0._handles = L1_1
	A0_0._handle_id = 1
	L1_1 = {}
	A0_0._projectiles = L1_1
	L1_1 = {}
	A0_0._issued_projectiles = L1_1
	A0_0._target_projectiles_per_frame = 5
	A0_0._target_delay_time = 0.3
	A0_0._report_spawn_time = false
	A0_0._report_spawn_time_threshold = 0.3
	A0_0._report_issue_time = false
	A0_0._report_issue_time_threshold = 0.3
end
function ProjectileManager.update(A0_2, A1_3, A2_4)
	local L3_5, L4_6, L5_7, L6_8
	L3_5 = 0
	while true do
		if L3_5 < L4_6 then
			L5_7(L6_8, 1)
			if L5_7 then
				if A0_2._report_spawn_time and L4_6.time > A0_2._report_spawn_time_threshold then
					print("Projectile spawned: ", L4_6.time, #A0_2._projectiles)
				end
				table.insert(A0_2._issued_projectiles, {
					bullet = L4_6.callback(L6_8, L4_6.position, L4_6.rotation, L4_6.spawn_unit),
					time = 0
				})
			end
			L3_5 = L3_5 + 1
		end
	end
	for 