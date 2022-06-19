BodyDamageGroup = BodyDamageGroup or class()
function BodyDamageGroup.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7, A8_8, A9_9)
	A0_0.name = A5_5
	A0_0._unit = A1_1
	A0_0._unit_extension = A2_2
	A0_0._destroyed_sequence_name = A3_3
	A0_0._damaged_sequence_name = A4_4
	A0_0._damage = 0
	A0_0._endurance = A6_6
	A0_0._destroyed = false
	A0_0._group_destroyed_callback = A7_7
	A0_0._damage_steps = A8_8
	A0_0._can_recive_dmg = true
	A0_0:get_next_damage_step()
	A0_0._damage_threshold = A9_9 or 0
end
function BodyDamageGroup.add_damage(A0_10, A1_11)
	if A0_10._can_recive_dmg == false or A0_10._unit:damage_data().invulnerable then
		return
	end
	A0_10._damage = A0_10._damage + A1_11
	if not A0_10._destroyed then
		if A0_10._damage > A0_10._endurance then
			A0_10._destroyed = true
			if A0_10._destroyed_sequence_name and A0_10._destroyed_sequence_name ~= "" then
				Application:debug("Running kill sequence: ", A0_10._destroyed_sequence_name)
				managers.sequence:run_sequence_simple(A0_10._destroyed_sequence_name, A0_10._unit)
			end
			if A0_10._group_destroyed_callback then
				A0_10._group_destroyed_callback(A0_10)
			end
		elseif A0_10._damage < A0_10._endurance * A0_10._damage_threshold and A0_10._damage > A0_10._endurance * A0_10._damage_threshold and A0_10._damaged_sequence_name ~= nil and A0_10._damaged_sequence_name ~= "" then
			Application:debug("Running dmg sequence: ", A0_10._damaged_sequence_name)
			managers.sequence:run_sequence_simple(A0_10._damaged_sequence_name, A0_10._unit)
		elseif A0_10._next_damage_step ~= nil and A0_10._damage >= A0_10._next_damage_step.damage then
			managers.sequence:run_sequence_simple(A0_10._next_damage_step.sequence_name, A0_10._unit)
			A0_10:get_next_damage_step()
		end
	end
end
function BodyDamageGroup.get_next_damage_step(A0_12)
	if A0_12._damage_steps ~= nil then
		A0_12._next_damage_step = table.remove(A0_12._damage_steps, 1)
		if A0_12._next_damage_step then
			A0_12._next_damage_step.damage = A0_12._next_damage_step.damage * A0_12._endurance
		end
	end
end
function BodyDamageGroup.activate(A0_13, A1_14)
	A0_13._can_recive_dmg = A1_14
end
function BodyDamageGroup.is_active(A0_15)
	local L1_16
	L1_16 = A0_15._can_recive_dmg
	if L1_16 then
		L1_16 = A0_15._destroyed
		L1_16 = not L1_16
	end
	return L1_16
end
