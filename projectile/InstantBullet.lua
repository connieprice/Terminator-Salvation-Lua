local L0_0
L0_0 = InstantBullet
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0()
end
InstantBullet = L0_0
L0_0 = mvector3
L0_0 = L0_0.add
function InstantBullet.init(A0_1, A1_2, A2_3, A3_4, A4_5, A5_6, A6_7, A7_8, A8_9, A9_10, A10_11, A11_12, A12_13, A13_14, A14_15)
	A0_1._bullet_type_name = A14_15
	A0_1._damage = A11_12
	assert(A0_1._damage)
	A0_1._inflictor_type = A12_13
	assert(A0_1._inflictor_type)
	A0_1._range = A1_2
	A0_1._near_damage_threshold = A2_3
	A0_1._far_damage_threshold = A4_5
	A0_1._far_damage = A5_6
	assert(A0_1._far_damage >= 0 and A0_1._far_damage <= 1)
	A0_1._slot_mask = A6_7
	A0_1._tracer_fx = A7_8
	A0_1._tracer_vel = A8_9
	A0_1._tracer_length = A9_10
	A0_1._decal = A10_11
	if A13_14 then
		A0_1._spawn_effect_func = A0_1.spawn_effect_at_high_speed
	else
		A0_1._spawn_effect_func = A0_1.spawn_effect
	end
	A0_1._hit_callback = callback(A0_1, A0_1, "hit_callback")
	A0_1._passed_callback = callback(A0_1, A0_1, "passed_callback")
	A0_1._issue_id = -1
	A0_1._position = Vector3(0, 0, 0)
	A0_1._rotation = Rotation()
	A0_1._tweak_settings = tweak_data.weapon
	A0_1._trail_settings = tweak_data.player.weapon
	A0_1._emitter = managers.action_event:create_emitter(nil)
end
function InstantBullet.destroy(A0_16)
	A0_16._emitter:destroy()
end
function InstantBullet.spawn(A0_17, A1_18, A2_19, A3_20)
	local L4_21
	A0_17._spawning_unit = A1_18
	L4_21 = A1_18.player_data
	L4_21 = L4_21(A1_18)
	A0_17._player_data = L4_21
	A0_17._position = A2_19
	A0_17._rotation = A3_20
	L4_21 = tweak_data
	L4_21 = L4_21.weapon
	L4_21 = L4_21.issue_raycasts
	if L4_21 then
		L4_21 = World
		L4_21 = L4_21.issue_raycast
		L4_21 = L4_21(L4_21, A0_17._hit_callback, "ray", A2_19, A2_19 + A3_20:y() * A0_17._range, "passed", A0_17._passed_callback, "slot_mask", A0_17._slot_mask, "ignore_unit", A1_18)
		A0_17._issue_id = L4_21
	else
		L4_21 = nil
		if A0_17._tweak_settings.disable_ray_callback then
			L4_21 = World:raycast("ray", A2_19, A2_19 + A3_20:y() * A0_17._range, "slot_mask", A0_17._slot_mask, "ignore_unit", A1_18)
		else
			L4_21 = World:raycast("ray", A2_19, A2_19 + A3_20:y() * A0_17._range, "passed", A0_17._passed_callback, "slot_mask", A0_17._slot_mask, "ignore_unit", A1_18)
		end
		A0_17:hit_callback(-1, L4_21)
	end
end
function InstantBullet.finished(A0_22)
	local L1_23
	L1_23 = A0_22._finished
	return L1_23
end
function InstantBullet.hit_callback(A0_24, A1_25, A2_26)
	local L3_27, L4_28, L5_29
	if A2_26 then
		L4_28 = A0_24
		L3_27 = A0_24.hit
		L5_29 = A2_26
		L3_27(L4_28, L5_29)
	end
	L3_27 = A0_24._tracer_fx
	if L3_27 then
		L3_27 = A0_24._tweak_settings
		L3_27 = L3_27.disable_ray_tracer
		if not L3_27 then
			L3_27 = World
			L4_28 = L3_27
			L3_27 = L3_27.effect_manager
			L3_27 = L3_27(L4_28)
			L4_28 = L3_27
			L3_27 = L3_27.spawn
			L5_29 = {}
			L5_29.effect = A0_24._tracer_fx
			L5_29.position = A0_24._position
			L5_29.normal = A0_24._rotation:y()
			L3_27 = L3_27(L4_28, L5_29)
			if A2_26 then
				L4_28 = A2_26.distance
				L5_29 = math
				L5_29 = L5_29.clamp
				L5_29 = L5_29((L4_28 - A0_24._tracer_length) / A0_24._tracer_vel, 0.001, L4_28)
				World:effect_manager():set_remaining_lifetime(L3_27, L5_29)
			end
		end
	end
	A0_24._finished = true
end
function InstantBullet.passed_callback(A0_30, A1_31)
	A0_30:hit(A1_31)
end
function InstantBullet.hit(A0_32, A1_33)
	A0_32._emitter:bullet_hit(A0_32._bullet_type_name, A1_33.position, A1_33.rotation, A1_33.normal)
	if A0_32._decal and not A0_32._tweak_settings.disable_ray_effect and not A0_32._disable_hit_effect then
		_UPVALUE0_(A1_33, A0_32._decal)
	end
	if _UPVALUE1_(A0_32, A1_33.body, A1_33) > 0 then
		_UPVALUE2_(A1_33.unit, A1_33.ray)
	end
end
