PlayerSlot = PlayerSlot or class()
function PlayerSlot.init(A0_0, A1_1)
	if A1_1.user_index then
		A0_0._user = managers.local_user:user_from_user_index(A1_1.user_index)
	end
end
function PlayerSlot.default_data(A0_2)
	local L1_3
	A0_2.user_index = nil
end
function PlayerSlot.save(A0_4, A1_5)
	if not A0_4._user then
		return
	end
	A1_5.user_index = A0_4._user:user_index()
end
function PlayerSlot.set_user(A0_6, A1_7, A2_8)
	assert(A1_7)
	assert(not A0_6._user)
	A0_6._user = A1_7
	A0_6._is_primary_user = A2_8
	if not A0_6._is_primary_user then
		A0_6._user:profile().difficulty_level = managers.save:profile().difficulty_level
	end
	A0_6:update_control()
end
function PlayerSlot.release_user(A0_9)
	assert(A0_9._user)
	A0_9._user = nil
	A0_9._is_primary_user = false
	A0_9:update_control()
end
function PlayerSlot.is_occupied(A0_10)
	return A0_10._user ~= nil
end
function PlayerSlot.user(A0_11)
	local L1_12
	L1_12 = A0_11._user
	return L1_12
end
function PlayerSlot.set_unit(A0_13, A1_14, A2_15, A3_16, A4_17, A5_18, A6_19)
	assert(A1_14)
	assert(not A0_13._unit)
	A0_13._ai_controllable = A5_18
	A0_13._human_controllable = A6_19
	A0_13._unit = A1_14
	A0_13:update_control()
end
function PlayerSlot.set_spawn_point(A0_20, A1_21, A2_22, A3_23, A4_24, A5_25, A6_26, A7_27, A8_28)
	A0_20._ai_controllable = A4_24
	A0_20._human_controllable = A5_25
	if not alive(A0_20._unit) then
		A0_20._unit = nil
	end
	if not A0_20._unit or A0_20._unit:name() ~= A1_21 then
		if A0_20._unit then
			if A0_20._user then
				A0_20._user:release_assigned_unit()
			end
			A0_20._unit:set_slot(0)
		end
		A0_20._unit = World:spawn_unit(A1_21, A2_22, A3_23)
		if A0_20._ai_controllable then
			A0_20._unit:ai_nerve_system():setup(A6_26)
		end
		A0_20:update_control()
	end
	if A7_27 and A8_28 < (A2_22 - A0_20._unit:position()):length() then
		UnitSpawnUtility.warp_to(A0_20._unit, A3_23, A2_22)
	end
end
function PlayerSlot.update(A0_29)
	if not alive(A0_29._unit) then
		A0_29._unit = nil
	end
end
function PlayerSlot.update_control(A0_30)
	if not alive(A0_30._unit) then
		A0_30._unit = nil
	end
	if not A0_30._unit then
		return
	end
	if A0_30._human_controllable and A0_30._user then
		assert(A0_30._unit)
		if A0_30._user:assigned_unit() ~= A0_30._unit then
			A0_30._user:set_assigned_unit(A0_30._unit)
			if A0_30._user:profile().levels[managers.save:profile().current_level_id] and managers.save:profile().current_checkpoint_id <= A0_30._user:profile().levels[managers.save:profile().current_level_id].maximum_checkpoint_id and A0_30._user:profile().levels[managers.save:profile().current_level_id].checkpoints[managers.save:profile().current_checkpoint_id].inventory.items[1].name ~= "" then
				A0_30._unit:base():spawn_weapon_state(A0_30._user:profile().levels[managers.save:profile().current_level_id].checkpoints[managers.save:profile().current_checkpoint_id].inventory.items)
			end
			if not true then
				A0_30._unit:base():spawn_human_controllable_weapons()
			end
		end
	elseif A0_30._ai_controllable then
		A0_30._unit:control():set_ai_controlled()
	else
		A0_30._unit:control():set_no_control()
	end
end
function PlayerSlot.spawned_unit(A0_31)
	local L1_32
	L1_32 = A0_31._unit
	return L1_32
end
