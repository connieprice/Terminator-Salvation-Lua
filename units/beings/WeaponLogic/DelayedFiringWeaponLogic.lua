require("units/beings/WeaponLogic/WeaponLogic")
if not DelayedFiringWeaponLogic then
	DelayedFiringWeaponLogic = class(WeaponLogic)
end
DelayedFiringWeaponLogic.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	WeaponLogic.init(l_1_0, l_1_1, l_1_2)
	l_1_0._enemy_data = l_1_1:enemy_data()
	l_1_0._setup = l_1_3
	l_1_0._waiting_to_fire = false
end

DelayedFiringWeaponLogic.update = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6)
	local l_2_7 = l_2_0._enemy_data
	local l_2_8 = l_2_0._setup
	local l_2_9 = l_2_7[l_2_8.prepared_variable_name]
	if l_2_3 > 0 and not l_2_9 then
		l_2_0._waiting_to_fire = true
		assert(l_2_4)
		l_2_0._waiting_to_fire_aim_target_position = l_2_4
	end
	local l_2_14, l_2_15 = , nil
	if l_2_2 or l_2_3 > 0 then
		do return end
	end
	do
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_2_9 then
			if l_2_0._waiting_to_fire then
				if not l_2_0:_aiming_at_target(nil, l_2_6) then
					local l_2_17 = nil
					assert(l_2_0._fire_object)
					 -- DECOMPILER ERROR: Confused about usage of registers!

					 -- DECOMPILER ERROR: Confused about usage of registers!

				end
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			elseif l_2_14 and l_2_0:_aiming_at_target(l_2_17, l_2_6) then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			if not (l_2_0._keep_prepared_timer and l_2_0._keep_prepared_timer < 0 and l_2_2) or l_2_3 > 0 or l_2_0._waiting_to_fire or not l_2_0._keep_prepared_timer or l_2_0._keep_prepared_timer >= 0 then
				l_2_0:_unprepare()
			end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Confused about usage of registers!

		elseif (l_2_0._keep_prepared_timer and l_2_0._keep_prepared_timer < 0 and l_2_2) or l_2_3 > 0 or l_2_0._waiting_to_fire or not l_2_0._keep_prepared_timer or l_2_0._keep_prepared_timer >= 0 then
			l_2_0:_prepare()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_2_0:_update_weapon_data(l_2_2, l_2_15, l_2_17, l_2_5)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

DelayedFiringWeaponLogic._prepare = function(l_3_0)
	l_3_0._unit:play_redirect(l_3_0._setup.prepare_redirect)
end

DelayedFiringWeaponLogic._unprepare = function(l_4_0)
	l_4_0._unit:play_redirect(l_4_0._setup.unprepare_redirect)
end


