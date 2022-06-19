Explosion = Explosion or class()
function debug_throw_grenade()
	local L0_0, L1_1, L2_2
	L0_0 = managers
	L0_0 = L0_0.player
	L1_1 = L0_0
	L0_0 = L0_0.players
	L0_0 = L0_0(L1_1)
	L1_1 = next
	L2_2 = L0_0
	L2_2 = L1_1(L2_2, nil)
	assert(L2_2)
	if L2_2 then
		World:spawn_unit("hand_grenade", L2_2:player_data().camera_position + 150 * Vector3(0, 1, 0):rotate_with(L2_2:player_data().camera_rotation)):push(10, Vector3(0, 1, 0):rotate_with(L2_2:player_data().camera_rotation) * 1000)
	end
end
function Explosion.init(A0_3, A1_4)
	local L2_5, L3_6, L4_7, L5_8, L6_9
	A0_3._unit = A1_4
	A0_3._spawning_unit = A1_4
	A0_3._action_emitter = L2_5
	A0_3._potential_victims_slot_mask = L2_5
	A0_3._explosion_covers_slot_mask = L2_5
	A0_3._radius = nil
	A0_3._rays_per_frame = 10
	A0_3._physics_effect = nil
	A0_3._found_potential_victims = false
	A0_3._body_damage_factor = 0.01
	L5_8 = A0_3._unit
	L6_9 = L5_8
	L5_8 = L5_8.position
	L6_9 = L5_8(L6_9)
	L2_5(L3_6, L4_7, L5_8, L6_9, L5_8(L6_9))
	L6_9 = L3_6(L4_7)
	for L5_8, L6_9 in L2_5(L3_6, L4_7, L5_8, L6_9, L3_6(L4_7)) do
		A0_3._action_emitter:unit_explosion(L6_9, A0_3._unit:position())
	end
end
function Explosion.destroy(A0_10)
	A0_10._action_emitter:destroy()
	A0_10._action_emitter = nil
end
function Explosion.set_spawning_unit(A0_11, A1_12)
	A0_11._spawning_unit = A1_12
end
function Explosion.set_faith_damage(A0_13, A1_14)
	local L2_15, L3_16
	L2_15 = A0_13._damage
	L3_16 = A1_14.hard
	L2_15.hard = L3_16
	L2_15 = A0_13._damage
	L3_16 = A1_14.soft
	L2_15.soft = L3_16
end
function Explosion.set_inflictor_type(A0_17, A1_18)
	A0_17._inflictor_type = A1_18
end
function Explosion._find_potential_victims(A0_19)
	local L1_20, L2_21, L3_22, L4_23, L5_24, L6_25, L7_26, L8_27, L9_28, L10_29, L11_30, L12_31, L13_32, L14_33
	L1_20 = World
	L1_20 = L1_20.find_units
	L5_24 = "sphere"
	L6_25 = A0_19._unit
	L7_26 = L6_25
	L6_25 = L6_25.position
	L6_25 = L6_25(L7_26)
	L7_26 = A0_19._radius
	L8_27 = A0_19._potential_victims_slot_mask
	L1_20 = L1_20(L2_21, L3_22, L4_23, L5_24, L6_25, L7_26, L8_27)
	A0_19._work_item_vector = L2_21
	for L5_24, L6_25 in L2_21(L3_22) do
		L7_26 = alive
		L8_27 = L6_25
		L7_26 = L7_26(L8_27)
		if L7_26 then
			L8_27 = L6_25
			L7_26 = L6_25.damage_data
			L7_26 = L7_26(L8_27)
			if L7_26 then
				L8_27 = L6_25
				L7_26 = L6_25.damage_data
				L7_26 = L7_26(L8_27)
				L8_27 = L7_26
				L7_26 = L7_26.is_fully_damaged
				L7_26 = L7_26(L8_27)
			elseif not L7_26 then
				L7_26 = {}
				L8_27 = {}
				L9_28 = {}
				L9_28.is_done = false
				L9_28.unit = L6_25
				L9_28.body_queue = L7_26
				L9_28.hit_bodies = L8_27
				L9_28.num_damage_bodies = 0
				L10_29 = L6_25.num_bodies
				L10_29 = L10_29(L11_30)
				for L14_33 = 0, L10_29 - 1 do
					if L6_25:body(L14_33):enabled() and L6_25:body(L14_33):has_ray_type("explosion") then
						if L6_25:body(L14_33):extension() and L6_25:body(L14_33):extension().damage then
							if L6_25:body(L14_33):extension().damage.is_explosion_receiver and L6_25:body(L14_33):extension().damage:is_explosion_receiver() then
								table.insert(L7_26, {
									body = L6_25:body(L14_33),
									body_damage_extension = L6_25:body(L14_33):extension().damage
								})
							end
						else
							table.insert(L7_26, {
								body = L6_25:body(L14_33)
							})
						end
					end
				end
				if L11_30 > 0 then
					L9_28.num_damage_bodies = L11_30
					L11_30(L12_31, L13_32)
				end
			end
		end
	end
end
function Explosion.update(A0_34, A1_35, A2_36, A3_37)
	local L4_38, L5_39
	L4_38 = A0_34._found_potential_victims
	if not L4_38 then
		L5_39 = A0_34
		L4_38 = A0_34._find_potential_victims
		L4_38(L5_39)
		A0_34._found_potential_victims = true
		A0_34._current_work_item = 1
	end
	L5_39 = A0_34
	L4_38 = A0_34.is_all_work_done
	L4_38 = L4_38(L5_39)
	if L4_38 then
		L4_38 = A0_34._unit
		L5_39 = L4_38
		L4_38 = L4_38.set_slot
		L4_38(L5_39, 0)
		return
	end
	L4_38 = A0_34._rays_per_frame
	while L4_38 > 0 do
		L5_39 = A0_34.is_all_work_done
		L5_39 = L5_39(A0_34)
		if not L5_39 then
			L5_39 = A0_34._work_item_vector
			L5_39 = L5_39[A0_34._current_work_item]
			if not L5_39.is_done then
				A0_34:raycast_for_work_item(L5_39)
				L4_38 = L4_38 - 1
			end
			A0_34._current_work_item = A0_34._current_work_item + 1
			if A0_34._current_work_item > #A0_34._work_item_vector then
				A0_34._current_work_item = 1
			end
		end
	end
end
function Explosion.is_all_work_done(A0_40)
	for 