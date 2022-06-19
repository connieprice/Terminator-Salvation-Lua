require("units/beings/WeaponLogic/WeaponLogic")
DelayedFiringWeaponLogic = DelayedFiringWeaponLogic or class(WeaponLogic)
function DelayedFiringWeaponLogic.init(A0_0, A1_1, A2_2, A3_3)
	WeaponLogic.init(A0_0, A1_1, A2_2)
	A0_0._enemy_data = A1_1:enemy_data()
	A0_0._setup = A3_3
	A0_0._waiting_to_fire = false
end
function DelayedFiringWeaponLogic.update(A0_4, A1_5, A2_6, A3_7, A4_8, A5_9, A6_10)
	local L7_11, L8_12, L9_13, L10_14, L11_15, L12_16, L13_17, L14_18
	L7_11 = A0_4._enemy_data
	L8_12 = A0_4._setup
	L9_13 = L8_12.prepared_variable_name
	L9_13 = L7_11[L9_13]
	L10_14 = A3_7 > 0
	if L10_14 and not L9_13 then
		A0_4._waiting_to_fire = true
		L11_15 = assert
		L12_16 = A4_8
		L11_15(L12_16)
		A0_4._waiting_to_fire_aim_target_position = A4_8
	end
	L11_15, L12_16 = nil, nil
	if A2_6 or A3_7 > 0 then
		L13_17 = L8_12.keep_prepared_time
		A0_4._keep_prepared_timer = L13_17
	else
		L13_17 = A0_4._keep_prepared_timer
		if L13_17 then
			L13_17 = A0_4._keep_prepared_timer
			L13_17 = L13_17 - A1_5
			A0_4._keep_prepared_timer = L13_17
			L13_17 = A0_4._keep_prepared_timer
			if L13_17 < 0 then
				A0_4._keep_prepared_timer = nil
			end
		end
	end
	L13_17 = A2_6 or A3_7 > 0 or A0_4._waiting_to_fire
	if L9_13 then
		L14_18 = A0_4._waiting_to_fire
		if L14_18 then
			L12_16 = A0_4._waiting_to_fire_aim_target_position
			L14_18 = A0_4._aiming_at_target
			L14_18 = L14_18(A0_4, L12_16, A6_10)
			if not L14_18 then
				L14_18 = A0_4._fire_object
				assert(L14_18)
				L12_16 = L14_18:position() + L14_18:rotation():y() * 1000
			end
			L11_15 = 1
			A0_4._waiting_to_fire = false
		else
			L12_16 = A4_8
			if L10_14 then
				L14_18 = A0_4._aiming_at_target
				L14_18 = L14_18(A0_4, L12_16, A6_10)
				if L14_18 then
					L11_15 = 1
				end
			else
				L11_15 = 0
			end
		end
		if not L13_17 then
			L14_18 = A0_4._unprepare
			L14_18(A0_4)
		end
	else
		L11_15 = 0
		if L13_17 then
			L14_18 = A0_4._prepare
			L14_18(A0_4)
		end
	end
	L14_18 = A0_4._update_weapon_data
	L14_18(A0_4, A2_6, L11_15, L12_16, A5_9)
end
function DelayedFiringWeaponLogic._prepare(A0_19)
	A0_19._unit:play_redirect(A0_19._setup.prepare_redirect)
end
function DelayedFiringWeaponLogic._unprepare(A0_20)
	A0_20._unit:play_redirect(A0_20._setup.unprepare_redirect)
end
