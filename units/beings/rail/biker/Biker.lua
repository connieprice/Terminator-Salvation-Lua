Biker = Biker or class(Rail2WheeledVehicle)
Biker._AIM_OBJECT = "a_fire_plasma_upper_left"
Biker._ROOT_OBJECT = "rp_biker"
Biker._ENGINE_SOUNDBANK_NAME = "rs2_sound"
Biker._ENGINE_SOUND_NAME = "rs2_motoloop"
Biker._ENGINE_SOUND_OUTPUT_OBJECT_NAME = "rp_biker"
function Biker.init(A0_0, A1_1)
	local L2_2
	L2_2 = Rail2WheeledVehicle
	L2_2 = L2_2.init
	L2_2(A0_0, A1_1)
	L2_2 = A0_0._unit
	L2_2 = L2_2.enemy_data
	L2_2 = L2_2(L2_2)
	A0_0._enemy_data = L2_2
	L2_2 = A0_0._unit
	L2_2 = L2_2.input
	L2_2 = L2_2(L2_2)
	A0_0._input = L2_2
	A0_0._unit = A1_1
	L2_2 = A0_0._unit
	L2_2 = L2_2.get_object
	L2_2 = L2_2(L2_2, Biker._AIM_OBJECT)
	A0_0._aim_object = L2_2
	L2_2 = A0_0._unit
	L2_2 = L2_2.get_object
	L2_2 = L2_2(L2_2, Biker._ROOT_OBJECT)
	A0_0._root_object = L2_2
	L2_2 = Sound
	L2_2 = L2_2.make_bank
	L2_2 = L2_2(L2_2, Biker._ENGINE_SOUNDBANK_NAME, Biker._ENGINE_SOUND_NAME)
	A0_0._engine_sound = L2_2
	L2_2 = A1_1.get_object
	L2_2 = L2_2(A1_1, Biker._ENGINE_SOUND_OUTPUT_OBJECT_NAME)
	A0_0._engine_sound:set_output(L2_2)
	A0_0._engine_sound:set_ambient(true)
	A0_0._collidable_units = World:find_units_quick("all", World:make_slot_mask(39))
	A0_0._gatling_l = A0_0._unit:get_object("a_gatling_gyro_l")
	A0_0._gatling_r = A0_0._unit:get_object("a_gatling_gyro_r")
	A0_0._hip_l = A0_0._unit:get_object("a_hip_l_target_02")
	A0_0._hip_r = A0_0._unit:get_object("a_hip_r_target_02")
	A0_0._collision_distance = tweak_data.rail.biker.COLLISION_DISTANCE
	A0_0._collision_detection_delay = 0.1
	A0_0._collision_detection_time = 0
	A0_0._collision_detection_radius = A0_0._collision_distance + 1000
	A0_0:_setup_weapons()
end
function Biker._setup_weapons(A0_3)
	local L1_4, L2_5, L3_6, L4_7, L5_8, L6_9
	L4_7 = A0_3._unit
	L5_8 = L4_7
	L4_7 = L4_7.position
	L4_7 = L4_7(L5_8)
	L5_8 = A0_3._unit
	L6_9 = L5_8
	L5_8 = L5_8.rotation
	L6_9 = L5_8(L6_9)
	A0_3._primary_weapon_l = L1_4
	L1_4(L2_5, L3_6)
	L1_4(L2_5, L3_6)
	L4_7 = A0_3._primary_weapon_l
	L5_8 = "at_gatling_barrel"
	L1_4(L2_5, L3_6, L4_7, L5_8)
	L4_7 = A0_3._unit
	L5_8 = L4_7
	L4_7 = L4_7.position
	L4_7 = L4_7(L5_8)
	L5_8 = A0_3._unit
	L6_9 = L5_8
	L5_8 = L5_8.rotation
	L6_9 = L5_8(L6_9)
	A0_3._primary_weapon_r = L1_4
	L1_4(L2_5, L3_6)
	L1_4(L2_5, L3_6)
	L4_7 = A0_3._primary_weapon_r
	L5_8 = "at_gatling_barrel"
	L1_4(L2_5, L3_6, L4_7, L5_8)
	A0_3._secondary_weapons = L1_4
	for L4_7, L5_8 in L1_4(L2_5) do
		L6_9 = World
		L6_9 = L6_9.spawn_unit
		L6_9 = L6_9(L6_9, A0_3._secondary_weapon_class, A0_3._unit:position(), A0_3._unit:rotation())
		L6_9:base():setup(A0_3._unit, {L5_8})
		L6_9:base():set_equiped(true)
		table.insert(A0_3._secondary_weapons, L6_9)
	end
end
function Biker.update(A0_10, A1_11, A2_12, A3_13)
	local L4_14, L5_15, L6_16, L7_17, L8_18, L9_19, L10_20, L11_21
	L4_14 = Rail2WheeledVehicle
	L4_14 = L4_14.update
	L5_15 = A0_10
	L6_16 = A1_11
	L4_14(L5_15, L6_16, L7_17, L8_18)
	L4_14 = A0_10._engine_sound
	L5_15 = L4_14
	L4_14 = L4_14.is_playing
	L4_14 = L4_14(L5_15)
	if not L4_14 then
		L4_14 = A0_10._engine_sound
		L5_15 = L4_14
		L4_14 = L4_14.play
		L4_14(L5_15)
	end
	L5_15 = A0_10
	L4_14 = A0_10._update_collision_detection
	L6_16 = A1_11
	L4_14(L5_15, L6_16, L7_17, L8_18)
	L5_15 = A0_10
	L4_14 = A0_10._update_animation_speed
	L4_14(L5_15)
	L4_14 = A0_10._input
	L5_15 = L4_14
	L4_14 = L4_14.primary_fire
	L4_14 = L4_14(L5_15)
	L5_15 = A0_10._input
	L6_16 = L5_15
	L5_15 = L5_15.secondary_fire
	L5_15 = L5_15(L6_16)
	L6_16 = A0_10._aim_object
	L6_16 = L6_16.position
	L6_16 = L6_16(L7_17)
	L6_16 = L6_16 + L7_17
	L10_20 = L6_16
	L7_17(L8_18, L9_19, L10_20)
	L10_20 = L6_16
	L7_17(L8_18, L9_19, L10_20)
	for L10_20, L11_21 in L7_17(L8_18) do
		A0_10:_update_secondary_weapon(L11_21, L6_16)
	end
	L7_17(L8_18)
	L7_17(L8_18)
	if L7_17 then
		L10_20 = 1
		L11_21 = 0
		L11_21 = L9_19(L10_20, L11_21, 1, 0)
		L10_20 = A0_10._unit
		L11_21 = L10_20
		L10_20 = L10_20.position
		L10_20 = L10_20(L11_21)
		L11_21 = Vector3
		L11_21 = L11_21(0, 0, 100)
		L10_20 = L10_20 + L11_21
		L11_21 = 100
		L8_18(L9_19, L10_20, L11_21)
	end
end
function Biker._update_collision_detection(A0_22, A1_23, A2_24, A3_25)
	local L4_26, L5_27, L6_28, L7_29, L8_30, L9_31, L10_32, L11_33
	if A2_24 >= L4_26 then
		if not L4_26 then
			for L7_29, L8_30 in L4_26(L5_27) do
				L9_31 = alive
				L10_32 = L8_30
				L9_31 = L9_31(L10_32)
				if L9_31 then
					L9_31 = A0_22._unit
					L10_32 = L9_31
					L9_31 = L9_31.position
					L9_31 = L9_31(L10_32)
					L11_33 = L8_30
					L10_32 = L8_30.position
					L10_32 = L10_32(L11_33)
					L9_31 = L9_31 - L10_32
					L10_32 = L9_31
					L9_31 = L9_31.length
					L9_31 = L9_31(L10_32)
					L10_32 = A0_22._collision_detection_radius
					if L9_31 <= L10_32 then
						L9_31 = A0_22._unit
						L10_32 = L9_31
						L9_31 = L9_31.rotation
						L9_31 = L9_31(L10_32)
						L10_32 = L9_31
						L9_31 = L9_31.y
						L9_31 = L9_31(L10_32)
						L10_32 = A0_22._collision_distance
						L9_31 = L9_31 * L10_32
						L10_32 = A0_22._unit
						L11_33 = L10_32
						L10_32 = L10_32.rotation
						L10_32 = L10_32(L11_33)
						L11_33 = L10_32
						L10_32 = L10_32.z
						L10_32 = L10_32(L11_33)
						L10_32 = L10_32 * 50
						L11_33 = A0_22._unit
						L11_33 = L11_33.position
						L11_33 = L11_33(L11_33)
						L11_33 = L11_33 + L9_31
						L11_33 = L11_33 + L10_32
						if L8_30:oobb():point_inside(L11_33) then
							Application:debug("BIKER COLLISION WITH", L8_30:name())
							A0_22._unit:damage():set_fully_damaged()
							A0_22._collided = true
						end
					end
				end
			end
		end
		A0_22._collision_detection_time = L4_26
	end
end
function Biker._update_gatling_gyro(A0_34)
	A0_34._biker_roll_prev = A0_34._root_object:rotation():pitch()
	A0_34._gatling_l:set_local_rotation(Rotation(A0_34._gatling_l:local_rotation():yaw(), A0_34._gatling_l:local_rotation():pitch() + (A0_34._root_object:rotation():pitch() - A0_34._biker_roll_prev), A0_34._gatling_l:local_rotation():roll()))
	A0_34._gatling_r:set_local_rotation(Rotation(A0_34._gatling_r:local_rotation():yaw(), A0_34._gatling_r:local_rotation():pitch() + (A0_34._root_object:rotation():pitch() - A0_34._biker_roll_prev), A0_34._gatling_r:local_rotation():roll()))
	if A0_34._root_object:rotation():pitch() > 0 then
		A0_34._hip_l:set_local_position(A0_34._hip_l:local_position() + Vector3(0, 0, -(A0_34._root_object:rotation():pitch() - A0_34._biker_roll_prev) * 1))
		A0_34._hip_r:set_local_position(A0_34._hip_r:local_position() + Vector3(0, 0, (A0_34._root_object:rotation():pitch() - A0_34._biker_roll_prev) * 1))
	elseif A0_34._root_object:rotation():pitch() < 0 then
		A0_34._hip_l:set_local_position(A0_34._hip_l:local_position() + Vector3(0, 0, -(A0_34._root_object:rotation():pitch() - A0_34._biker_roll_prev) * 1))
		A0_34._hip_r:set_local_position(A0_34._hip_r:local_position() + Vector3(0, 0, (A0_34._root_object:rotation():pitch() - A0_34._biker_roll_prev) * 1))
	end
end
function Biker._update_effects(A0_35)
	for 