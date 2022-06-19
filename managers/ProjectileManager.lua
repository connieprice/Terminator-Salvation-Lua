if not ProjectileManager then
	ProjectileManager = class()
end
ProjectileManager.init = function(l_1_0)
	l_1_0._handles = {}
	l_1_0._handle_id = 1
	l_1_0._projectiles = {}
	l_1_0._issued_projectiles = {}
	l_1_0._target_projectiles_per_frame = 5
	l_1_0._target_delay_time = 0.3
	l_1_0._report_spawn_time = false
	l_1_0._report_spawn_time_threshold = 0.3
	l_1_0._report_issue_time = false
	l_1_0._report_issue_time_threshold = 0.3
end

ProjectileManager.update = function(l_2_0, l_2_1, l_2_2)
	while 1 do
		local l_2_3 = 0
		while #l_2_0._projectiles > 0 and l_2_3 < l_2_0._target_projectiles_per_frame do
			local l_2_4 = l_2_0._projectiles[1]
			table.remove(l_2_0._projectiles, 1)
			local l_2_5 = l_2_0._handles[l_2_4.id]
			if l_2_5 then
				local l_2_6 = l_2_5.object
				if l_2_0._report_spawn_time and l_2_0._report_spawn_time_threshold < l_2_4.time then
					print("Projectile spawned: ", l_2_4.time, #l_2_0._projectiles)
				end
				local l_2_7, l_2_14, l_2_16 = l_2_4.callback(l_2_6, l_2_4.position, l_2_4.rotation, l_2_4.spawn_unit)
				l_2_14 = table
				l_2_14 = l_2_14.insert
				local l_2_8, l_2_15, l_2_17 = nil
				l_2_16 = l_2_0._issued_projectiles
				local l_2_9 = nil
				local l_2_10 = nil
				l_2_14(l_2_16, l_2_8)
				l_2_8 = {bullet = l_2_7, time = 0}
			end
			l_2_3 = l_2_3 + 1
		end
		for i_0,i_1 in ipairs(l_2_0._projectiles) do
			i_1.time = i_1.time + l_2_2
		end
		while 1 do
			while 1 do
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				if 1 <= #l_2_0._issued_projectiles then
					if l_2_0._issued_projectiles[1].bullet:finished() then
						if l_2_0._report_issue_time and l_2_0._report_issue_time_threshold < l_2_0._issued_projectiles[1].time then
							print("Projectile issue: ", l_2_0._issued_projectiles[1].time, #l_2_0._issued_projectiles)
						end
						 -- DECOMPILER ERROR: Confused about usage of registers!

						table.remove(l_2_0._issued_projectiles, 1)
						 -- DECOMPILER ERROR: Confused about usage of registers!

						l_2_0._issued_projectiles[1].bullet:destroy()
					end
					 -- DECOMPILER ERROR: Confused about usage of registers!

				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

				 -- WARNING: undefined locals caused missing assignments!
				 -- WARNING: missing end command somewhere! Added here
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

ProjectileManager.register_emitter = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0._handle_id
	local l_3_3 = l_3_0._handles
	local l_3_4 = {}
	l_3_4.object = l_3_1
	l_3_3[l_3_2] = l_3_4
	l_3_3 = l_3_0._handle_id
	l_3_3 = l_3_3 + 1
	l_3_0._handle_id = l_3_3
	return l_3_2
end

ProjectileManager.unregister_emitter = function(l_4_0, l_4_1)
	l_4_0._handles[l_4_1] = nil
end

ProjectileManager.spawn_projectile_event = function(l_5_0, l_5_1, l_5_2, l_5_3, l_5_4, l_5_5)
	local l_5_6 = table.insert
	local l_5_7 = l_5_0._projectiles
	local l_5_8 = {}
	l_5_8.id = l_5_1
	l_5_8.callback = l_5_2
	l_5_8.time = 0
	l_5_8.position = l_5_3
	l_5_8.rotation = l_5_4
	l_5_8.spawn_unit = l_5_5
	l_5_6(l_5_7, l_5_8)
end


